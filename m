From: Fionn Cleary <clearyf-/Zw1syy4LHg@public.gmane.org>
Subject: [PATCH] spi/omap2-mcpsi: Always call spi_finalize_current_message()
Date: Thu, 23 Apr 2015 21:13:40 +0200
Message-ID: <87h9s63bff.fsf@tcd.ie>
Mime-Version: 1.0
Content-Type: text/plain
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The spi queue waits forever for spi_finalize_current_message() to be
called, blocking the bus.  Ensure that all error paths from
omap2_mcspi_transfer_one_message() call spi_finalize_current_message().

Signed-off-by: Fionn Cleary <fionn.cleary-6oiIBCxl0MMjD8S081q9vkEOCMrvLtNR@public.gmane.org>
---
 drivers/spi/spi-omap2-mcspi.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 102cff5..f7b13e1 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -1216,6 +1216,7 @@ static int omap2_mcspi_transfer_one_message(struct spi_master *master,
 	struct omap2_mcspi	*mcspi;
 	struct omap2_mcspi_dma	*mcspi_dma;
 	struct spi_transfer	*t;
+	int status;
 
 	spi = m->spi;
 	mcspi = spi_master_get_devdata(master);
@@ -1235,7 +1236,8 @@ static int omap2_mcspi_transfer_one_message(struct spi_master *master,
 					tx_buf ? "tx" : "",
 					rx_buf ? "rx" : "",
 					t->bits_per_word);
-			return -EINVAL;
+			status = -EINVAL;
+			goto out;
 		}
 
 		if (m->is_dma_mapped || len < DMA_MIN_BYTES)
@@ -1247,7 +1249,8 @@ static int omap2_mcspi_transfer_one_message(struct spi_master *master,
 			if (dma_mapping_error(mcspi->dev, t->tx_dma)) {
 				dev_dbg(mcspi->dev, "dma %cX %d bytes error\n",
 						'T', len);
-				return -EINVAL;
+				status = -EINVAL;
+				goto out;
 			}
 		}
 		if (mcspi_dma->dma_rx && rx_buf != NULL) {
@@ -1259,14 +1262,19 @@ static int omap2_mcspi_transfer_one_message(struct spi_master *master,
 				if (tx_buf != NULL)
 					dma_unmap_single(mcspi->dev, t->tx_dma,
 							len, DMA_TO_DEVICE);
-				return -EINVAL;
+				status = -EINVAL;
+				goto out;
 			}
 		}
 	}
 
 	omap2_mcspi_work(mcspi, m);
+	/* spi_finalize_current_message() changes the status inside the
+	 * spi_message, save the status here. */
+	status = m->status;
+out:
 	spi_finalize_current_message(master);
-	return 0;
+	return status;
 }
 
 static int omap2_mcspi_master_setup(struct omap2_mcspi *mcspi)
-- 
1.9.1


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

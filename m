From: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH V2 2/3] spi: img-spfi: Reset controller after each message
Date: Wed,  8 Apr 2015 10:03:15 -0700
Message-ID: <1428512596-23766-2-git-send-email-abrestic@chromium.org>
References: <1428512596-23766-1-git-send-email-abrestic@chromium.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1428512596-23766-1-git-send-email-abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Imagination has recommended that the SPFI controller be reset after
each message, regardless of success or failure.  Do this in an
unprepare_message() callback.

Signed-off-by: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
---
New for v2.
---
 drivers/spi/spi-img-spfi.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-img-spfi.c b/drivers/spi/spi-img-spfi.c
index a3cf5be..dedb7d8 100644
--- a/drivers/spi/spi-img-spfi.c
+++ b/drivers/spi/spi-img-spfi.c
@@ -414,8 +414,6 @@ static void img_spfi_handle_err(struct spi_master *master,
 		dmaengine_terminate_all(spfi->rx_ch);
 	}
 	spin_unlock_irqrestore(&spfi->lock, flags);
-
-	spfi_reset(spfi);
 }
 
 static int img_spfi_prepare(struct spi_master *master, struct spi_message *msg)
@@ -437,6 +435,16 @@ static int img_spfi_prepare(struct spi_master *master, struct spi_message *msg)
 	return 0;
 }
 
+static int img_spfi_unprepare(struct spi_master *master,
+			      struct spi_message *msg)
+{
+	struct img_spfi *spfi = spi_master_get_devdata(master);
+
+	spfi_reset(spfi);
+
+	return 0;
+}
+
 static void img_spfi_config(struct spi_master *master, struct spi_device *spi,
 			    struct spi_transfer *xfer)
 {
@@ -610,6 +618,7 @@ static int img_spfi_probe(struct platform_device *pdev)
 	master->set_cs = img_spfi_set_cs;
 	master->transfer_one = img_spfi_transfer_one;
 	master->prepare_message = img_spfi_prepare;
+	master->unprepare_message = img_spfi_unprepare;
 	master->handle_err = img_spfi_handle_err;
 
 	spfi->tx_ch = dma_request_slave_channel(spfi->dev, "tx");
-- 
2.2.0.rc0.207.ga3a616c

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH 11/18] spi: rspi: Move RSPI-specific setup out of DMA routines
Date: Mon,  2 Jun 2014 15:38:13 +0200
Message-ID: <1401716301-29612-12-git-send-email-geert+renesas@glider.be>
References: <1401716301-29612-1-git-send-email-geert+renesas@glider.be>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
	Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1401716301-29612-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Refactor RSPI (on SH) DMA handling to make it reusable for other RSPI
implementations:
  - Call the DMA routines after configuring the TX Mode bit and after
    calling rspi_receive_init(), so these RSPI-specific operations can be
    removed from the DMA routines,
  - Absorb rspi_transfer_out_in() into rspi_transfer_one().

Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
---
 drivers/spi/spi-rspi.c | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 753ac7bdfd55..3dea8adfdcf3 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -480,7 +480,6 @@ static int rspi_send_dma(struct rspi_data *rspi, struct spi_transfer *t)
 	 */
 	disable_irq(rspi->tx_irq);
 
-	rspi_write8(rspi, rspi_read8(rspi, RSPI_SPCR) | SPCR_TXMD, RSPI_SPCR);
 	rspi_enable_irq(rspi, SPCR_SPTIE);
 	rspi->dma_callbacked = 0;
 
@@ -550,8 +549,6 @@ static int rspi_send_receive_dma(struct rspi_data *rspi, struct spi_transfer *t)
 	if (!desc_rx)
 		return -EIO;
 
-	rspi_receive_init(rspi);
-
 	/*
 	 * DMAC needs SPTIE, but if SPTIE is set, this IRQ routine will be
 	 * called. So, this driver disables the IRQ while DMA transfer.
@@ -560,7 +557,6 @@ static int rspi_send_receive_dma(struct rspi_data *rspi, struct spi_transfer *t)
 	if (rspi->rx_irq != rspi->tx_irq)
 		disable_irq(rspi->rx_irq);
 
-	rspi_write8(rspi, rspi_read8(rspi, RSPI_SPCR) & ~SPCR_TXMD, RSPI_SPCR);
 	rspi_enable_irq(rspi, SPCR_SPTIE | SPCR_SPRIE);
 	rspi->dma_callbacked = 0;
 
@@ -602,9 +598,10 @@ static bool rspi_can_dma(struct spi_master *master, struct spi_device *spi,
 	return __rspi_can_dma(rspi, xfer);
 }
 
-static int rspi_transfer_out_in(struct rspi_data *rspi,
-				struct spi_transfer *xfer)
+static int rspi_transfer_one(struct spi_master *master, struct spi_device *spi,
+			     struct spi_transfer *xfer)
 {
+	struct rspi_data *rspi = spi_master_get_devdata(master);
 	u8 spcr;
 	int ret;
 
@@ -617,6 +614,13 @@ static int rspi_transfer_out_in(struct rspi_data *rspi,
 	}
 	rspi_write8(rspi, spcr, RSPI_SPCR);
 
+	if (master->can_dma && __rspi_can_dma(rspi, xfer)) {
+		if (xfer->rx_buf)
+			return rspi_send_receive_dma(rspi, xfer);
+		else
+			return rspi_send_dma(rspi, xfer);
+	}
+
 	ret = rspi_pio_transfer(rspi, xfer->tx_buf, xfer->rx_buf, xfer->len);
 	if (ret < 0)
 		return ret;
@@ -627,20 +631,6 @@ static int rspi_transfer_out_in(struct rspi_data *rspi,
 	return 0;
 }
 
-static int rspi_transfer_one(struct spi_master *master, struct spi_device *spi,
-			     struct spi_transfer *xfer)
-{
-	struct rspi_data *rspi = spi_master_get_devdata(master);
-
-	if (!master->can_dma || !__rspi_can_dma(rspi, xfer))
-		return rspi_transfer_out_in(rspi, xfer);
-
-	if (xfer->rx_buf)
-		return rspi_send_receive_dma(rspi, xfer);
-	else
-		return rspi_send_dma(rspi, xfer);
-}
-
 static int rspi_rz_transfer_out_in(struct rspi_data *rspi,
 				   struct spi_transfer *xfer)
 {
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

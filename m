From: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
Subject: [PATCH 1/3] spi: clps711x: Simplify handling of RX & TX buffers
Date: Sun,  2 Feb 2014 10:59:48 +0400
Message-ID: <1391324390-17547-1-git-send-email-shc_work@mail.ru>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Signed-off-by: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
---
 drivers/spi/spi-clps711x.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-clps711x.c b/drivers/spi/spi-clps711x.c
index bee864d..0b80624 100644
--- a/drivers/spi/spi-clps711x.c
+++ b/drivers/spi/spi-clps711x.c
@@ -31,7 +31,6 @@ struct spi_clps711x_data {
 
 	u8			*tx_buf;
 	u8			*rx_buf;
-	int			count;
 	int			len;
 
 	int			chipselect[0];
@@ -92,11 +91,12 @@ static int spi_clps711x_transfer_one_message(struct spi_master *master,
 	struct spi_clps711x_data *hw = spi_master_get_devdata(master);
 	struct spi_transfer *xfer;
 	int status = 0, cs = hw->chipselect[msg->spi->chip_select];
-	u32 data;
 
 	spi_clps711x_setup_mode(msg->spi);
 
 	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
+		u8 data;
+
 		if (spi_clps711x_setup_xfer(msg->spi, xfer)) {
 			status = -EINVAL;
 			goto out_xfr;
@@ -106,13 +106,12 @@ static int spi_clps711x_transfer_one_message(struct spi_master *master,
 
 		reinit_completion(&hw->done);
 
-		hw->count = 0;
 		hw->len = xfer->len;
 		hw->tx_buf = (u8 *)xfer->tx_buf;
 		hw->rx_buf = (u8 *)xfer->rx_buf;
 
 		/* Initiate transfer */
-		data = hw->tx_buf ? hw->tx_buf[hw->count] : 0;
+		data = hw->tx_buf ? *hw->tx_buf++ : 0;
 		clps_writel(data | SYNCIO_FRMLEN(8) | SYNCIO_TXFRMEN, SYNCIO);
 
 		wait_for_completion(&hw->done);
@@ -137,18 +136,16 @@ out_xfr:
 static irqreturn_t spi_clps711x_isr(int irq, void *dev_id)
 {
 	struct spi_clps711x_data *hw = (struct spi_clps711x_data *)dev_id;
-	u32 data;
+	u8 data;
 
 	/* Handle RX */
 	data = clps_readb(SYNCIO);
 	if (hw->rx_buf)
-		hw->rx_buf[hw->count] = (u8)data;
-
-	hw->count++;
+		*hw->rx_buf++ = data;
 
 	/* Handle TX */
-	if (hw->count < hw->len) {
-		data = hw->tx_buf ? hw->tx_buf[hw->count] : 0;
+	if (--hw->len > 0) {
+		data = hw->tx_buf ? *hw->tx_buf++ : 0;
 		clps_writel(data | SYNCIO_FRMLEN(8) | SYNCIO_TXFRMEN, SYNCIO);
 	} else
 		complete(&hw->done);
-- 
1.8.3.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

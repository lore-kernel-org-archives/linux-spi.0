From: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
Subject: [PATCH 2/3] spi: clps711x: Add support for 1-8 BPW transfers
Date: Sun,  2 Feb 2014 10:59:49 +0400
Message-ID: <1391324390-17547-2-git-send-email-shc_work@mail.ru>
References: <1391324390-17547-1-git-send-email-shc_work@mail.ru>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1391324390-17547-1-git-send-email-shc_work-JGs/UdohzUI@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This patch adds support for 1 to 8 BPW to driver and removes
excess BPW validation since this is already checked by SPI core.

Signed-off-by: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
---
 drivers/spi/spi-clps711x.c | 39 ++++++++++++++++-----------------------
 1 file changed, 16 insertions(+), 23 deletions(-)

diff --git a/drivers/spi/spi-clps711x.c b/drivers/spi/spi-clps711x.c
index 0b80624..d9fa933 100644
--- a/drivers/spi/spi-clps711x.c
+++ b/drivers/spi/spi-clps711x.c
@@ -31,6 +31,7 @@ struct spi_clps711x_data {
 
 	u8			*tx_buf;
 	u8			*rx_buf;
+	unsigned int		bpw;
 	int			len;
 
 	int			chipselect[0];
@@ -56,18 +57,12 @@ static void spi_clps711x_setup_mode(struct spi_device *spi)
 		clps_writew(clps_readw(SYSCON3) & ~SYSCON3_ADCCKNSEN, SYSCON3);
 }
 
-static int spi_clps711x_setup_xfer(struct spi_device *spi,
-				   struct spi_transfer *xfer)
+static void spi_clps711x_setup_xfer(struct spi_device *spi,
+				    struct spi_transfer *xfer)
 {
 	u32 speed = xfer->speed_hz ? : spi->max_speed_hz;
-	u8 bpw = xfer->bits_per_word;
 	struct spi_clps711x_data *hw = spi_master_get_devdata(spi->master);
 
-	if (bpw != 8) {
-		dev_err(&spi->dev, "Unsupported master bus width %i\n", bpw);
-		return -EINVAL;
-	}
-
 	/* Setup SPI frequency divider */
 	if (!speed || (speed >= hw->max_speed_hz))
 		clps_writel((clps_readl(SYSCON1) & ~SYSCON1_ADCKSEL_MASK) |
@@ -81,38 +76,36 @@ static int spi_clps711x_setup_xfer(struct spi_device *spi,
 	else
 		clps_writel((clps_readl(SYSCON1) & ~SYSCON1_ADCKSEL_MASK) |
 			    SYSCON1_ADCKSEL(0), SYSCON1);
-
-	return 0;
 }
 
 static int spi_clps711x_transfer_one_message(struct spi_master *master,
 					     struct spi_message *msg)
 {
 	struct spi_clps711x_data *hw = spi_master_get_devdata(master);
+	struct spi_device *spi = msg->spi;
 	struct spi_transfer *xfer;
-	int status = 0, cs = hw->chipselect[msg->spi->chip_select];
+	int cs = hw->chipselect[spi->chip_select];
 
-	spi_clps711x_setup_mode(msg->spi);
+	spi_clps711x_setup_mode(spi);
 
 	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
 		u8 data;
 
-		if (spi_clps711x_setup_xfer(msg->spi, xfer)) {
-			status = -EINVAL;
-			goto out_xfr;
-		}
+		spi_clps711x_setup_xfer(spi, xfer);
 
-		gpio_set_value(cs, !!(msg->spi->mode & SPI_CS_HIGH));
+		gpio_set_value(cs, !!(spi->mode & SPI_CS_HIGH));
 
 		reinit_completion(&hw->done);
 
 		hw->len = xfer->len;
+		hw->bpw = xfer->bits_per_word ? : spi->bits_per_word;
 		hw->tx_buf = (u8 *)xfer->tx_buf;
 		hw->rx_buf = (u8 *)xfer->rx_buf;
 
 		/* Initiate transfer */
 		data = hw->tx_buf ? *hw->tx_buf++ : 0;
-		clps_writel(data | SYNCIO_FRMLEN(8) | SYNCIO_TXFRMEN, SYNCIO);
+		clps_writel(data | SYNCIO_FRMLEN(hw->bpw) | SYNCIO_TXFRMEN,
+			    SYNCIO);
 
 		wait_for_completion(&hw->done);
 
@@ -121,13 +114,12 @@ static int spi_clps711x_transfer_one_message(struct spi_master *master,
 
 		if (xfer->cs_change ||
 		    list_is_last(&xfer->transfer_list, &msg->transfers))
-			gpio_set_value(cs, !(msg->spi->mode & SPI_CS_HIGH));
+			gpio_set_value(cs, !(spi->mode & SPI_CS_HIGH));
 
 		msg->actual_length += xfer->len;
 	}
 
-out_xfr:
-	msg->status = status;
+	msg->status = 0;
 	spi_finalize_current_message(master);
 
 	return 0;
@@ -146,7 +138,8 @@ static irqreturn_t spi_clps711x_isr(int irq, void *dev_id)
 	/* Handle TX */
 	if (--hw->len > 0) {
 		data = hw->tx_buf ? *hw->tx_buf++ : 0;
-		clps_writel(data | SYNCIO_FRMLEN(8) | SYNCIO_TXFRMEN, SYNCIO);
+		clps_writel(data | SYNCIO_FRMLEN(hw->bpw) | SYNCIO_TXFRMEN,
+			    SYNCIO);
 	} else
 		complete(&hw->done);
 
@@ -180,7 +173,7 @@ static int spi_clps711x_probe(struct platform_device *pdev)
 
 	master->bus_num = pdev->id;
 	master->mode_bits = SPI_CPHA | SPI_CS_HIGH;
-	master->bits_per_word_mask = SPI_BPW_MASK(8);
+	master->bits_per_word_mask =  SPI_BPW_RANGE_MASK(1, 8);
 	master->num_chipselect = pdata->num_chipselect;
 	master->setup = spi_clps711x_setup;
 	master->transfer_one_message = spi_clps711x_transfer_one_message;
-- 
1.8.3.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

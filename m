From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [RFT][PATCH] spi: clps711x: Refactor to use core message parsing
Date: Mon, 17 Feb 2014 21:59:52 +0800
Message-ID: <1392645592.15727.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Convert to use default implementation of transfer_one_message() which provides
standard handling of delays and chip select management.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
Hi Alexander,
I don't have this hardware, can you help testing this patch.
Thanks,
Axel
 drivers/spi/spi-clps711x.c | 89 ++++++++++++++++++++--------------------------
 1 file changed, 38 insertions(+), 51 deletions(-)

diff --git a/drivers/spi/spi-clps711x.c b/drivers/spi/spi-clps711x.c
index f973e97..6ae0cbf 100644
--- a/drivers/spi/spi-clps711x.c
+++ b/drivers/spi/spi-clps711x.c
@@ -24,8 +24,6 @@
 #define DRIVER_NAME	"spi-clps711x"
 
 struct spi_clps711x_data {
-	struct completion	done;
-
 	struct clk		*spi_clk;
 	u32			max_speed_hz;
 
@@ -43,15 +41,6 @@ static int spi_clps711x_setup(struct spi_device *spi)
 	return 0;
 }
 
-static void spi_clps711x_setup_mode(struct spi_device *spi)
-{
-	/* Setup edge for transfer */
-	if (spi->mode & SPI_CPHA)
-		clps_writew(clps_readw(SYSCON3) | SYSCON3_ADCCKNSEN, SYSCON3);
-	else
-		clps_writew(clps_readw(SYSCON3) & ~SYSCON3_ADCCKNSEN, SYSCON3);
-}
-
 static void spi_clps711x_setup_xfer(struct spi_device *spi,
 				    struct spi_transfer *xfer)
 {
@@ -73,55 +62,52 @@ static void spi_clps711x_setup_xfer(struct spi_device *spi,
 			    SYSCON1_ADCKSEL(0), SYSCON1);
 }
 
-static int spi_clps711x_transfer_one_message(struct spi_master *master,
-					     struct spi_message *msg)
+static void spi_clps711x_set_cs(struct spi_device *spi, bool enable)
 {
-	struct spi_clps711x_data *hw = spi_master_get_devdata(master);
-	struct spi_device *spi = msg->spi;
-	struct spi_transfer *xfer;
-
-	spi_clps711x_setup_mode(spi);
-
-	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
-		u8 data;
-
-		spi_clps711x_setup_xfer(spi, xfer);
-
+	if (enable)
 		gpio_set_value(spi->cs_gpio, !!(spi->mode & SPI_CS_HIGH));
+	else
+		gpio_set_value(spi->cs_gpio, !(spi->mode & SPI_CS_HIGH));
+}
 
-		reinit_completion(&hw->done);
-
-		hw->len = xfer->len;
-		hw->bpw = xfer->bits_per_word ? : spi->bits_per_word;
-		hw->tx_buf = (u8 *)xfer->tx_buf;
-		hw->rx_buf = (u8 *)xfer->rx_buf;
-
-		/* Initiate transfer */
-		data = hw->tx_buf ? *hw->tx_buf++ : 0;
-		clps_writel(data | SYNCIO_FRMLEN(hw->bpw) | SYNCIO_TXFRMEN,
-			    SYNCIO);
+static int spi_clps711x_prepare_message(struct spi_master *master,
+					struct spi_message *msg)
+{
+	struct spi_device *spi = msg->spi;
 
-		wait_for_completion(&hw->done);
+	/* Setup edge for transfer */
+	if (spi->mode & SPI_CPHA)
+		clps_writew(clps_readw(SYSCON3) | SYSCON3_ADCCKNSEN, SYSCON3);
+	else
+		clps_writew(clps_readw(SYSCON3) & ~SYSCON3_ADCCKNSEN, SYSCON3);
 
-		if (xfer->delay_usecs)
-			udelay(xfer->delay_usecs);
+	return 0;
+}
 
-		if (xfer->cs_change ||
-		    list_is_last(&xfer->transfer_list, &msg->transfers))
-			gpio_set_value(spi->cs_gpio, !(spi->mode & SPI_CS_HIGH));
+static int spi_clps711x_transfer_one(struct spi_master *master,
+				     struct spi_device *spi,
+				     struct spi_transfer *xfer)
+{
+	struct spi_clps711x_data *hw = spi_master_get_devdata(master);
+	u8 data;
 
-		msg->actual_length += xfer->len;
-	}
+	spi_clps711x_setup_xfer(spi, xfer);
 
-	msg->status = 0;
-	spi_finalize_current_message(master);
+	hw->len = xfer->len;
+	hw->bpw = xfer->bits_per_word ? : spi->bits_per_word;
+	hw->tx_buf = (u8 *)xfer->tx_buf;
+	hw->rx_buf = (u8 *)xfer->rx_buf;
 
-	return 0;
+	/* Initiate transfer */
+	data = hw->tx_buf ? *hw->tx_buf++ : 0;
+	clps_writel(data | SYNCIO_FRMLEN(hw->bpw) | SYNCIO_TXFRMEN, SYNCIO);
+	return 1;
 }
 
 static irqreturn_t spi_clps711x_isr(int irq, void *dev_id)
 {
-	struct spi_clps711x_data *hw = (struct spi_clps711x_data *)dev_id;
+	struct spi_master *master = dev_id;
+	struct spi_clps711x_data *hw = spi_master_get_devdata(master);
 	u8 data;
 
 	/* Handle RX */
@@ -135,7 +121,7 @@ static irqreturn_t spi_clps711x_isr(int irq, void *dev_id)
 		clps_writel(data | SYNCIO_FRMLEN(hw->bpw) | SYNCIO_TXFRMEN,
 			    SYNCIO);
 	} else
-		complete(&hw->done);
+		complete(&master->xfer_completion);
 
 	return IRQ_HANDLED;
 }
@@ -173,7 +159,9 @@ static int spi_clps711x_probe(struct platform_device *pdev)
 	master->bits_per_word_mask =  SPI_BPW_RANGE_MASK(1, 8);
 	master->num_chipselect = pdata->num_chipselect;
 	master->setup = spi_clps711x_setup;
-	master->transfer_one_message = spi_clps711x_transfer_one_message;
+	master->set_cs = spi_clps711x_set_cs;
+	master->prepare_message = spi_clps711x_prepare_message;
+	master->transfer_one = spi_clps711x_transfer_one;
 
 	hw = spi_master_get_devdata(master);
 
@@ -199,7 +187,6 @@ static int spi_clps711x_probe(struct platform_device *pdev)
 	}
 	hw->max_speed_hz = clk_get_rate(hw->spi_clk);
 
-	init_completion(&hw->done);
 	platform_set_drvdata(pdev, master);
 
 	/* Disable extended mode due hardware problems */
@@ -209,7 +196,7 @@ static int spi_clps711x_probe(struct platform_device *pdev)
 	clps_readl(SYNCIO);
 
 	ret = devm_request_irq(&pdev->dev, IRQ_SSEOTI, spi_clps711x_isr, 0,
-			       dev_name(&pdev->dev), hw);
+			       dev_name(&pdev->dev), master);
 	if (ret) {
 		dev_err(&pdev->dev, "Can't request IRQ\n");
 		goto err_out;
-- 
1.8.1.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

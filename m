From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v1] spi: pxa2xx: set clock divider according to rate
Date: Wed, 24 Jan 2018 13:59:52 +0200
Message-ID: <20180124115952.51765-1-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Skylake and recent Intel SoCs we have a fractional divider installed on the
reference clock for SPI host controller. It allows to much more precisely set
clock rate on the interface. Use it to get better rate approximation especially
on lowest speed.

This has been tested on updated version of clk-fractional-divider.c that uses
rational best approximation algorithm [1].

[1] http://www.spinics.net/lists/linux-clk/msg03135.html

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-pxa2xx.c | 30 +++++++++++++++++++++++-------
 drivers/spi/spi-pxa2xx.h |  1 +
 2 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 4cb515a3104c..1bbc7e116613 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -933,8 +933,9 @@ static unsigned int quark_x1000_get_clk_div(int rate, u32 *dds)
 
 static unsigned int ssp_get_clk_div(struct driver_data *drv_data, int rate)
 {
-	unsigned long ssp_clk = drv_data->master->max_speed_hz;
 	const struct ssp_device *ssp = drv_data->ssp;
+	struct chip_data *chip = drv_data->cur_chip;
+	unsigned long ssp_clk = chip->ssp_clk;
 
 	rate = min_t(int, ssp_clk, rate);
 
@@ -944,6 +945,19 @@ static unsigned int ssp_get_clk_div(struct driver_data *drv_data, int rate)
 		return (ssp_clk / rate - 1) & 0xfff;
 }
 
+static unsigned int spt_get_clk_div(struct driver_data *drv_data, int rate)
+{
+	const struct ssp_device *ssp = drv_data->ssp;
+	struct chip_data *chip = drv_data->cur_chip;
+	long round;
+
+	round = clk_round_rate(ssp->clk, rate);
+	clk_set_rate(ssp->clk, round);
+
+	chip->ssp_clk = round;
+	return ssp_get_clk_div(drv_data, rate);
+}
+
 static unsigned int pxa2xx_ssp_get_clk_div(struct driver_data *drv_data,
 					   int rate)
 {
@@ -951,10 +965,14 @@ static unsigned int pxa2xx_ssp_get_clk_div(struct driver_data *drv_data,
 		spi_get_ctldata(drv_data->master->cur_msg->spi);
 	unsigned int clk_div;
 
+	chip->ssp_clk = drv_data->master->max_speed_hz;
 	switch (drv_data->ssp_type) {
 	case QUARK_X1000_SSP:
 		clk_div = quark_x1000_get_clk_div(rate, &chip->dds_rate);
 		break;
+	case LPSS_SPT_SSP:
+		clk_div = spt_get_clk_div(drv_data, rate);
+		break;
 	default:
 		clk_div = ssp_get_clk_div(drv_data, rate);
 		break;
@@ -1132,14 +1150,12 @@ static void pump_transfers(unsigned long data)
 	/* NOTE:  PXA25x_SSP _could_ use external clocking ... */
 	cr0 = pxa2xx_configure_sscr0(drv_data, clk_div, bits);
 	if (!pxa25x_ssp_comp(drv_data))
-		dev_dbg(&message->spi->dev, "%u Hz actual, %s\n",
-			master->max_speed_hz
-				/ (1 + ((cr0 & SSCR0_SCR(0xfff)) >> 8)),
+		dev_dbg(&message->spi->dev, "%ld Hz actual, %s\n",
+			chip->ssp_clk / (1 + ((cr0 & SSCR0_SCR(0xfff)) >> 8)),
 			dma_mapped ? "DMA" : "PIO");
 	else
-		dev_dbg(&message->spi->dev, "%u Hz actual, %s\n",
-			master->max_speed_hz / 2
-				/ (1 + ((cr0 & SSCR0_SCR(0x0ff)) >> 8)),
+		dev_dbg(&message->spi->dev, "%ld Hz actual, %s\n",
+			chip->ssp_clk / 2 / (1 + ((cr0 & SSCR0_SCR(0xff)) >> 8)),
 			dma_mapped ? "DMA" : "PIO");
 
 	if (is_lpss_ssp(drv_data)) {
diff --git a/drivers/spi/spi-pxa2xx.h b/drivers/spi/spi-pxa2xx.h
index 94f7b0713281..368dc7ab9935 100644
--- a/drivers/spi/spi-pxa2xx.h
+++ b/drivers/spi/spi-pxa2xx.h
@@ -82,6 +82,7 @@ struct chip_data {
 	u16 lpss_rx_threshold;
 	u16 lpss_tx_threshold;
 	u8 enable_dma;
+	long ssp_clk;
 	union {
 		struct gpio_desc *gpiod_cs;
 		unsigned int frm;
-- 
2.15.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

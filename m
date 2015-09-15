From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 16/16] spi: pxa2xx: Remove cr0 variable from struct chip_data
Date: Tue, 15 Sep 2015 16:26:28 +0300
Message-ID: <1442323588-29642-16-git-send-email-jarkko.nikula@linux.intel.com>
References: <1442323588-29642-1-git-send-email-jarkko.nikula@linux.intel.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
	Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1442323588-29642-1-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

There hasn't been need to carry chip->cr0 after SPI core started to
validate speed_hz and bits_per_word transfer parameters. That effectively
caused that pump_transfers() always recalculated it and practically
chip->cr0 is used locally in setup() for debug prints only.

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-pxa2xx.c | 10 ++++------
 drivers/spi/spi-pxa2xx.h |  1 -
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 3948e6deb0f1..7a4cb07a5f47 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1105,6 +1105,7 @@ static int setup(struct spi_device *spi)
 	struct driver_data *drv_data = spi_master_get_devdata(spi->master);
 	unsigned int clk_div;
 	uint tx_thres, tx_hi_thres, rx_thres;
+	u32 cr0;
 
 	switch (drv_data->ssp_type) {
 	case QUARK_X1000_SSP:
@@ -1197,8 +1198,6 @@ static int setup(struct spi_device *spi)
 
 	clk_div = pxa2xx_ssp_get_clk_div(drv_data, chip, spi->max_speed_hz);
 
-	chip->cr0 = pxa2xx_configure_sscr0(drv_data, clk_div,
-					   spi->bits_per_word);
 	switch (drv_data->ssp_type) {
 	case QUARK_X1000_SSP:
 		chip->threshold = (QUARK_X1000_SSCR1_RxTresh(rx_thres)
@@ -1220,15 +1219,16 @@ static int setup(struct spi_device *spi)
 		chip->cr1 |= SSCR1_LBM;
 
 	/* NOTE:  PXA25x_SSP _could_ use external clocking ... */
+	cr0 = pxa2xx_configure_sscr0(drv_data, clk_div, spi->bits_per_word);
 	if (!pxa25x_ssp_comp(drv_data))
 		dev_dbg(&spi->dev, "%ld Hz actual, %s\n",
 			drv_data->max_clk_rate
-				/ (1 + ((chip->cr0 & SSCR0_SCR(0xfff)) >> 8)),
+				/ (1 + ((cr0 & SSCR0_SCR(0xfff)) >> 8)),
 			chip->enable_dma ? "DMA" : "PIO");
 	else
 		dev_dbg(&spi->dev, "%ld Hz actual, %s\n",
 			drv_data->max_clk_rate / 2
-				/ (1 + ((chip->cr0 & SSCR0_SCR(0x0ff)) >> 8)),
+				/ (1 + ((cr0 & SSCR0_SCR(0x0ff)) >> 8)),
 			chip->enable_dma ? "DMA" : "PIO");
 
 	if (spi->bits_per_word <= 8) {
@@ -1240,8 +1240,6 @@ static int setup(struct spi_device *spi)
 		chip->read = u16_reader;
 		chip->write = u16_writer;
 	} else if (spi->bits_per_word <= 32) {
-		if (!is_quark_x1000_ssp(drv_data))
-			chip->cr0 |= SSCR0_EDSS;
 		chip->n_bytes = 4;
 		chip->read = u32_reader;
 		chip->write = u32_writer;
diff --git a/drivers/spi/spi-pxa2xx.h b/drivers/spi/spi-pxa2xx.h
index 0875e985b90d..b91bda26bfa8 100644
--- a/drivers/spi/spi-pxa2xx.h
+++ b/drivers/spi/spi-pxa2xx.h
@@ -86,7 +86,6 @@ struct driver_data {
 };
 
 struct chip_data {
-	u32 cr0;
 	u32 cr1;
 	u32 dds_rate;
 	u32 psp;
-- 
2.5.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

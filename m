From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 1/2] spi: pxa2xx: Set the max_speed_hz of the master
Date: Fri, 25 Sep 2015 10:27:17 +0300
Message-ID: <1443166038-31658-1-git-send-email-jarkko.nikula@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>, linux-acpi@vger.kernel.org,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>
To: linux-spi@vger.kernel.org
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Carry input clock of the controller in max_speed_hz of struct spi_master
instead of in own driver data. They mean the same thing and more over now
the max_speed_hz is not even set here.

As an added bonus this allows SPI core to validate that transfer speed is
not beyond the maximum input clock. This is not a problem in spi-pxa2xx as
the driver doesn't use transfer speed parameter directly but via input
clock divider calculation which will top at divide by one. However it's
better to validate speed before passing it here.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 drivers/spi/spi-pxa2xx.c | 12 ++++++------
 drivers/spi/spi-pxa2xx.h |  3 ---
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 7a4cb07a5f47..36cbb0f10856 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -806,7 +806,7 @@ static unsigned int quark_x1000_get_clk_div(int rate, u32 *dds)
 
 static unsigned int ssp_get_clk_div(struct driver_data *drv_data, int rate)
 {
-	unsigned long ssp_clk = drv_data->max_clk_rate;
+	unsigned long ssp_clk = drv_data->master->max_speed_hz;
 	const struct ssp_device *ssp = drv_data->ssp;
 
 	rate = min_t(int, ssp_clk, rate);
@@ -1221,13 +1221,13 @@ static int setup(struct spi_device *spi)
 	/* NOTE:  PXA25x_SSP _could_ use external clocking ... */
 	cr0 = pxa2xx_configure_sscr0(drv_data, clk_div, spi->bits_per_word);
 	if (!pxa25x_ssp_comp(drv_data))
-		dev_dbg(&spi->dev, "%ld Hz actual, %s\n",
-			drv_data->max_clk_rate
+		dev_dbg(&spi->dev, "%u Hz actual, %s\n",
+			drv_data->master->max_speed_hz
 				/ (1 + ((cr0 & SSCR0_SCR(0xfff)) >> 8)),
 			chip->enable_dma ? "DMA" : "PIO");
 	else
-		dev_dbg(&spi->dev, "%ld Hz actual, %s\n",
-			drv_data->max_clk_rate / 2
+		dev_dbg(&spi->dev, "%u Hz actual, %s\n",
+			drv_data->master->max_speed_hz / 2
 				/ (1 + ((cr0 & SSCR0_SCR(0x0ff)) >> 8)),
 			chip->enable_dma ? "DMA" : "PIO");
 
@@ -1477,7 +1477,7 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 	/* Enable SOC clock */
 	clk_prepare_enable(ssp->clk);
 
-	drv_data->max_clk_rate = clk_get_rate(ssp->clk);
+	master->max_speed_hz = clk_get_rate(ssp->clk);
 
 	/* Load default SSP configuration */
 	pxa2xx_spi_write(drv_data, SSCR0, 0);
diff --git a/drivers/spi/spi-pxa2xx.h b/drivers/spi/spi-pxa2xx.h
index b91bda26bfa8..fd7a7bc91b9f 100644
--- a/drivers/spi/spi-pxa2xx.h
+++ b/drivers/spi/spi-pxa2xx.h
@@ -46,9 +46,6 @@ struct driver_data {
 	u32 clear_sr;
 	u32 mask_sr;
 
-	/* Maximun clock rate */
-	unsigned long max_clk_rate;
-
 	/* Message Transfer pump */
 	struct tasklet_struct pump_transfers;
 
-- 
2.5.3


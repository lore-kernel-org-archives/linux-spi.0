From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 6/7] spi: pxa2xx: Add support for multiple LPSS chip select signals
Date: Thu, 22 Oct 2015 16:44:44 +0300
Message-ID: <1445521485-2029-6-git-send-email-jarkko.nikula@linux.intel.com>
References: <1445521485-2029-1-git-send-email-jarkko.nikula@linux.intel.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1445521485-2029-1-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

LPSS SPI devices in a successor of Intel Sunrisepoint can have up to 4 chip
selects per port. SPI capabilities register bits 12:9 tell which are
enabled. For simplicity we assume chip selects are enabled one after
another without disabled chip selects between. For instance CS0 | CS1 | CS2
but not CS0 | CS1 | CS3.

This patch adds support for detecting the number of enabled chip selects
and adds output control to those LPSS SPI ports that have more than one
chip select signal.

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-pxa2xx.c | 48 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 43 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 672963653d3b..6851649d1b15 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -13,6 +13,7 @@
  * GNU General Public License for more details.
  */
 
+#include <linux/bitops.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/device.h>
@@ -64,6 +65,10 @@ MODULE_ALIAS("platform:pxa2xx-spi");
 #define GENERAL_REG_RXTO_HOLDOFF_DISABLE	BIT(24)
 #define SPI_CS_CONTROL_SW_MODE			BIT(0)
 #define SPI_CS_CONTROL_CS_HIGH			BIT(1)
+#define SPI_CS_CONTROL_CS_SEL_SHIFT		8
+#define SPI_CS_CONTROL_CS_SEL_MASK		(3 << SPI_CS_CONTROL_CS_SEL_SHIFT)
+#define SPI_CAPS_CS_EN_SHIFT			9
+#define SPI_CAPS_CS_EN_MASK			(0xf << SPI_CAPS_CS_EN_SHIFT)
 
 struct lpss_config {
 	/* LPSS offset from drv_data->ioaddr */
@@ -72,6 +77,7 @@ struct lpss_config {
 	int reg_general;
 	int reg_ssp;
 	int reg_cs_ctrl;
+	int reg_capabilities;
 	/* FIFO thresholds */
 	u32 rx_threshold;
 	u32 tx_threshold_lo;
@@ -85,6 +91,7 @@ static const struct lpss_config lpss_platforms[] = {
 		.reg_general = 0x08,
 		.reg_ssp = 0x0c,
 		.reg_cs_ctrl = 0x18,
+		.reg_capabilities = -1,
 		.rx_threshold = 64,
 		.tx_threshold_lo = 160,
 		.tx_threshold_hi = 224,
@@ -94,6 +101,7 @@ static const struct lpss_config lpss_platforms[] = {
 		.reg_general = 0x08,
 		.reg_ssp = 0x0c,
 		.reg_cs_ctrl = 0x18,
+		.reg_capabilities = -1,
 		.rx_threshold = 64,
 		.tx_threshold_lo = 160,
 		.tx_threshold_hi = 224,
@@ -103,6 +111,7 @@ static const struct lpss_config lpss_platforms[] = {
 		.reg_general = -1,
 		.reg_ssp = 0x20,
 		.reg_cs_ctrl = 0x24,
+		.reg_capabilities = 0xfc,
 		.rx_threshold = 1,
 		.tx_threshold_lo = 32,
 		.tx_threshold_hi = 56,
@@ -271,15 +280,34 @@ static void lpss_ssp_setup(struct driver_data *drv_data)
 static void lpss_ssp_cs_control(struct driver_data *drv_data, bool enable)
 {
 	const struct lpss_config *config;
-	u32 value;
+	u32 value, cs;
 
 	config = lpss_get_config(drv_data);
 
 	value = __lpss_ssp_read_priv(drv_data, config->reg_cs_ctrl);
-	if (enable)
+	if (enable) {
+		cs = drv_data->cur_msg->spi->chip_select;
+		cs <<= SPI_CS_CONTROL_CS_SEL_SHIFT;
+		if (cs != (value & SPI_CS_CONTROL_CS_SEL_MASK)) {
+			/*
+			 * When switching another chip select output active
+			 * the output must be selected first and wait 2 ssp_clk
+			 * cycles before changing state to active. Otherwise
+			 * a short glitch will occur on the previous chip
+			 * select since output select is latched but state
+			 * control is not.
+			 */
+			value &= ~SPI_CS_CONTROL_CS_SEL_MASK;
+			value |= cs;
+			__lpss_ssp_write_priv(drv_data,
+					      config->reg_cs_ctrl, value);
+			ndelay(1000000000 /
+			       (drv_data->master->max_speed_hz / 2));
+		}
 		value &= ~SPI_CS_CONTROL_CS_HIGH;
-	else
+	} else {
 		value |= SPI_CS_CONTROL_CS_HIGH;
+	}
 	__lpss_ssp_write_priv(drv_data, config->reg_cs_ctrl, value);
 }
 
@@ -1383,6 +1411,7 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 	struct spi_master *master;
 	struct driver_data *drv_data;
 	struct ssp_device *ssp;
+	const struct lpss_config *config;
 	int status;
 	u32 tmp;
 
@@ -1422,7 +1451,6 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LOOP;
 
 	master->bus_num = ssp->port_id;
-	master->num_chipselect = platform_info->num_chipselect;
 	master->dma_alignment = DMA_ALIGNMENT;
 	master->cleanup = cleanup;
 	master->setup = setup;
@@ -1505,8 +1533,18 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 	if (!is_quark_x1000_ssp(drv_data))
 		pxa2xx_spi_write(drv_data, SSPSP, 0);
 
-	if (is_lpss_ssp(drv_data))
+	if (is_lpss_ssp(drv_data)) {
 		lpss_ssp_setup(drv_data);
+		config = lpss_get_config(drv_data);
+		if (config->reg_capabilities >= 0) {
+			tmp = __lpss_ssp_read_priv(drv_data,
+						   config->reg_capabilities);
+			tmp &= SPI_CAPS_CS_EN_MASK;
+			tmp >>= SPI_CAPS_CS_EN_SHIFT;
+			platform_info->num_chipselect = ffz(tmp);
+		}
+	}
+	master->num_chipselect = platform_info->num_chipselect;
 
 	tasklet_init(&drv_data->pump_transfers, pump_transfers,
 		     (unsigned long)drv_data);
-- 
2.6.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

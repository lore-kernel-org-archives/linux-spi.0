From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 3/5] spi: pxa2xx: Detect number of enabled Intel LPSS SPI chip select signals
Date: Wed, 28 Oct 2015 15:13:41 +0200
Message-ID: <1446038023-8819-3-git-send-email-jarkko.nikula@linux.intel.com>
References: <1446038023-8819-1-git-send-email-jarkko.nikula@linux.intel.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1446038023-8819-1-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

SPI capabilities register located in private registers space of newer
Intel LPSS SPI host controllers tell in register bits 12:9 which chip
select signals are enabled.

Use that information for detecting the number of chip selects. For
simplicity we assume chip selects are enabled one after another without
disabled chip selects between. For instance CS0 | CS1 | CS2 but not
CS0 | CS1 | CS3.

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-pxa2xx.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 019f4dda2cf2..4f4edebdc29f 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -13,6 +13,7 @@
  * GNU General Public License for more details.
  */
 
+#include <linux/bitops.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/device.h>
@@ -66,6 +67,8 @@ MODULE_ALIAS("platform:pxa2xx-spi");
 #define LPSS_CS_CONTROL_CS_HIGH			BIT(1)
 #define LPSS_CS_CONTROL_CS_SEL_SHIFT		8
 #define LPSS_CS_CONTROL_CS_SEL_MASK		(3 << LPSS_CS_CONTROL_CS_SEL_SHIFT)
+#define LPSS_CAPS_CS_EN_SHIFT			9
+#define LPSS_CAPS_CS_EN_MASK			(0xf << LPSS_CAPS_CS_EN_SHIFT)
 
 struct lpss_config {
 	/* LPSS offset from drv_data->ioaddr */
@@ -74,6 +77,7 @@ struct lpss_config {
 	int reg_general;
 	int reg_ssp;
 	int reg_cs_ctrl;
+	int reg_capabilities;
 	/* FIFO thresholds */
 	u32 rx_threshold;
 	u32 tx_threshold_lo;
@@ -87,6 +91,7 @@ static const struct lpss_config lpss_platforms[] = {
 		.reg_general = 0x08,
 		.reg_ssp = 0x0c,
 		.reg_cs_ctrl = 0x18,
+		.reg_capabilities = -1,
 		.rx_threshold = 64,
 		.tx_threshold_lo = 160,
 		.tx_threshold_hi = 224,
@@ -96,6 +101,7 @@ static const struct lpss_config lpss_platforms[] = {
 		.reg_general = 0x08,
 		.reg_ssp = 0x0c,
 		.reg_cs_ctrl = 0x18,
+		.reg_capabilities = -1,
 		.rx_threshold = 64,
 		.tx_threshold_lo = 160,
 		.tx_threshold_hi = 224,
@@ -105,6 +111,7 @@ static const struct lpss_config lpss_platforms[] = {
 		.reg_general = -1,
 		.reg_ssp = 0x20,
 		.reg_cs_ctrl = 0x24,
+		.reg_capabilities = 0xfc,
 		.rx_threshold = 1,
 		.tx_threshold_lo = 32,
 		.tx_threshold_hi = 56,
@@ -1404,6 +1411,7 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 	struct spi_master *master;
 	struct driver_data *drv_data;
 	struct ssp_device *ssp;
+	const struct lpss_config *config;
 	int status;
 	u32 tmp;
 
@@ -1443,7 +1451,6 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LOOP;
 
 	master->bus_num = ssp->port_id;
-	master->num_chipselect = platform_info->num_chipselect;
 	master->dma_alignment = DMA_ALIGNMENT;
 	master->cleanup = cleanup;
 	master->setup = setup;
@@ -1529,6 +1536,19 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 	if (is_lpss_ssp(drv_data))
 		lpss_ssp_setup(drv_data);
 
+	if (is_lpss_ssp(drv_data)) {
+		lpss_ssp_setup(drv_data);
+		config = lpss_get_config(drv_data);
+		if (config->reg_capabilities >= 0) {
+			tmp = __lpss_ssp_read_priv(drv_data,
+						   config->reg_capabilities);
+			tmp &= LPSS_CAPS_CS_EN_MASK;
+			tmp >>= LPSS_CAPS_CS_EN_SHIFT;
+			platform_info->num_chipselect = ffz(tmp);
+		}
+	}
+	master->num_chipselect = platform_info->num_chipselect;
+
 	tasklet_init(&drv_data->pump_transfers, pump_transfers,
 		     (unsigned long)drv_data);
 
-- 
2.6.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Subject: [PATCH v3 4/5] spi: dw: add support for gpio controlled chip select
Date: Fri, 31 Jan 2014 12:07:47 +0200
Message-ID: <dcd482e399c06e67a8115214a3b6cf52b1f25338.1391162172.git.baruch@tkos.co.il>
References: <cover.1391162172.git.baruch@tkos.co.il>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1391162172.git.baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Also, use this opportunity to let spi_chip_sel() handle chip-select
deactivation as well.

Signed-off-by: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
---
 drivers/spi/spi-dw-mmio.c | 22 ++++++++++++++++++++++
 drivers/spi/spi-dw.c      | 18 ++++++++++++------
 drivers/spi/spi-dw.h      | 16 +++++++++++-----
 3 files changed, 45 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index 86d247ecd2d2..4167b6eb47d8 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -17,6 +17,7 @@
 #include <linux/scatterlist.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_gpio.h>
 
 #include "spi-dw.h"
 
@@ -80,6 +81,27 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
 	}
 	dws->max_freq = clk_get_rate(dwsmmio->clk);
 
+	if (pdev->dev.of_node) {
+		int i;
+
+		for (i = 0; i < dws->num_cs; i++) {
+			int cs_gpio = of_get_named_gpio(pdev->dev.of_node,
+					"cs-gpios", i);
+
+			if (cs_gpio == -EPROBE_DEFER) {
+				ret = cs_gpio;
+				goto out;
+			}
+
+			if (gpio_is_valid(cs_gpio)) {
+				ret = devm_gpio_request(&pdev->dev, cs_gpio,
+						dev_name(&pdev->dev));
+				if (ret)
+					goto out;
+			}
+		}
+	}
+
 	ret = dw_spi_add_host(&pdev->dev, dws);
 	if (ret)
 		goto out;
diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index cd05c0050325..2805f43ac35e 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -24,6 +24,7 @@
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
+#include <linux/gpio.h>
 
 #include "spi-dw.h"
 
@@ -36,9 +37,6 @@
 #define DONE_STATE	((void *)2)
 #define ERROR_STATE	((void *)-1)
 
-#define MRST_SPI_DEASSERT	0
-#define MRST_SPI_ASSERT		1
-
 /* Slave spi_dev related */
 struct chip_data {
 	u16 cr0;
@@ -273,8 +271,8 @@ static void giveback(struct dw_spi *dws)
 					struct spi_transfer,
 					transfer_list);
 
-	if (!last_transfer->cs_change && dws->cs_control)
-		dws->cs_control(MRST_SPI_DEASSERT);
+	if (!last_transfer->cs_change)
+		spi_chip_sel(dws, dws->cur_msg->spi, 0);
 
 	spi_finalize_current_message(dws->master);
 }
@@ -500,7 +498,7 @@ static void pump_transfers(unsigned long data)
 			dw_writew(dws, DW_SPI_CTRL0, cr0);
 
 		spi_set_clk(dws, clk_div ? clk_div : chip->clk_div);
-		spi_chip_sel(dws, spi->chip_select);
+		spi_chip_sel(dws, spi, 1);
 
 		/* Set the interrupt mask, for poll mode just disable all int */
 		spi_mask_intr(dws, 0xff);
@@ -551,6 +549,7 @@ static int dw_spi_setup(struct spi_device *spi)
 {
 	struct dw_spi_chip *chip_info = NULL;
 	struct chip_data *chip;
+	int ret;
 
 	/* Only alloc on first setup */
 	chip = spi_get_ctldata(spi);
@@ -604,6 +603,13 @@ static int dw_spi_setup(struct spi_device *spi)
 			| (spi->mode  << SPI_MODE_OFFSET)
 			| (chip->tmode << SPI_TMOD_OFFSET);
 
+	if (gpio_is_valid(spi->cs_gpio)) {
+		ret = gpio_direction_output(spi->cs_gpio,
+				!(spi->mode & SPI_CS_HIGH));
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 3fd7ab599ab4..6d2acad34f64 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -3,6 +3,7 @@
 
 #include <linux/io.h>
 #include <linux/scatterlist.h>
+#include <linux/gpio.h>
 
 /* Register offsets */
 #define DW_SPI_CTRL0			0x00
@@ -178,15 +179,20 @@ static inline void spi_set_clk(struct dw_spi *dws, u16 div)
 	dw_writel(dws, DW_SPI_BAUDR, div);
 }
 
-static inline void spi_chip_sel(struct dw_spi *dws, u16 cs)
+static inline void spi_chip_sel(struct dw_spi *dws, struct spi_device *spi,
+		int active)
 {
-	if (cs > dws->num_cs)
-		return;
+	u16 cs = spi->chip_select;
+	int gpio_val = active ? (spi->mode & SPI_CS_HIGH) :
+		!(spi->mode & SPI_CS_HIGH);
 
 	if (dws->cs_control)
-		dws->cs_control(1);
+		dws->cs_control(active);
+	if (gpio_is_valid(spi->cs_gpio))
+		gpio_set_value(spi->cs_gpio, gpio_val);
 
-	dw_writel(dws, DW_SPI_SER, 1 << cs);
+	if (active)
+		dw_writel(dws, DW_SPI_SER, 1 << cs);
 }
 
 /* Disable IRQ bits */
-- 
1.8.5.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

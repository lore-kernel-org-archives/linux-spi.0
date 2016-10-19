From: Milo Kim <woogyom.kim@gmail.com>
Subject: [PATCH 2/3] spi: sun6i: Support Allwinner H3 SPI controller
Date: Wed, 19 Oct 2016 23:02:33 +0900
Message-ID: <20161019140234.13518-3-woogyom.kim@gmail.com>
References: <20161019140234.13518-1-woogyom.kim@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Milo Kim <woogyom.kim@gmail.com>
To: Mark Brown <broonie@kernel.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161019140234.13518-1-woogyom.kim@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

H3 has two SPI controllers. The size of the buffer is 64 * 8.
(8 bit transfer by 64 entry FIFO)
A31 has four controllers. The size of the buffer is 128 * 8.
(8 bit transfer by 128 entry FIFO)

Register maps are sharable, so sun6i SPI driver is reusable with
device configuration.

Use the variable, 'fifo_depth' instead of fixed value to support both SPI
controllers.

Cc: Mark Brown <broonie@kernel.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
---
 drivers/spi/Kconfig     |  4 ++--
 drivers/spi/spi-sun6i.c | 38 +++++++++++++++++++++++++++-----------
 2 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index b799547..06d0845 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -610,11 +610,11 @@ config SPI_SUN4I
 	  SPI driver for Allwinner sun4i, sun5i and sun7i SoCs
 
 config SPI_SUN6I
-	tristate "Allwinner A31 SPI controller"
+	tristate "Allwinner A31/H3 SPI controller"
 	depends on ARCH_SUNXI || COMPILE_TEST
 	depends on RESET_CONTROLLER
 	help
-	  This enables using the SPI controller on the Allwinner A31 SoCs.
+	  This enables using the SPI controller on the Allwinner A31/H3 SoCs.
 
 config SPI_MXS
 	tristate "Freescale MXS SPI controller"
diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index 9918a57..91235b2 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -17,6 +17,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
@@ -24,6 +25,7 @@
 #include <linux/spi/spi.h>
 
 #define SUN6I_FIFO_DEPTH		128
+#define SUN8I_FIFO_DEPTH		64
 
 #define SUN6I_GBL_CTL_REG		0x04
 #define SUN6I_GBL_CTL_BUS_ENABLE		BIT(0)
@@ -90,6 +92,7 @@ struct sun6i_spi {
 	const u8		*tx_buf;
 	u8			*rx_buf;
 	int			len;
+	int			fifo_depth;
 };
 
 static inline u32 sun6i_spi_read(struct sun6i_spi *sspi, u32 reg)
@@ -155,7 +158,9 @@ static void sun6i_spi_set_cs(struct spi_device *spi, bool enable)
 
 static size_t sun6i_spi_max_transfer_size(struct spi_device *spi)
 {
-	return SUN6I_FIFO_DEPTH - 1;
+	struct sun6i_spi *sspi = spi_master_get_devdata(spi->master);
+
+	return sspi->fifo_depth - 1;
 }
 
 static int sun6i_spi_transfer_one(struct spi_master *master,
@@ -170,7 +175,7 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 	u32 reg;
 
 	/* We don't support transfer larger than the FIFO */
-	if (tfr->len > SUN6I_FIFO_DEPTH)
+	if (tfr->len > sspi->fifo_depth)
 		return -EINVAL;
 
 	reinit_completion(&sspi->done);
@@ -265,7 +270,7 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 			SUN6I_BURST_CTL_CNT_STC(tx_len));
 
 	/* Fill the TX FIFO */
-	sun6i_spi_fill_fifo(sspi, SUN6I_FIFO_DEPTH);
+	sun6i_spi_fill_fifo(sspi, sspi->fifo_depth);
 
 	/* Enable the interrupts */
 	sun6i_spi_write(sspi, SUN6I_INT_CTL_REG, SUN6I_INT_CTL_TC);
@@ -288,7 +293,7 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 		goto out;
 	}
 
-	sun6i_spi_drain_fifo(sspi, SUN6I_FIFO_DEPTH);
+	sun6i_spi_drain_fifo(sspi, sspi->fifo_depth);
 
 out:
 	sun6i_spi_write(sspi, SUN6I_INT_CTL_REG, 0);
@@ -360,8 +365,16 @@ static int sun6i_spi_runtime_suspend(struct device *dev)
 	return 0;
 }
 
+static const struct of_device_id sun6i_spi_match[] = {
+	{ .compatible = "allwinner,sun6i-a31-spi", .data = (int *)SUN6I_FIFO_DEPTH },
+	{ .compatible = "allwinner,sun8i-h3-spi", .data = (int *)SUN8I_FIFO_DEPTH },
+	{}
+};
+MODULE_DEVICE_TABLE(of, sun6i_spi_match);
+
 static int sun6i_spi_probe(struct platform_device *pdev)
 {
+	const struct of_device_id *id;
 	struct spi_master *master;
 	struct sun6i_spi *sspi;
 	struct resource	*res;
@@ -398,6 +411,15 @@ static int sun6i_spi_probe(struct platform_device *pdev)
 	}
 
 	sspi->master = master;
+
+	id = of_match_device(sun6i_spi_match, &pdev->dev);
+	if (!id) {
+		dev_err(&pdev->dev, "Cannot get device ID\n");
+		goto err_free_master;
+	}
+
+	sspi->fifo_depth = (int)id->data;
+
 	master->max_speed_hz = 100 * 1000 * 1000;
 	master->min_speed_hz = 3 * 1000;
 	master->set_cs = sun6i_spi_set_cs;
@@ -469,12 +491,6 @@ static int sun6i_spi_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id sun6i_spi_match[] = {
-	{ .compatible = "allwinner,sun6i-a31-spi", },
-	{}
-};
-MODULE_DEVICE_TABLE(of, sun6i_spi_match);
-
 static const struct dev_pm_ops sun6i_spi_pm_ops = {
 	.runtime_resume		= sun6i_spi_runtime_resume,
 	.runtime_suspend	= sun6i_spi_runtime_suspend,
@@ -493,5 +509,5 @@ module_platform_driver(sun6i_spi_driver);
 
 MODULE_AUTHOR("Pan Nan <pannan@allwinnertech.com>");
 MODULE_AUTHOR("Maxime Ripard <maxime.ripard@free-electrons.com>");
-MODULE_DESCRIPTION("Allwinner A31 SPI controller driver");
+MODULE_DESCRIPTION("Allwinner A31/H3 SPI controller driver");
 MODULE_LICENSE("GPL");
-- 
2.9.3

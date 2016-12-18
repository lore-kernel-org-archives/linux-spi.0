From: Joel Holdsworth <joel-IJEoVVyKhCJXvIrf17iDB/XRex20P6io@public.gmane.org>
Subject: [PATCH v10 3/3] fpga: Add support for Lattice iCE40 FPGAs
Date: Sat, 17 Dec 2016 22:33:54 -0700
Message-ID: <1482039234-21335-3-git-send-email-joel@airwebreathe.org.uk>
References: <1482039234-21335-1-git-send-email-joel@airwebreathe.org.uk>
Cc: Joel Holdsworth <joel-IJEoVVyKhCJXvIrf17iDB/XRex20P6io@public.gmane.org>
To: atull-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org, moritz.fischer-+aYTwkv1SeIAvxtiuMwx3w@public.gmane.org,
        robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        marex-ynQEQJNshbs@public.gmane.org, linux-fpga-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1482039234-21335-1-git-send-email-joel-IJEoVVyKhCJXvIrf17iDB/XRex20P6io@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This patch adds support to the FPGA manager for configuring the SRAM of
iCE40LM, iCE40LP, iCE40HX, iCE40 Ultra, iCE40 UltraLite and iCE40
UltraPlus devices, through slave SPI.

Signed-off-by: Joel Holdsworth <joel-IJEoVVyKhCJXvIrf17iDB/XRex20P6io@public.gmane.org>
Reviewed-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Reviewed-by: Moritz Fischer <moritz.fischer-+aYTwkv1SeIAvxtiuMwx3w@public.gmane.org>
Acked-by: Alan Tull <atull-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
---
 drivers/fpga/Kconfig     |   6 ++
 drivers/fpga/Makefile    |   1 +
 drivers/fpga/ice40-spi.c | 219 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 226 insertions(+)
 create mode 100644 drivers/fpga/ice40-spi.c

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index ce861a2..967cda4 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -20,6 +20,12 @@ config FPGA_REGION
 	  FPGA Regions allow loading FPGA images under control of
 	  the Device Tree.
 
+config FPGA_MGR_ICE40_SPI
+	tristate "Lattice iCE40 SPI"
+	depends on OF && SPI
+	help
+	  FPGA manager driver support for Lattice iCE40 FPGAs over SPI.
+
 config FPGA_MGR_SOCFPGA
 	tristate "Altera SOCFPGA FPGA Manager"
 	depends on ARCH_SOCFPGA || COMPILE_TEST
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index 8df07bc..cc0d364 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -6,6 +6,7 @@
 obj-$(CONFIG_FPGA)			+= fpga-mgr.o
 
 # FPGA Manager Drivers
+obj-$(CONFIG_FPGA_MGR_ICE40_SPI)	+= ice40-spi.o
 obj-$(CONFIG_FPGA_MGR_SOCFPGA)		+= socfpga.o
 obj-$(CONFIG_FPGA_MGR_SOCFPGA_A10)	+= socfpga-a10.o
 obj-$(CONFIG_FPGA_MGR_ZYNQ_FPGA)	+= zynq-fpga.o
diff --git a/drivers/fpga/ice40-spi.c b/drivers/fpga/ice40-spi.c
new file mode 100644
index 0000000..16ea2c6
--- /dev/null
+++ b/drivers/fpga/ice40-spi.c
@@ -0,0 +1,219 @@
+/*
+ * FPGA Manager Driver for Lattice iCE40.
+ *
+ *  Copyright (c) 2016 Joel Holdsworth
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * This driver adds support to the FPGA manager for configuring the SRAM of
+ * Lattice iCE40 FPGAs through slave SPI.
+ */
+
+#include <linux/fpga/fpga-mgr.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/of_gpio.h>
+#include <linux/spi/spi.h>
+#include <linux/stringify.h>
+
+#define ICE40_SPI_MAX_SPEED 25000000 /* Hz */
+#define ICE40_SPI_MIN_SPEED 1000000 /* Hz */
+
+#define ICE40_SPI_RESET_DELAY 1 /* us (>200ns) */
+#define ICE40_SPI_HOUSEKEEPING_DELAY 1200 /* us */
+
+#define ICE40_SPI_NUM_ACTIVATION_BYTES DIV_ROUND_UP(49, 8)
+
+struct ice40_fpga_priv {
+	struct spi_device *dev;
+	struct gpio_desc *reset;
+	struct gpio_desc *cdone;
+};
+
+static enum fpga_mgr_states ice40_fpga_ops_state(struct fpga_manager *mgr)
+{
+	struct ice40_fpga_priv *priv = mgr->priv;
+
+	return gpiod_get_value(priv->cdone) ? FPGA_MGR_STATE_OPERATING :
+		FPGA_MGR_STATE_UNKNOWN;
+}
+
+static int ice40_fpga_ops_write_init(struct fpga_manager *mgr,
+				     struct fpga_image_info *info,
+				     const char *buf, size_t count)
+{
+	struct ice40_fpga_priv *priv = mgr->priv;
+	struct spi_device *dev = priv->dev;
+	struct spi_message message;
+	struct spi_transfer assert_cs_then_reset_delay = {
+		.cs_change   = 1,
+		.delay_usecs = ICE40_SPI_RESET_DELAY
+	};
+	struct spi_transfer housekeeping_delay_then_release_cs = {
+		.delay_usecs = ICE40_SPI_HOUSEKEEPING_DELAY
+	};
+	int ret;
+
+	if ((info->flags & FPGA_MGR_PARTIAL_RECONFIG)) {
+		dev_err(&dev->dev,
+			"Partial reconfiguration is not supported\n");
+		return -ENOTSUPP;
+	}
+
+	/* Lock the bus, assert CRESET_B and SS_B and delay >200ns */
+	spi_bus_lock(dev->master);
+
+	gpiod_set_value(priv->reset, 1);
+
+	spi_message_init(&message);
+	spi_message_add_tail(&assert_cs_then_reset_delay, &message);
+	ret = spi_sync_locked(dev, &message);
+
+	/* Come out of reset */
+	gpiod_set_value(priv->reset, 0);
+
+	/* Abort if the chip-select failed */
+	if (ret)
+		goto fail;
+
+	/* Check CDONE is de-asserted i.e. the FPGA is reset */
+	if (gpiod_get_value(priv->cdone)) {
+		dev_err(&dev->dev, "Device reset failed, CDONE is asserted\n");
+		ret = -EIO;
+		goto fail;
+	}
+
+	/* Wait for the housekeeping to complete, and release SS_B */
+	spi_message_init(&message);
+	spi_message_add_tail(&housekeeping_delay_then_release_cs, &message);
+	ret = spi_sync_locked(dev, &message);
+
+fail:
+	spi_bus_unlock(dev->master);
+
+	return ret;
+}
+
+static int ice40_fpga_ops_write(struct fpga_manager *mgr,
+				const char *buf, size_t count)
+{
+	struct ice40_fpga_priv *priv = mgr->priv;
+
+	return spi_write(priv->dev, buf, count);
+}
+
+static int ice40_fpga_ops_write_complete(struct fpga_manager *mgr,
+					 struct fpga_image_info *info)
+{
+	struct ice40_fpga_priv *priv = mgr->priv;
+	struct spi_device *dev = priv->dev;
+	const u8 padding[ICE40_SPI_NUM_ACTIVATION_BYTES] = {0};
+
+	/* Check CDONE is asserted */
+	if (!gpiod_get_value(priv->cdone)) {
+		dev_err(&dev->dev,
+			"CDONE was not asserted after firmware transfer\n");
+		return -EIO;
+	}
+
+	/* Send of zero-padding to activate the firmware */
+	return spi_write(dev, padding, sizeof(padding));
+}
+
+static const struct fpga_manager_ops ice40_fpga_ops = {
+	.state = ice40_fpga_ops_state,
+	.write_init = ice40_fpga_ops_write_init,
+	.write = ice40_fpga_ops_write,
+	.write_complete = ice40_fpga_ops_write_complete,
+};
+
+static int ice40_fpga_probe(struct spi_device *spi)
+{
+	struct device *dev = &spi->dev;
+	struct device_node *np = spi->dev.of_node;
+	struct ice40_fpga_priv *priv;
+	int ret;
+
+	if (!np) {
+		dev_err(dev, "No Device Tree entry\n");
+		return -EINVAL;
+	}
+
+	priv = devm_kzalloc(&spi->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = spi;
+
+	/* Check board setup data. */
+	if (spi->max_speed_hz > ICE40_SPI_MAX_SPEED) {
+		dev_err(dev, "SPI speed is too high, maximum speed is "
+			__stringify(ICE40_SPI_MAX_SPEED) "\n");
+		return -EINVAL;
+	}
+
+	if (spi->max_speed_hz < ICE40_SPI_MIN_SPEED) {
+		dev_err(dev, "SPI speed is too low, minimum speed is "
+			__stringify(ICE40_SPI_MIN_SPEED) "\n");
+		return -EINVAL;
+	}
+
+	if (spi->mode & SPI_CPHA) {
+		dev_err(dev, "Bad SPI mode, CPHA not supported\n");
+		return -EINVAL;
+	}
+
+	/* Set up the GPIOs */
+	priv->cdone = devm_gpiod_get(dev, "cdone", GPIOD_IN);
+	if (IS_ERR(priv->cdone)) {
+		dev_err(dev, "Failed to get CDONE GPIO: %ld\n",
+			PTR_ERR(priv->cdone));
+		return -EINVAL;
+	}
+
+	priv->reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(priv->reset)) {
+		dev_err(dev, "Failed to get CRESET_B GPIO: %ld\n",
+			PTR_ERR(priv->reset));
+		return -EINVAL;
+	}
+
+	/* Register with the FPGA manager */
+	ret = fpga_mgr_register(dev, "Lattice iCE40 FPGA Manager",
+				&ice40_fpga_ops, priv);
+	if (ret) {
+		dev_err(dev, "Unable to register FPGA manager");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int ice40_fpga_remove(struct spi_device *spi)
+{
+	fpga_mgr_unregister(&spi->dev);
+	return 0;
+}
+
+static const struct of_device_id ice40_fpga_of_match[] = {
+	{ .compatible = "lattice,ice40-fpga-mgr", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, ice40_fpga_of_match);
+
+static struct spi_driver ice40_fpga_driver = {
+	.probe = ice40_fpga_probe,
+	.remove = ice40_fpga_remove,
+	.driver = {
+		.name = "ice40spi",
+		.of_match_table = of_match_ptr(ice40_fpga_of_match),
+	},
+};
+
+module_spi_driver(ice40_fpga_driver);
+
+MODULE_AUTHOR("Joel Holdsworth <joel-IJEoVVyKhCJXvIrf17iDB/XRex20P6io@public.gmane.org>");
+MODULE_DESCRIPTION("Lattice iCE40 FPGA Manager");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Joel Holdsworth <joel-IJEoVVyKhCJXvIrf17iDB/XRex20P6io@public.gmane.org>
Subject: [PATCH v6 3/3] fpga: Add support for Lattice iCE40 FPGAs
Date: Mon, 31 Oct 2016 22:50:48 -0600
Message-ID: <1477975848-25715-3-git-send-email-joel@airwebreathe.org.uk>
References: <1477975848-25715-1-git-send-email-joel@airwebreathe.org.uk>
Cc: Joel Holdsworth <joel-IJEoVVyKhCJXvIrf17iDB/XRex20P6io@public.gmane.org>
To: atull-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org, moritz.fischer-+aYTwkv1SeIAvxtiuMwx3w@public.gmane.org,
        geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1477975848-25715-1-git-send-email-joel-IJEoVVyKhCJXvIrf17iDB/XRex20P6io@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The Lattice iCE40 is a family of FPGAs with a minimalistic architecture
and very regular structure, designed for low-cost, high-volume consumer
and system applications.

This patch adds support to the FPGA manager for configuring the SRAM of
iCE40LM, iCE40LP, iCE40HX, iCE40 Ultra, iCE40 UltraLite and iCE40
UltraPlus devices, through slave SPI.

The iCE40 family is notable because it is the first FPGA family to have
complete reverse engineered bit-stream documentation for the iCE40LP and
iCE40HX devices. Furthermore, there is now a Free Software Verilog
synthesis tool-chain: the "IceStorm" tool-chain.

This project is the work of Clifford Wolf, who is the maintainer of
Yosys Verilog RTL synthesis framework, and Mathias Lasser, with notable
contributions from "Cotton Seed", the main author of "arachne-pnr"; a
place-and-route tool for iCE40 FPGAs.

Having a Free Software synthesis tool-chain offers interesting
opportunities for embedded devices that are able reconfigure themselves
with open firmware that is generated on the device itself. For example
a mobile device might have an application processor with an iCE40 FPGA
attached, which implements slave devices, or through which the processor
communicates with other devices through the FPGA fabric.

A kernel driver for the iCE40 is useful, because in some cases, the FPGA
may need to be configured before other devices can be accessed.

An example of such a device is the icoBoard; a RaspberryPI HAT which
features an iCE40HX8K with a 1 or 8 MBit SRAM and ports for
Digilent-compatible PMOD modules. A PMOD module may contain a device
with which the kernel communicates, via the FPGA.
---
 drivers/fpga/Kconfig     |   6 ++
 drivers/fpga/Makefile    |   1 +
 drivers/fpga/ice40-spi.c | 219 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 226 insertions(+)
 create mode 100644 drivers/fpga/ice40-spi.c

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index d614102..85ff429 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -13,6 +13,12 @@ config FPGA
 
 if FPGA
 
+config FPGA_MGR_ICE40_SPI
+	tristate "Lattice iCE40 SPI"
+	depends on SPI
+	help
+	  FPGA manager driver support for Lattice iCE40 FPGAs over SPI.
+
 config FPGA_MGR_SOCFPGA
 	tristate "Altera SOCFPGA FPGA Manager"
 	depends on ARCH_SOCFPGA
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index 8d83fc6..adb5811 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -6,5 +6,6 @@
 obj-$(CONFIG_FPGA)			+= fpga-mgr.o
 
 # FPGA Manager Drivers
+obj-$(CONFIG_FPGA_MGR_ICE40_SPI)	+= ice40-spi.o
 obj-$(CONFIG_FPGA_MGR_SOCFPGA)		+= socfpga.o
 obj-$(CONFIG_FPGA_MGR_ZYNQ_FPGA)	+= zynq-fpga.o
diff --git a/drivers/fpga/ice40-spi.c b/drivers/fpga/ice40-spi.c
new file mode 100644
index 0000000..c39e6f0
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
+#include <linux/of_gpio.h>
+#include <linux/spi/spi.h>
+
+#define ICE40_SPI_FPGAMGR_RESET_DELAY 1 /* us (>200ns) */
+#define ICE40_SPI_FPGAMGR_HOUSEKEEPING_DELAY 1200 /* us */
+
+#define ICE40_SPI_FPGAMGR_NUM_ACTIVATION_BITS 49 /* bits */
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
+	return gpiod_get_value(priv->cdone) ? FPGA_MGR_STATE_OPERATING :
+		FPGA_MGR_STATE_UNKNOWN;
+}
+
+static int ice40_fpga_ops_write_init(struct fpga_manager *mgr, u32 flags,
+				     const char *buf, size_t count)
+{
+	struct ice40_fpga_priv *priv = mgr->priv;
+	struct spi_device *dev = priv->dev;
+	struct spi_message message;
+	int ret;
+
+	if ((flags & FPGA_MGR_PARTIAL_RECONFIG)) {
+		dev_err(&dev->dev,
+			"Partial reconfiguration is not supported\n");
+		return -ENOTSUPP;
+	}
+
+	/* Lock the bus, assert CRESET_B and SS_B and delay >200ns */
+	ret = spi_bus_lock(dev->master);
+	if (ret) {
+		dev_err(&dev->dev, "Failed to lock SPI bus, ret: %d\n", ret);
+		return ret;
+	}
+
+	gpiod_set_value(priv->reset, 1);
+
+	spi_message_init(&message);
+	spi_message_add_tail(&(struct spi_transfer){.cs_change = 1,
+		.delay_usecs = ICE40_SPI_FPGAMGR_RESET_DELAY}, &message);
+	ret = spi_sync_locked(dev, &message);
+	if (ret) {
+		dev_err(&dev->dev, "Failed to set chip-select, ret: %d\n", ret);
+		spi_bus_unlock(dev->master);
+		return ret;
+	}
+
+	/* Come out of reset */
+	gpiod_set_value(priv->reset, 0);
+
+	/* Check CDONE is de-asserted i.e. the FPGA is reset */
+	if (gpiod_get_value(priv->cdone)) {
+		dev_err(&dev->dev, "Device reset failed, CDONE is asserted\n");
+		ret = -EIO;
+	}
+
+	/* Wait for the housekeeping to complete, and release SS_B */
+	spi_message_init(&message);
+	spi_message_add_tail(&(struct spi_transfer){
+		.delay_usecs = ICE40_SPI_FPGAMGR_HOUSEKEEPING_DELAY}, &message);
+	ret = spi_sync_locked(dev, &message);
+	if (ret)
+		dev_err(&dev->dev, "Failed while releasing chip-select, ret: %d\n", ret);
+
+	spi_bus_unlock(dev->master);
+
+	return ret;
+}
+
+static int ice40_fpga_ops_write(struct fpga_manager *mgr,
+				const char *buf, size_t count)
+{
+	struct ice40_fpga_priv *priv = mgr->priv;
+	struct spi_device *dev = priv->dev;
+	int ret;
+
+	ret = spi_write(dev, buf, count);
+	if (ret)
+		dev_err(&dev->dev, "Error sending SPI data, ret: %d\n", ret);
+
+	return ret;
+}
+
+static int ice40_fpga_ops_write_complete(struct fpga_manager *mgr, u32 flags)
+{
+	struct ice40_fpga_priv *priv = mgr->priv;
+	struct spi_device *dev = priv->dev;
+	int ret = 0;
+
+	/* Check CDONE is asserted */
+	if (!gpiod_get_value(priv->cdone)) {
+		dev_err(&dev->dev,
+			"CDONE was not asserted after firmware transfer\n");
+		return -EIO;
+	}
+
+	/* Send of zero-padding to activate the firmware */
+	ret = spi_write(dev, NULL, (ICE40_SPI_FPGAMGR_NUM_ACTIVATION_BITS +
+			dev->bits_per_word - 1) / dev->bits_per_word);
+	if (ret) {
+		dev_err(&dev->dev, "Error sending zero padding, ret: %d\n",
+			ret);
+		return ret;
+	}
+
+	/* Success */
+	return 0;
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
+	if (spi->max_speed_hz > 25000000) {
+		dev_err(dev, "speed is too high\n");
+		return -EINVAL;
+	} else if (spi->mode & SPI_CPHA) {
+		dev_err(dev, "bad mode\n");
+		return -EINVAL;
+	}
+
+	/* Set up the GPIOs */
+	priv->cdone = devm_gpiod_get(dev, "cdone", GPIOD_IN);
+	if (IS_ERR(priv->cdone)) {
+		dev_err(dev, "Failed to get CDONE GPIO: %ld\n",
+			PTR_ERR(priv->cdone));
+		return ret;
+	}
+
+	priv->reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(priv->reset)) {
+		dev_err(dev, "Failed to get CRESET_B GPIO: %ld\n",
+			PTR_ERR(priv->reset));
+		return ret;
+	}
+
+	/* Register with the FPGA manager */
+	ret = fpga_mgr_register(dev, "Lattice iCE40 FPGA Manager",
+				&ice40_fpga_ops, priv);
+	if (ret) {
+		dev_err(dev, "unable to register FPGA manager");
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
+#ifdef CONFIG_OF
+static const struct of_device_id ice40_fpga_of_match[] = {
+	{ .compatible = "lattice,ice40-fpga-mgr", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, ice40_fpga_of_match);
+#endif
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

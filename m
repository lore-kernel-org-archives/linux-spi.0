From: Sergei Ianovich <ynvich@gmail.com>
Subject: [PATCH v3] spi: master driver to enable RTC on ICPDAS LP-8841
Date: Mon, 22 Feb 2016 14:57:42 +0300
Message-ID: <1456142265-12925-1-git-send-email-ynvich@gmail.com>
References: <1456105630-28914-1-git-send-email-ynvich@gmail.com>
Cc: Sergei Ianovich <ynvich@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
	DEVICE TREE BINDINGS),
	linux-spi@vger.kernel.org (open list:SPI SUBSYSTEM)
To: linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456105630-28914-1-git-send-email-ynvich@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

ICP DAS LP-8841 contains a DS-1302 RTC. This driver provides an SPI
master which makes the RTC usable. The driver is not supposed to work
with anything else.

The driver uses the standard MicroWire half-duplex transfer timing.
Master output is set on low clock and sensed by the RTC on the rising
edge. Master input is set by the RTC on the trailing edge and is sensed
by the master on low clock.

Signed-off-by: Sergei Ianovich <ynvich@gmail.com>
CC: Mark Brown <broonie@kernel.org>
---
   v2..v3 to fix Mark Brown review comments
   * drop dependencies in Kconfig
   * use #ifdef CONFIG_OF to allow build without DT
   * drop empty driver->remove

   v1..v2 to fix Mark Brown review comments
   * drop ifdef around MODULE_NAME
   * use usleep_range directly
   * drop empty master->cleanup

 .../devicetree/bindings/spi/spi-lp8841-rtc.txt     |  55 +++++
 drivers/spi/Kconfig                                |   9 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-lp8841-rtc.c                       | 255 +++++++++++++++++++++
 4 files changed, 320 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-lp8841-rtc.txt
 create mode 100644 drivers/spi/spi-lp8841-rtc.c

diff --git a/Documentation/devicetree/bindings/spi/spi-lp8841-rtc.txt b/Documentation/devicetree/bindings/spi/spi-lp8841-rtc.txt
new file mode 100644
index 0000000..f191aef
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-lp8841-rtc.txt
@@ -0,0 +1,55 @@
+* ICP DAS LP-8841 SPI Controller for RTC
+
+ICP DAS LP-8841 contains a DS-1302 RTC. This driver provides an SPI
+master which makes the RTC usable. The driver is not supposed to work
+with anything else.
+
+The driver uses the standard MicroWire half-duplex transfer timing.
+Master output is set on low clock and sensed by the RTC on the rising
+edge. Master input is set by the RTC on the trailing edge and is sensed
+by the master on low clock.
+
+Required properties:
+
+- #address-cells: should be 1
+
+- #size-cells: should be 0
+
+- compatible: should be "icpdas,spi-lp8841-rtc"
+
+- reg: should provide IO memory address
+
+Requirements to SPI slave nodes:
+
+- There can be only one slave device.
+
+- The spi slave node should claim the following flags which are
+  required by the spi controller.
+
+  - spi-3wire: The master itself has only 3 wire. It cannor work in
+    full duplex mode.
+
+  - spi-cs-high: DS-1302 has active high chip select line. The master
+    doesn't support active low.
+
+  - spi-lsb-first: DS-1302 requires least significant bit first
+    transfers. The master only support this type of bit ordering.
+
+
+Example:
+
+spi0@901c {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	compatible = "icpdas,spi-lp8841-rtc";
+	reg = <0x901c 0x1>;
+
+	rtc@0 {
+		compatible = "maxim,rtc-ds1302";
+		reg = <0>;
+		spi-max-frequency = <500000>;
+		spi-3wire;
+		spi-lsb-first;
+		spi-cs-high;
+	};
+};
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 7706416..6a6626a 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -271,6 +271,15 @@ config SPI_LM70_LLP
 	  which interfaces to an LM70 temperature sensor using
 	  a parallel port.
 
+config SPI_LP8841_RTC
+	tristate "ICP DAS LP-8841 SPI Controller for RTC"
+	help
+	  This driver provides an SPI master device to drive Maxim
+	  DS-1302 real time clock.
+
+	  Say N here unless you plan to run the kernel on an ICP DAS
+	  LP-8x4x industrial computer.
+
 config SPI_MPC52xx
 	tristate "Freescale MPC52xx SPI (non-PSC) controller support"
 	depends on PPC_MPC52xx
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 8991ffc..9d10ddc 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -46,6 +46,7 @@ obj-$(CONFIG_SPI_GPIO)			+= spi-gpio.o
 obj-$(CONFIG_SPI_IMG_SPFI)		+= spi-img-spfi.o
 obj-$(CONFIG_SPI_IMX)			+= spi-imx.o
 obj-$(CONFIG_SPI_LM70_LLP)		+= spi-lm70llp.o
+obj-$(CONFIG_SPI_LP8841_RTC)		+= spi-lp8841-rtc.o
 obj-$(CONFIG_SPI_MESON_SPIFC)		+= spi-meson-spifc.o
 obj-$(CONFIG_SPI_MPC512x_PSC)		+= spi-mpc512x-psc.o
 obj-$(CONFIG_SPI_MPC52xx_PSC)		+= spi-mpc52xx-psc.o
diff --git a/drivers/spi/spi-lp8841-rtc.c b/drivers/spi/spi-lp8841-rtc.c
new file mode 100644
index 0000000..ae177bc
--- /dev/null
+++ b/drivers/spi/spi-lp8841-rtc.c
@@ -0,0 +1,255 @@
+/*
+ * SPI master driver for ICP DAS LP-8841 RTC
+ *
+ * Copyright (C) 2016 Sergei Ianovich
+ *
+ * based on
+ *
+ * Dallas DS1302 RTC Support
+ * Copyright (C) 2002 David McCullough
+ * Copyright (C) 2003 - 2007 Paul Mundt
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/spi/spi.h>
+
+#define DRIVER_NAME	"spi_lp8841_rtc"
+
+#define SPI_LP8841_RTC_CE	0x01
+#define SPI_LP8841_RTC_CLK	0x02
+#define SPI_LP8841_RTC_nWE	0x04
+#define SPI_LP8841_RTC_MOSI	0x08
+#define SPI_LP8841_RTC_MISO	0x01
+
+/*
+ * REVISIT If there is support for SPI_3WIRE and SPI_LSB_FIRST in SPI
+ * GPIO driver, this SPI driver can be replaced by a simple GPIO driver
+ * providing 3 GPIO pins.
+ */
+
+struct spi_lp8841_rtc {
+	void		*iomem;
+	unsigned long	state;
+};
+
+static inline void
+setsck(struct spi_lp8841_rtc *data, int is_on)
+{
+	if (is_on)
+		data->state |= SPI_LP8841_RTC_CLK;
+	else
+		data->state &= ~SPI_LP8841_RTC_CLK;
+	writeb(data->state, data->iomem);
+}
+
+static inline void
+setmosi(struct spi_lp8841_rtc *data, int is_on)
+{
+	if (is_on)
+		data->state |= SPI_LP8841_RTC_MOSI;
+	else
+		data->state &= ~SPI_LP8841_RTC_MOSI;
+	writeb(data->state, data->iomem);
+}
+
+static inline int
+getmiso(struct spi_lp8841_rtc *data)
+{
+	return ioread8(data->iomem) & SPI_LP8841_RTC_MISO;
+}
+
+static inline u32
+bitbang_txrx_be_cpha0_lsb(struct spi_lp8841_rtc *data,
+		unsigned usecs, unsigned cpol, unsigned flags,
+		u32 word, u8 bits)
+{
+	/* if (cpol == 0) this is SPI_MODE_0; else this is SPI_MODE_2 */
+
+	u32 shift = 32 - bits;
+	/* clock starts at inactive polarity */
+	for (; likely(bits); bits--) {
+
+		/* setup LSB (to slave) on leading edge */
+		if ((flags & SPI_MASTER_NO_TX) == 0)
+			setmosi(data, (word & 1));
+
+		usleep_range(usecs, usecs + 1);	/* T(setup) */
+
+		/* sample LSB (from slave) on trailing edge */
+		word >>= 1;
+		if ((flags & SPI_MASTER_NO_RX) == 0)
+			word |= (getmiso(data) << 31);
+
+		setsck(data, !cpol);
+		usleep_range(usecs, usecs + 1);
+
+		setsck(data, cpol);
+	}
+
+	word >>= shift;
+	return word;
+}
+
+static int
+spi_lp8841_rtc_transfer_one(struct spi_master *master,
+			    struct spi_device *spi,
+			    struct spi_transfer *t)
+{
+	struct spi_lp8841_rtc	*data = spi_master_get_devdata(master);
+	unsigned		count = t->len;
+	const u8		*tx = t->tx_buf;
+	u8			*rx = t->rx_buf;
+	u8			word = 0;
+	int			ret = 0;
+
+	if (tx) {
+		data->state &= ~SPI_LP8841_RTC_nWE;
+		writeb(data->state, data->iomem);
+		while (likely(count > 0)) {
+			word = *tx++;
+			bitbang_txrx_be_cpha0_lsb(data, 1, 0,
+					SPI_MASTER_NO_RX, word, 8);
+			count--;
+		}
+	} else if (rx) {
+		data->state |= SPI_LP8841_RTC_nWE;
+		writeb(data->state, data->iomem);
+		while (likely(count > 0)) {
+			word = bitbang_txrx_be_cpha0_lsb(data, 1, 0,
+					SPI_MASTER_NO_TX, word, 8);
+			*rx++ = word;
+			count--;
+		}
+	} else {
+		ret = -EINVAL;
+	}
+
+	spi_finalize_current_transfer(master);
+
+	return ret;
+}
+
+static void
+spi_lp8841_rtc_set_cs(struct spi_device *spi, bool enable)
+{
+	struct spi_lp8841_rtc *data = spi_master_get_devdata(spi->master);
+
+	data->state = 0;
+	writeb(data->state, data->iomem);
+	if (enable) {
+		usleep_range(4, 5);
+		data->state |= SPI_LP8841_RTC_CE;
+		writeb(data->state, data->iomem);
+		usleep_range(4, 5);
+	}
+}
+
+static int
+spi_lp8841_rtc_setup(struct spi_device *spi)
+{
+	if ((spi->mode & SPI_CS_HIGH) == 0) {
+		dev_err(&spi->dev, "unsupported active low chip select\n");
+		return -EINVAL;
+	}
+
+	if ((spi->mode & SPI_LSB_FIRST) == 0) {
+		dev_err(&spi->dev, "unsupported MSB first mode\n");
+		return -EINVAL;
+	}
+
+	if ((spi->mode & SPI_3WIRE) == 0) {
+		dev_err(&spi->dev, "unsupported wiring. 3 wires required\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id spi_lp8841_rtc_dt_ids[] = {
+	{ .compatible = "icpdas,spi-lp8841-rtc" },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(of, spi_lp8841_rtc_dt_ids);
+#endif
+
+static int
+spi_lp8841_rtc_probe(struct platform_device *pdev)
+{
+	int				ret;
+	struct spi_master		*master;
+	struct spi_lp8841_rtc		*data;
+	void				*iomem;
+
+	master = spi_alloc_master(&pdev->dev, sizeof(*data));
+	if (!master)
+		return -ENOMEM;
+	platform_set_drvdata(pdev, master);
+
+	master->flags = SPI_MASTER_HALF_DUPLEX;
+	master->mode_bits = SPI_CS_HIGH | SPI_3WIRE | SPI_LSB_FIRST;
+
+	master->bus_num = pdev->id;
+	master->num_chipselect = 1;
+	master->setup = spi_lp8841_rtc_setup;
+	master->set_cs = spi_lp8841_rtc_set_cs;
+	master->transfer_one = spi_lp8841_rtc_transfer_one;
+	master->bits_per_word_mask = SPI_BPW_MASK(8);
+#ifdef CONFIG_OF
+	master->dev.of_node = pdev->dev.of_node;
+#endif
+
+	data = spi_master_get_devdata(master);
+
+	iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	data->iomem =  devm_ioremap_resource(&pdev->dev, iomem);
+	if (IS_ERR(data->iomem)) {
+		dev_err(&pdev->dev, "failed to get IO address\n");
+		goto err_put_master;
+	}
+
+	/* register with the SPI framework */
+	ret = devm_spi_register_master(&pdev->dev, master);
+	if (ret) {
+		dev_err(&pdev->dev, "cannot register spi master\n");
+		goto err_put_master;
+	}
+
+	return ret;
+
+
+err_put_master:
+	spi_master_put(master);
+
+	return ret;
+}
+
+MODULE_ALIAS("platform:" DRIVER_NAME);
+
+static struct platform_driver spi_lp8841_rtc_driver = {
+	.driver = {
+		.name	= DRIVER_NAME,
+		.of_match_table = of_match_ptr(spi_lp8841_rtc_dt_ids),
+	},
+	.probe		= spi_lp8841_rtc_probe,
+};
+module_platform_driver(spi_lp8841_rtc_driver);
+
+MODULE_DESCRIPTION("SPI master driver for ICP DAS LP-8841 RTC");
+MODULE_AUTHOR("Sergei Ianovich");
+MODULE_LICENSE("GPL");
-- 
2.6.3

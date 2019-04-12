From: Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 3/3] spi: Add SPI bus gpio multiplexer
Date: Fri, 12 Apr 2019 17:02:13 +1200
Message-ID: <20190412050213.17698-4-chris.packham@alliedtelesis.co.nz>
References: <20190412050213.17698-1-chris.packham@alliedtelesis.co.nz>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Cc: Hamish Martin <hamish.martin@alliedtelesis.co.nz>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
To: broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190412050213.17698-1-chris.packham@alliedtelesis.co.nz>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This add support for a gpio based multiplexer for SPI buses. This can be
used in situations where the cs-gpios property does not work with the
hardware design. In particular this support situations where a single
gpio is used to select between two possible devices.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 drivers/spi/Kconfig        |   7 ++
 drivers/spi/Makefile       |   1 +
 drivers/spi/spi-mux-gpio.c | 169 +++++++++++++++++++++++++++++++++++++
 3 files changed, 177 insertions(+)
 create mode 100644 drivers/spi/spi-mux-gpio.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index f761655e2a36..bfb4bd5bc2f3 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -426,6 +426,13 @@ config SPI_MT65XX
 	  say Y or M here.If you are not sure, say N.
 	  SPI drivers for Mediatek MT65XX and MT81XX series ARM SoCs.
=20
+config SPI_MUX_GPIO
+	tristate "SPI bus gpio multiplexer"
+	help
+	  This selects the SPI bus gpio multiplexer.
+	  If you have a hardware design that requires multiplexing
+	  on the SPI bus say Y or M here. If you are not sure, say N.
+
 config SPI_NPCM_PSPI
 	tristate "Nuvoton NPCM PSPI Controller"
 	depends on ARCH_NPCM || COMPILE_TEST
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index d8fc03c9faa2..32d831374e1f 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -62,6 +62,7 @@ obj-$(CONFIG_SPI_MPC52xx)		+=3D spi-mpc52xx.o
 obj-$(CONFIG_SPI_MT65XX)                +=3D spi-mt65xx.o
 obj-$(CONFIG_SPI_MXIC)			+=3D spi-mxic.o
 obj-$(CONFIG_SPI_MXS)			+=3D spi-mxs.o
+obj-$(CONFIG_SPI_MUX_GPIO)		+=3D spi-mux-gpio.o
 obj-$(CONFIG_SPI_NPCM_PSPI)		+=3D spi-npcm-pspi.o
 obj-$(CONFIG_SPI_NUC900)		+=3D spi-nuc900.o
 obj-$(CONFIG_SPI_NXP_FLEXSPI)		+=3D spi-nxp-fspi.o
diff --git a/drivers/spi/spi-mux-gpio.c b/drivers/spi/spi-mux-gpio.c
new file mode 100644
index 000000000000..3666863a4e3f
--- /dev/null
+++ b/drivers/spi/spi-mux-gpio.c
@@ -0,0 +1,169 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 Allied Telesis
+ */
+
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/spi/spi.h>
+#include <linux/gpio/consumer.h>
+
+struct spi_mux_gpio {
+	struct gpio_descs *gpios;
+	struct spi_controller *ctlr;
+	struct spi_controller *parent_ctlr;
+	int chip_select;
+};
+
+static void spi_mux_set_cs(struct spi_device *spi, bool enable)
+{
+	DECLARE_BITMAP(values, BITS_PER_TYPE(spi->chip_select));
+	struct spi_mux_gpio *mux =3D spi_master_get_devdata(spi->controller);
+	struct spi_device spidev =3D *spi;
+
+	values[0] =3D spi->chip_select;
+
+	gpiod_set_array_value_cansleep(mux->gpios->ndescs,
+				       mux->gpios->desc,
+				       mux->gpios->info, values);
+
+	spidev.controller =3D mux->parent_ctlr;
+	spidev.master =3D mux->parent_ctlr;
+	spidev.chip_select =3D mux->chip_select;
+
+	mux->parent_ctlr->set_cs(&spidev, enable);
+}
+
+static int spi_mux_transfer_one(struct spi_controller *ctlr,
+				struct spi_device *spi,
+				struct spi_transfer *transfer)
+{
+	struct spi_mux_gpio *mux =3D spi_master_get_devdata(ctlr);
+	struct spi_device spidev =3D *spi;
+
+	spidev.controller =3D mux->parent_ctlr;
+	spidev.master =3D mux->parent_ctlr;
+	spidev.chip_select =3D mux->chip_select;
+
+	return mux->parent_ctlr->transfer_one(mux->parent_ctlr, &spidev, transf=
er);
+
+}
+
+static int spi_mux_setup(struct spi_device *spi)
+{
+	struct spi_mux_gpio *mux =3D spi_master_get_devdata(spi->controller);
+	struct spi_device spidev =3D *spi;
+
+	spidev.controller =3D mux->parent_ctlr;
+	spidev.master =3D mux->parent_ctlr;
+	spidev.chip_select =3D mux->chip_select;
+
+	return mux->parent_ctlr->setup(&spidev);
+}
+
+static int spi_mux_gpio_probe(struct platform_device *pdev)
+{
+	struct device_node *np =3D pdev->dev.of_node;
+	struct device_node *parent;
+	struct spi_controller *parent_ctlr;
+	struct spi_controller *ctlr;
+	struct spi_mux_gpio *mux;
+	struct gpio_descs *gpios;
+	int ret;
+
+	gpios =3D devm_gpiod_get_array(&pdev->dev, NULL, GPIOD_OUT_LOW);
+	if (IS_ERR(gpios))
+		return PTR_ERR(gpios);
+
+	parent =3D of_parse_phandle(np, "spi-parent-bus", 0);
+	if (!parent)
+		return -ENODEV;
+
+	parent_ctlr =3D of_find_spi_controller_by_node(parent);
+	if (!parent_ctlr) {
+		ret =3D -EPROBE_DEFER;
+		goto err_put_node;
+	}
+
+	ctlr =3D spi_alloc_master(&pdev->dev, sizeof(*mux));
+	if (!ctlr) {
+		ret =3D -ENOMEM;
+		goto err_put_device;
+	}
+	mux =3D spi_master_get_devdata(ctlr);
+	platform_set_drvdata(pdev, mux);
+
+	ctlr->mode_bits =3D parent_ctlr->mode_bits;
+	ctlr->bits_per_word_mask =3D parent_ctlr->bits_per_word_mask;
+	ctlr->auto_runtime_pm =3D parent_ctlr->auto_runtime_pm;
+	ctlr->flags =3D parent_ctlr->flags;
+	ctlr->set_cs =3D spi_mux_set_cs;
+	ctlr->transfer_one =3D spi_mux_transfer_one;
+	ctlr->setup =3D spi_mux_setup;
+	ctlr->num_chipselect =3D of_get_available_child_count(np);
+	ctlr->bus_num =3D -1;
+
+	mux->gpios =3D gpios;
+	mux->ctlr =3D ctlr;
+	mux->parent_ctlr =3D parent_ctlr;
+	ret =3D of_property_read_u32(np, "spi-parent-cs",
+				   &mux->chip_select);
+	if (ret)
+		mux->chip_select =3D 0;
+
+	ctlr->dev.of_node =3D np;
+	ret =3D devm_spi_register_controller(&pdev->dev, ctlr);
+	if (ret) {
+		dev_err(&pdev->dev, "Error: failed to register SPI bus %pOF %d\n",
+			np, ret);
+		goto err_put_ctlr;
+	}
+
+	return 0;
+
+err_put_ctlr:
+	spi_controller_put(ctlr);
+err_put_device:
+	put_device(&parent_ctlr->dev);
+err_put_node:
+	of_node_put(parent);
+
+	return ret;
+}
+
+static int spi_mux_gpio_remove(struct platform_device *pdev)
+{
+	struct spi_mux_gpio *mux =3D platform_get_drvdata(pdev);
+
+	spi_controller_put(mux->ctlr);
+	put_device(&mux->parent_ctlr->dev);
+
+	return 0;
+}
+
+static const struct of_device_id spi_mux_gpio_of_match[] =3D {
+	{ .compatible =3D "spi-mux-gpio", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, spi_mux_gpio_of_match);
+
+static struct platform_driver spi_mux_gpio_driver =3D {
+	.probe	=3D spi_mux_gpio_probe,
+	.remove	=3D spi_mux_gpio_remove,
+	.driver	=3D {
+		.name	=3D "spi-mux-gpio",
+		.of_match_table =3D spi_mux_gpio_of_match,
+	},
+};
+
+module_platform_driver(spi_mux_gpio_driver);
+
+MODULE_DESCRIPTION("SPI bus mutliplexer driver");
+MODULE_AUTHOR("Allied Telesis");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:spi-mux-gpio");
--=20
2.21.0

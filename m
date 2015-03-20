From: Bert Vermeulen <bert@biot.com>
Subject: [PATCH 2/2] spi: Add driver for the CPLD chip on Mikrotik RB4xx boards
Date: Fri, 20 Mar 2015 13:16:33 +0100
Message-ID: <1426853793-24454-3-git-send-email-bert@biot.com>
References: <1426853793-24454-1-git-send-email-bert@biot.com>
Cc: Bert Vermeulen <bert@biot.com>
To: ralf@linux-mips.org, broonie@kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <1426853793-24454-1-git-send-email-bert@biot.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
List-Id: linux-spi.vger.kernel.org

The CPLD is connected to the NAND flash chip and five LEDs. Access to
those devices goes via this driver.

Signed-off-by: Bert Vermeulen <bert@biot.com>
---
 arch/mips/include/asm/mach-ath79/rb4xx_cpld.h |  41 ++++
 drivers/spi/Kconfig                           |   8 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-rb4xx-cpld.c                  | 326 ++++++++++++++++++++++++++
 4 files changed, 376 insertions(+)
 create mode 100644 arch/mips/include/asm/mach-ath79/rb4xx_cpld.h
 create mode 100644 drivers/spi/spi-rb4xx-cpld.c

diff --git a/arch/mips/include/asm/mach-ath79/rb4xx_cpld.h b/arch/mips/include/asm/mach-ath79/rb4xx_cpld.h
new file mode 100644
index 0000000..1df5a7e
--- /dev/null
+++ b/arch/mips/include/asm/mach-ath79/rb4xx_cpld.h
@@ -0,0 +1,41 @@
+/*
+ * SPI driver definitions for the CPLD chip on the Mikrotik RB4xx boards
+ *
+ * Copyright (C) 2010 Gabor Juhos <juhosg@openwrt.org>
+ *
+ * This file was based on the patches for Linux 2.6.27.39 published by
+ * MikroTik for their RouterBoard 4xx series devices.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
+
+#define CPLD_GPIO_nLED1		0
+#define CPLD_GPIO_nLED2		1
+#define CPLD_GPIO_nLED3		2
+#define CPLD_GPIO_nLED4		3
+#define CPLD_GPIO_FAN		4
+#define CPLD_GPIO_ALE		5
+#define CPLD_GPIO_CLE		6
+#define CPLD_GPIO_nCE		7
+#define CPLD_GPIO_nLED5		8
+
+#define CPLD_NUM_GPIOS		9
+
+#define CPLD_CFG_nLED1		BIT(CPLD_GPIO_nLED1)
+#define CPLD_CFG_nLED2		BIT(CPLD_GPIO_nLED2)
+#define CPLD_CFG_nLED3		BIT(CPLD_GPIO_nLED3)
+#define CPLD_CFG_nLED4		BIT(CPLD_GPIO_nLED4)
+#define CPLD_CFG_FAN		BIT(CPLD_GPIO_FAN)
+#define CPLD_CFG_ALE		BIT(CPLD_GPIO_ALE)
+#define CPLD_CFG_CLE		BIT(CPLD_GPIO_CLE)
+#define CPLD_CFG_nCE		BIT(CPLD_GPIO_nCE)
+#define CPLD_CFG_nLED5		BIT(CPLD_GPIO_nLED5)
+
+struct rb4xx_cpld_platform_data {
+	unsigned	gpio_base;
+};
+
+extern int rb4xx_cpld_read(unsigned char *rx_buf, unsigned cnt);
+extern int rb4xx_cpld_write(const unsigned char *buf, unsigned count);
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index aa76ce5..b32fa6a 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -435,6 +435,14 @@ config SPI_RB4XX
 	help
 	  SPI controller driver for the Mikrotik RB4xx series boards.
 
+config SPI_RB4XX_CPLD
+	tristate "MikroTik RB4XX CPLD driver"
+	depends on ATH79_MACH_RB4XX
+	help
+	  SPI driver for the Xilinx CPLD chip present on the MikroTik
+	  RB4xx boards. It controls CPU access to the NAND flash and
+	  user LEDs.
+
 config SPI_RSPI
 	tristate "Renesas RSPI/QSPI controller"
 	depends on SUPERH || ARCH_SHMOBILE || COMPILE_TEST
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 0218f39..c9bbdf9 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -67,6 +67,7 @@ obj-$(CONFIG_SPI_PXA2XX_PCI)		+= spi-pxa2xx-pci.o
 obj-$(CONFIG_SPI_QUP)			+= spi-qup.o
 obj-$(CONFIG_SPI_ROCKCHIP)		+= spi-rockchip.o
 obj-$(CONFIG_SPI_RB4XX)			+= spi-rb4xx.o
+obj-$(CONFIG_SPI_RB4XX_CPLD)		+= spi-rb4xx-cpld.o
 obj-$(CONFIG_SPI_RSPI)			+= spi-rspi.o
 obj-$(CONFIG_SPI_S3C24XX)		+= spi-s3c24xx-hw.o
 spi-s3c24xx-hw-y			:= spi-s3c24xx.o
diff --git a/drivers/spi/spi-rb4xx-cpld.c b/drivers/spi/spi-rb4xx-cpld.c
new file mode 100644
index 0000000..4e777e2
--- /dev/null
+++ b/drivers/spi/spi-rb4xx-cpld.c
@@ -0,0 +1,326 @@
+/*
+ * SPI driver for the CPLD chip on the Mikrotik RB4xx boards
+ *
+ * Copyright (C) 2010 Gabor Juhos <juhosg@openwrt.org>
+ *
+ * This file was based on the patches for Linux 2.6.27.39 published by
+ * MikroTik for their RouterBoard 4xx series devices.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
+
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/bitops.h>
+#include <linux/spi/spi.h>
+#include <linux/gpio.h>
+#include <linux/slab.h>
+
+#include <asm/mach-ath79/rb4xx_cpld.h>
+
+#define DRV_NAME	"spi-rb4xx-cpld"
+#define DRV_DESC	"RB4xx CPLD driver"
+#define DRV_VERSION	"0.1.0"
+
+#define CPLD_CMD_WRITE_NAND	0x08 /* send cmd, n x send data, send idle */
+#define CPLD_CMD_WRITE_CFG	0x09 /* send cmd, n x send cfg */
+#define CPLD_CMD_READ_NAND	0x0a /* send cmd, send idle, n x read data */
+#define CPLD_CMD_READ_FAST	0x0b /* send cmd, 4 x idle, n x read data */
+#define CPLD_CMD_LED5_ON	0x0c /* send cmd */
+#define CPLD_CMD_LED5_OFF	0x0d /* send cmd */
+
+struct rb4xx_cpld {
+	struct spi_device	*spi;
+	struct mutex		lock;
+	struct gpio_chip	chip;
+	unsigned int		config;
+};
+
+static struct rb4xx_cpld *rb4xx_cpld;
+
+static inline struct rb4xx_cpld *gpio_to_cpld(struct gpio_chip *chip)
+{
+	return container_of(chip, struct rb4xx_cpld, chip);
+}
+
+static int rb4xx_cpld_write_cmd(struct rb4xx_cpld *cpld, unsigned char cmd)
+{
+	struct spi_transfer t[1];
+	struct spi_message m;
+	unsigned char tx_buf[1];
+	int err;
+
+	spi_message_init(&m);
+	memset(&t, 0, sizeof(t));
+
+	t[0].tx_buf = tx_buf;
+	t[0].len = sizeof(tx_buf);
+	spi_message_add_tail(&t[0], &m);
+
+	tx_buf[0] = cmd;
+
+	err = spi_sync(cpld->spi, &m);
+	return err;
+}
+
+static int rb4xx_cpld_write_cfg(struct rb4xx_cpld *cpld, unsigned char config)
+{
+	struct spi_transfer t[1];
+	struct spi_message m;
+	unsigned char cmd[2];
+	int err;
+
+	spi_message_init(&m);
+	memset(&t, 0, sizeof(t));
+
+	t[0].tx_buf = cmd;
+	t[0].len = sizeof(cmd);
+	spi_message_add_tail(&t[0], &m);
+
+	cmd[0] = CPLD_CMD_WRITE_CFG;
+	cmd[1] = config;
+
+	err = spi_sync(cpld->spi, &m);
+	return err;
+}
+
+static int __rb4xx_cpld_change_cfg(struct rb4xx_cpld *cpld, unsigned mask,
+				   unsigned value)
+{
+	unsigned int config;
+	int err;
+
+	config = cpld->config & ~mask;
+	config |= value;
+
+	if ((cpld->config ^ config) & 0xff) {
+		err = rb4xx_cpld_write_cfg(cpld, config);
+		if (err)
+			return err;
+	}
+
+	if ((cpld->config ^ config) & CPLD_CFG_nLED5) {
+		err = rb4xx_cpld_write_cmd(cpld, (value) ? CPLD_CMD_LED5_ON :
+							   CPLD_CMD_LED5_OFF);
+		if (err)
+			return err;
+	}
+
+	cpld->config = config;
+	return 0;
+}
+
+int rb4xx_cpld_read(unsigned char *rx_buf, unsigned count)
+{
+	static const unsigned char cmd[2] = { CPLD_CMD_READ_NAND, 0 };
+	struct spi_transfer t[2] = {
+		{
+			.tx_buf = &cmd,
+			.len = 2,
+		}, {
+			.tx_buf = NULL,
+			.rx_buf = rx_buf,
+			.len = count,
+		},
+	};
+	struct spi_message m;
+
+	if (rb4xx_cpld == NULL)
+		return -ENODEV;
+
+	spi_message_init(&m);
+	spi_message_add_tail(&t[0], &m);
+	spi_message_add_tail(&t[1], &m);
+	return spi_sync(rb4xx_cpld->spi, &m);
+}
+EXPORT_SYMBOL_GPL(rb4xx_cpld_read);
+
+int rb4xx_cpld_write(const unsigned char *buf, unsigned count)
+{
+	static const unsigned char cmd = CPLD_CMD_WRITE_NAND;
+	struct spi_transfer t[3] = {
+		{
+			.tx_buf = &cmd,
+			.len = 1,
+		}, {
+			.tx_buf = buf,
+			.len = count,
+			.fast_write = 1,
+		}, {
+			.len = 1,
+			.fast_write = 1,
+		},
+	};
+	struct spi_message m;
+
+	if (rb4xx_cpld == NULL)
+		return -ENODEV;
+
+	spi_message_init(&m);
+	spi_message_add_tail(&t[0], &m);
+	spi_message_add_tail(&t[1], &m);
+	spi_message_add_tail(&t[2], &m);
+	return spi_sync(rb4xx_cpld->spi, &m);
+}
+EXPORT_SYMBOL_GPL(rb4xx_cpld_write);
+
+static int rb4xx_cpld_gpio_get(struct gpio_chip *chip, unsigned offset)
+{
+	struct rb4xx_cpld *cpld = gpio_to_cpld(chip);
+	int ret;
+
+	mutex_lock(&cpld->lock);
+	ret = (cpld->config >> offset) & 1;
+	mutex_unlock(&cpld->lock);
+
+	return ret;
+}
+
+static void rb4xx_cpld_gpio_set(struct gpio_chip *chip, unsigned offset,
+				int value)
+{
+	struct rb4xx_cpld *cpld = gpio_to_cpld(chip);
+
+	mutex_lock(&cpld->lock);
+	__rb4xx_cpld_change_cfg(cpld, (1 << offset), !!value << offset);
+	mutex_unlock(&cpld->lock);
+}
+
+static int rb4xx_cpld_gpio_direction_input(struct gpio_chip *chip,
+					   unsigned offset)
+{
+	return -EOPNOTSUPP;
+}
+
+static int rb4xx_cpld_gpio_direction_output(struct gpio_chip *chip,
+					    unsigned offset,
+					    int value)
+{
+	struct rb4xx_cpld *cpld = gpio_to_cpld(chip);
+	int ret;
+
+	mutex_lock(&cpld->lock);
+	ret = __rb4xx_cpld_change_cfg(cpld, (1 << offset), !!value << offset);
+	mutex_unlock(&cpld->lock);
+
+	return ret;
+}
+
+static int rb4xx_cpld_gpio_init(struct rb4xx_cpld *cpld, unsigned int base)
+{
+	int err;
+
+	/* init config */
+	cpld->config = CPLD_CFG_nLED1 | CPLD_CFG_nLED2 | CPLD_CFG_nLED3 |
+		       CPLD_CFG_nLED4 | CPLD_CFG_nLED5;
+	rb4xx_cpld_write_cfg(cpld, cpld->config);
+
+	/* setup GPIO chip */
+	cpld->chip.label = DRV_NAME;
+
+	cpld->chip.get = rb4xx_cpld_gpio_get;
+	cpld->chip.set = rb4xx_cpld_gpio_set;
+	cpld->chip.direction_input = rb4xx_cpld_gpio_direction_input;
+	cpld->chip.direction_output = rb4xx_cpld_gpio_direction_output;
+
+	cpld->chip.base = base;
+	cpld->chip.ngpio = CPLD_NUM_GPIOS;
+	cpld->chip.can_sleep = 1;
+	cpld->chip.dev = &cpld->spi->dev;
+	cpld->chip.owner = THIS_MODULE;
+
+	err = gpiochip_add(&cpld->chip);
+	if (err)
+		dev_err(&cpld->spi->dev, "adding GPIO chip failed, err=%d\n",
+			err);
+
+	return err;
+}
+
+static int rb4xx_cpld_probe(struct spi_device *spi)
+{
+	struct rb4xx_cpld *cpld;
+	struct rb4xx_cpld_platform_data *pdata;
+	int err;
+
+	pdata = spi->dev.platform_data;
+	if (!pdata) {
+		dev_dbg(&spi->dev, "no platform data\n");
+		return -EINVAL;
+	}
+
+	cpld = kzalloc(sizeof(*cpld), GFP_KERNEL);
+	if (!cpld)
+		return -ENOMEM;
+
+	mutex_init(&cpld->lock);
+	cpld->spi = spi_dev_get(spi);
+	dev_set_drvdata(&spi->dev, cpld);
+
+	spi->mode = SPI_MODE_0;
+	spi->bits_per_word = 8;
+	err = spi_setup(spi);
+	if (err) {
+		dev_err(&spi->dev, "spi_setup failed, err=%d\n", err);
+		goto err_drvdata;
+	}
+
+	err = rb4xx_cpld_gpio_init(cpld, pdata->gpio_base);
+	if (err)
+		goto err_drvdata;
+
+	rb4xx_cpld = cpld;
+
+	return 0;
+
+err_drvdata:
+	dev_set_drvdata(&spi->dev, NULL);
+	kfree(cpld);
+
+	return err;
+}
+
+static int rb4xx_cpld_remove(struct spi_device *spi)
+{
+	struct rb4xx_cpld *cpld;
+
+	rb4xx_cpld = NULL;
+	cpld = dev_get_drvdata(&spi->dev);
+	dev_set_drvdata(&spi->dev, NULL);
+	kfree(cpld);
+
+	return 0;
+}
+
+static struct spi_driver rb4xx_cpld_driver = {
+	.driver = {
+		.name		= DRV_NAME,
+		.bus		= &spi_bus_type,
+		.owner		= THIS_MODULE,
+	},
+	.probe		= rb4xx_cpld_probe,
+	.remove		= rb4xx_cpld_remove,
+};
+
+static int __init rb4xx_cpld_init(void)
+{
+	return spi_register_driver(&rb4xx_cpld_driver);
+}
+module_init(rb4xx_cpld_init);
+
+static void __exit rb4xx_cpld_exit(void)
+{
+	spi_unregister_driver(&rb4xx_cpld_driver);
+}
+module_exit(rb4xx_cpld_exit);
+
+MODULE_DESCRIPTION(DRV_DESC);
+MODULE_VERSION(DRV_VERSION);
+MODULE_AUTHOR("Gabor Juhos <juhosg@openwrt.org>");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1

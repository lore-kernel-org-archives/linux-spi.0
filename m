From: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3] nand: Add NAND driver for Mikrotik RB4xx series boards
Date: Tue, 21 Jul 2015 13:29:04 -0700
Message-ID: <20150721202904.GK24125@google.com>
References: <1431689631-7217-1-git-send-email-bert@biot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, fransklaver-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bert Vermeulen <bert-Nh2F35Ii2RQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1431689631-7217-1-git-send-email-bert-Nh2F35Ii2RQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

+ linux-spi, linux-gpio

Hi Bert,

On Fri, May 15, 2015 at 01:33:51PM +0200, Bert Vermeulen wrote:
> The NAND chip containing the root filesystem is behind an SPI-connected
> CPLD. This driver uses the spi-rb4xx driver to communicate with the CPLD.
> 
> The CPLD also acts as a GPIO expander: the ALE/CLE/NCE pins are set via
> CPLD commands. Some LEDs on the board are also accessed this way.
> 
> Signed-off-by: Bert Vermeulen <bert-Nh2F35Ii2RQ@public.gmane.org>
> ---
> Changes in v3:
> - Add link to parent device
> Changes in v2:
> - Fix Kconfig dependencies and description
> - Move NAND partitions into platform data
> - Use gpiod API with lookup table, and devm_ as needed
> - Code cleanup

Sorry for the late review. A few small comments.

> 
>  arch/mips/include/asm/mach-ath79/rb4xx.h |  44 +++
>  drivers/mtd/nand/Kconfig                 |   7 +
>  drivers/mtd/nand/Makefile                |   1 +
>  drivers/mtd/nand/rb4xx_nand.c            | 484 +++++++++++++++++++++++++++++++
>  4 files changed, 536 insertions(+)
>  create mode 100644 arch/mips/include/asm/mach-ath79/rb4xx.h
>  create mode 100644 drivers/mtd/nand/rb4xx_nand.c
> 
> diff --git a/arch/mips/include/asm/mach-ath79/rb4xx.h b/arch/mips/include/asm/mach-ath79/rb4xx.h
> new file mode 100644
> index 0000000..667ea748
> --- /dev/null
> +++ b/arch/mips/include/asm/mach-ath79/rb4xx.h
> @@ -0,0 +1,44 @@
> +/*
> + * SPI driver definitions for the CPLD chip on the Mikrotik RB4xx boards
> + *
> + * Copyright (C) 2010 Gabor Juhos <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
> + *
> + * This file was based on the patches for Linux 2.6.27.39 published by
> + * MikroTik for their RouterBoard 4xx series devices.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published
> + * by the Free Software Foundation.
> + */
> +
> +#include <linux/spi/flash.h>
> +
> +#define RB4XX_GPIO_CPLD_BASE	32
> +
> +#define CPLD_GPIO_LED1		0
> +#define CPLD_GPIO_LED2		2
> +#define CPLD_GPIO_LED3		1
> +#define CPLD_GPIO_LED4		3
> +#define CPLD_GPIO_FAN		4
> +#define CPLD_GPIO_ALE		5
> +#define CPLD_GPIO_CLE		6
> +#define CPLD_GPIO_NCE		7
> +#define CPLD_GPIO_LED5		8
> +
> +#define CPLD_NUM_GPIOS		9
> +
> +#define CPLD_CFG_LED1		BIT(CPLD_GPIO_LED1)
> +#define CPLD_CFG_LED2		BIT(CPLD_GPIO_LED2)
> +#define CPLD_CFG_LED3		BIT(CPLD_GPIO_LED3)
> +#define CPLD_CFG_LED4		BIT(CPLD_GPIO_LED4)
> +#define CPLD_CFG_FAN		BIT(CPLD_GPIO_FAN)
> +#define CPLD_CFG_ALE		BIT(CPLD_GPIO_ALE)
> +#define CPLD_CFG_CLE		BIT(CPLD_GPIO_CLE)
> +#define CPLD_CFG_NCE		BIT(CPLD_GPIO_NCE)
> +#define CPLD_CFG_LED5		BIT(CPLD_GPIO_LED5)

Are the above definitions all really shared with others? I'd really
prefer hardware definitions like this stay local to the driver, if
possible.

> +
> +struct rb4xx_cpld_platform_data {
> +	unsigned gpio_base;

^^ This looks like you're trying to support a deprecated feature. I see
this comment on gpio_chip::base:

      @base: identifies the first GPIO number handled by this chip;
      or, if negative during registration, requests dynamic ID allocation.                                                              
      DEPRECATION: providing anything non-negative and nailing the base                                                                 
      base offset of GPIO chips is deprecated. Please pass -1 as base to                                                                
      let gpiolib select the chip base in all possible cases. We want to                                                                
      get rid of the static GPIO number space in the long run.         

So you probably need to kill the gpio_base code.

> +	struct flash_platform_data flash_data;

Do you really need this platform data? This helps to make the driver a
little less portable. And if you really need to configure a few things
(e.g., partitions), you can switch to device tree instead.

> +};
> +

^^^ git-am warns: new blank line at EOF.

> diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
> index 5897d8d..873639f 100644
> --- a/drivers/mtd/nand/Kconfig
> +++ b/drivers/mtd/nand/Kconfig
> @@ -530,4 +530,11 @@ config MTD_NAND_HISI504
>  	help
>  	  Enables support for NAND controller on Hisilicon SoC Hip04.
>  
> +config MTD_NAND_RB4XX
> +	tristate "NAND flash driver for Mikrotik RB4xx series boards"
> +	depends on MTD_NAND && SPI_RB4XX

Is this really dependent on the SPI driver? At least for the sake of
compile-testing, I think that's not true, and even more so if you kill
off the platform header / platform data.

And the MTD_NAND dependency is redundant, as the config entry is already
enclosed within the 'if MTD_NAND' block.

So maybe this?

	depends on SPI_RB4XX || COMPILE_TEST

> +	help
> +	  Enables support for the NAND flash chip on Mikrotik Routerboard
> +	  RB4xx series.
> +
>  endif # MTD_NAND
> diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile
> index 582bbd05..56dbd08 100644
> --- a/drivers/mtd/nand/Makefile
> +++ b/drivers/mtd/nand/Makefile
> @@ -52,5 +52,6 @@ obj-$(CONFIG_MTD_NAND_XWAY)		+= xway_nand.o
>  obj-$(CONFIG_MTD_NAND_BCM47XXNFLASH)	+= bcm47xxnflash/
>  obj-$(CONFIG_MTD_NAND_SUNXI)		+= sunxi_nand.o
>  obj-$(CONFIG_MTD_NAND_HISI504)	        += hisi504_nand.o
> +obj-$(CONFIG_MTD_NAND_RB4XX)	        += rb4xx_nand.o
>  
>  nand-objs := nand_base.o nand_bbt.o nand_timings.o
> diff --git a/drivers/mtd/nand/rb4xx_nand.c b/drivers/mtd/nand/rb4xx_nand.c
> new file mode 100644
> index 0000000..842c848
> --- /dev/null
> +++ b/drivers/mtd/nand/rb4xx_nand.c
> @@ -0,0 +1,484 @@
> +/*
> + * NAND flash driver for the MikroTik RouterBoard 4xx series
> + *
> + * Copyright (C) 2008-2011 Gabor Juhos <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
> + * Copyright (C) 2008 Imre Kaloz <kaloz-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
> + * Copyright (C) 2015 Bert Vermeulen <bert-Nh2F35Ii2RQ@public.gmane.org>
> + *
> + * This file was based on the driver for Linux 2.6.22 published by
> + * MikroTik for their RouterBoard 4xx series devices.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published
> + * by the Free Software Foundation.
> + */
> +
> +#include <linux/mtd/nand.h>
> +#include <linux/spi/spi.h>
> +#include <linux/platform_device.h>
> +#include <linux/gpio/driver.h>
> +#include <linux/gpio/consumer.h>
> +
> +#include <asm/mach-ath79/rb4xx.h>
> +
> +#define CPLD_CMD_WRITE_NAND	0x08
> +#define CPLD_CMD_WRITE_CFG	0x09
> +#define CPLD_CMD_READ_NAND	0x0a
> +#define CPLD_CMD_READ_FAST	0x0b
> +#define CPLD_CMD_LED5_ON	0x0c
> +#define CPLD_CMD_LED5_OFF	0x0d
> +
> +struct rb4xx_nand_info {
> +	struct nand_chip chip;
> +	struct mtd_info mtd;
> +	struct spi_device *spi_dev;
> +	struct gpio_desc *gpio_rdy;
> +	struct gpio_desc *gpio_ale;
> +	struct gpio_desc *gpio_cle;
> +	struct gpio_desc *gpio_nce;
> +};
> +
> +struct rb4xx_cpld {
> +	struct spi_device *spi;
> +	struct mutex lock;
> +	struct gpio_chip chip;
> +	unsigned int config;
> +};
> +
> +/*
> + * We need to use the OLD Yaffs-1 OOB layout, otherwise the RB bootloader
> + * will not be able to find the kernel that we load.
> + */
> +static struct nand_ecclayout rb4xx_nand_ecclayout = {
> +	.eccbytes = 6,
> +	.eccpos = { 8, 9, 10, 13, 14, 15 },
> +	.oobavail = 9,
> +	.oobfree = { { 0, 4 }, { 6, 2 }, { 11, 2 }, { 4, 1 } }
> +};
> +
> +static inline struct rb4xx_cpld *gpio_to_cpld(struct gpio_chip *chip)
> +{
> +	return container_of(chip, struct rb4xx_cpld, chip);
> +}
> +
> +static int rb4xx_cpld_write_cmd(struct rb4xx_cpld *cpld, unsigned char cmd)
> +{
> +	struct spi_transfer t;
> +	struct spi_message m;
> +
> +	spi_message_init(&m);
> +
> +	memset(&t, 0, sizeof(t));
> +	t.tx_buf = &cmd;
> +	t.len = sizeof(cmd);
> +	spi_message_add_tail(&t, &m);
> +	return spi_sync(cpld->spi, &m);
> +}
> +
> +static int rb4xx_cpld_write_cfg(struct rb4xx_cpld *cpld, unsigned char config)
> +{
> +	struct spi_transfer t;
> +	struct spi_message m;
> +	unsigned char cmd[2] = {
> +		CPLD_CMD_WRITE_CFG, config
> +	};
> +
> +	spi_message_init(&m);
> +
> +	memset(&t, 0, sizeof(t));
> +	t.tx_buf = cmd;
> +	t.len = sizeof(cmd);
> +	spi_message_add_tail(&t, &m);
> +	return spi_sync(cpld->spi, &m);
> +}
> +
> +static int rb4xx_cpld_change_cfg(struct rb4xx_cpld *cpld, u32 mask, u32 value)
> +{
> +	unsigned int config;
> +	int ret;
> +
> +	config = cpld->config & ~mask;
> +	config |= value;
> +
> +	if (mask & 0xff) {
> +		ret = rb4xx_cpld_write_cfg(cpld, config);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (mask & CPLD_CFG_LED5) {
> +		if (value & CPLD_CFG_LED5)
> +			ret = rb4xx_cpld_write_cmd(cpld, CPLD_CMD_LED5_ON);
> +		else
> +			ret = rb4xx_cpld_write_cmd(cpld, CPLD_CMD_LED5_OFF);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	cpld->config = config;
> +
> +	return 0;
> +}
> +
> +static int rb4xx_cpld_gpio_get(struct gpio_chip *chip, unsigned offset)
> +{
> +	struct rb4xx_cpld *cpld = gpio_to_cpld(chip);
> +	int value;
> +
> +	mutex_lock(&cpld->lock);
> +	value = (cpld->config >> offset) & 1;
> +	mutex_unlock(&cpld->lock);
> +
> +	return value;
> +}
> +
> +static void rb4xx_cpld_gpio_set(struct gpio_chip *chip,
> +				unsigned offset, int value)
> +{
> +	struct rb4xx_cpld *cpld = gpio_to_cpld(chip);
> +
> +	mutex_lock(&cpld->lock);
> +	rb4xx_cpld_change_cfg(cpld, (1 << offset), !!value << offset);
> +	mutex_unlock(&cpld->lock);
> +}
> +
> +static int rb4xx_cpld_gpio_direction_input(struct gpio_chip *chip,
> +					   unsigned offset)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static int rb4xx_cpld_gpio_direction_output(struct gpio_chip *chip,
> +					    unsigned offset, int value)
> +{
> +	struct rb4xx_cpld *cpld = gpio_to_cpld(chip);
> +	int ret;
> +
> +	mutex_lock(&cpld->lock);
> +	ret = rb4xx_cpld_change_cfg(cpld, (1 << offset), !!value << offset);
> +	mutex_unlock(&cpld->lock);
> +
> +	return ret;
> +}
> +
> +static int rb4xx_cpld_read(struct spi_device *spi, unsigned char *rx_buf,
> +			   unsigned len)
> +{
> +	struct spi_message m;
> +	static const unsigned char cmd[2] = {
> +		CPLD_CMD_READ_NAND, 0
> +	};
> +	struct spi_transfer t[2] = {
> +		{
> +			.tx_buf = &cmd,
> +			.len = sizeof(cmd),
> +		}, {
> +			.rx_buf = rx_buf,
> +			.len = len,
> +		},
> +	};
> +
> +	spi_message_init(&m);
> +	spi_message_add_tail(&t[0], &m);
> +	spi_message_add_tail(&t[1], &m);
> +	return spi_sync(spi, &m);
> +}
> +
> +static int rb4xx_cpld_write(struct spi_device *spi, const u8 *buf, int len)
> +{
> +	struct spi_message m;
> +	static const unsigned char cmd = CPLD_CMD_WRITE_NAND;
> +	struct spi_transfer t[3] = {
> +		{
> +			.tx_buf = &cmd,
> +			.len = sizeof(cmd),
> +		}, {
> +			.tx_buf = buf,
> +			.len = len,
> +			.tx_nbits = SPI_NBITS_DUAL,
> +		}, {
> +			.len = 1,
> +			.tx_nbits = SPI_NBITS_DUAL,
> +		},
> +	};
> +
> +	spi_message_init(&m);
> +	spi_message_add_tail(&t[0], &m);
> +	spi_message_add_tail(&t[1], &m);
> +	spi_message_add_tail(&t[2], &m);
> +	return spi_sync(spi, &m);
> +}
> +
> +static int rb4xx_nand_dev_ready(struct mtd_info *mtd)
> +{
> +	struct nand_chip *chip = mtd->priv;
> +	struct rb4xx_nand_info *info = chip->priv;
> +
> +	return gpiod_get_value_cansleep(info->gpio_rdy);
> +}
> +
> +static void rb4xx_nand_cmd_ctrl(struct mtd_info *mtd, int cmd,
> +				unsigned int ctrl)
> +{
> +	struct nand_chip *chip = mtd->priv;
> +	struct rb4xx_nand_info *info = chip->priv;
> +	u8 data = cmd;
> +	int ret;
> +
> +	if (ctrl & NAND_CTRL_CHANGE) {
> +		gpiod_set_value_cansleep(info->gpio_cle,
> +					(ctrl & NAND_CLE) ? 1 : 0);
> +		gpiod_set_value_cansleep(info->gpio_ale,
> +					(ctrl & NAND_ALE) ? 1 : 0);
> +		gpiod_set_value_cansleep(info->gpio_nce,
> +					(ctrl & NAND_NCE) ? 0 : 1);
> +	}
> +
> +	if (cmd != NAND_CMD_NONE) {
> +		ret = rb4xx_cpld_write(info->spi_dev, &data, 1);
> +		if (ret)
> +			pr_err("rb4xx_nand: write cmd failed, error %d\n", ret);
> +	}
> +}
> +
> +static unsigned char rb4xx_nand_read_byte(struct mtd_info *mtd)
> +{
> +	struct nand_chip *chip = mtd->priv;
> +	struct rb4xx_nand_info *info = chip->priv;
> +	unsigned char data;
> +	int ret;
> +
> +	ret = rb4xx_cpld_read(info->spi_dev, &data, 1);
> +	if (ret) {
> +		pr_err("rb4xx_nand: read data failed, error %d\n", ret);
> +		return 0xff;
> +	}
> +
> +	return data;
> +}
> +
> +static void rb4xx_nand_write_buf(struct mtd_info *mtd, const unsigned char *buf,
> +				 int len)
> +{
> +	struct nand_chip *chip = mtd->priv;
> +	struct rb4xx_nand_info *info = chip->priv;
> +	int ret;
> +
> +	ret = rb4xx_cpld_write(info->spi_dev, buf, len);
> +	if (ret)
> +		pr_err("rb4xx_nand: write buf failed, error %d\n", ret);
> +}
> +
> +static void rb4xx_nand_read_buf(struct mtd_info *mtd, unsigned char *buf,
> +				int len)
> +{
> +	struct nand_chip *chip = mtd->priv;
> +	struct rb4xx_nand_info *info = chip->priv;
> +	int ret;
> +
> +	ret = rb4xx_cpld_read(info->spi_dev, buf, len);
> +	if (ret)
> +		pr_err("rb4xx_nand: read buf failed, error %d\n", ret);
> +}
> +
> +static int rb4xx_cpld_gpio_init(struct rb4xx_cpld *cpld, unsigned int base)
> +{
> +	int ret;
> +
> +	cpld->chip.label = "rb4xx-cpld";
> +	cpld->chip.base = base;
> +	cpld->chip.ngpio = CPLD_NUM_GPIOS;
> +	cpld->chip.can_sleep = 1;
> +	cpld->chip.dev = &cpld->spi->dev;
> +	cpld->chip.get = rb4xx_cpld_gpio_get;
> +	cpld->chip.set = rb4xx_cpld_gpio_set;
> +	cpld->chip.direction_input = rb4xx_cpld_gpio_direction_input;
> +	cpld->chip.direction_output = rb4xx_cpld_gpio_direction_output;
> +
> +	ret = gpiochip_add(&cpld->chip);
> +	if (ret)
> +		dev_err(&cpld->spi->dev, "adding GPIO chip failed, error %d\n",
> +			ret);
> +
> +	return ret;
> +}
> +
> +static int rb4xx_cpld_probe(struct spi_device *spi)
> +{
> +	struct rb4xx_cpld *cpld;
> +	struct rb4xx_cpld_platform_data *pdata;
> +	int ret;
> +
> +	pdata = dev_get_platdata(&spi->dev);
> +	if (!pdata)
> +		return -ENODATA;
> +
> +	cpld = devm_kzalloc(&spi->dev, sizeof(*cpld), GFP_KERNEL);
> +	if (!cpld)
> +		return -ENOMEM;
> +
> +	mutex_init(&cpld->lock);
> +	cpld->spi = spi_dev_get(spi);
> +	dev_set_drvdata(&spi->dev, cpld);
> +
> +	ret = spi_setup(spi);
> +	if (ret) {
> +		dev_err(&spi->dev, "SPI setup failed, error %d\n", ret);
> +		return ret;
> +	}
> +
> +	return rb4xx_cpld_gpio_init(cpld, pdata->gpio_base);
> +}
> +
> +static int rb4xx_cpld_remove(struct spi_device *spi)
> +{
> +	struct rb4xx_cpld *cpld;
> +
> +	cpld = dev_get_drvdata(&spi->dev);
> +	gpiochip_remove(&cpld->chip);
> +	mutex_destroy(&cpld->lock);
> +
> +	return 0;
> +}
> +
> +static struct spi_driver rb4xx_cpld_driver = {
> +	.probe = rb4xx_cpld_probe,
> +	.remove = rb4xx_cpld_remove,
> +	.driver = {
> +		.name = "rb4xx-cpld",
> +		.owner = THIS_MODULE,
> +	},
> +};

I feel some deja vu here (did I make this comment before?); why do you
need to embed both a SPI and a platform driver here? It appears that the
NAND controller actually sits on the SPI bus, so this really is not a
platform driver; it's a SPI driver. Can you just kill off all the
platform_driver stuff and merge the probe functions?

Or if I'm missing something big, please do enlighten.

> +
> +static int rb4xx_nand_probe(struct platform_device *pdev)
> +{
> +	struct device *spi_dev;
> +	struct rb4xx_nand_info	*info;
> +	struct rb4xx_cpld_platform_data *pdata;
> +	int ret;
> +
> +	/*
> +	 * NAND chip is behind the CPLD on SPI bus 0 CS 1. Allow this
> +	 * to silently fail the second time around.
> +	 */
> +	spi_register_driver(&rb4xx_cpld_driver);

If you can do the above, then this "silently fails" stuff goes away.

> +
> +	/*
> +	 * Getting a handle on the SPI device above will fail the first time,
> +	 * but should succeed whenever that driver gets probed.
> +	 */
> +	spi_dev = bus_find_device_by_name(&spi_bus_type, NULL, "spi0.1");

This is really fragile, as you're using platform knowledge and naming
expectations as your only way to connect the NAND and SPI "devices". If
you merge the two drivers, you don't need this.

If merging the devices doesn't work, then you might either try something
with device tree + phandles to get the reference, or else you can just
pass pointers to the struct spi_device via platform data, rather than
trying to infer the relationship.

> +	if (!spi_dev)
> +		return -EPROBE_DEFER;
> +
> +	pdata = dev_get_platdata(spi_dev);
> +	if (!pdata)
> +		return -ENODATA;
> +
> +	info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
> +	if (!info)
> +		return -ENOMEM;
> +
> +	info->gpio_ale = devm_gpiod_get(&pdev->dev, "NAND ALE", GPIOD_OUT_LOW);
> +	if (IS_ERR(info->gpio_ale)) {
> +		dev_err(&pdev->dev, "unable to request gpio NAND ALE: %ld\n",
> +			PTR_ERR(info->gpio_ale));
> +		return -ENOENT;
> +	}
> +
> +	info->gpio_cle = devm_gpiod_get(&pdev->dev, "NAND CLE", GPIOD_OUT_LOW);
> +	if (IS_ERR(info->gpio_cle)) {
> +		dev_err(&pdev->dev, "unable to request gpio NAND CLE: %ld\n",
> +			PTR_ERR(info->gpio_cle));
> +		return -ENOENT;
> +	}
> +
> +	info->gpio_nce = devm_gpiod_get(&pdev->dev, "NAND NCE", GPIOD_OUT_LOW);
> +	if (IS_ERR(info->gpio_nce)) {
> +		dev_err(&pdev->dev, "unable to request gpio NAND NCE: %ld\n",
> +			PTR_ERR(info->gpio_nce));
> +		return -ENOENT;
> +	}
> +
> +	/* Platform GPIO, has no device to manage it. */
> +	info->gpio_rdy = gpiod_get(NULL, "NAND RDY", GPIOD_IN);
> +	if (IS_ERR(info->gpio_rdy)) {
> +		dev_err(&pdev->dev, "unable to request gpio RDY: %ld\n",
> +			PTR_ERR(info->gpio_rdy));
> +		return -ENOENT;
> +	}
> +
> +	info->spi_dev = container_of(spi_dev, struct spi_device, dev);
> +
> +	info->chip.priv	= info;
> +	info->mtd.priv	= &info->chip;
> +	info->mtd.owner	= THIS_MODULE;
> +	info->mtd.dev.parent = &pdev->dev;
> +
> +	info->chip.cmd_ctrl	= rb4xx_nand_cmd_ctrl;
> +	info->chip.dev_ready	= rb4xx_nand_dev_ready;
> +	info->chip.read_byte	= rb4xx_nand_read_byte;
> +	info->chip.write_buf	= rb4xx_nand_write_buf;
> +	info->chip.read_buf	= rb4xx_nand_read_buf;
> +
> +	info->chip.chip_delay	= 25;
> +	info->chip.ecc.mode	= NAND_ECC_SOFT;
> +
> +	platform_set_drvdata(pdev, info);
> +
> +	ret = nand_scan_ident(&info->mtd, 1, NULL);
> +	if (ret) {
> +		ret = -ENXIO;
> +		goto err_gpio;
> +	}
> +
> +	if (info->mtd.writesize == 512)
> +		info->chip.ecc.layout = &rb4xx_nand_ecclayout;
> +
> +	ret = nand_scan_tail(&info->mtd);
> +	if (ret) {
> +		ret = -ENXIO;
> +		goto err_gpio;
> +	}
> +
> +	ret = mtd_device_register(&info->mtd, pdata->flash_data.parts,
> +				  pdata->flash_data.nr_parts);
> +	if (ret)
> +		goto err_release_nand;
> +
> +	return 0;
> +
> +err_release_nand:
> +	nand_release(&info->mtd);
> +err_gpio:
> +	gpiod_put(info->gpio_rdy);
> +
> +	return ret;
> +}
> +
> +static int rb4xx_nand_remove(struct platform_device *pdev)
> +{
> +	struct rb4xx_nand_info *info = platform_get_drvdata(pdev);
> +
> +	nand_release(&info->mtd);
> +	gpiod_put(info->gpio_rdy);
> +	spi_unregister_driver(&rb4xx_cpld_driver);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver rb4xx_nand_driver = {
> +	.probe = rb4xx_nand_probe,
> +	.remove = rb4xx_nand_remove,
> +	.driver = {
> +		.name = "rb4xx-nand",
> +	},
> +};
> +
> +module_platform_driver(rb4xx_nand_driver);
> +
> +MODULE_DESCRIPTION("NAND flash driver for RouterBoard 4xx series");
> +MODULE_AUTHOR("Gabor Juhos <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>");
> +MODULE_AUTHOR("Imre Kaloz <kaloz-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>");
> +MODULE_AUTHOR("Bert Vermeulen <bert-Nh2F35Ii2RQ@public.gmane.org>");
> +MODULE_LICENSE("GPL v2");

Thanks,
Brian
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

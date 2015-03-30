From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 1/1] spi: Add SPI driver for Mikrotik RB4xx series boards
Date: Mon, 30 Mar 2015 22:14:40 +0300
Message-ID: <CAHp75Vcc1F8=Ne71Xr7XPovtOzAY7DLPLMOnbQAF8+cG_pOVmw@mail.gmail.com>
References: <1427739857-13395-1-git-send-email-bert@biot.com>
	<1427739857-13395-2-git-send-email-bert@biot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bert Vermeulen <bert-Nh2F35Ii2RQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1427739857-13395-2-git-send-email-bert-Nh2F35Ii2RQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Mon, Mar 30, 2015 at 9:24 PM, Bert Vermeulen <bert-Nh2F35Ii2RQ@public.gmane.org> wrote:
> This driver mediates access between the connected CPLD and other devices
> on the bus.
>
> The m25p80-compatible boot flash and (some models) MMC use regular SPI,
> bitbanged as required by the SoC. However the SPI-connected CPLD has
> a "fast write" mode, in which two bits are transferred by SPI clock
> cycle. The second bit is transmitted with the SoC's CS2 pin.
>
> Protocol drivers using this fast write facility signal this by setting
> the cs_change flag on transfers.

Looks nicer, still few comments below.

>
> Signed-off-by: Bert Vermeulen <bert-Nh2F35Ii2RQ@public.gmane.org>
> ---
>  drivers/spi/Kconfig     |   6 ++
>  drivers/spi/Makefile    |   1 +
>  drivers/spi/spi-rb4xx.c | 241 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 248 insertions(+)
>  create mode 100644 drivers/spi/spi-rb4xx.c
>
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index ab8dfbe..aa76ce5 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -429,6 +429,12 @@ config SPI_ROCKCHIP
>           The main usecase of this controller is to use spi flash as boot
>           device.
>
> +config SPI_RB4XX
> +       tristate "Mikrotik RB4XX SPI master"
> +       depends on SPI_MASTER && ATH79_MACH_RB4XX
> +       help
> +         SPI controller driver for the Mikrotik RB4xx series boards.
> +
>  config SPI_RSPI
>         tristate "Renesas RSPI/QSPI controller"
>         depends on SUPERH || ARCH_SHMOBILE || COMPILE_TEST
> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> index d8cbf65..0218f39 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -66,6 +66,7 @@ obj-$(CONFIG_SPI_PXA2XX)              += spi-pxa2xx-platform.o
>  obj-$(CONFIG_SPI_PXA2XX_PCI)           += spi-pxa2xx-pci.o
>  obj-$(CONFIG_SPI_QUP)                  += spi-qup.o
>  obj-$(CONFIG_SPI_ROCKCHIP)             += spi-rockchip.o
> +obj-$(CONFIG_SPI_RB4XX)                        += spi-rb4xx.o
>  obj-$(CONFIG_SPI_RSPI)                 += spi-rspi.o
>  obj-$(CONFIG_SPI_S3C24XX)              += spi-s3c24xx-hw.o
>  spi-s3c24xx-hw-y                       := spi-s3c24xx.o
> diff --git a/drivers/spi/spi-rb4xx.c b/drivers/spi/spi-rb4xx.c
> new file mode 100644
> index 0000000..9bbec9c
> --- /dev/null
> +++ b/drivers/spi/spi-rb4xx.c
> @@ -0,0 +1,241 @@
> +/*
> + * SPI controller driver for the Mikrotik RB4xx boards
> + *
> + * Copyright (C) 2010 Gabor Juhos <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
> + *

There are two authors below but only one old copyright. I guess there
is should be another one dated 2015.

> + * This file was based on the patches for Linux 2.6.27.39 published by
> + * MikroTik for their RouterBoard 4xx series devices.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/clk.h>
> +#include <linux/spi/spi.h>
> +
> +#include <asm/mach-ath79/ar71xx_regs.h>
> +
> +#define SPI_CLOCK_FASTEST      0x40
> +#define SPI_HZ                 33333334
> +#define CPLD_CMD_WRITE_NAND    0x08 /* bulk write mode */
> +
> +struct rb4xx_spi {
> +       void __iomem            *base;
> +       struct spi_master       *master;
> +};
> +
> +static inline void do_spi_clk(void __iomem *base, u32 spi_ioc, int value)
> +{
> +       u32 regval;
> +
> +       regval = spi_ioc;
> +       if (value & BIT(0))
> +               regval |= AR71XX_SPI_IOC_DO;
> +
> +       __raw_writel(regval, base + AR71XX_SPI_REG_IOC);
> +       __raw_writel(regval | AR71XX_SPI_IOC_CLK, base + AR71XX_SPI_REG_IOC);

So, why to avoid IO accessor helpers?

> +}
> +
> +static void do_spi_byte(void __iomem *base, u32 spi_ioc, u8 byte)
> +{
> +       int i;
> +
> +       for (i = 7; i >= 0; i--)

Just a matter of style, but you can use while-loop here as well.

> +               do_spi_clk(base, spi_ioc, byte >> i);
> +}
> +
> +static inline void do_spi_clk_fast(void __iomem *base, u32 spi_ioc, u8 value)
> +{
> +       u32 regval;
> +
> +       regval = spi_ioc;
> +       if (value & BIT(1))
> +               regval |= AR71XX_SPI_IOC_DO;
> +       if (value & BIT(0))
> +               regval |= AR71XX_SPI_IOC_CS2;
> +
> +       __raw_writel(regval, base + AR71XX_SPI_REG_IOC);
> +       __raw_writel(regval | AR71XX_SPI_IOC_CLK, base + AR71XX_SPI_REG_IOC);
> +}
> +
> +/* Two bits at a time, msb first */
> +static void do_spi_byte_fast(void __iomem *base, u32 spi_ioc, u8 byte)
> +{
> +       do_spi_clk_fast(base, spi_ioc, byte >> 6);
> +       do_spi_clk_fast(base, spi_ioc, byte >> 4);
> +       do_spi_clk_fast(base, spi_ioc, byte >> 2);
> +       do_spi_clk_fast(base, spi_ioc, byte);

Just a nitpick, what if explicitly show >> 0?

> +}
> +
> +static void set_cs(struct spi_device *spi, bool enable)
> +{
> +       struct rb4xx_spi *rbspi = spi_master_get_devdata(spi->master);
> +
> +       /*
> +        * Setting CS is done along with bitbanging the actual values,
> +        * since it's all on the same hardware register. However the
> +        * CPLD needs CS deselected after every command.
> +        */
> +       if (!enable)
> +               __raw_writel(AR71XX_SPI_IOC_CS0 | AR71XX_SPI_IOC_CS1,
> +                            rbspi->base + AR71XX_SPI_REG_IOC);
> +}
> +
> +/* Deselect CS0 and CS1. */
> +static int unprep(struct spi_master *master)
> +{
> +       struct rb4xx_spi *rbspi = spi_master_get_devdata(master);
> +
> +       __raw_writel(AR71XX_SPI_IOC_CS0 | AR71XX_SPI_IOC_CS1,
> +                    rbspi->base + AR71XX_SPI_REG_IOC);
> +
> +       return 0;
> +}
> +
> +static int rb4xx_transfer_one(struct spi_master *master,
> +                             struct spi_device *spi, struct spi_transfer *t)
> +{
> +       struct rb4xx_spi *rbspi = spi_master_get_devdata(master);
> +       int i;
> +       u32 spi_ioc;
> +       u8 *rx_buf;
> +       const u8 *tx_buf;
> +       unsigned char out;
> +
> +       /*
> +        * Prime the SPI register with the SPI device selected. The m25p80 boot
> +        * flash and CPLD share the CS0 pin. This works because the CPLD's
> +        * command set was designed to almost not clash with that of the
> +        * boot flash.
> +        */
> +       if (spi->chip_select == 2)
> +               spi_ioc = AR71XX_SPI_IOC_CS0;
> +       else
> +               spi_ioc = AR71XX_SPI_IOC_CS1;
> +
> +       tx_buf = t->tx_buf;
> +       rx_buf = t->rx_buf;
> +       for (i = 0; i < t->len; ++i) {
> +               out = tx_buf ? tx_buf[i] : 0x00;
> +               if (spi->chip_select == 1 && t->cs_change) {
> +                       /* CPLD in bulk write mode gets two bits per clock */
> +                       do_spi_byte_fast(rbspi->base, spi_ioc, out);
> +                       /* Don't want the real CS toggled */
> +                       t->cs_change = 0;
> +               } else {
> +                       do_spi_byte(rbspi->base, spi_ioc, out);
> +               }
> +               if (!rx_buf)
> +                       continue;
> +               rx_buf[i] = __raw_readl(rbspi->base + AR71XX_SPI_REG_RDS) & 0xff;

Since you have u8 type you don need to & 0xff.

> +       }
> +       spi_finalize_current_transfer(master);
> +
> +       return 0;
> +}
> +
> +static int rb4xx_spi_setup(struct spi_device *spi)
> +{
> +       if (spi->mode & ~(SPI_CS_HIGH)) {

Redundant parens.

> +               dev_err(&spi->dev, "mode %x not supported\n", spi->mode);
> +               return -EINVAL;
> +       }
> +
> +       if (spi->bits_per_word != 8 && spi->bits_per_word != 0) {
> +               dev_err(&spi->dev, "bits_per_word %u not supported\n",
> +                       spi->bits_per_word);
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
> +static int rb4xx_spi_probe(struct platform_device *pdev)
> +{
> +       struct spi_master *master;
> +       struct clk *ahb_clk;
> +       struct rb4xx_spi *rbspi;
> +       struct resource *r;
> +       int err = 0;
> +
> +       ahb_clk = devm_clk_get(&pdev->dev, "ahb");
> +       if (IS_ERR(ahb_clk))
> +               return PTR_ERR(ahb_clk);
> +
> +       err = clk_prepare_enable(ahb_clk);
> +       if (err)
> +               return err;
> +
> +       r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       if (!r)
> +               return -ENOENT;

(a)

> +
> +       master = spi_alloc_master(&pdev->dev, sizeof(*rbspi));
> +       if (!master)
> +               return -ENOMEM;
> +
> +       master->bus_num = 0;
> +       master->num_chipselect = 3;
> +       master->setup = rb4xx_spi_setup;
> +       master->transfer_one = rb4xx_transfer_one;
> +       master->unprepare_transfer_hardware = unprep;
> +       master->set_cs = set_cs;
> +
> +       rbspi = spi_master_get_devdata(master);
> +
> +       platform_set_drvdata(pdev, rbspi);
> +
> +       rbspi->base = devm_ioremap_resource(&pdev->dev, r);
> +       if (!rbspi->base) {
> +               err = -ENXIO;
> +               goto err_put_master;
> +       }

(b)

First of all you don't need to check for return code in (a) since (b)
will do this for you. Second, you have to propagate the actual error
code in (b). And third, since you are using devm_* approach you may
move this before master allocation and save few lines.

> +
> +       rbspi->master = master;
> +
> +       err = spi_register_master(master);
> +       if (err) {
> +               dev_err(&pdev->dev, "failed to register SPI master\n");
> +               goto err_put_master;
> +       }
> +
> +       /* Enable SPI */
> +       __raw_writel(AR71XX_SPI_FS_GPIO, rbspi->base + AR71XX_SPI_REG_FS);
> +
> +       return 0;
> +
> +err_put_master:
> +       spi_master_put(master);
> +
> +       return err;
> +}
> +
> +static int rb4xx_spi_remove(struct platform_device *pdev)
> +{
> +       struct rb4xx_spi *rbspi = platform_get_drvdata(pdev);
> +
> +       platform_set_drvdata(pdev, NULL);

This is redundant.

> +       spi_master_put(rbspi->master);
> +
> +       return 0;
> +}
> +
> +static struct platform_driver rb4xx_spi_drv = {
> +       .probe          = rb4xx_spi_probe,
> +       .remove         = rb4xx_spi_remove,
> +       .driver         = {
> +               .name   = "rb4xx-spi",
> +       },
> +};
> +
> +module_platform_driver(rb4xx_spi_drv);
> +
> +MODULE_DESCRIPTION("Mikrotik RB4xx SPI controller driver");
> +MODULE_AUTHOR("Gabor Juhos <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>");
> +MODULE_AUTHOR("Bert Vermeulen <bert-Nh2F35Ii2RQ@public.gmane.org>");
> +MODULE_LICENSE("GPL v2");
> --
> 1.9.1
>



-- 
With Best Regards,
Andy Shevchenko
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

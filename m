From: Moritz Fischer <moritz.fischer-+aYTwkv1SeIAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v8 3/3] fpga: Add support for Lattice iCE40 FPGAs
Date: Mon, 7 Nov 2016 10:26:11 -0800
Message-ID: <CAAtXAHcr_tG5QPkN4WP9Otav+AsLJaWAutwcu7cxvegU2-+QfQ@mail.gmail.com>
References: <1478486962-26794-1-git-send-email-joel@airwebreathe.org.uk> <1478486962-26794-3-git-send-email-joel@airwebreathe.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Alan Tull <atull-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>,
        Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
        Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Devicetree List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex-ynQEQJNshbs@public.gmane.org>,
        clifford-cPpHkPqGOEfk7+2FdBfRIA@public.gmane.org
To: Joel Holdsworth <joel-IJEoVVyKhCJXvIrf17iDB/XRex20P6io@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1478486962-26794-3-git-send-email-joel-IJEoVVyKhCJXvIrf17iDB/XRex20P6io@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Joel,

couple of nits inline below:

On Sun, Nov 6, 2016 at 6:49 PM, Joel Holdsworth
<joel-IJEoVVyKhCJXvIrf17iDB/XRex20P6io@public.gmane.org> wrote:
> The Lattice iCE40 is a family of FPGAs with a minimalistic architecture
> and very regular structure, designed for low-cost, high-volume consumer
> and system applications.
>
> This patch adds support to the FPGA manager for configuring the SRAM of
> iCE40LM, iCE40LP, iCE40HX, iCE40 Ultra, iCE40 UltraLite and iCE40
> UltraPlus devices, through slave SPI.
>
> The iCE40 family is notable because it is the first FPGA family to have
> complete reverse engineered bit-stream documentation for the iCE40LP and
> iCE40HX devices. Furthermore, there is now a Free Software Verilog
> synthesis tool-chain: the "IceStorm" tool-chain.
>
> This project is the work of Clifford Wolf, who is the maintainer of
> Yosys Verilog RTL synthesis framework, and Mathias Lasser, with notable
> contributions from "Cotton Seed", the main author of "arachne-pnr"; a
> place-and-route tool for iCE40 FPGAs.
>
> Having a Free Software synthesis tool-chain offers interesting
> opportunities for embedded devices that are able reconfigure themselves
> with open firmware that is generated on the device itself. For example
> a mobile device might have an application processor with an iCE40 FPGA
> attached, which implements slave devices, or through which the processor
> communicates with other devices through the FPGA fabric.
>
> A kernel driver for the iCE40 is useful, because in some cases, the FPGA
> may need to be configured before other devices can be accessed.
>
> An example of such a device is the icoBoard; a RaspberryPI HAT which
> features an iCE40HX8K with a 1 or 8 MBit SRAM and ports for
> Digilent-compatible PMOD modules. A PMOD module may contain a device
> with which the kernel communicates, via the FPGA.

Personally I find this a bit verbose, but that's just me.

>
> Signed-off-by: Joel Holdsworth <joel-IJEoVVyKhCJXvIrf17iDB/XRex20P6io@public.gmane.org>
> ---
>  drivers/fpga/Kconfig     |   6 ++
>  drivers/fpga/Makefile    |   1 +
>  drivers/fpga/ice40-spi.c | 217 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 224 insertions(+)
>  create mode 100644 drivers/fpga/ice40-spi.c
>
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index d614102..5b0f137 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -13,6 +13,12 @@ config FPGA
>
>  if FPGA
>
> +config FPGA_MGR_ICE40_SPI
> +       tristate "Lattice iCE40 SPI"
> +       depends on OF && SPI
> +       help
> +         FPGA manager driver support for Lattice iCE40 FPGAs over SPI.
> +
>  config FPGA_MGR_SOCFPGA
>         tristate "Altera SOCFPGA FPGA Manager"
>         depends on ARCH_SOCFPGA
> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> index 8d83fc6..adb5811 100644
> --- a/drivers/fpga/Makefile
> +++ b/drivers/fpga/Makefile
> @@ -6,5 +6,6 @@
>  obj-$(CONFIG_FPGA)                     += fpga-mgr.o
>
>  # FPGA Manager Drivers
> +obj-$(CONFIG_FPGA_MGR_ICE40_SPI)       += ice40-spi.o
>  obj-$(CONFIG_FPGA_MGR_SOCFPGA)         += socfpga.o
>  obj-$(CONFIG_FPGA_MGR_ZYNQ_FPGA)       += zynq-fpga.o
> diff --git a/drivers/fpga/ice40-spi.c b/drivers/fpga/ice40-spi.c
> new file mode 100644
> index 0000000..7d7595b
> --- /dev/null
> +++ b/drivers/fpga/ice40-spi.c
> @@ -0,0 +1,217 @@
> +/*
> + * FPGA Manager Driver for Lattice iCE40.
> + *
> + *  Copyright (c) 2016 Joel Holdsworth
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; version 2 of the License.
> + *
> + * This driver adds support to the FPGA manager for configuring the SRAM of
> + * Lattice iCE40 FPGAs through slave SPI.
> + */
> +
> +#include <linux/fpga/fpga-mgr.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/module.h>
> +#include <linux/of_gpio.h>
> +#include <linux/spi/spi.h>
> +
> +#define ICE40_SPI_FPGAMGR_RESET_DELAY 1 /* us (>200ns) */
> +#define ICE40_SPI_FPGAMGR_HOUSEKEEPING_DELAY 1200 /* us */
> +
> +#define ICE40_SPI_FPGAMGR_NUM_ACTIVATION_BYTES DIV_ROUND_UP(49, 8)
> +
> +struct ice40_fpga_priv {
> +       struct spi_device *dev;
> +       struct gpio_desc *reset;
> +       struct gpio_desc *cdone;
> +};
> +
> +static enum fpga_mgr_states ice40_fpga_ops_state(struct fpga_manager *mgr)
> +{
> +       struct ice40_fpga_priv *priv = mgr->priv;
> +
> +       return gpiod_get_value(priv->cdone) ? FPGA_MGR_STATE_OPERATING :
> +               FPGA_MGR_STATE_UNKNOWN;
> +}
> +
> +static int ice40_fpga_ops_write_init(struct fpga_manager *mgr, u32 flags,
> +                                    const char *buf, size_t count)
> +{
> +       struct ice40_fpga_priv *priv = mgr->priv;
> +       struct spi_device *dev = priv->dev;
> +       struct spi_message message;
> +       struct spi_transfer assert_cs_then_reset_delay = {.cs_change = 1,
> +               .delay_usecs = ICE40_SPI_FPGAMGR_RESET_DELAY};

Formatting looks odd, can you move the .cs_change to the next line?

> +       struct spi_transfer housekeeping_delay_then_release_cs = {
> +               .delay_usecs = ICE40_SPI_FPGAMGR_HOUSEKEEPING_DELAY};
> +       int ret;
> +
> +       if ((flags & FPGA_MGR_PARTIAL_RECONFIG)) {
> +               dev_err(&dev->dev,
> +                       "Partial reconfiguration is not supported\n");
> +               return -ENOTSUPP;
> +       }
> +
> +       /* Lock the bus, assert CRESET_B and SS_B and delay >200ns */
> +       spi_bus_lock(dev->master);
> +
> +       gpiod_set_value(priv->reset, 1);
> +
> +       spi_message_init(&message);
> +       spi_message_add_tail(&assert_cs_then_reset_delay, &message);
> +       ret = spi_sync_locked(dev, &message);
> +
> +       /* Come out of reset */
> +       gpiod_set_value(priv->reset, 0);
> +
> +       /* Abort if the chip-select failed */
> +       if (ret)
> +               goto fail;
> +
> +       /* Check CDONE is de-asserted i.e. the FPGA is reset */
> +       if (gpiod_get_value(priv->cdone)) {
> +               dev_err(&dev->dev, "Device reset failed, CDONE is asserted\n");
> +               ret = -EIO;
> +               goto fail;
> +       }
> +
> +       /* Wait for the housekeeping to complete, and release SS_B */
> +       spi_message_init(&message);
> +       spi_message_add_tail(&housekeeping_delay_then_release_cs, &message);
> +       ret = spi_sync_locked(dev, &message);
> +
> +fail:
> +       spi_bus_unlock(dev->master);
> +
> +       return ret;
> +}
> +
> +static int ice40_fpga_ops_write(struct fpga_manager *mgr,
> +                               const char *buf, size_t count)
> +{
> +       struct ice40_fpga_priv *priv = mgr->priv;
> +
> +       return spi_write(priv->dev, buf, count);
> +}
> +
> +static int ice40_fpga_ops_write_complete(struct fpga_manager *mgr, u32 flags)
> +{
> +       struct ice40_fpga_priv *priv = mgr->priv;
> +       struct spi_device *dev = priv->dev;
> +       const u8 padding[ICE40_SPI_FPGAMGR_NUM_ACTIVATION_BYTES] = {0,};
> +
> +       /* Check CDONE is asserted */
> +       if (!gpiod_get_value(priv->cdone)) {
> +               dev_err(&dev->dev,
> +                       "CDONE was not asserted after firmware transfer\n");
> +               return -EIO;
> +       }
> +
> +       /* Send of zero-padding to activate the firmware */
> +       return spi_write(dev, padding, sizeof(padding));

I'd move all of these into the write() callback.

> +}
> +
> +static void ice40_fpga_ops_fpga_remove(struct fpga_manager *mgr)
> +{
> +       struct ice40_fpga_priv *priv = mgr->priv;
> +
> +       /* Enter reset */
> +       gpiod_set_value(priv->reset, 1);

I know Marek had suggested this, none of the other drivers behave like that.
I'm not sure this is expected behavior for most people.

> +}
> +
> +static const struct fpga_manager_ops ice40_fpga_ops = {
> +       .state = ice40_fpga_ops_state,
> +       .write_init = ice40_fpga_ops_write_init,
> +       .write = ice40_fpga_ops_write,
> +       .write_complete = ice40_fpga_ops_write_complete,
> +       .fpga_remove = ice40_fpga_ops_fpga_remove
> +};
> +
> +static int ice40_fpga_probe(struct spi_device *spi)
> +{
> +       struct device *dev = &spi->dev;
> +       struct device_node *np = spi->dev.of_node;
> +       struct ice40_fpga_priv *priv;
> +       int ret;
> +
> +       if (!np) {
> +               dev_err(dev, "No Device Tree entry\n");
> +               return -EINVAL;
> +       }
> +
> +       priv = devm_kzalloc(&spi->dev, sizeof(*priv), GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       priv->dev = spi;
> +
> +       /* Check board setup data. */
> +       if (spi->max_speed_hz > 25000000) {
> +               dev_err(dev, "Speed is too high\n");
> +               return -EINVAL;
> +       }
> +
> +       if (spi->max_speed_hz < 1000000) {
> +               dev_err(dev, "Speed is too low\n");
> +               return -EINVAL;
> +       }
> +
> +       if (spi->mode & SPI_CPHA) {
> +               dev_err(dev, "Bad mode\n");
> +               return -EINVAL;
> +       }
> +
> +       /* Set up the GPIOs */
> +       priv->cdone = devm_gpiod_get(dev, "cdone", GPIOD_IN);
> +       if (IS_ERR(priv->cdone)) {
> +               dev_err(dev, "Failed to get CDONE GPIO: %ld\n",
> +                       PTR_ERR(priv->cdone));
> +               return -EINVAL;
> +       }
> +
> +       priv->reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
> +       if (IS_ERR(priv->reset)) {
> +               dev_err(dev, "Failed to get CRESET_B GPIO: %ld\n",
> +                       PTR_ERR(priv->reset));
> +               return -EINVAL;
> +       }
> +
> +       /* Register with the FPGA manager */
> +       ret = fpga_mgr_register(dev, "Lattice iCE40 FPGA Manager",
> +                               &ice40_fpga_ops, priv);
> +       if (ret) {
> +               dev_err(dev, "Unable to register FPGA manager");
> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +static int ice40_fpga_remove(struct spi_device *spi)
> +{
> +       fpga_mgr_unregister(&spi->dev);
> +       return 0;
> +}
> +
> +static const struct of_device_id ice40_fpga_of_match[] = {
> +       { .compatible = "lattice,ice40-fpga-mgr", },
> +       {},
> +};
> +MODULE_DEVICE_TABLE(of, ice40_fpga_of_match);
> +
> +static struct spi_driver ice40_fpga_driver = {
> +       .probe = ice40_fpga_probe,
> +       .remove = ice40_fpga_remove,
> +       .driver = {
> +               .name = "ice40spi",
> +               .of_match_table = of_match_ptr(ice40_fpga_of_match),
> +       },
> +};
> +
> +module_spi_driver(ice40_fpga_driver);
> +
> +MODULE_AUTHOR("Joel Holdsworth <joel-IJEoVVyKhCJXvIrf17iDB/XRex20P6io@public.gmane.org>");
> +MODULE_DESCRIPTION("Lattice iCE40 FPGA Manager");
> +MODULE_LICENSE("GPL v2");
> --
> 2.7.4
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

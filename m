From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v5 2/2] spi: Add generic SPI multiplexer
Date: Tue, 4 Feb 2020 13:10:12 +0200
Message-ID: <CAHp75VfouDS0MM=V2FesXrVssp4Mx230gh_cuFN7Ej+DpnVzJQ@mail.gmail.com>
References: <20200204032838.20739-1-chris.packham@alliedtelesis.co.nz> <20200204032838.20739-3-chris.packham@alliedtelesis.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200204032838.20739-3-chris.packham@alliedtelesis.co.nz>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Feb 4, 2020 at 5:28 AM Chris Packham
<chris.packham@alliedtelesis.co.nz> wrote:
>
> Add a SPI device driver that sits in-band and provides a SPI controller
> which supports chip selects via a mux-control. This enables extra SPI
> devices to be connected with limited native chip selects.
>

FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Mostly I did style review here.

> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>
> Notes:
>     Changes in v5:
>     - Drop redudnant lines, use IS_ERR() instead of PTR_ERR_OR_ZERO
>
>     Changes in v4:
>     - incorporate review feedback from Andy
>
>  drivers/spi/Kconfig   |  11 +++
>  drivers/spi/Makefile  |   1 +
>  drivers/spi/spi-mux.c | 187 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 199 insertions(+)
>  create mode 100644 drivers/spi/spi-mux.c
>
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 870f7797b56b..a4509000a291 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -881,6 +881,17 @@ config SPI_ZYNQMP_GQSPI
>  # Add new SPI master controllers in alphabetical order above this line
>  #
>
> +comment "SPI Multiplexer support"
> +
> +config SPI_MUX
> +       tristate "SPI multiplexer support"
> +       select MULTIPLEXER
> +       help
> +         This adds support for SPI multiplexers. Each SPI mux will be
> +         accessible as a SPI controller, the devices behind the mux will appear
> +         to be chip selects on this controller. It is still necessary to
> +         select one or more specific mux-controller drivers.
> +
>  #
>  # There are lots of SPI device types, with sensors and memory
>  # being probably the most widely used ones.
> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> index bb49c9e6d0a0..116409533727 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -9,6 +9,7 @@ ccflags-$(CONFIG_SPI_DEBUG) := -DDEBUG
>  # config declarations into driver model code
>  obj-$(CONFIG_SPI_MASTER)               += spi.o
>  obj-$(CONFIG_SPI_MEM)                  += spi-mem.o
> +obj-$(CONFIG_SPI_MUX)                  += spi-mux.o
>  obj-$(CONFIG_SPI_SPIDEV)               += spidev.o
>  obj-$(CONFIG_SPI_LOOPBACK_TEST)                += spi-loopback-test.o
>
> diff --git a/drivers/spi/spi-mux.c b/drivers/spi/spi-mux.c
> new file mode 100644
> index 000000000000..4f94c9127fc1
> --- /dev/null
> +++ b/drivers/spi/spi-mux.c
> @@ -0,0 +1,187 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// General Purpose SPI multiplexer
> +
> +#include <linux/err.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mux/consumer.h>
> +#include <linux/slab.h>
> +#include <linux/spi/spi.h>
> +
> +#define SPI_MUX_NO_CS  ((unsigned int)-1)
> +
> +/**
> + * DOC: Driver description
> + *
> + * This driver supports a MUX on an SPI bus. This can be useful when you need
> + * more chip selects than the hardware peripherals support, or than are
> + * available in a particular board setup.
> + *
> + * The driver will create an additional SPI controller. Devices added under the
> + * mux will be handled as 'chip selects' on this controller.
> + */
> +
> +/**
> + * struct spi_mux_priv - the basic spi_mux structure
> + * @spi:               pointer to the device struct attached to the parent
> + *                     spi controller
> + * @current_cs:                The current chip select set in the mux
> + * @child_msg_complete: The mux replaces the complete callback in the child's
> + *                     message to its own callback; this field is used by the
> + *                     driver to store the child's callback during a transfer
> + * @child_msg_context: Used to store the child's context to the callback
> + * @child_msg_dev:     Used to store the spi_device pointer to the child
> + * @mux:               mux_control structure used to provide chip selects for
> + *                     downstream spi devices
> + */
> +struct spi_mux_priv {
> +       struct spi_device       *spi;
> +       unsigned int            current_cs;
> +
> +       void                    (*child_msg_complete)(void *context);
> +       void                    *child_msg_context;
> +       struct spi_device       *child_msg_dev;
> +       struct mux_control      *mux;
> +};
> +
> +/* should not get called when the parent controller is doing a transfer */
> +static int spi_mux_select(struct spi_device *spi)
> +{
> +       struct spi_mux_priv *priv = spi_controller_get_devdata(spi->controller);
> +       int ret;
> +
> +       if (priv->current_cs == spi->chip_select)
> +               return 0;
> +
> +       dev_dbg(&priv->spi->dev, "setting up the mux for cs %d\n",
> +               spi->chip_select);
> +
> +       /* copy the child device's settings except for the cs */
> +       priv->spi->max_speed_hz = spi->max_speed_hz;
> +       priv->spi->mode = spi->mode;
> +       priv->spi->bits_per_word = spi->bits_per_word;
> +
> +       ret = mux_control_select(priv->mux, spi->chip_select);
> +       if (ret)
> +               return ret;
> +
> +       priv->current_cs = spi->chip_select;
> +
> +       return 0;
> +}
> +
> +static int spi_mux_setup(struct spi_device *spi)
> +{
> +       struct spi_mux_priv *priv = spi_controller_get_devdata(spi->controller);
> +
> +       /*
> +        * can be called multiple times, won't do a valid setup now but we will
> +        * change the settings when we do a transfer (necessary because we
> +        * can't predict from which device it will be anyway)
> +        */
> +       return spi_setup(priv->spi);
> +}
> +
> +static void spi_mux_complete_cb(void *context)
> +{
> +       struct spi_mux_priv *priv = (struct spi_mux_priv *)context;
> +       struct spi_controller *ctlr = spi_get_drvdata(priv->spi);
> +       struct spi_message *m = ctlr->cur_msg;
> +
> +       m->complete = priv->child_msg_complete;
> +       m->context = priv->child_msg_context;
> +       m->spi = priv->child_msg_dev;
> +       spi_finalize_current_message(ctlr);
> +       mux_control_deselect(priv->mux);
> +}
> +
> +static int spi_mux_transfer_one_message(struct spi_controller *ctlr,
> +                                               struct spi_message *m)
> +{
> +       struct spi_mux_priv *priv = spi_controller_get_devdata(ctlr);
> +       struct spi_device *spi = m->spi;
> +       int ret;
> +
> +       ret = spi_mux_select(spi);
> +       if (ret)
> +               return ret;
> +
> +       /*
> +        * Replace the complete callback, context and spi_device with our own
> +        * pointers. Save originals
> +        */
> +       priv->child_msg_complete = m->complete;
> +       priv->child_msg_context = m->context;
> +       priv->child_msg_dev = m->spi;
> +
> +       m->complete = spi_mux_complete_cb;
> +       m->context = priv;
> +       m->spi = priv->spi;
> +
> +       /* do the transfer */
> +       return spi_async(priv->spi, m);
> +}
> +
> +static int spi_mux_probe(struct spi_device *spi)
> +{
> +       struct spi_controller *ctlr;
> +       struct spi_mux_priv *priv;
> +       int ret;
> +
> +       ctlr = spi_alloc_master(&spi->dev, sizeof(*priv));
> +       if (!ctlr)
> +               return -ENOMEM;
> +
> +       spi_set_drvdata(spi, ctlr);
> +       priv = spi_controller_get_devdata(ctlr);
> +       priv->spi = spi;
> +
> +       priv->mux = devm_mux_control_get(&spi->dev, NULL);
> +       if (IS_ERR(priv->mux)) {
> +               ret = PTR_ERR(priv->mux);
> +               if (ret != -EPROBE_DEFER)
> +                       dev_err(&spi->dev, "failed to get control-mux\n");
> +               goto err_put_ctlr;
> +       }
> +
> +       priv->current_cs = SPI_MUX_NO_CS;
> +
> +       /* supported modes are the same as our parent's */
> +       ctlr->mode_bits = spi->controller->mode_bits;
> +       ctlr->flags = spi->controller->flags;
> +       ctlr->transfer_one_message = spi_mux_transfer_one_message;
> +       ctlr->setup = spi_mux_setup;
> +       ctlr->num_chipselect = mux_control_states(priv->mux);
> +       ctlr->bus_num = -1;
> +       ctlr->dev.of_node = spi->dev.of_node;
> +
> +       ret = devm_spi_register_controller(&spi->dev, ctlr);
> +       if (ret)
> +               goto err_put_ctlr;
> +
> +       return 0;
> +
> +err_put_ctlr:
> +       spi_controller_put(ctlr);
> +
> +       return ret;
> +}
> +
> +static const struct of_device_id spi_mux_of_match[] = {
> +       { .compatible = "spi-mux" },
> +       { }
> +};
> +
> +static struct spi_driver spi_mux_driver = {
> +       .probe  = spi_mux_probe,
> +       .driver = {
> +               .name   = "spi-mux",
> +               .of_match_table = spi_mux_of_match,
> +       },
> +};
> +
> +module_spi_driver(spi_mux_driver);
> +
> +MODULE_DESCRIPTION("SPI multiplexer");
> +MODULE_LICENSE("GPL");
> --
> 2.25.0
>


-- 
With Best Regards,
Andy Shevchenko

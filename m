From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 2/2] spi: Add generic SPI multiplexer
Date: Thu, 30 Jan 2020 18:43:52 +0200
Message-ID: <CAHp75Vd1i2rDwVcK54tox_5=q3b5HHjTa2dcsQqK_UE5ODcsVQ@mail.gmail.com>
References: <20200127210415.5708-1-chris.packham@alliedtelesis.co.nz> <20200127210415.5708-3-chris.packham@alliedtelesis.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Chris Packham <chris.packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200127210415.5708-3-chris.packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, Jan 27, 2020 at 11:04 PM Chris Packham
<chris.packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org> wrote:
>
> Add a SPI device driver that sits in-band and provides a SPI controller
> which supports chip selects via a mux-control. This enables extra SPI
> devices to be connected with limited native chip selects.

...

>  obj-$(CONFIG_SPI_MEM)                  += spi-mem.o
>  obj-$(CONFIG_SPI_SPIDEV)               += spidev.o
>  obj-$(CONFIG_SPI_LOOPBACK_TEST)                += spi-loopback-test.o
> +obj-$(CONFIG_SPI_MUX)                  += spi-mux.o

Maybe after SPI_MEM ?

...

> +struct spi_mux_priv {
> +       struct spi_device       *spi;
> +       unsigned int            current_cs;
> +

> +       void                    (*child_mesg_complete)(void *context);
> +       void                    *child_mesg_context;
> +       struct spi_device       *child_mesg_dev;

mesg -> msg ?

> +       struct mux_control      *mux;
> +};

...

> +static int spi_mux_select(struct spi_device *spi)
> +{
> +       struct spi_mux_priv *priv = spi_controller_get_devdata(spi->controller);

> +       int ret = 0;

Drop this assignment...

> +       if (priv->current_cs != spi->chip_select) {

...convert this to
 if (cs == chip_select)
    return 0;

> +               dev_dbg(&priv->spi->dev,
> +                       "setting up the mux for cs %d\n",
> +                       spi->chip_select);

After above changes this perhaps fits one line (now it fits two, by
the way, not three).

> +}

-- 
With Best Regards,
Andy Shevchenko

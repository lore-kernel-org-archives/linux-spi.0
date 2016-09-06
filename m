From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH v2] spi: sh-msiof: request and set cs-gpio direction to output
Date: Tue, 6 Sep 2016 14:59:45 +0200
Message-ID: <CAMuHMdVzdVkMNYr45pHS1gMtExHsFEiM_WQ7AaKKn7HuFWVyZg@mail.gmail.com>
References: <20160906124118.13979-1-ulrich.hecht+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>,
        Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Ulrich Hecht <ulrich.hecht+renesas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160906124118.13979-1-ulrich.hecht+renesas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Uli,

On Tue, Sep 6, 2016 at 2:41 PM, Ulrich Hecht
<ulrich.hecht+renesas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Required for the CS signal to actually be visible to the device.
>
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>
> This revision uses devm_gpio_request_one() instead of gpio_request()/
> gpio_direction_output(), as suggested by Geert.

I suggested to use a devm_*() function as it relieves a device's .remove()
function of the burden to do manual resource management.

However, I had missed that freeing is not done in the device's .remove()
function, but in spi_master.cleanup(). Life cycle is completely different here,
and .setup() and .cleanup() may be called multiple times if SPI slaves are
added/removed dynamically (e.g. DT overlays). Fortunately you kept the
invocation of devm_gpio_free(), so calling .setup() and .cleanup() multiple
times (pairwise) still works.

>  drivers/spi/spi-sh-msiof.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
> index 6852552a..ed01289 100644
> --- a/drivers/spi/spi-sh-msiof.c
> +++ b/drivers/spi/spi-sh-msiof.c
> @@ -541,15 +541,32 @@ static int sh_msiof_spi_setup(struct spi_device *spi)
>                                   !!(spi->mode & SPI_LSB_FIRST),
>                                   !!(spi->mode & SPI_CS_HIGH));
>
> -       if (spi->cs_gpio >= 0)
> -               gpio_set_value(spi->cs_gpio, !(spi->mode & SPI_CS_HIGH));
> +       if (spi->cs_gpio >= 0 && !spi_get_ctldata(spi)) {
> +               int ret = devm_gpio_request_one(&p->pdev->dev, spi->cs_gpio,
> +                               spi->mode & SPI_CS_HIGH ? GPIOF_OUT_INIT_LOW :
> +                               GPIOF_OUT_INIT_HIGH, dev_name(&spi->dev));
> +
> +               if (ret < 0)
> +                       return ret;
>
> +               spi_set_ctldata(spi, (void *)spi->cs_gpio);
> +       }
>
>         pm_runtime_put(&p->pdev->dev);
>
>         return 0;
>  }
>
> +static void sh_msiof_spi_cleanup(struct spi_device *spi)
> +{
> +       struct sh_msiof_spi_priv *p = spi_master_get_devdata(spi->master);
> +
> +       if (spi->cs_gpio >= 0)
> +               devm_gpio_free(&p->pdev->dev, spi->cs_gpio);

I'm wondering if this can lead to a double free? E.g. if .setup() fails?

> +
> +       spi_set_ctldata(spi, NULL);
> +}

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

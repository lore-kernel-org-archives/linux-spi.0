From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [RFC PATCH v2 10/12] spi: core: convert spi_master to use gpio_desc
Date: Fri, 24 Nov 2017 13:59:53 +0100
Message-ID: <CAMuHMdVx=JSL0dViZpL1spujK-K0kCTX3P=UWVOnxwhqw8nnWg@mail.gmail.com>
References: <20170727220322.26654-1-chris.packham@alliedtelesis.co.nz> <20170727220322.26654-11-chris.packham@alliedtelesis.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Chris Packham <chris.packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170727220322.26654-11-chris.packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Chris,

On Fri, Jul 28, 2017 at 12:03 AM, Chris Packham
<chris.packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org> wrote:
> Instead of numeric gpios make struct spi_master hold an array of struct
> gpio_desc. For now struct spi_device still maintains a numeric gpio
> which will be updated in a subsequent change.
>
> Signed-off-by: Chris Packham <chris.packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>

Thanks for your patch!

> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -40,6 +40,7 @@
>  #include <linux/ioport.h>
>  #include <linux/acpi.h>
>  #include <linux/highmem.h>
> +#include <linux/gpio/consumer.h>
>
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/spi.h>
> @@ -531,7 +532,9 @@ int spi_add_device(struct spi_device *spi)
>         }
>
>         if (ctlr->cs_gpios)

As desc_to_gpio() crashes when passed a NULL pointer, the above check should
be changed to:

        if (ctlr->cs_gpios && ctlr->cs_gpios[spi->chip_select])

> -               spi->cs_gpio = ctlr->cs_gpios[spi->chip_select];
> +               spi->cs_gpio = desc_to_gpio(ctlr->cs_gpios[spi->chip_select]);
> +       else
> +               spi->cs_gpio = -ENOENT;

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

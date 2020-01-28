From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH] spi: spi-fsl-espi: add GPIO chipselect support
Date: Tue, 28 Jan 2020 10:20:24 +0100
Message-ID: <CAMuHMdWiWqquohF93jssKuu0GFhs0QHtyXsTse5WN9rUjPGd4A@mail.gmail.com>
References: <067ed094-fa5d-f472-8abd-c22f4c0dba03@inbox.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
To: Maxim Kochetkov <fido_max-aPYA7nAdAYY@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <067ed094-fa5d-f472-8abd-c22f4c0dba03-aPYA7nAdAYY@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Maxim,

Thanks for your patch!

On Tue, Jan 28, 2020 at 8:26 AM Maxim Kochetkov <fido_max-aPYA7nAdAYY@public.gmane.org> wrote:
> Subject: [PATCH] spi: spi-fsl-espi: add GPIO chipselect support
>
> eSPI controller can't send transactions without hardware chip selects.
> So, to use GPIO chip selects with eSPI controller we need to use one
> dedicated hardware chip select signal. To specify shared chip select for
> GPIO use "fsl,espi-shared-chipselect" DT property.

Do you need a property to specify this?
Can't the driver just pick an unused native chip select instead?
Recently I've added generic support for that to the SPI core, cfr. commit
7d93aecdb58d47e8 ("spi: Add generic support for unused native cs with
cs-gpios").

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

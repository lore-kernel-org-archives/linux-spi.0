From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH 4/5] spi: spi-gpio: Make optional chipselect handling more explicit
Date: Wed, 3 Jan 2018 09:21:40 +0100
Message-ID: <CAMuHMdV5tdm0diunWg2BXxgVsG0FqwTgXXXBD+p9nbOEXcd59Q@mail.gmail.com>
References: <20180101133749.29567-1-linus.walleij@linaro.org> <20180101133749.29567-5-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180101133749.29567-5-linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Linus,

On Mon, Jan 1, 2018 at 2:37 PM, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> I don't like the use of a NULL GPIO descriptor to handle the
> "no chipselect connected" case, as it makes the code hard to read.
> Use a clear bool "has_cs" that we use to explicitly handle the
> case when no chip select is connected to it is clear to readers
> how this is achieved.

Hmm, having two indicators for the same feature (spi_gpio->has_cs == true and
spi_gpio->cs_gpios[0] = NULL), and the need to keep them in sync in the
future, also complicates things.

> When there is no chip select connected, we don't even allocate a
> placeholder for the GPIO descriptor.

That's good, although it may have no effect on actual memory consumption
due to slab granularity.

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

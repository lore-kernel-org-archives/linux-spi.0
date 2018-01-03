From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 4/5] spi: spi-gpio: Make optional chipselect handling more explicit
Date: Wed, 3 Jan 2018 09:58:56 +0100
Message-ID: <CACRpkdZaLKUs+9BP_Tp8bhdCur+CHaTK1RsS=i2na4Edqz1VGw@mail.gmail.com>
References: <20180101133749.29567-1-linus.walleij@linaro.org>
 <20180101133749.29567-5-linus.walleij@linaro.org> <CAMuHMdV5tdm0diunWg2BXxgVsG0FqwTgXXXBD+p9nbOEXcd59Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMuHMdV5tdm0diunWg2BXxgVsG0FqwTgXXXBD+p9nbOEXcd59Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Jan 3, 2018 at 9:21 AM, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org> wrote:

> Hmm, having two indicators for the same feature (spi_gpio->has_cs == true and
> spi_gpio->cs_gpios[0] = NULL), and the need to keep them in sync in the
> future, also complicates things.

The patch does not do this.

It removes the latter and adds the former. That is why it removes the
assignment of NULL to cs_gpios[0].

>> When there is no chip select connected, we don't even allocate a
>> placeholder for the GPIO descriptor.
>
> That's good, although it may have no effect on actual memory consumption
> due to slab granularity.

No idea, I'm not doing it to save memory anyways.

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

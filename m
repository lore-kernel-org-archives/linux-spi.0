From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH 4/5] spi: spi-gpio: Make optional chipselect handling more explicit
Date: Wed, 3 Jan 2018 10:17:17 +0100
Message-ID: <CAMuHMdVeTQOxRMJaohGFtw6LUtwQb6H46rsrf1fRFno9KBQXXA@mail.gmail.com>
References: <20180101133749.29567-1-linus.walleij@linaro.org>
 <20180101133749.29567-5-linus.walleij@linaro.org> <CAMuHMdV5tdm0diunWg2BXxgVsG0FqwTgXXXBD+p9nbOEXcd59Q@mail.gmail.com>
 <CACRpkdZaLKUs+9BP_Tp8bhdCur+CHaTK1RsS=i2na4Edqz1VGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CACRpkdZaLKUs+9BP_Tp8bhdCur+CHaTK1RsS=i2na4Edqz1VGw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Linus,

On Wed, Jan 3, 2018 at 9:58 AM, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> On Wed, Jan 3, 2018 at 9:21 AM, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org> wrote:
>
>> Hmm, having two indicators for the same feature (spi_gpio->has_cs == true and
>> spi_gpio->cs_gpios[0] = NULL), and the need to keep them in sync in the
>> future, also complicates things.
>
> The patch does not do this.
>
> It removes the latter and adds the former. That is why it removes the
> assignment of NULL to cs_gpios[0].

So what is cs_gpios[0] if has_cs == true? Oh, it will point to unallocated
memory right after the structure...

See, that's the ambiguity of having two variables...
We do have NULL pointers and ERR_PTRs, so this ambiguity can (and IMHO
should) be avoided.

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

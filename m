From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: spidev: Fix CS polarity if GPIO descriptors are used
Date: Fri, 21 Feb 2020 14:20:41 +0100
Message-ID: <CACRpkdbz1b0W8oP2+tZVnRZgexe17tS6OT_FEVO1KderOAqbxA@mail.gmail.com>
References: <fca3ba7cdc930cd36854666ceac4fbcf01b89028.1582027457.git.lukas@wunner.de>
 <CACRpkdZmzL_bDRuiBehmd-QC93K_xJ5VHM0HaypCFXLU6sZvkQ@mail.gmail.com> <20200220061122.srkb663imntm4c6a@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Simon Han <z.han-pnUOlEj4XnTQT0dZR+AlfA@public.gmane.org>
To: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200220061122.srkb663imntm4c6a-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thu, Feb 20, 2020 at 7:11 AM Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org> wrote:
> On Wed, Feb 19, 2020 at 04:47:50PM +0100, Linus Walleij wrote:

> > > +                       if (ctlr->use_gpio_descriptors && ctlr->cs_gpiods &&
> > > +                           ctlr->cs_gpiods[spi->chip_select])
> > > +                               tmp |= SPI_CS_HIGH;
> >
> > Should this be tmp ^= SPI_CS_HIGH?
> >
> > If the device tree node for cs-gpios is actually active high, which
> > happens, then you probably want the opposite of what was
> > requested, right?
>
> I don't quite follow.  Using an XOR here would seem to be inconsistent
> with what you added to of_spi_parse_dt():  In that function, you
> *always* set SPI_CS_HIGH if gpio_descs are used.  So if the polarity
> is specified in the cs-gpios property, anything else is considered
> irrelevant and ignored.

It's not just cs-gpios though: if you look in drivers/gpio/gpiolib-of.c
in the function of_gpio_flags_quirks() you see that the bool property
spi-cs-high in the consumer node will take precedence over the
cs-gpios property and that will also be handled transparently by gpiolib.
(commit 6953c57ab1721 with fixes on top).

But I guess that is what you mean.

Yes as far as I can see this solves the problem of double-specifying
(both in device tree and from userspace) that we want CS high,
so after some thinking:
Reviewed-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

> TBH the way commit f3186dd87669 abuses SPI_CS_HIGH seems clumsy to me.

Clumsy programmer, that's me, yeah sometimes :/

> Would it not have been possible to just amend spi_set_cs() like this:
>
> -       if (spi->mode & SPI_CS_HIGH)
> +       if (spi->mode & SPI_CS_HIGH || (ctlr->use_gpio_descriptors &&
> +                                        ctlr->cs_gpiods &&
> +                                        ctlr->cs_gpiods[spi->chip_select]))
>                 enable = !enable;
>
> This would have avoided the regression fixed by my patch.

There is way too much double inversion going on for sure (some
of it dating back before any attempts to use gpiolib for polarity
handling and I just feel partially responsible) but I just haven't
figured out how to properly fix the problem. Maybe it was just
stupid of me to try to move polarity inversion semantics over to
gpiolib before fixing that though.

Patches like the above are also welcome!

Yours,
Linus Walleij

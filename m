From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH] spi: rb4xx: Fix set_cs logic.
Date: Tue, 21 Apr 2015 11:46:49 +0200
Message-ID: <CAMuHMdW=_=CJENSqNSk6Lgt8-9Ea=TmWsKmLWUKGpbM0N8MXYg@mail.gmail.com>
References: <1429538005-1985-1-git-send-email-bert@biot.com>
	<20150420203703.GG14892@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Bert Vermeulen <bert-Nh2F35Ii2RQ@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150420203703.GG14892-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Mon, Apr 20, 2015 at 10:37 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Mon, Apr 20, 2015 at 03:53:25PM +0200, Bert Vermeulen wrote:
>> As it turns out, the set_cs() enable parameter refers to the logic level
>> on the CS pin, not the state of chip selection.
>
>> This broke functionality of the LEDs behind the CPLD, or at least delayed
>> the commands until another one came in to toggle CS.
>
> No, the enable parameter *should* refer to chip select assertion (see
> how we handle GPIO chip selects).  However it's possible that this
> device has an inverted chip select and should be registered with the
> SPI_CS_HIGH flag?

It's logic level:

 * @set_cs: set the logic level of the chip select line.  May be called
 *          from interrupt context.

See commit bd6857a0c630207484a03ddc470fab34b23f80bb
Author: Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Date:   Tue Jan 21 16:10:07 2014 +0100

    spi: Correct set_cs() documentation

    The documentation for spi_master.set_cs() says:

        assert or deassert chip select, true to assert

    i.e. its "enable" parameter uses assertion-level logic.

    This does not match the implementation of spi_set_cs(), which calls
    spi_master.set_cs() with the wanted logic level of the chip select line,
    which depends on the polarity of the chip select signal.

    Correct the documentation to match the implementation.

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

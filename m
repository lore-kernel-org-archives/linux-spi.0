From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: spi: tests driver to test basic alignment/length issues via loopback
Date: Thu, 26 Nov 2015 10:54:47 +0100
Message-ID: <CAMuHMdX6AVqhDUyvxgPGOdVYi4LPAm7CCGD-M7sUQCbXZJ+49w@mail.gmail.com>
References: <753FCC7B-67D9-495B-A6C1-D49793502C90@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <753FCC7B-67D9-495B-A6C1-D49793502C90-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Martin,

On Wed, Nov 25, 2015 at 7:56 PM, Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org> wrote:
> For complete testing the only thing it requires is  MOSI connected to MISO.
> and then it can detect lots of situations:

BTW, with several SPI drivers, you can set SPI_LOOP instead.
This can be useful on boards where the SPI pins are not available on
expansion headers, or where the pins are used for other functions.

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

From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH v2 1/4] spi: spidev: Restore all SPI mode flags on ioctl failure
Date: Thu, 27 Feb 2014 09:59:42 +0100
Message-ID: <CAMuHMdUx7imXCDWLAF9oOdLi-OtrZovwCpAXkvvq95B8q7m0cw@mail.gmail.com>
References: <1393324819-3810-1-git-send-email-geert@linux-m68k.org>
	<20140227045032.GN9383@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140227045032.GN9383-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark,

On Thu, Feb 27, 2014 at 5:50 AM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> > In commit f477b7fb13df2b843997559ff34e87d054ba6538 ("spi: DUAL and QUAD
> > support"), spi_device.mode was enlarged from 8 to 16 bits.
>
> Applied, thanks.

Thanks a lot!

>> For SPI_IOC_WR_MODE this is probably not so important, as it doesn't allow
>> setting Quad or Dual mode anyway, but SPI_IOC_WR_LSB_FIRST is used to just
>> set or clear a single bit.
>
> Since there's no API for it at present I'd not expect somethng that is
> using spidev to be able to have enabled any of the high mode bits.
> Unless I'm missing some path for this?

No, you're right.

While Quad mode could have been enabled in board info or DT, you can't use
it without setting [rt]x_nbits, and you can't share an SPI slave between spidev
and another driver[*]. I forgot about the latter.

[*] It would be a nice feature for debugging, though. In fact I'm
doing it, as the
    RSPI driver currently ignores the chip select number, so I have 3 m25p80
    drivers (in single, dual, resp. quad mode), and an spidev driver,
all talking to
    the same SPI FLASH.

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

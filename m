From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: spi: Provide core support for full duplex devices
Date: Thu, 6 Feb 2014 15:51:53 +0100 (CET)
Message-ID: <alpine.DEB.2.02.1402061544110.23936@ayla.of.borg>
References: <CAMuHMdUY+XEqKYh7mMOYUV18PpR+7SFw+BEUFh-9yL=H6reQkA@mail.gmail.com> <20140206134657.GQ32298@sirena.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140206134657.GQ32298-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thu, 6 Feb 2014, Mark Brown wrote:
> On Thu, Feb 06, 2014 at 01:56:41PM +0100, Geert Uytterhoeven wrote:
> > I'll see whether I can make use of this in the RSPI driver.
> > However, I think there's an incompatibility with Dual and Quad SPI
> > transfers: those are unidirectional, so you must not supply a buffer in
> > the unused direction.
> 
> Right, but as a result of that any hardware which can do dual or quad
> mode must of necessity not require full duplex operation.  I suppose
> it's possible that some hardware might be sufficiently idiotic to
> require full duplex operation only for normal SPI mode but that's a
> separate quirk.  I guess from the above that the rspi hardware has this
> problem?

Yes it does ;-)

As the MISO/MOSI pins are reused for Dual/Quad, it cannot be full-duplex,
except for loopback.

> It is, of course, also always possible that someone would implement quad
> and dual with separate pins for both directions - I can see people doing
> this for use with DSPs for example.

Sure, but it'll be incompatible (without adding glue logic) with e.g. the
current line of Quad SPI FLASHes from Spansion etc.

Anyway, I think it's safer to not set up rx/tx_buf for the unused direction
in the SPI core code for Dual/Quad transfers, until someone proves the above
hardware does exist. If both rx/tx_buf are filled in, the SPI master driver
cannot know in which direction the Dual/Quad transfer is operating.

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

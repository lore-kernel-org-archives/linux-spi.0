From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH 2/3] spi: bitbang: add lsb first support
Date: Thu, 13 Mar 2014 20:22:47 +0100
Message-ID: <CAMuHMdWJRz_ZDpOGO_uBBshajWHDjirvZStYuWxZpkFOsexLRQ@mail.gmail.com>
References: <1394637636-29042-1-git-send-email-m.grzeschik@pengutronix.de>
	<1394637636-29042-3-git-send-email-m.grzeschik@pengutronix.de>
	<20140312212941.GP3327@book.gsilab.sittig.org>
	<20140312213544.GX28112@sirena.org.uk>
	<20140313181107.GT3327@book.gsilab.sittig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Michael Grzeschik <m.grzeschik-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-arm-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
To: Gerhard Sittig <gsi-ynQEQJNshbs@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140313181107.GT3327-kDjWylLy9wD0K7fsECOQyeGNnDKD8DIp@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Gerhard,

On Thu, Mar 13, 2014 at 7:11 PM, Gerhard Sittig <gsi-ynQEQJNshbs@public.gmane.org> wrote:
> http://graphics.stanford.edu/~seander/bithacks.html#BitReverseObvious
> and the following sections suggest that code might get less
> expensive when you accept to no longer see at first glance what's
> happening.  Given a good identifier and an appropriate comment,
> http://graphics.stanford.edu/~seander/bithacks.html#ReverseParallel
> might be acceptable for mainline.

I had faint memories of seeing this algorithm in the Linux kernel sources,
but I can't seem to find it anymore.

We do have a different implementation in lib/bitrev.c.

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

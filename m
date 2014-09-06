From: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2] spi: orion: support armada extended baud rates
Date: Sat, 6 Sep 2014 15:16:54 +0200
Message-ID: <20140906151654.49584b70@free-electrons.com>
References: <1409835268-29555-1-git-send-email-gerg@uclinux.org>
	<CAMuHMdWDOaPnmCzThqCo2848eDj6jmi-eaXM1YAXQLi41da34A@mail.gmail.com>
	<5409057A.6090900@uclinux.org>
	<CAMuHMdWf6_yBhpNgK=wJcQqzLNJvTnC95SrqrcZyRH+jGL93vA@mail.gmail.com>
	<5409B68A.7010604@uclinux.org>
	<20140906120600.GA11500@arch.cereza>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Greg Ungerer <gerg-JBU5SbJe1FlAfugRpC6u6w@public.gmane.org>,
	Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>,
	Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>,
	Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140906120600.GA11500-nAQHv47ARr+vIlHkl8J1cg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hello,

On Sat, 6 Sep 2014 09:06:00 -0300, Ezequiel Garcia wrote:

> Confirmed. Judging from the specs, seems the same SPI IP is on all the
> Armada SoCs; you can do the 'armada-spi' compatible addition on 375 and 38x.

However, I believe a compatible string like "armada-370-spi" should be
used instead of "armada-spi". The normal rule is to use the oldest SoC
that introduced a certain feature as the compatible string.

Remember for example that Armada 1500 (Berlin) is a completely different
line of SoC, which cannot use this SPI driver.

Thanks Greg for working on this! I noticed this as well recently when
doing an SPI development, but you were faster than me in proposing a
patch!

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Jakub =?UTF-8?B?S2ljacWEc2tp?= <moorray3-5tc4TXWwyLM@public.gmane.org>
Subject: Re: spi: bcm2835: driver for "auxiliar" spi1/spi2
Date: Thu, 25 Jun 2015 19:42:19 +0200
Message-ID: <20150625194219.4846221d@north>
References: <5582933E.1050500@martin.sperl.org>
	<55829B18.4030609@tronnes.org>
	<20150618105848.GE14071@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Noralf =?UTF-8?B?VHLDuG5uZXM=?= <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>,
	Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150618105848.GE14071-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thu, 18 Jun 2015 11:58:48 +0100, Mark Brown wrote:
> On Thu, Jun 18, 2015 at 12:19:04PM +0200, Noralf Tr=C3=B8nnes wrote:
>=20
> > There is also an aux mini uart that shares interrupt with spi1/2.
> > The AUXIRQ register determines the interrupt source. How should thi=
s
> > sharing be done? This uart is really only useful on the Compute Mod=
ule
> > since it's pins overlap the pl011 uart pins on the other boards.
> > This is how the mini uart is used/setup downstream:
> > https://github.com/raspberrypi/linux/pull/1008
>=20
> Linux supports shared interrupts perfectly fine, though it sounds lik=
e
> this is actually a cascaded interrupt (the demux is another interrupt
> controller) which we also support just fine.

Mark, could you give us a hint how to best go about this shared IRQ?
I failed to find any generic interrupt controller.  I imagine there
should be some fake irqchip we can instantiate from DT giving it a
irq line and a memory address and it should provide us with 32(bit)
demuxed irqs based on status of bits in specified memory location.
Does this sound reasonable?  Does such fake irqchip driver exist?
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

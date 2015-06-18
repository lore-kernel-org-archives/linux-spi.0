From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: spi: bcm2835: driver for "auxiliar" spi1/spi2
Date: Thu, 18 Jun 2015 13:37:11 +0200
Message-ID: <5582AD67.9020503@martin.sperl.org>
References: <5582933E.1050500@martin.sperl.org> <55829B18.4030609@tronnes.org> <20150618105848.GE14071@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	=?windows-1252?Q?Noralf_Tr=F8nnes?= <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150618105848.GE14071-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 2015-06-18 12:58, Mark Brown wrote:
> On Thu, Jun 18, 2015 at 12:19:04PM +0200, Noralf Tr=F8nnes wrote:
> Linux supports shared interrupts perfectly fine, though it sounds lik=
e
> this is actually a cascaded interrupt (the demux is another interrupt
> controller) which we also support just fine.

So we need to move the route of using a cascaded demux interrupt handle=
r
for interrupt separation.

The other thing is: is there a "framework" to handle access to the
the "enable" register shared by all three devices (spi1/spi2/uart1),
or do we have to create a tiny module (aux-bcm2835 or similar) to
serialize access to this register?

=46or the moment I will start focusing on the implementation itself whi=
le
we can figure out the interrupt-controller configuration in DT in
parallel...

We also should look into upstreaming the configuration of uart1 - even
if only available on the compute board...

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Jakub =?UTF-8?B?S2ljacWEc2tp?= <moorray3-5tc4TXWwyLM@public.gmane.org>
Subject: Re: [PATCH] spi: expose spi_master and spi_device statistics via
 sysfs
Date: Fri, 19 Jun 2015 12:00:41 +0200
Message-ID: <20150619120041.7e7e4d96@north>
References: <1432574909-2326-1-git-send-email-kernel@martin.sperl.org>
	<556EE446.3060407@metafoo.de>
	<20150603115319.GF14071@sirena.org.uk>
	<8DBE5E2D-47ED-48D3-A185-82AF4831B0A2@martin.sperl.org>
	<B3BA7701-96E1-466A-90EA-121E2A85F851@martin.sperl.org>
	<20150618134918.GF14071@sirena.org.uk>
	<20150619115625.7e1aa9e6@north>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150619115625.7e1aa9e6@north>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Fri, 19 Jun 2015 11:56:25 +0200, Jakub Kici=C5=84ski wrote:
> On Thu, 18 Jun 2015 14:49:18 +0100, Mark Brown wrote:
> > On Thu, Jun 18, 2015 at 02:54:35PM +0200, Martin Sperl wrote:
> >=20
> > > Now that I am back here some examples from /sys which contain mul=
tiple values:
> > > /sys/devices/platform/soc/20980000.usb/pools:
> >=20
> > The fact that other people have broken the ABI doesn't mean it's a =
good
> > idea to introduce further ABI breakage.
>=20
> How about putting this file in debugfs after all?  Mark suggested it
> initially but the conversation went in other direction.  Martin said
> that his main purpose is to help *debugging* performance of RPi dma,
> so it's a perfect candidate for debugfs.  I can't in my mind see any
> use for this information on a production system to be honest...

Sorry about triple posting, my mail provider got banned by spamcop :$
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH linux-next v4 5/5] mtd: atmel-quadspi: add driver for Atmel QSPI controller
Date: Tue, 25 Aug 2015 12:22:10 +0200
Message-ID: <201508251222.10813.marex@denx.de>
References: <cover.1440410236.git.cyrille.pitchen@atmel.com> <201508241303.52066.marex@denx.de> <55DC40C1.3050405@atmel.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org,
	computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, beanhuo-AL4WhLSQfzjQT0dZR+AlfA@public.gmane.org,
	juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org, shijie.huang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org,
	mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org,
	galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55DC40C1.3050405-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tuesday, August 25, 2015 at 12:17:37 PM, Cyrille Pitchen wrote:
> Hi Marek,

Hi!

> Le 24/08/2015 13:03, Marek Vasut a =E9crit :
> > On Monday, August 24, 2015 at 12:14:00 PM, Cyrille Pitchen wrote:
> >> This driver add support to the new Atmel QSPI controller embedded =
into
> >> sama5d2x SoCs. It expects a NOR memory to be connected to the QSPI
> >> controller.
> >>=20
> >> Signed-off-by: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
> >> Acked-by: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
> >=20
> > Hi,
> >=20
> > [...]
> >=20
> >> +/* Register access macros */
> >=20
> > These are functions, not macros :)
> >=20
> > btw is there any reason for these ? I'd say, just put the read*() a=
nd
> > write*() functions directly into the code and be done with it, it i=
s
> > much less confusing.
>=20
> If you don't mind, I'd rather keep some of these inline functions. I =
have
> no strong justification, it's more a personal taste: it makes lines
> shorter as it avoids the need to add "->regs + ".
> Also it makes the code consistent with other Atmel drivers which alre=
ady
> use such wrappers.
>=20
> However I'll fix the comment and remove the byte and word versions, w=
hich
> are not used. So only qspi_readl() and qspi_writel() are left.
>=20
> Does it sound good to you?

In my mind, seeing explicit readl_relaxed() somewhere is much easier to
digest than seeing some wrapper, which I have to look up. But please do
wait for others to voice their concern too, I might not be the best per=
son
to tell you what to do when it comes to wrapping IO accessors ;-)

Best regards,
Marek Vasut
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

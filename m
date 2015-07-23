From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH v2 1/5] mtd: spi-nor: notify (Q)SPI controller about protocol change
Date: Thu, 23 Jul 2015 09:00:50 +0200
Message-ID: <201507230900.50570.marex@denx.de>
References: <cover.1437569902.git.cyrille.pitchen@atmel.com> <201507221541.46135.marex@denx.de> <55AFC3F0.5050002@atmel.com>
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
In-Reply-To: <55AFC3F0.5050002-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wednesday, July 22, 2015 at 06:25:20 PM, Cyrille Pitchen wrote:
> Hi Marek,
>=20
> Le 22/07/2015 15:41, Marek Vasut a =E9crit :
> > On Wednesday, July 22, 2015 at 03:17:06 PM, Cyrille Pitchen wrote:
> >> Once the Quad SPI mode has been enabled on a Micron flash memory, =
this
> >> device expects ALL the following commands to use the SPI 4-4-4 pro=
tocol.
> >> The (Q)SPI controller needs to be notified about the protocol chan=
ge so
> >> it can adapt and keep on dialoging with the Micron memory.
> >>=20
> >> Signed-off-by: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
> >> ---
> >>=20
> >>  drivers/mtd/spi-nor/spi-nor.c | 17 +++++++++++++++++
> >>  include/linux/mtd/spi-nor.h   | 13 +++++++++++++
> >>  2 files changed, 30 insertions(+)
> >>=20
> >> diff --git a/drivers/mtd/spi-nor/spi-nor.c
> >> b/drivers/mtd/spi-nor/spi-nor.c index d78831b4422b..93627d4e6be8 1=
00644
> >> --- a/drivers/mtd/spi-nor/spi-nor.c
> >> +++ b/drivers/mtd/spi-nor/spi-nor.c
> >> @@ -163,6 +163,18 @@ static inline int write_disable(struct spi_no=
r
> >> *nor)
> >>=20
> >>  	return nor->write_reg(nor, SPINOR_OP_WRDI, NULL, 0, 0);
> >> =20
> >>  }
> >>=20
> >> +/*
> >> + * Notify the (Q)SPI controller about the new protocol to be used=
=2E
> >=20
> > Hi!
> >=20
> > Can you please just reword this a little, so that it is absolutelly=
 clear
> > even to the less bright of us (like me) that this is a notification
> > coming from the upper layers (ie. the spi-nor framework) toward the
> > hardware ?
>=20
> Sure, no problem! what about the following?
>=20
> /*
>  * Let the spi-nor framework notify lower layers, especially the driv=
er of
> the * (Q)SPI controller, about the new protocol to be used. Indeed, o=
nce
> the * spi-nor framework has sent manufacturer specific commands to a
> memory to * enable its Quad SPI mode, it should immediately after tel=
l the
> QSPI * controller to use the very same Quad SPI protocol as expected =
by
> the memory. */

Sure, excellent, thanks ! :-)
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

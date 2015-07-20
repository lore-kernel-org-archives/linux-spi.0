From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH 4/7] Documentation: mtd: add a DT property to set the latency code of Spansion memory
Date: Mon, 20 Jul 2015 21:29:41 +0200
Message-ID: <201507202129.42105.marex@denx.de>
References: <cover.1437059658.git.cyrille.pitchen@atmel.com> <201507161944.20523.marex@denx.de> <55ACBE1B.6050507@atmel.com>
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
In-Reply-To: <55ACBE1B.6050507-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Monday, July 20, 2015 at 11:23:39 AM, Cyrille Pitchen wrote:
> Hi Marek,

Hi!

> Le 16/07/2015 19:44, Marek Vasut a =E9crit :
> > On Thursday, July 16, 2015 at 05:27:51 PM, Cyrille Pitchen wrote:
> >=20
> > Hi!
> >=20
> >> Both the SPI controller and the NOR flash memory need to agree on =
the
> >> number of dummy cycles to use for Fast Read commands. For Spansion
> >> memories, this number of dummy cycles is not given directly but th=
rough
> >> a so called "latency code".
> >> The latency code can be found into the memory datasheet and depend=
s on
> >> the SPI clock frequency, the Fast Read op code and the Single/Dual=
 Data
> >> Rate mode.
> >=20
> > Shouldn't you be able to derive the latency code from the above
> > information, which you already know then ?
>=20
> Yes I agree with you; this could have been done adding static tables =
inside
> the driver instead of creating a new DT property dedicated to Spansio=
n
> memories.

OK, I see now. The latency code can not be calculed from "SPI clock fre=
quency,=20
the Fast Read op code and the Single/Dual Data Rate mode" easily, you n=
eed to
index into some table to obtain some ad-hoc value. Got it. Sorry for th=
e noise!

> When I wrote this patch, I had a close look at the s25fl512s datashee=
t but
> only overviewed few datasheets for other Spansion QSPI flash memories=
=2E So
> I don't know whether a single latency code table could be shared amon=
g all
> Spansion memories or many tables should be added to support different
> memory models.
>=20
> That's why I've chosen to add a dedicated DT property to support Span=
sion
> memories as it avoids to add tables to guess the proper latency code =
to be
> used. I thought it would be more flexible.
>=20
> Maybe I will remove the support of Spansion QSPI memories from this s=
eries
> for now. Their support can still be implemented later.
>=20
> Anyway, thanks for your review :)

Let's wait for more comments :)

Best regards,
Marek Vasut
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

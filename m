From: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 4/7] Documentation: mtd: add a DT property to set the
 latency code of Spansion memory
Date: Mon, 20 Jul 2015 11:23:39 +0200
Message-ID: <55ACBE1B.6050507@atmel.com>
References: <cover.1437059658.git.cyrille.pitchen@atmel.com> <398ca9f17bda638e05e97f258fb4e6d27ac828db.1437059658.git.cyrille.pitchen@atmel.com> <201507161944.20523.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
	<computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	<beanhuo-AL4WhLSQfzjQT0dZR+AlfA@public.gmane.org>, <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>,
	<shijie.huang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>,
	<linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	<devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	<pawel.moll-5wv7dgnIgG8@public.gmane.org>, <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	<ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	<linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201507161944.20523.marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Marek,

Le 16/07/2015 19:44, Marek Vasut a =E9crit :
> On Thursday, July 16, 2015 at 05:27:51 PM, Cyrille Pitchen wrote:
>=20
> Hi!
>=20
>> Both the SPI controller and the NOR flash memory need to agree on th=
e
>> number of dummy cycles to use for Fast Read commands. For Spansion
>> memories, this number of dummy cycles is not given directly but thro=
ugh a
>> so called "latency code".
>> The latency code can be found into the memory datasheet and depends =
on the
>> SPI clock frequency, the Fast Read op code and the Single/Dual Data =
Rate
>> mode.
>=20
> Shouldn't you be able to derive the latency code from the above infor=
mation,
> which you already know then ?
Yes I agree with you; this could have been done adding static tables in=
side the
driver instead of creating a new DT property dedicated to Spansion memo=
ries.

When I wrote this patch, I had a close look at the s25fl512s datasheet =
but only
overviewed few datasheets for other Spansion QSPI flash memories. So I =
don't
know whether a single latency code table could be shared among all Span=
sion
memories or many tables should be added to support different memory mod=
els.

That's why I've chosen to add a dedicated DT property to support Spansi=
on
memories as it avoids to add tables to guess the proper latency code to=
 be
used. I thought it would be more flexible.

Maybe I will remove the support of Spansion QSPI memories from this ser=
ies for
now. Their support can still be implemented later.

Anyway, thanks for your review :)

>=20
> Best regards,
> Marek Vasut
>=20

Best Regards,

Cyrille
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

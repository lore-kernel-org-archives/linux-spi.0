From: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH linux-next 0/4] mtd: spi-nor: fix Quad SPI memory support
Date: Mon, 2 Nov 2015 13:56:47 +0100
Message-ID: <56375D8F.5040403@atmel.com>
References: <cover.1442590224.git.cyrille.pitchen@atmel.com>
 <201511020207.57031.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
	<computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	<beanhuo-AL4WhLSQfzjQT0dZR+AlfA@public.gmane.org>, <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>, <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>,
	<jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>, <jteki-oRp2ZoJdM/RWk0Htik3J/w@public.gmane.org>,
	<linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	<devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	<pawel.moll-5wv7dgnIgG8@public.gmane.org>, <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	<ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	<linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201511020207.57031.marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Le 02/11/2015 02:07, Marek Vasut a =E9crit :
> On Friday, September 18, 2015 at 05:49:24 PM, Cyrille Pitchen wrote:
>> Hi all,
>=20
> Hi!
>=20
Hi Marek!

>> this series of patches fixes the QSPI support mostly for Micron and
>> Macronix memories. There are also some updates for Spansion memories=
=2E
>> There are also many comments to explain the implementation choices b=
ased
>> on the datasheets from memory manufacturers.
>>
>> The series was backported to a at91-4.1 kernel then tested on a sama=
5d2
>> xplained board, which embeds a at25df321a memory on a SPI controller=
 and
>> a Micron n25q128a13 QSPI memory on the new Atmel QSPI controller.
>>
>> The at25 memory was used to check non regression on the m25p80 drive=
r
>> whereas the Micron memory was used to test the fixes of the spi-nor
>> framework. The driver for the Atmel QSPI controller will be sent in =
a
>> dedicated series.
>=20
> Are there any news on this patch series? I'd like to use that for my =
own
> QSPI driver (the Cadence one), so I'd like to check on the status. Ar=
e you
> still working on this please ?
>=20
Nothing new from my side. This series of patches should have taken into=
 account
all the comments I'd received from previous series. At least, I hope so=
=2E
If I forgot some points or if something is still missing, let me know a=
nd I'll
update the series accordingly.

I also wait for a kind of agreement on how we could update the framewor=
k API
so that more QSPI memories could be supported. I have already written a=
 driver
for an Atmel QSPI controller. This driver is based on this series of pa=
tches.
I have to know what the updated API will be before sending another seri=
es for
the QSPI controller driver. So this series is one proposal for some API=
 updates
but other proposals may exist.

I've asked Brian on IRC for review and pieces of advice on how he think=
s the
work should be done. I've understood he's right now a little bit busy. =
I'm fine
with it. I also often have to deal with many topics almost in the same =
time so
I can understand whether he needs more time.

Anyway, I guess Brian has already started to review these patches since=
 last
=46riday he referred to a previous talk we had about some leading space=
:

http://lists.infradead.org/pipermail/linux-mtd/2015-October/062956.html


> Thanks!
>=20
> Best regards,
> Marek Vasut
>=20

Best regards,

Cyrille
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

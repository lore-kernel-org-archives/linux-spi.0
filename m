From: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [LINUX PATCH v2 1/3] spi: Added dummy_cycle entry in the
 spi_transfer structure.
Date: Thu, 14 Apr 2016 17:23:04 +0200
Message-ID: <570FB5D8.90807@atmel.com>
References: <1460039969-9835-1-git-send-email-lakshmis@xilinx.com>
 <57067694.8030806@atmel.com>
 <4FF8F58FAA9D5D4193D4E554E4352C5902C720DE@XAP-PVEXMBX02.xlnx.xilinx.com>
 <570F4F9F.3090605@atmel.com> <20160414085707.GE18024@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Lakshmi Sai Krishna Potthuri
	<lakshmi.sai.krishna.potthuri-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	Michal Simek <michals-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	Soren Brinkmann <sorenb-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	"David Woodhouse" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
	Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>,
	Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
	Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>,
	"Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>,
	Jagan Teki <jteki-oRp2ZoJdM/RWk0Htik3J/w@public.gmane.org>,
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	"linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Harini Katakam <harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	Punnaiah C
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160414085707.GE18024-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Le 14/04/2016 10:57, Mark Brown a =E9crit :
> On Thu, Apr 14, 2016 at 10:06:55AM +0200, Cyrille Pitchen wrote:
>=20
>> I understand but you propose to patch both the SPI layer and the m25=
p80 driver
>> to introduce some support which is already provided by the "spi_flas=
h_read"
>> hook: struct spi_flash_read_message has already a "dummy_bytes" fiel=
d.
>> IMHO, it looks redundant.
>=20
> My understanding is that this is intended for dummy bits rather than
> dummy bytes.
>=20

dummy_bits =3D=3D (dummy_bytes * 8) and
dummy_cycles =3D=3D ((dummy_bytes * 8) / addr_nbits)

witch addr_nbits in {1, 2, 4}

the struct_flash_read_message has both dummy_bytes and addr_nbits membe=
rs.

The spi-nor framework seems to always provide a multiple of 8 for dummy=
 *bits*.
I guess because the m25p80 driver only supports such number of dummy bi=
ts but
also because all SPI memories can be configured so their number of dumm=
y cycles keeps the byte alignment for the data to follow.

It still allows to use less than 8 dummy *cycles*, for instance the fac=
tory
settings for Macronix Quad SPI memories are:
- 4 dummy cycles for Fast Read 1-2-2 (hence 8 dummy bits)
- 6 dummy cycles for Fast Read x-4-4 (hence 24 dummy bits)

AFAIK, only Micron QSPI memories could be configured so the number of d=
ummy
cycles doesn't result in a multiple of 8 bits but theirs are not the
recommanded timings provided by the datasheet.

Micron factory settings are:
- 10 dummy cycles for Fast Read x-4-4 (hence 40 dummy bits)
- 8 dummy cycles for other Fast Reads.


Best regards,

Cyrille
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

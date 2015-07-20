From: Cyrille Pitchen <cyrille.pitchen@atmel.com>
Subject: Re: [PATCH 7/7] mtd: atmel-quadspi: add driver for Atmel QSPI controller
Date: Mon, 20 Jul 2015 10:55:54 +0200
Message-ID: <55ACB79A.3010101@atmel.com>
References: <cover.1437059658.git.cyrille.pitchen@atmel.com>	 <cf2522fc858b72af78d057ac76c4f029e80edf4a.1437059658.git.cyrille.pitchen@atmel.com> <1437123868.24981.7.camel@tiscali.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <nicolas.ferre@atmel.com>, <broonie@kernel.org>,
	<linux-spi@vger.kernel.org>, <dwmw2@infradead.org>,
	<computersforpeace@gmail.com>, <zajec5@gmail.com>,
	<beanhuo@micron.com>, <juhosg@openwrt.org>, <marex@denx.de>,
	<shijie.huang@intel.com>, <ben@decadent.org.uk>,
	<linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
	<pawel.moll@arm.com>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
	<linux-mtd@lists.infradead.org>
To: Paul Bolle <pebolle@tiscali.nl>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1437123868.24981.7.camel@tiscali.nl>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Paul,

I've removed the ".bus =3D &plaform_bus_type" for the next series.
Thank you for the explanation and the review :)

Best Regards,

Cyrille

Le 17/07/2015 11:04, Paul Bolle a =C3=A9crit :
> On do, 2015-07-16 at 17:27 +0200, Cyrille Pitchen wrote:
>> --- /dev/null
>> +++ b/drivers/mtd/spi-nor/atmel-quadspi.c
>=20
>> +static struct platform_driver atmel_qspi_driver =3D {
>> +	.driver		=3D {
>> +		[...]
>> +		.bus	=3D &platform_bus_type,
>> +		[...]
>> +};
>> +module_platform_driver(atmel_qspi_driver);
>=20
> Nit: on module init this will basically do
>     __platform_driver_register(&atmel_qspi_driver, THIS_MODULE);
>=20
> which will again set bus to &platform_bus_type. So you might as well
> drop that line.
>=20
>=20
> Paul Bolle
>=20

From: Sergei Ianovich <ynvich@gmail.com>
Subject: Re: [PATCH v1] spi: master driver to enable RTC on ICPDAS LP-8841
Date: Mon, 22 Feb 2016 12:26:14 +0300
Message-ID: <1456133174.2386.33.camel@gmail.com>
References: <1456105630-28914-1-git-send-email-ynvich@gmail.com>
	 <20160222031027.GP18327@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree@vger.kernel.org>,
	"open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160222031027.GP18327@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, 2016-02-22 at 12:10 +0900, Mark Brown wrote:
> On Mon, Feb 22, 2016 at 04:47:06AM +0300, Sergei Ianovich wrote:
> > ICP DAS LP-8841 contains a DS-1302 RTC. This driver provides an SPI
> > master which makes the RTC usable. The driver is not supposed to
> > work
> > with anything else.
>=20
> So this is something that is internal to a single chip or something?
> I'm slightly unclear from the above if this is or is not a SPI
> controller.=C2=A0=C2=A0If it isn't generic the DT should probably jus=
t describe
> the IP and let the driver create the SPI controller and device if
> that
> is an expedient way of doing things.
>=20
> > +spi0@901c {
> > +	#address-cells =3D <1>;
> > +	#size-cells =3D <0>;
> > +	compatible =3D "icpdas,spi-lp8841-rtc";
> > +	reg =3D <0x901c 0x1>;
> > +
> > +	rtc@0 {
> > +		compatible =3D "maxim,rtc-ds1302";
> > +		reg =3D <0>;
> > +		spi-max-frequency =3D <500000>;
> > +		spi-3wire;
> > +		spi-lsb-first;
> > +		spi-cs-high;
> > +	};
> > +};
>=20
> This example makes it seem like an actual SPI controller but just one
> that's broken/limited?

Yes. This is an actual SPI controller with minimal required
functionality. I didn't implement anything I don't need.

> > +config SPI_LP8841_RTC
> > +	tristate "ICP DAS LP-8841 SPI Controller for RTC"
> > +	depends on OF && (MACH_PXA27X_DT || COMPILE_TEST)
>=20
> Does this need a strict DT dependency or can it build without DT?

The driver can only be useful on a single industrial PC. That PC
requires DT, so I made this a strict=C2=A0dependency. The dependency ca=
n be
removed by using ifdefs, but I see no point why.

> > +/*
> > + * REVISIT If there is support for SPI_3WIRE and SPI_LSB_FIRST in
> > SPI
> > + * GPIO driver, this SPI driver can be replaced by a simple GPIO
> > driver
> > + * providing 3 GPIO pins.
> > + */
>=20
> What's the advantage of not doing that?=C2=A0=C2=A0Overall the driver=
 looks
> fairly
> good but it does seem to just implement a straight bitbanging driver
> with less flexibility.

MicroWire (SPI_3WIRE) mode is slightly different from the modes
implemented in=C2=A0spi-bitbang-txrx.h. I was getting junk from device =
in
both Mode0 and Mode2 until I changed the implementation. The change is
documented in the patch.

There will also need to be changes in bitbang.c. SPI_LSB_FIRST will
require a new flasg in txrx_word(). To keep overhead low will require
to grow txrx_word[] from 4 to 16 or even 32. CPOL, CPHA, LSB_FIRST,
3_WIRE each requires an additional power of 2.

While this change could be benefitial to both spi-gpio and spi-bitbang,=
=20
it is very big.

> > +#ifndef DRIVER_NAME
> > +#define DRIVER_NAME	"spi_lp8841_rtc"
> > +#endif
>=20
> If you want to use a define for this just use a define for it, don't
> do
> this ifdef stuff.

Yes, I'll fix this. This has been blindly copied from spi-gpio.c.

> > +static inline void
> > +spidelay(unsigned usec)
> > +{
> > +	usleep_range(usec, usec + 1);
> > +}
>=20
> Just use usleep_range() directly.

Yes, I will.

> > +static void
> > +spi_lp8841_rtc_cleanup(struct spi_device *spi)
> > +{
> > +}
>=20
> Remove empty functions, if they can be empty the core will support
> ignoring them if they are missing.

Yes, I will.

Thanks for a lightning fast review.
>=C2=A0>=C2=A0

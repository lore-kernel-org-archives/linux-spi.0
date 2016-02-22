From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v1] spi: master driver to enable RTC on ICPDAS LP-8841
Date: Mon, 22 Feb 2016 20:08:16 +0900
Message-ID: <20160222110816.GD18327@sirena.org.uk>
References: <1456105630-28914-1-git-send-email-ynvich@gmail.com>
 <20160222031027.GP18327@sirena.org.uk>
 <1456133174.2386.33.camel@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="P+5wBWHyMmVhWeqO"
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"open list:SPI SUBSYSTEM" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Sergei Ianovich <ynvich-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1456133174.2386.33.camel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--P+5wBWHyMmVhWeqO
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 22, 2016 at 12:26:14PM +0300, Sergei Ianovich wrote:
> On Mon, 2016-02-22 at 12:10 +0900, Mark Brown wrote:
> > On Mon, Feb 22, 2016 at 04:47:06AM +0300, Sergei Ianovich wrote:

> > > +config SPI_LP8841_RTC
> > > +	tristate "ICP DAS LP-8841 SPI Controller for RTC"
> > > +	depends on OF && (MACH_PXA27X_DT || COMPILE_TEST)

> > Does this need a strict DT dependency or can it build without DT?

> The driver can only be useful on a single industrial PC. That PC
> requires DT, so I made this a strict=A0dependency. The dependency can be
> removed by using ifdefs, but I see no point why.

It makes it easier for anyone doing generic work on the kernel to build
test, one could make exactly the same argument about the dependency on
the PXA27x machine.

> > > +/*
> > > + * REVISIT If there is support for SPI_3WIRE and SPI_LSB_FIRST in
> > > SPI
> > > + * GPIO driver, this SPI driver can be replaced by a simple GPIO
> > > driver
> > > + * providing 3 GPIO pins.
> > > + */

> > What's the advantage of not doing that?=A0=A0Overall the driver looks
> > fairly
> > good but it does seem to just implement a straight bitbanging driver
> > with less flexibility.

> MicroWire (SPI_3WIRE) mode is slightly different from the modes
> implemented in=A0spi-bitbang-txrx.h. I was getting junk from device in
> both Mode0 and Mode2 until I changed the implementation. The change is
> documented in the patch.

> There will also need to be changes in bitbang.c. SPI_LSB_FIRST will
> require a new flasg in txrx_word(). To keep overhead low will require
> to grow txrx_word[] from 4 to 16 or even 32. CPOL, CPHA, LSB_FIRST,
> 3_WIRE each requires an additional power of 2.

> While this change could be benefitial to both spi-gpio and spi-bitbang,=
=20
> it is very big.

OK, the number of users is probably small enough that it's not worth
worryinng about duplication.

--P+5wBWHyMmVhWeqO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWyuweAAoJECTWi3JdVIfQn4MH/RccQbJgucUlUUndwy9SALGR
YWFx0e/1/aY+dHSgfiHXi5nC7um8Nct9ojKBk74oUvCwwtjnmJGBpPUJUg5d9///
CebiwC+qbe2BuMy9Uy2qoRKgkd8lMva2n6Amn2HDkwvcDgh0jFTKgKPV7QcSZ9qk
uyYrV6AAqk82fhE8szxQDQuG7sefwuGfABC6fx+gYQhVjZZZj47AIYONmqKlnnmz
neOWuUoq8rigCb0kUT75NEVWh97hzYu4x93Vo9JxI5LBymUPO/ir4Q9rYdLEjiwP
NHwHbIx4brkAGRRRdz0+r+pE+OZ11/4lTdvR4Jt3rboIpFgyr0xYDDf8V0WmCQw=
=dN5H
-----END PGP SIGNATURE-----

--P+5wBWHyMmVhWeqO--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

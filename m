From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 0/3] spi: dw: refactor to use SPI core message handling
Date: Fri, 6 Mar 2015 20:28:22 +0000
Message-ID: <20150306202822.GE21293@sirena.org.uk>
References: <1425301137-8043-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Ey8lWCThJgjr0fHX"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1425301137-8043-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Ey8lWCThJgjr0fHX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 02, 2015 at 02:58:54PM +0200, Andy Shevchenko wrote:
> This patch series is dedicated to refactoring of spi-dw driver to use SPI=
 core
> message handling. The driver has been tested in PIO mode on Intel Medfield
> device in loopback mode.
>=20
> Note, the patch 3/3 depends on [1].
>=20
> [1] http://www.spinics.net/lists/linux-spi/msg02982.html

Please ensure that your e-mails are readable by humans - if you're
referencing some other patch include a human readable description.  I
frequently read mail with no internet access (eg, on planes or trains)
where that link would mean nothing.

--Ey8lWCThJgjr0fHX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU+g3lAAoJECTWi3JdVIfQpr0H/1ovvTwBi+aOAWN9bGn67rK2
th97qnnqnbY6b92VRmmNJ88nM1wdlAkZzWO0o1Ch+ila7JbJv5acXqXC8cUiZyDK
v1vokY7eIlf6EBZT+JcGpUgQSR9nD+3dxaRGU1bUHQwO39dpqdpmkTjLZb82/d4X
OYE1m3iNFx76aDQtNYmWpMQyPD+8AvpHBDwCi8C4ffMd0eOJ3tsnJVOefa0V4Uyg
Wy7Ry/w04CQ7MWy/rkRjTC+n85y0AdtehG0w0NbCD5RbMt+Y9T5+wfKTvQZarTPt
sKZOZamL4vdBW085OtGrL6qE/Z+yT5z78woM0sb1iYQ3+gRBzQxLH1iwlZHBYAA=
=lVTS
-----END PGP SIGNATURE-----

--Ey8lWCThJgjr0fHX--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

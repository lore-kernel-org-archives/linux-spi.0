From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 07/11] spi: spi-ep93xx: remove 'dss' from per chip
 private data
Date: Wed, 3 Jul 2013 19:22:54 +0100
Message-ID: <20130703182254.GE27646@sirena.org.uk>
References: <201307021009.30230.hartleys@visionengravers.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4vXjQNnSxf1+t97G"
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	spi-devel-general@lists.sourceforge.net,
	Ryan Mallon <rmallon@gmail.com>, mika.westerberg@iki.fi,
	grant.likely@linaro.org, hsweeten@visionengravers.com
To: H Hartley Sweeten <hartleys@visionengravers.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201307021009.30230.hartleys@visionengravers.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--4vXjQNnSxf1+t97G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 02, 2013 at 10:09:29AM -0700, H Hartley Sweeten wrote:
> This value is only needed to set the bits per word for each transfer
> of a message. There is no reason to set the value in ep93xx_spi_enable()
> because ep93xx_spi_process_transfer() sets it again for each transfer.

Applied, thanks.

--4vXjQNnSxf1+t97G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR1Gv7AAoJELSic+t+oim9Kk4P/1TK1/teZ5P2ZhfHQ/NDXtfK
Os53h2qwVfjYNZwosaJDaIulUToRDdUSVck4nPQX4YwkWo+1Fdpk6SU+cAoe4IQg
gnb8TLieMyBoh9VECTLLzvowbI7VY1Rtmlqx4I7nRHm2JfNVudh/3JnYA+GfcSLn
RmeoFFe6fW/zLWOsWHhinemn+Bvvjs2EM2f03256qggSRGht1on4LE/nR1hRbXfS
0mjNFqGSARrtVlLTl3kDmqkdtTiDmHJSw6i4jGVnFV/XozXxBuzFS7Z3qwZ7OJy1
KjJFbYVl+MPKduw/YDAQdRSkKCVEPgkdE2VLaUpNx3mJ3twh5WrgskV+MdKl4lj2
4wcYuHz0mTixFjyQ1XnD4xWnCMx4GLA6CAMKyt2fWMINCvQvPNlVBm4H8okYfDwL
ym2sX/jVr6mBQIuqtjBOw6WwIeJ2GmsLQHDJjtHm2mReptXjZcuuCnzmVxjm6gx/
qZwcr3PEAsD0gsKe2yxYQnPIGaT3JzNEY2BVRHLQRJ69lsvmNooE322Sx0KlkI8y
J/P6eZbFg/Uw3WJCd+b+QRfIjsjonCIWAtD34s7c9LPoCUoPnrPsJJKGDQotyl7+
dLXPaWek7UGYH1HB/ocNYt4iHCSF0OeotsLx1O11fkaMD1rbuZOuGnxskt96Iccs
vh8iDOgGy4eFg6ffSW24
=2v6/
-----END PGP SIGNATURE-----

--4vXjQNnSxf1+t97G--

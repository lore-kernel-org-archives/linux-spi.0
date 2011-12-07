From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] spi: use gpio_request_one() instead of
 spi_gpio_alloc() helper function
Date: Wed, 7 Dec 2011 22:21:09 +0100
Message-ID: <20111207212109.GA1314@pengutronix.de>
References: <1323071447.20963.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Cc: linux-kernel@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net,
	Linus Walleij <linus.walleij@linaro.org>
To: Axel Lin <axel.lin@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1323071447.20963.3.camel@phoenix>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 05, 2011 at 03:50:47PM +0800, Axel Lin wrote:
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

This will make the driver depend on GPIOLIB, currently it depends only
on GENERIC_GPIO. That needs to be addressed and made sure it won't cause
a regression for the in-kernel users.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk7f2MUACgkQD27XaX1/VRtksACeJiiWx7oweAqcIeQglcvnHyLo
+7UAn1NjjAKveQSVrZxZtG1IcWzUljo9
=mSNZ
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--

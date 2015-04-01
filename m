From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: spi-bfin5xx: Initialize cr_width in
 bfin_spi_pump_transfers()
Date: Wed, 1 Apr 2015 21:29:06 +0100
Message-ID: <20150401202906.GD6023@sirena.org.uk>
References: <BLU436-SMTP1172BE3B8CDF9C6A7CC89CCB9F30@phx.gbl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2iBwrppp/7QCDedR"
Cc: linux-spi@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Chen Gang <xili_gchen_5257@hotmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <BLU436-SMTP1172BE3B8CDF9C6A7CC89CCB9F30@phx.gbl>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--2iBwrppp/7QCDedR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 02, 2015 at 03:03:33AM +0800, Chen Gang wrote:
> cr_width may be not initialized before using by cr, the related warning
> (with defconfig under blackfin by gcc5):

Applied, thanks.

--2iBwrppp/7QCDedR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVHFURAAoJECTWi3JdVIfQLFYH/2xd1PZfLy94zuZMwTZjRP/7
6ED0Ei8YKS2WIxa3llZ8qgeVKEO9GfGSjwTnM3V+1yfNUALc6LEGgHUUtKJ9FW66
YGOEpQl/HeAm/KLuMryVqcmqN8nN/cxgMe782HX+XZXb0VvE7xQFMeaKBH+eHvxM
48O+eFea7r9cwSkVfymctXYfpPlFAx8mT5iyJ8813vi4Jn2c2QgohdZBSbGlbV4l
A+7/LCABKCqn4RSEt21F90+70Q3VMxDt1nLMxeBgc/i7FFFRC4abXGw1DZe8Wd/+
DQ7VPzt57BV+K4GJHli41rK+vJGnBd8s8lK9PAlL9th5RLiYBMiftrASVOTzeeQ=
=21AT
-----END PGP SIGNATURE-----

--2iBwrppp/7QCDedR--

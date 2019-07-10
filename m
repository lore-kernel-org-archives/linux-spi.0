From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] spi: spi-nxp-fspi: dynamically alloc AHB memory for
 FSPI
Date: Wed, 10 Jul 2019 16:16:28 +0100
Message-ID: <20190710151628.GF14859@sirena.co.uk>
References: <20190710023128.13115-1-han.xu@nxp.com>
 <20190710023128.13115-2-han.xu@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Y/WcH0a6A93yCHGr"
Cc: ashish.kumar@nxp.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
To: han.xu@nxp.com
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190710023128.13115-2-han.xu@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--Y/WcH0a6A93yCHGr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2019 at 10:31:26AM +0800, han.xu@nxp.com wrote:
> From: Han Xu <han.xu@nxp.com>
>=20
> dynamically alloc AHB memory for FSPI controller

Why?  This is currently done at probe which is what you'd expect
to happen here, there's no explanation as to why this change is
being made.

--Y/WcH0a6A93yCHGr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0mAUsACgkQJNaLcl1U
h9Dwqwf/XfgT2pwWuQsy6NbQs7XkAQ/D0a1jByJNafCXGsuoIDp9fBsT27ugprQ0
2BkIzw0Mj2hgvh7Fx0vlB78sDiU17SLMFKWHzHxLQGCHFDeX0z2i9pfnFYKgN1fn
r0qusnbnu0ZqgFcXtqMV+muWvGVZXrXqraICv9mnbfgUc2LgizjDY6vD4RrgLrWM
Gpu65WuvbMXf/FXOuIHGSlfe2Cl4dLBkaf5Vr/sxti0r6n0bxmm3RoTO6GpS9Z+h
21pGi63ixddVXMCGOK+93DutGZcTpPx9JFuIKha3oJVNNblrXEEIBfWd4RgAQJD7
GitY8PwFzdAShFzKzne8bzwtUfIIUQ==
=89qm
-----END PGP SIGNATURE-----

--Y/WcH0a6A93yCHGr--

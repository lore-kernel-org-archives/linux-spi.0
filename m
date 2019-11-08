From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH AUTOSEL 4.19 124/205] gpio: of: Handle SPI chipselect
 legacy bindings
Date: Fri, 8 Nov 2019 12:05:49 +0000
Message-ID: <20191108120549.GA5532@sirena.co.uk>
References: <20191108113752.12502-1-sashal@kernel.org>
 <20191108113752.12502-124-sashal@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-spi@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-gpio@vger.kernel.org
To: Sasha Levin <sashal@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191108113752.12502-124-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 08, 2019 at 06:36:31AM -0500, Sasha Levin wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
>=20
> [ Upstream commit 6953c57ab1721ce57914fc5741d0ce0568756bb0 ]
>=20
> The SPI chipselects are assumed to be active low in the current
> binding, so when we want to use GPIO descriptors and handle
> the active low/high semantics in gpiolib, we need a special
> parsing quirk to deal with this.

This stuff is *incredibly* fragile, are we sure this isn't manifiesting
in later kernels as a result of some other fix or cleanup exposing
issues and won't break without that fixup?  I loose track of all the
GPIO stuff.

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3FWhwACgkQJNaLcl1U
h9D6VAf/aQvUCk5KwmYDafiih+sMdQS5rdG1M0qIchk9PsPJfHsAk/+c+Alwdcq5
VFhvlX/FDZspFImn1yh2S+YblDxd084LRo3bC/aLlzt5BC3hLBRQoqR3np12R/6B
sE1WLP9j1G85zUpvCluxCodf5QUPeijr5ByW+L7q70Dmovx8YI8EsNMG7ady8drc
9sdnO+kpoLizkvJDPsSY67RcxSHmD3gdxq28Bsnc8q2HuHq545Ypip8EicHP1ptX
Mt+D5+kjLIztZssCVjpYK8Vssqm6kSiz8Acaq7MShBSAo6pVvdDU2cNoLmGXyezg
R4EkfCZITRI4doWFNGv5hshc54GSng==
=lio8
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--

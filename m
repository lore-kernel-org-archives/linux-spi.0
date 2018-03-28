From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: mediatek: remove redundant MODULE_ALIAS entries
Date: Wed, 28 Mar 2018 10:14:16 +0800
Message-ID: <20180328021416.GK29239@sirena.org.uk>
References: <58fc8553bdc3cbad8d107a905947b7e4d9c12b92.1522054975.git.sean.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SdaPbLtAangIkrMZ"
Cc: matthias.bgg@gmail.com, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
To: sean.wang@mediatek.com
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <58fc8553bdc3cbad8d107a905947b7e4d9c12b92.1522054975.git.sean.wang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--SdaPbLtAangIkrMZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 26, 2018 at 06:04:18PM +0800, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
>=20
> MODULE_ALIAS exports information to allow the module to be auto-loaded at
> boot for the drivers registered using legacy platform registration.
>=20
> However, currently the driver is always used by DT-only platform,
> MODULE_ALIAS is redundant and should be removed properly.

There is no meaningful cost to having the alias there, why remove it?

--SdaPbLtAangIkrMZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlq6+ngACgkQJNaLcl1U
h9DH+Qf9EtxwWsTohTFZLq84M56CM8LV9zkR8RXwk1z1y8iuiUjwqlLSfeAltGNU
XHcFWDc3Q9+hsx/nhq3YsVGJ8b7ligzUs+jfsZ4a9G+/KG+89ojAMzn24zTZoQWy
0FjMU6KfdlhcM07f3g7GH/Rj/OiriBGOs1hfYtHZA0fOshGgT5yLPMSwb5GTbjgD
flCk4qclIug/P8+WDGYMABV0+zypuZK1xtK+fmoFZwTLKg8BnQU7pyZIsainqjIj
MjhGdolULgvMBtVbqwS84epAWq88wxTd9FZGyeEgCbc8L4hrrXuuMH3Xj/lqHBEf
mQQkcN8gROFJYdGdIakuHP69k7Il9g==
=HD40
-----END PGP SIGNATURE-----

--SdaPbLtAangIkrMZ--

From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 2/2] i2c: mark device nodes only in case of successful
 instantiation
Date: Tue, 25 Oct 2016 11:23:01 +0200
Message-ID: <20161025092301.GC1597@katana>
References: <20161017135957.20297-1-ralf@ramses-pyramidenbau.de>
 <20161017135957.20297-3-ralf@ramses-pyramidenbau.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="z4+8/lEcDcG5Ke9S"
Cc: Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux SPI <linux-spi@vger.kernel.org>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        "linux-kernel @ vger . kernel . org" <linux-kernel@vger.kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>
To: Ralf Ramsauer <ralf@ramses-pyramidenbau.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161017135957.20297-3-ralf@ramses-pyramidenbau.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--z4+8/lEcDcG5Ke9S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 17, 2016 at 03:59:57PM +0200, Ralf Ramsauer wrote:
> Instantiated I2C device nodes are marked with OF_POPULATE. This was
> introduced in 4f001fd. On unloading, loaded device nodes will of course
> be unmarked. The problem are nodes that fail during initialisation: If a
> node fails, it won't be unloaded and hence not be unmarked.
>=20
> If a I2C driver module is unloaded and reloaded, it will skip nodes that
> failed before.
>=20
> Skip device nodes that are already populated and mark them only in case
> of success.
>=20
> Note that the same issue exists for SPI.
>=20
> Fixes: 4f001fd ("i2c: Mark instantiated device nodes with OF_POPULATE")
> Signed-off-by: Ralf Ramsauer <ralf@ramses-pyramidenbau.de>

Applied to for-current, thanks!


--z4+8/lEcDcG5Ke9S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYDyR1AAoJEBQN5MwUoCm2Xj8P/3C1MutimouBmDa59NrKf/DV
evEZBR9Echq0bu3MlvJYrfoqsgYMLtDQ3Y37sB4gswceD+b8W1cSfn0MK7R97m1l
78QWtxm9ZISKVg2JIt9Kut47ZM3iFD2dzkM5I0HEkcYOApRB+QADp9t7j1LL0o4P
fiukJiX0JdBoDRZFoVKLxGt3/X3RUJfwMYs1bTnDvA7UrmX8thcYeGt4yQ9r1eoe
yUP4lVT0wZKToXnWmnLUYxgGbCZjXMIN4IK9X/33fyAySrIossdwzGTKy/wxSpDb
neYztFT8B2I8cFfgQOvdhHXJwfV0h8jofgRKjTJGpGYSwzOqr+Pkmmldwifw3Wpc
0Sg7erFGfEI8hUXu4GlPXXCQzOXCGYyubYLrLmhytA/4+kbF32GjXF7PRKBNxh1a
hljPdPqNyN2oflWEoPNgJnUKFRCAVZsSOOQeIqcdo1ErUwTA/d7GPKQyOiGFxcqz
03NkaTYxOIgNP1F/L0NXHyAMKr4brPU2jlVRuwM1Ohvc6MnY+6vVrORPtHrzgsH2
PMOd9oQjrYygNQ7AFo9EzI2lRxgd+6slZNdlTUnEyh6gwaIgxWzMTNPSSyi4QMeH
PtYK/gJhSrTL4qb+jKitA0GFvG70Z3FU+V0TGccx/dt30ikihj1Y+YN3dgvT+kgr
h/wN2a1xBdQIUad28mSf
=DSaT
-----END PGP SIGNATURE-----

--z4+8/lEcDcG5Ke9S--

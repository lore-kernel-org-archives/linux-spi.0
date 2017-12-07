From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH] spi: sun6i: disable/unprepare clocks on remove
Date: Thu, 7 Dec 2017 17:36:27 +0100
Message-ID: <20171207163627.i4nrojgveczjfeox@flea.lan>
References: <20171207140453.55krsazvnfqr7ooe@agrajag.zerfleddert.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nv2mta4twuhhctkt"
Cc: Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
To: Tobias Jordan <Tobias.Jordan@elektrobit.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171207140453.55krsazvnfqr7ooe@agrajag.zerfleddert.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--nv2mta4twuhhctkt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 07, 2017 at 03:04:53PM +0100, Tobias Jordan wrote:
> sun6i_spi_probe() uses sun6i_spi_runtime_resume() to prepare/enable
> clocks, so sun6i_spi_remove() should use sun6i_spi_runtime_suspend() to
> disable/unprepare them if we're not suspended.
> Replacing pm_runtime_disable() by pm_runtime_force_suspend() will ensure
> that sun6i_spi_runtime_suspend() is called if needed.
>=20
> Found by Linux Driver Verification project (linuxtesting.org).
>=20
> Fixes: 3558fe900e8af spi: sunxi: Add Allwinner A31 SPI controller driver

This isn't the proper fixes format.

> Signed-off-by: Tobias Jordan <Tobias.Jordan@elektrobit.com>

Once fixed,
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--nv2mta4twuhhctkt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlopbgcACgkQ0rTAlCFN
r3TdJQ/+Jinh5IEBLLuno79aQiL3E/9gvM8eioylAMnVpB4kX19RSdjn1/GrGGBl
2bYXvH6pKvs8mh4QTpDlwcIghs3IX69Vo7BE3c3lyDEaihsIDlGV2i5RCT4YiaaF
HY3VZgRWJd/hdhGEpCBidmsqSqlKAphEwHNhiT8t2pd1kwZ4OTwIyVgdCVPmmLIv
xy3f/FrjmWljXDdbHowDYuBOiGWK5WIIZ0JUzZ3I9isFtI/iSKLbZFLdtOQMpmIF
8wQD2r8GMqN2h6QRoj5lQKyfNrNCnadIh8O3o0e4CuI75BqqkmKdlSAfOnoMe2tQ
gKg3zAKGE8jSUy2ZiCV6Dt69NJuObgyoweOAQjRbe2AVBh46+mWphcXpGmes/UYR
Wy3lf/E5qgS6lffdg7JF8sJcigE6Vo+Rw2nZkN2Kr0VkJ5yJnlLtGHjZqRz0V5KS
qvxvmt1Qp7K48NZj7jvub1AXIUJIXawpWx0gXzl+YznFd99Bo4WHGLxDuAiUgTU1
MloaANd8ZbUmnqnMlMFREMoXNoOOAZHULrOMnR/PxKh+9wuKlj+0DT6H2hkjsR7X
kAJ2qqcXSDWW99pox0CvLqCd4rVBAtOrJ6Fep+EgZ+ap43omygCsAi++v+dnKnOW
b+Xt2FcSO/bFP5BwGjyyQ5ilRTwO7Xb9dm3CK0V/gIAwgVXFMaA=
=JdmT
-----END PGP SIGNATURE-----

--nv2mta4twuhhctkt--

From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH AUTOSEL 5.4 128/350] spi: pxa2xx: Set
 controller->max_transfer_size in dma mode
Date: Wed, 11 Dec 2019 10:47:38 +0000
Message-ID: <20191211104738.GA3870@sirena.org.uk>
References: <20191210210735.9077-1-sashal@kernel.org>
 <20191210210735.9077-89-sashal@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
To: Sasha Levin <sashal@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191210210735.9077-89-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2019 at 04:03:53PM -0500, Sasha Levin wrote:
> From: Daniel Vetter <daniel.vetter@ffwll.ch>
>=20
> [ Upstream commit b2662a164f9dc48da8822e56600686d639056282 ]
>=20
> In DMA mode we have a maximum transfer size, past that the driver
> falls back to PIO (see the check at the top of pxa2xx_spi_transfer_one).
> Falling back to PIO for big transfers defeats the point of a dma engine,
> hence set the max transfer size to inform spi clients that they need
> to do something smarter.

This won't fix anything by itself, this asks other code to change how it
behaves which may or may not work in older kernels.

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3wyUcACgkQJNaLcl1U
h9B1owf/c2+Di9MxB58DRS++wONQSVLBDBAzhSYBzUcKxUidr6Yieo8WKOq5RnZa
Xfw5SuLTDnTe7S4iXTo0Gn3ejpU1Eb63YvCGs9+6bM4z3lfcU3wIzXUhW7OsmIxY
HVSTa7iqOjusoR7WpboRgWRyFUdvcK4Y6jBUxh5roUD5IIojLGuVmk2QQVLlLaSq
Mpw15lKs5DGIjq5AHQA0vmNDtjAhVdr/mFw3XSqeviIvfQ3H0CTbz6B8RIgiwGZ8
V9HDm7EeEHvb4H1nbeK9ileA1+Sor/2iGHt1Lwrb1xzKZJ+twuU6dB0NAkWcPv5A
JCBMe73eK3vBVARzxfKmxEApfO37rQ==
=C+Pn
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--

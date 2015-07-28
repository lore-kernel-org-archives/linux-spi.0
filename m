From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/2] spi: s3c64xx: add more debug prints.
Date: Tue, 28 Jul 2015 15:52:41 +0100
Message-ID: <20150728145241.GE11162@sirena.org.uk>
References: <cover.1438075797.git.hramrach@gmail.com>
 <8b628c8d38c4a01f5c4657a4213984d98789d757.1438075797.git.hramrach@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wTNU0LI7DBF44jvL"
Cc: Kukjin Kim <kgene@kernel.org>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
To: Michal Suchanek <hramrach@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8b628c8d38c4a01f5c4657a4213984d98789d757.1438075797.git.hramrach@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--wTNU0LI7DBF44jvL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2015 at 09:37:03AM -0000, Michal Suchanek wrote:
> The SPI transfers can mysteriously fail so add more debug prints about
> SPI parameters set by the driver.
>=20
> The hardware specific SPI driver is the only place where the programmed
> SPI parameters are known so there is no other reasonable place for these
> prints.

For timing things there should already be enough information in the
trace points with better resolution.

--wTNU0LI7DBF44jvL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVt5c4AAoJECTWi3JdVIfQZY8H/0gktAsH2ChHQ6TlFXf8dbQt
oLuL051gnhc0Z1j6Tznh5ThbfAg7vZb9JulwWuuYIhU2jP6GGN3DUUsXIrO8PsnX
KBhsdkwoioyAAx9Bxob2tDMrkPQATgHxt50pVp10YWMTp0757n8SBBr7eDOYwc+n
PeG8MzFQuC7PU+zsW3PavTp+YPnjpdgntrBcQFnThNRPyJ/UrTrB1Dpx5HqRqe/R
csKUFr1CGd90q0gJojumkI5FVccp7wIii3C+BtcZ0V4mGE5upFGi3SEFoOMgKaeW
7M7jh3cfx8bfPoeg5ZBQwxult7vnK51+ToJYjiNNHWPEyJgdl4Ss0HO4wrov2aM=
=4ZOu
-----END PGP SIGNATURE-----

--wTNU0LI7DBF44jvL--

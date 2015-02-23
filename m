From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] drivers: spi: fix compiler warning in spi-s3c64xx
Date: Mon, 23 Feb 2015 23:21:35 +0900
Message-ID: <20150223142135.GC6236@finisterre.sirena.org.uk>
References: <1424694646-26002-1-git-send-email-andre.przywara@arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3WLtXmtPTeS+BWmV"
Cc: Kukjin Kim <kgene@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-spi@vger.kernel.org,
	arnd@arndb.de
To: Andre Przywara <andre.przywara@arm.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1424694646-26002-1-git-send-email-andre.przywara@arm.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--3WLtXmtPTeS+BWmV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 23, 2015 at 12:30:46PM +0000, Andre Przywara wrote:
> The Exynos 7 arm64 support now allows the S3C64xx SPI driver to be
> compiled into an ARM64 kernel, so the cast from the [rt]x_dmach int
> variable to a void* in this driver now triggers a warning.
> Add a long cast to silence the compiler.

Applied, thanks.

--3WLtXmtPTeS+BWmV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU6zduAAoJECTWi3JdVIfQ/WgH/2WjP9ysYqvL5bvXNUgCFosp
Uje0DBt0s5Dsysrw+ZiYgSNgYiBx4ieG3xjtWPgAgYBhtH9gyjFGbNosdKP6dhhB
BGOSR+O3PzuxmjEbWyqAhgQ8yY0iWwWmFWbngnIf7/7+R0nw0klEwzms54vg56EB
5Op5indYqYh5mX09Y78EjynKQhr/M21u/tcZ7nMWmuZwYmxAp+XmFl0KJG5CFuTI
oRnKT58Ene79abXVw1GaC9dJCa3IhYHh0DF19tgKNx5BVsOXgKfNZTCqC6+pDf0t
v5GQlN57UpR+nD7Fldnl7MLnJV9lCGbQIJC7UfINaDvEJmnoQ1pMqlT2rshyy/I=
=Y0hP
-----END PGP SIGNATURE-----

--3WLtXmtPTeS+BWmV--

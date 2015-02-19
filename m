From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: sirf: add reset controller dependency
Date: Thu, 19 Feb 2015 18:41:55 +0900
Message-ID: <20150219094155.GA3198@finisterre.sirena.org.uk>
References: <4553005.HBquOfbqXe@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Barry Song <Baohua.Song@csr.com>
To: Arnd Bergmann <arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4553005.HBquOfbqXe@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 18, 2015 at 04:29:10PM +0100, Arnd Bergmann wrote:

> The adds a dependency in Kconfig to prevent it from being selected
> if the resets are not available.

Why is this a better fix than making the reset controller API stub
itself out?  It's probably not such a big deal here but for devices that
could be integrated into SoCs with and without reset controllers it
seems like we might want that.

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU5a/jAAoJECTWi3JdVIfQo4wH/0tARyD8j51uWSnUptMPvvU0
4m3+JU4FNqGaPnIsPk+7Bep8FeLNxqMAmynV6oQBGpbjvn7YSB9cU02LjQxkc5I9
zDUEkMY4hXzMb3o5NDwEFAILblGi9doBM7d8HwE9zj630M687Pt2aGok9e+V+4QM
uOckwb6hzVf8xsxl4k+IPRZHvIiMxq8WV+04rSb35Ax5i60eNfMat/6UrSo0M+ec
8ja94YPS7D+qYXjijW4YK4+V/jUbrKna2/WJlfzPEoq81IB/Z3K5kEO5DqEyxhRP
7rNSWqjFsOjSIkUDzah7tJibWf/MJ0JCocV7WPL0M9WVlWjqExu4pGwPdmFPR84=
=6Zrd
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--

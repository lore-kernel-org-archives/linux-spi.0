From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: add spi_sync_single_transfer wrapper for single
 spi_transfer
Date: Fri, 17 Jun 2016 12:34:53 +0100
Message-ID: <20160617113453.GG26099@sirena.org.uk>
References: <1466034046-718-1-git-send-email-andi.shyti@samsung.com>
 <CGME20160616161054epcas1p26a6616bcb99a3375eee6c11c76117d76@epcas1p2.samsung.com>
 <5762CF88.4060800@metafoo.de>
 <20160617004311.GA911@samsunx.samsung>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="f5QefDQHtn8hx44O"
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Andi Shyti <andi@etezian.org>
To: Andi Shyti <andi.shyti@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160617004311.GA911@samsunx.samsung>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--f5QefDQHtn8hx44O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 17, 2016 at 09:43:11AM +0900, Andi Shyti wrote:

> > > The spi_sync_single_transfer function calls spi_sync_transfer
> > > with a single spi_transfer element, instead of an array.

> > So, what's the advantage of using this as opposed to calling
> > spi_sync_transfer with a 1 for the number of transfers?

> Not much, but it keeps the code a bit nicer to read for those
> using spi_sync_transfer with only one spi_transfer. Besides it's
> also more understandable what the function itself does and there
> would not be any need to jump into the spi_sync_transfer to check
> what the number '1' is needed for (for example it's not a boolean=20
> 'true' value).

I really don't think this has been a big source of confusion for people.

--f5QefDQHtn8hx44O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXY+BcAAoJECTWi3JdVIfQkjwH/1+fAfyg9aDF/ohOane2rEAg
fGzf+YdfsyAeK9qaNH5asNhwO1k4JdYYP8MKWzQRQSJ1XvbWvFsSPJ7o9DZoExzH
79fVdropcSg32LfosNxVj9mZ4LzYYKDxrtzrqgs7C3kbSkCR2rgzFT9CT0u2SDUW
DEUyO6YW5lD4i0nMNkSbl9NSZhc0JMwvh1k8MF+Owpo5XSagcoAcGrfPRlyyreO2
v9BqELKwGXw6fRyNbPgXBYUAaPU3pMIJQUPtnZy4v4BqM9fZF2Cja/D845/JHDJ1
GyVZXLhtEurIyxjCr51gCqZt7MPgwUrR/Lorsh35rXJiShsmgfyI2/l3zg65TnA=
=Pgz6
-----END PGP SIGNATURE-----

--f5QefDQHtn8hx44O--

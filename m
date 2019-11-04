From: Mark Brown <broonie@kernel.org>
Subject: Re: spi-mem and gpio chipselects
Date: Mon, 4 Nov 2019 12:44:44 +0000
Message-ID: <20191104124444.GB5238@sirena.co.uk>
References: <cbe69f5457c4dd1c2cc96a247c6c6fca61c0d43c.camel@alliedtelesis.co.nz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Fba/0zbH8Xs+Fj9o"
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cbe69f5457c4dd1c2cc96a247c6c6fca61c0d43c.camel@alliedtelesis.co.nz>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--Fba/0zbH8Xs+Fj9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 04, 2019 at 12:35:24AM +0000, Chris Packham wrote:

> I'm working on a platform that has a slightly complicated scheme for
> SPI chip-selects using gpios[1]. The spi controller driver in this case
> supports the spi-mem operations which appear to bypass the generic
> spi_set_cs().

> Would there be any harm in adding calls to spi_set_cs() to spi-mem.c?
> Naively spi_mem_access_start() and spi_mem_access_end() seem like
> convenient places to start.

That's only going to work in cases where the controller translates
things into a single SPI operation on the flash which I'm not sure is
always going to be the case.  We'd need a way to guarantee that the
controller is going to do that in order to avoid data corruption issues.

--Fba/0zbH8Xs+Fj9o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3AHTsACgkQJNaLcl1U
h9CKcgf/a3Rsv/nEWYK652244fSFdDjB0Ae/GjNHxD+cHFj3PApNAkCG1mA1XAux
nu2t/yNhOlkeXysq1o7zHbsttZpVI9MPh9seGhrvyk1vMVnRv3DghWjgVNAZKv1h
pmWU3zN6MAU0K05C46j5B6QgF4euavsIS61ynsokTvdOdGfRLZQe2eBuRokPut5B
2scTuUx7HB6ybEWU+vjeXN53v3UYDfCoKYI0A3XiX9F4n3m7WTW+5xPu2etP8a1C
C0OFvD/mkVWCoQDeFWCIOTQ7thQc9HiAK2xgtTPeSggqQi7cj/bb14bE0FtGnCrM
5m6A7jwYbpby8OEZPG9MJphRUVclhw==
=E4bF
-----END PGP SIGNATURE-----

--Fba/0zbH8Xs+Fj9o--

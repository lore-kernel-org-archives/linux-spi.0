From: Mark Brown <broonie@kernel.org>
Subject: Re: spi-mem and gpio chipselects
Date: Tue, 5 Nov 2019 11:42:27 +0000
Message-ID: <20191105114227.GB4500@sirena.co.uk>
References: <cbe69f5457c4dd1c2cc96a247c6c6fca61c0d43c.camel@alliedtelesis.co.nz>
 <20191104124444.GB5238@sirena.co.uk>
 <039edb7cdd9114ad7a14e27f869db6c85d756418.camel@alliedtelesis.co.nz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oLBj+sq0vYjzfsbl"
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <039edb7cdd9114ad7a14e27f869db6c85d756418.camel@alliedtelesis.co.nz>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--oLBj+sq0vYjzfsbl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 04, 2019 at 08:06:42PM +0000, Chris Packham wrote:
> On Mon, 2019-11-04 at 12:44 +0000, Mark Brown wrote:

> > That's only going to work in cases where the controller translates
> > things into a single SPI operation on the flash which I'm not sure is
> > always going to be the case.  We'd need a way to guarantee that the
> > controller is going to do that in order to avoid data corruption issues.

> In my particular case (spi-bcm-qspi.c) bcm_qspi_bspi_exec_mem_op() does
> seem to assert the native chip-select then do it's operation. As I
> understand the wait_for_completion_timeout() will schedule so other

The issue is what happens if the hardware translates the operations it's
being asked to do into multiple physical operations on the bus for some
reason.  It sounds like yours won't but we can't just unconditionally
push the chip select control out to software even if the normal SPI
modes support it.

> tasks may run but spi_mem_access_start() has taken an io_mutex so
> anything that accesses that spi bus will block.

That's guaranteed.

--oLBj+sq0vYjzfsbl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3BYCIACgkQJNaLcl1U
h9DUGAf6AgYGHHtC8fjKSGW1POmrYB0mCJNdi6rKRYZinsVOIroYP0LIhjZUqUNP
ZxMkM9qsd0D6LWIJSsBjInHzKMP1JnD/Wv8eKsfkmU/vXQ4zpGWtnJ7fKEgGUZOE
MMLj5vfAHtvwKMBdAHzAZn4/iRw8U0EgDnXA0KtlmACpxKUgPxJ4RAuxeDIDygc8
OSmebFYqYVOvJeCI+mokjyv6MNQqUuZW6u7WDAQp4vHp8JbHFULXuGOtLFNwXdv9
6JD7FcEXG1Q5QP3CkrrnPs7a3wTVCZllbNvZLQM7xI8+vVjwQFxqOyELnAmc/+uX
JdHNYU7Wd+KlbLB9SpXBPCpufwIi5Q==
=MtHO
-----END PGP SIGNATURE-----

--oLBj+sq0vYjzfsbl--

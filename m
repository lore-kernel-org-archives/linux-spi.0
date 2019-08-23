From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/5] spi: spi-fsl-dspi: Exit the ISR with IRQ_NONE
 when it's not ours
Date: Fri, 23 Aug 2019 11:28:16 +0100
Message-ID: <20190823102816.GN23391@sirena.co.uk>
References: <20190822211514.19288-1-olteanv@gmail.com>
 <20190822211514.19288-3-olteanv@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SLfjTIIQuAzj8yil"
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, netdev@vger.kernel.org
To: Vladimir Oltean <olteanv@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190822211514.19288-3-olteanv@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--SLfjTIIQuAzj8yil
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 23, 2019 at 12:15:11AM +0300, Vladimir Oltean wrote:
> The DSPI interrupt can be shared between two controllers at least on the
> LX2160A. In that case, the driver for one controller might misbehave and
> consume the other's interrupt. Fix this by actually checking if any of
> the bits in the status register have been asserted.

It would be better to have done this as the first patch before
the restructuring, that way we could send this as a fix - the
refactoring while good doesn't really fit with stable.

--SLfjTIIQuAzj8yil
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1fv78ACgkQJNaLcl1U
h9Cv4gf+PlempNcDKec7OiBxdWny+wFPRO1wq7OKtAEtzU2wFvuZYAjGYbCciUyw
cKlSUJ9T9Lg4Rq9PTM7CbmY3FobaqJyqTeZT6cADZE1QZoTJD78lQxB8XmJtRBu1
r8z6XPbgLbRnws9lzRQIDdRvdIX4DO9sFiY/M+9nbbMGbGbkYKbHNk5461pHEV45
c9lCEgHX62vJerrt0jxfomw50W8tEaqhZ9q6dg1zXwuXjXMmPBPQNnTkexYuco8L
PIfr5fq2cFMOH0hvXdim2H8spTU3tizQQlZS7NeXkaC8tgE4vBYibF1BYnoCfuos
AYL6TZxFXh9I5JM/fUCBs+qbLtbneg==
=lQOn
-----END PGP SIGNATURE-----

--SLfjTIIQuAzj8yil--

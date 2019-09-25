From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/2] spi: Add call to spi_slave_abort() function when
 spidev driver is released
Date: Wed, 25 Sep 2019 09:45:17 -0700
Message-ID: <20190925164517.GI2036@sirena.org.uk>
References: <20190924110547.14770-1-lukma@denx.de>
 <20190925091143.15468-1-lukma@denx.de>
 <20190925091143.15468-2-lukma@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xzV2nyj/vUZRUtI2"
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        krzk@kernel.org
To: Lukasz Majewski <lukma@denx.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190925091143.15468-2-lukma@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--xzV2nyj/vUZRUtI2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 25, 2019 at 11:11:42AM +0200, Lukasz Majewski wrote:
> This change is necessary for spidev devices (e.g. /dev/spidev3.0) working
> in the slave mode (like NXP's dspi driver for Vybrid SoC).

Please do not submit new versions of already applied patches, please
submit incremental updates to the existing code.  Modifying existing
commits creates problems for other users building on top of those
commits so it's best practice to only change pubished git commits if
absolutely essential.

That said I'll handle this this one time.

--xzV2nyj/vUZRUtI2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2LmXQACgkQJNaLcl1U
h9AX+wf/YRDipet4jypZCYH78t9sIO4yBQwRzjv9DLVcymB1XijNG10pbEZJZ2jt
kMBpgC6UkBZGYB8UygjYvzMdenYZgbzSa0rV013H2GaWwVzInVdPF0xJ6/uDvVak
9CZD+ZzYg3HqCBOPvzCXa2kPVvc2KmCJttjRB37QXaGzrEWEvSjbaSfszL2dIuk3
E3xCNU6Y+noyIjwSmrKL0WxSHwdUx4ldAaOWdPFdAL14+yGNMQbTCXwP3WdC35DB
tRaO09BGacJvbP3SVVTvr4EGG6Qi2oFYEHaUpCWMtSJWYwzxA4YGNc7FgqCiLaO0
MzP6qGgidGi4lPuWomspXMyRPUBKmg==
=QKDX
-----END PGP SIGNATURE-----

--xzV2nyj/vUZRUtI2--

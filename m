From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: lpspi: Fix CLK pin becomes low before one transfer
Date: Tue, 11 Dec 2018 14:30:05 +0000
Message-ID: <20181211143005.GJ6686@sirena.org.uk>
References: <20181204062224.28844-1-xiaoning.wang@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yr/DzoowOgTDcSCF"
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Clark Wang <xiaoning.wang@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181204062224.28844-1-xiaoning.wang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--yr/DzoowOgTDcSCF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 04, 2018 at 06:23:19AM +0000, Clark Wang wrote:
> Remove Reset operation in fsl_lpspi_config(). This RST may cause both CLK
> and CS pins go from high to low level under cs-gpio mode.
> Add fsl_lpspi_reset() function after one message transfer to clear all
> flags in use.

This doesn't apply against current code, please check and resend.

--yr/DzoowOgTDcSCF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwPye0ACgkQJNaLcl1U
h9BAygf/dnLhg3GtANkZTYpKtHYETF7XJSIoWNyd9k0A9sJ5RoRZsze7LKQwR7rz
D6PtMkNEv5HJDLOYZLz19V1TuTSwRHAKJ3w4Lz+Yb6vl9guscyXTncXcv3steZX5
nSZQgWl2aBGKynQy5/lv7uOlLr6hcCZFkZq0sD183oPGCw7HPqMokISo+FQPndUh
ZKNVqpcEF5YZJJE0YPbrGp0rHqW4AaLdYDuOrM6zgwqmdu0G1eZkNNww9ulI0g1N
mzB+tUd8Oup0u/LfyYQcfNpcfgaf2h5m2+rL5snG8CVSF0gHFPQHyojfev4QGfZS
ppfXA3gov1qTmMysUM25YMpq52mRIA==
=pMcg
-----END PGP SIGNATURE-----

--yr/DzoowOgTDcSCF--

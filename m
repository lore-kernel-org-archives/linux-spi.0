From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/6] spi: core: handle timeout error from
 transfer_one()
Date: Tue, 3 Apr 2018 16:52:24 +0100
Message-ID: <20180403155224.GA11578@sirena.org.uk>
References: <20180403152905.1524-1-ssuloev@orpaltech.com>
 <20180403152905.1524-2-ssuloev@orpaltech.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To: Sergey Suloev <ssuloev@orpaltech.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180403152905.1524-2-ssuloev@orpaltech.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 03, 2018 at 06:29:00PM +0300, Sergey Suloev wrote:
> As long as sun4i/sun6i SPI drivers have overriden the default
> "wait for completion" procedure then we need to properly
> handle -ETIMEDOUT error from transfer_one().

Why is this connected to those drivers specifically?

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrDozUACgkQJNaLcl1U
h9DiiAf/TxkH07nauiAh1vLXq1Cgu4J0BnUFgZLNMuEr7efgpYGxPmJRsvuSMVJp
uJWPVl6WsI4xnogwnz1LwzOGJ65BJx9RJYvDf+I9Gq6Y1tvAA1qJMlnGjTyGSD35
+VG9+jDfSv0kwmR+Fawf6i4Yzod3VBIRnWVg1E8jSIFSf7yNx17fJ7XBoqwMKGBT
71RtzHLbKdtkPj98nr7hZcUoytB7qDZxJw6NROZDZzZXNGA0k5OtioTXbKJGnCkn
LpitfZWqKPSQQ1B6/2sUTjXEX8nJw7LWVvAduiq8mzongCkicJlEwSurjZ7K8UcW
m3Apg9c9OGAa65v4GOLC1lEcQkl88A==
=zoIV
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--

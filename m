From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH -next] spi: Fix double IDR allocation with DT aliases
Date: Thu, 23 Aug 2018 11:21:21 +0100
Message-ID: <20180823102121.GC5207@sirena.org.uk>
References: <20180821095303.27664-1-geert+renesas@glider.be>
 <35fbd3ae-3ac3-f6ef-874b-3d99c4d4d29a@compulab.co.il>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ctP54qlpMx3WjD+/"
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
To: Kirill Kapranov <kirill.kapranov@compulab.co.il>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <35fbd3ae-3ac3-f6ef-874b-3d99c4d4d29a@compulab.co.il>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--ctP54qlpMx3WjD+/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 22, 2018 at 08:51:40PM +0300, Kirill Kapranov wrote:

Please don't top post, reply in line with needed context.  This allows
readers to readily follow the flow of conversation and understand what
you are talking about and also helps ensure that everything in the
discussion is being addressed.

> I have to point at the following threat: a dynamically allocated ID may
> 'squat' a bus ID that intended for a device with statically allocated ID.
> This scenario is possible since module loading order is uncertain.
> This threat seems to be inevitable...

For DT systems the dynamically allocated IDs start at the maximum
positive ID and work down so in practice it is vanishingly unlikely that
there will be a collision as idiomatic static DT IDs would be low
integers.

--ctP54qlpMx3WjD+/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlt+iqAACgkQJNaLcl1U
h9DEYwf+PeNSBmBQJsoTnSeUanFKW3zKsRohegEb3DegJ5Rmq6PL5PLV7V6KhWTU
UGRz17Z0DB70xLyzs4sUPC/6L4xCw4fYMYLBulUIzFWKQlmGFKsGzfx4E8VY7pN5
Izw0MFPUnrKsT84C8m1k3PWaa4qprvBRKnAUKCBQZnzGz80ZLE1T7nsb05szBQKx
NRYobSv124dL9aomXEywmcSWk22T+8eRb6OEPPQ/DxHPZfdxHMkb4ehMhPUFz7wb
K2m9P5zaEKN1cTM8aNWoRSRmh92Y626DH6/WmmwtBfX3ppcDXoPImwnI4qeb12P2
dzP36/20rWtDmkVlLeaBPlZMSr7LcA==
=9h9Y
-----END PGP SIGNATURE-----

--ctP54qlpMx3WjD+/--

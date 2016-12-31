From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: s3c64xx: Don't request/release DMA channels for
 each SPI transfer
Date: Sat, 31 Dec 2016 18:26:15 +0000
Message-ID: <20161231182615.tuukfj5fa4wwkwvj@sirena.org.uk>
References: <CGME20161229121937eucas1p11cd0bb98b21699b0f773ecaeb7c29d26@eucas1p1.samsung.com>
 <1483013971-26446-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oqusqpokiiwc2g7t"
Cc: linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Andi Shyti <andi.shyti@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        Javier Martinez Canillas <javier@osg.samsung.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1483013971-26446-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--oqusqpokiiwc2g7t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 29, 2016 at 01:19:31PM +0100, Marek Szyprowski wrote:
> Requesting a DMA channel might be a time consuming operation, so there is
> no need to acquire and release DMA channel for each SPI transfer.

This doesn't apply against current code, please check and resend.

--oqusqpokiiwc2g7t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlhn+EYACgkQJNaLcl1U
h9D+mAf/R4mZuFtpT8CgxdVrya27EEOoc3h0A980GgeT1xCad/DA9xQSAbGH0LLn
PNkDOCjfBcxIAwll47QkYai6ChW0nV0F1m+JhvspqvS0L5ub1nIGygTqHGNc26Zs
pUmZTEpBCSr4X5u8jkViZL0urfE+A6AvN8TbbMdeZCRB0pFcS4CeB89ncVlbOm5J
KxqOTPtQEjgfpbXpWtmpYh3C8NVmkVQGiIA4rMbV42Bm3wvRs7B7/FpOCgWvitu/
pQYqnMm6XHHLH3QzGSIxRo/lBjd43pe2ego9dDE9nnL+EUC6Unksaj9QYFMlOiA9
0YmILqwJ8LGK/29II7lbPmWLUZSyKQ==
=mrLv
-----END PGP SIGNATURE-----

--oqusqpokiiwc2g7t--

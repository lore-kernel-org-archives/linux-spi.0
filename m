From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: spi-s3c64xx: Add missing pm_runtime_put on setup
 fail
Date: Fri, 18 Oct 2013 00:34:36 +0100
Message-ID: <20131017233436.GV2443@sirena.org.uk>
References: <1382013941-861-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yKFK96CsHx70a80G"
Cc: Ben Dooks <ben-linux@fluff.org>,
	Kukjin Kim <kgene.kim@samsung.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sylwester Nawrocki <s.nawrocki@samsung.com>
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1382013941-861-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--yKFK96CsHx70a80G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 17, 2013 at 02:45:41PM +0200, Krzysztof Kozlowski wrote:
> pm_runtime_put() wasn't called if clock rate could not be set up in
> s3c64xx_spi_setup() leading to invalid count of device pm_runtime usage.

Applied, thanks.

--yKFK96CsHx70a80G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSYHQJAAoJELSic+t+oim9CxoP/icS4A1e9WFvDuZeTe1oruiD
CRgZxOZJyTmzj1hzb732j67NmamZckOGDTag4S8ofYkO5N1ecCTH8rPHxwll0TiF
jsBcUg13gFqJBmRo9wuQAB6Y9mSeKxiXKZKj0Z1U3NBFDi72q2nmnCCinQcqfSw2
/FFohIvizTH5KeokJVLhWlnvUTMOdyuJHZMoaV2M42hm0d8za1yq5Zzp+lbTDhvr
AjyOl5GEmAOaLevtNmK6R/21XxLBgEw0aEsG4hSXcRzH/yOnkQIRTsQYC3svLlC+
dYqRzvDLslFRI4CQOU9UReZ/XAiFPhNtmjlzv1uS9GYTxNh8X/aPHJm7bRYuLnMS
uzI1lGttWAeRY2VUDwc7rAnhaZvGL9jLYWm2U2tJ0Kq/7dDmY1xud+GijPlirKWT
29swwcUIa1k9/RvW569vsZ0ydph5dsPVKEhB0rUAPh3J2zLL2NYBYqBoOab7fx7t
/0agKCQHG7pacrwC37M2hw1fmmMcjD4nsV1tJVUypz1mHOfJcthhMCM50ttkQlAI
3ujhqlN1dE4aHsRjQYhXFqqo+NUDAs4OOfFPzRHLZCiMGpLydc9XP7TIG1SrgiR8
v0GRQhZUu+RxkWfegA4C3ptuEAMFQaVb87eBCvQM3UoqAsIhPiJfQY7yqnQ9ArAP
+GXp8tW7A1CHUsUM7yiz
=9Etr
-----END PGP SIGNATURE-----

--yKFK96CsHx70a80G--

From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: s3c64xx: add SPDX identifier
Date: Tue, 12 Dec 2017 10:31:42 +0000
Message-ID: <20171212103142.GC16323@sirena.org.uk>
References: <CGME20171212075830epcas2p31afc4a2e715e857694082748fd2bbe49@epcas2p3.samsung.com>
 <20171212075815.8683-1-andi.shyti@samsung.com>
 <CAJKOXPfdKyT8-bpM7tmveb3jWCRSSXwnkifhsRw_ag8X9z0W8A@mail.gmail.com>
 <20171212100730.GA16323@sirena.org.uk>
 <CAJKOXPdM+C_JWOiqT8obEAsEsGJ1GvJMG=o2Kq0TCiOwdmZOxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NKoe5XOeduwbEQHU"
Cc: Andi Shyti <andi.shyti@samsung.com>, Kukjin Kim <kgene@kernel.org>,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andi Shyti <andi@etezian.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJKOXPdM+C_JWOiqT8obEAsEsGJ1GvJMG=o2Kq0TCiOwdmZOxw@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--NKoe5XOeduwbEQHU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 12, 2017 at 11:13:26AM +0100, Krzysztof Kozlowski wrote:
> On Tue, Dec 12, 2017 at 11:07 AM, Mark Brown <broonie@kernel.org> wrote:

> > Apparently that's the thing for SPDX headers.

> Yes (although in sources one can find /* */ as well) but the rest of
> comment does not have to be changed in that case. With quick grep
> through sources I could not find such practice.

Yes, it's not great.  There was some discussion about it which you can
dig out of the archives indicating a desire to use C++ comments more but
there's not been much effort to communicate that and there's no tooling
to back it up so it's all messy.

--NKoe5XOeduwbEQHU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlovsA0ACgkQJNaLcl1U
h9AaQAf9HWY1mDja1iyWRTlBj98j3wOVIS33lDBUMQPtxvgpdTtMv89M1kWH5ROU
LklKkgQEoa3oYqvwSxTEgVIOaNoNJXqU4foccW1/a/lET4HdVyZ5bHwL4fGu0R9M
Rl6rrFbzeloZCe/YQa2Pw7ozqpqM1+CiLWkABNAikLOkaoBQEyW0ieBHj2mbv0FU
nahsRsB6wUPh2KTYFowKkVdidk0s/9nbKAGyETk/zZhS1ZtI6x1M9kG9pNC9SEgf
5zgYxI6hJa0jpT89XkTJvCWxt7tfuSb1GNA7hz0fQtW7j6O4NCi+i7VBI/ERI5/c
OXwO04usTjoIe1zW8mzkun/cTIJZfA==
=VnCq
-----END PGP SIGNATURE-----

--NKoe5XOeduwbEQHU--

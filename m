From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V2 2/4] spi: lpspi: Add slave mode support
Date: Thu, 6 Dec 2018 20:25:06 +0000
Message-ID: <20181206202506.GF3084@sirena.org.uk>
References: <20181130042753.28756-1-xiaoning.wang@nxp.com>
 <20181130042753.28756-3-xiaoning.wang@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2FkSFaIQeDFoAt0B"
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Clark Wang <xiaoning.wang@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181130042753.28756-3-xiaoning.wang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--2FkSFaIQeDFoAt0B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 30, 2018 at 04:29:07AM +0000, Clark Wang wrote:
> Add slave mode support to the fsl-lpspi driver, only in PIO mode.
>=20
> For now, there are some limitations for slave mode transmission, which
> have been mentioned in cover-letter.

The cover letter doesn't end up in git, it would be better to include
this information here :(

--2FkSFaIQeDFoAt0B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwJhaEACgkQJNaLcl1U
h9BPFQf9H6drQEU8AddzQIyy1gN9Wcvo3cYwMpDs6HuWtjGgERbXyZ83HK8qLD1O
5JTciY6t2U8neNkyHC/JziMl4gs6eJ8ac1lZIAqsPAAXJHNk7es936T17EhHn5UL
2Ivanb5aDZqgrkzyVyNqOWLsBUaMdsBEDou2cf42qkLR6ey0b7Hnjc02DdgYqoVP
xAhUlGYEhjte5OwvzUm1ESQcPrMWkDnyxIcuJEaNensh49P5We1AMJXbM9hlFD8L
jWWgnL5JUtEOZM/k1S96UZAW3ubN6/DUTLJzW+I2y3muGQIyMKPs5BnUmm7rzkP9
BPwYEEARlkSoavo9LSZIwTBemG+YgA==
=rHPc
-----END PGP SIGNATURE-----

--2FkSFaIQeDFoAt0B--

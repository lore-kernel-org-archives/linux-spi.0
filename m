From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH v2 4/6] spi: sun4i: use completion provided by SPI core
 driver
Date: Wed, 4 Apr 2018 09:13:26 +0200
Message-ID: <20180404071326.6mcaal77mzgfnhuy@flea>
References: <20180403152905.1524-1-ssuloev@orpaltech.com>
 <20180403152905.1524-5-ssuloev@orpaltech.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fbfiet4p3ftpkrnv"
Cc: Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
To: Sergey Suloev <ssuloev@orpaltech.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180403152905.1524-5-ssuloev@orpaltech.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--fbfiet4p3ftpkrnv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 03, 2018 at 06:29:03PM +0300, Sergey Suloev wrote:
> As long as the completion already provided by the SPI core
> then there is no need to waste extra-memory on this.
> Also a waiting function was added to avoid code duplication.

This should also be split in two parts.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--fbfiet4p3ftpkrnv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrEexYACgkQ0rTAlCFN
r3QJKg/9HkS+s2JWnNaBiwt78vVwybXyqL9bWwmXQ5+0hjfiow/lP/jQzskv90Ej
aURcZYt6gPQiXtnQJN5R6jxt+HnaZUMAWh5U/kL9ChE9etvoBVo9P+N0CfC2pBe+
nsl/hLqmAFHNwAT2/HgJIk/pGXPYKkAJfXspXRW3Wb9FBBa89FJqevbsGK3cj+FN
hZLyjDa4wwop15MCwxoFeyFoDHo/7Q0b5qSg1hOjAyt9nrvEw35FxuuefEej9h2D
GiMgVdfXTVn6hN5QcYJXrOiTLDJnpywDM6NfH64YwZv0gplj9LVC1UwnVB+P7aKT
9c26eip9DChSSlzjYZLCPfS2VmN/J9L0RtkysKlBH2y8oAAshh1rinfRcqeGss20
iWs++wBASKcG6PiCLEQ7WoxlA4FSDU8R+OmM1ev+Yivqm7fVDUjsi0dh5zK9r7/6
C4nDPIPNp7TK9VaJM2vN0uZSE1V/Sd3J0WlyqOjBxbExDsRfvYdH+ZJH9Hf9Y8ih
aYbIqeGOatFtGBmSL4Ejfrq9dlHvtkWj6wRvaBJ3rL/vp3DV+oa1xNlVYDwf8kGH
fxxbaWDLXuc96DxAXOdOGEyQlrM1Waq3J5GcL4sSyjzC5ump5hFsy07zu0yHn9Ud
vQ3kdx1O0PtfZ8iLBH7R70H31dMbHlkNYDvA+pQ8zCY8bUXyO5Q=
=zwXE
-----END PGP SIGNATURE-----

--fbfiet4p3ftpkrnv--

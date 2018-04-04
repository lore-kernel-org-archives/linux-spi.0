From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH v3 5/6] spi: sun6i: introduce register set/unset helpers
Date: Wed, 4 Apr 2018 09:02:15 +0200
Message-ID: <20180404070215.matr7snuyxjd7syu@flea>
References: <20180403154449.2443-1-ssuloev@orpaltech.com>
 <20180403154449.2443-6-ssuloev@orpaltech.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="27hwlkrs2c4ciypb"
Cc: Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
To: Sergey Suloev <ssuloev@orpaltech.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180403154449.2443-6-ssuloev@orpaltech.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--27hwlkrs2c4ciypb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 03, 2018 at 06:44:48PM +0300, Sergey Suloev wrote:
> Two helper functions were added in order to set/unset
> specified flags in registers.
>=20
> Signed-off-by: Sergey Suloev <ssuloev@orpaltech.com>

Again, I'm not really sure what the benefit of that is. Your diffstat
is pretty much identical, so it's basically just moving code around.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--27hwlkrs2c4ciypb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrEeHYACgkQ0rTAlCFN
r3Ql5A//YDJuOQUfZlB15TiE0DDnqqBOrQvEpidlgLBWFyPwGjySislkUqgpPg4i
UVaxdOC1M4XcqsOhacFUqSamvXTNhRr6CF5AzicFx37S9Gv7DS2SmM829e2e2B2j
aCXkSpjctWl95jVkyObkAKsRj3fGZl2TFAiKMzRoVxUrfO9Bqb38HyMTtyLImEyy
04kmwtXNm5wlJoL0dDOcw1FCvDXuGH0kv/1+EPimJaGtqYWzVPGDKbzNG+VjS3zz
DCGKfvqqTwvJRj6DDQ/mqlQ47+3ct9KLlp9Ip63ilhGkvffPbj1RLf5VQlOnz7UY
aG5ke8CWSofenN1lNpvXDZSs6Sg8W2D+rQkxGGGHNOPuXa2h20jJLyziW1PkBaJO
/eGfDMCbkkRWMOXFQ6tDUo+FwobwR8B3IzjqAb5D4RebrK80mOxezUDDtSYDokUS
fFApxnbxmbNKrsc12/nFcEZzsqPayn/bPuCTpl82OmtDELBVDtTxpYChpWb3+nSj
o1JjxHGCbZjHt79+fIIr+hrx+a8+UNzKeOX+G+ORv7IK01qG+fojShq9z6sxM0D8
nlrAtll+PkYL5wL+iMMPdzNJ7Tvoo1FykRmU5kgb/62jB1xD9VM2bNdpmyR8LHO4
O+9ZsNF4aY7dFtmYyOEe6PFtz/4ZIZQYDmVLnSuWUmmRbA7WkOQ=
=vo6V
-----END PGP SIGNATURE-----

--27hwlkrs2c4ciypb--

From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 14/14] drivers/spi/spi-s3c24xx.c: fix error return code
Date: Wed, 22 Aug 2012 18:00:25 +0100
Message-ID: <20120822170025.GV7995@opensource.wolfsonmicro.com>
References: <1345365870-29831-1-git-send-email-Julia.Lawall@lip6.fr>
 <1345365870-29831-15-git-send-email-Julia.Lawall@lip6.fr>
 <1b3201cd8049$e753f720$b5fbe560$%kim@samsung.com>
 <20120822114015.GI7995@opensource.wolfsonmicro.com>
 <alpine.DEB.2.02.1208221342240.1991@hadrien>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="L46vHWpLfEKD8KlK"
Cc: Kukjin Kim <kgene.kim@samsung.com>,
	'Ben Dooks' <ben-linux@fluff.org>,
	kernel-janitors@vger.kernel.org,
	'Grant Likely' <grant.likely@secretlab.ca>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
To: Julia Lawall <julia.lawall@lip6.fr>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1208221342240.1991@hadrien>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--L46vHWpLfEKD8KlK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 22, 2012 at 01:42:47PM +0200, Julia Lawall wrote:
> From: Julia Lawall <Julia.Lawall@lip6.fr>
>=20
> Initialize return variable before exiting on an error path.

Applied, thanks.

--L46vHWpLfEKD8KlK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQNRAKAAoJEFJkBDiqVpZ44swP/37K/DW4+jPwNyYfKgYsDNHQ
u4Q6uJfTi8whnArR9vMhWxWtoWq1uEjt6pyVuawX6krXIJ5Tr576jwsXrS0GSO58
B/kWCTYqV/lThDPejrQNi7hzVjZZnDqchINDGkqo+wuc71EZ2Qc6kndS64Qn1iOu
YQ8AQZwBNSvwU8iWBMbFVubxtHGlC1L4dUYS7Js04FqSbYyqoWNdlzajIdQmK/NY
EtkdUtY37g4yD80R4fjK3soGHNOzv7ofNAtJnby9fRfxed2wC09bC9V0MIaq+7Nu
ttuD0sJIokbZnMsXDtKqT4k2QOMk7OxxVAYiuRdaEG/YGh7HmHwwVvYryh/rc8Nb
DD0+QoSXdiMj9kPAkWO35mEvFa0VPivaxNwk3KsAzhO7eje+83SHGwt+LgX00WNT
cZEoR73h9dyoIZaGO3g5AXTMeYiBC+mmE1RExYWHupH75bchOxvxGmrlVSU37kKH
4JoPRUN16Jgn3Z+Fx986dU0MzzJhsmL52/+GAIQaH9iip7iH/Dw17KsYmCg8iEM1
yIgR+ZAO5LscF4o7sx5yGoRWiHaCzUa2kd9ruUp3bXLIwv0T+QFkkUwbM0VX+Ty7
3XyppW6oRJ7LYISaitHITJw3KANVYr/dMoOcre3DxrBsOzkUwajQVqFOyqWAbI4C
2AeKAd+K/2hA8atJ5l4A
=qOlD
-----END PGP SIGNATURE-----

--L46vHWpLfEKD8KlK--

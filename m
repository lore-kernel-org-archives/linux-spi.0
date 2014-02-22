From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 03/10] spi: sh-msiof: Change hz from unsigned long to u32
Date: Sat, 22 Feb 2014 12:11:32 +0900
Message-ID: <20140222031132.GS25940@sirena.org.uk>
References: <1392907389-21798-1-git-send-email-geert@linux-m68k.org>
 <1392907389-21798-4-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="A3RWl4qWgABmkY4K"
Cc: Takashi Yoshii <takasi-y@ops.dti.ne.jp>,
	Magnus Damm <magnus.damm@gmail.com>, linux-spi@vger.kernel.org,
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@linux-m68k.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1392907389-21798-4-git-send-email-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--A3RWl4qWgABmkY4K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2014 at 03:43:02PM +0100, Geert Uytterhoeven wrote:
> From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
>=20
> Both spi_transfer.speed_hz and spi_master.max_speed_hz are u32

Applied, thanks.

--A3RWl4qWgABmkY4K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTCBVhAAoJELSic+t+oim9rmYP/RcAebjQPwIRnqh1nJRkOTtY
2L0h5vp4qfYUUtijsA3fNv01OCaIJPL7wT4gsbNfELOjPqK8ccYqv2KVpb3gvIRv
a5ofKBKxQguOHcId78qb93ng3LDwH1PT8qPrvXFRSvAjjaLKsF1ht76ALeetaU8a
3GlJPJLksrSCd4ieaK+tVB1+4sH4Jfek/xtzWT7z3J44iyjuxDIzJr51+ldekHUP
tOFQ2UAD3VjxvgHKpQiAaY2unj5mIEPBTu0RrmnLQk6XYVFyEeLEJ59f51mWMWzG
yD5ISTcLhO9DNI7B814sR1EIg0YE3KsSX9c7BUdnKR4PEDx0sjQXLMF/r56q5XO5
6WJ2VQxpaE+8nGLH0/q3+wzhoWYD1g8J2OEKfAc3eOCiLMjlcL9jQNLMVBoDhXMc
Z9P0gOPvgmdEntbVJ0nT1DRI0lwMDtuwv2VmkojfZcl5mLOtbfWYDQlRcFEsWqzl
5cI6aQ73pxIT052x16jyqlZ+DflWb5fDyKEEVioqdvbtoZs6afCWxBBw5rkUWVto
fxu1WfX7TeXXqR920iG0J9/jiuEwR55q7wE7AEDuFVKNhDjkRclKGmR7it2WosJa
CUNjD/vUQFKY+sTi5mvmKuZEKH8FK+ExB48sfnVEgiGSL1gwoKD3d8gbLtKA0dKD
wDavLE9qZ1zSj04fjNk8
=BT/V
-----END PGP SIGNATURE-----

--A3RWl4qWgABmkY4K--

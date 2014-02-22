From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 05/10] spi: sh-msiof: Use the core cs_gpio field, and
 make it optional
Date: Sat, 22 Feb 2014 12:12:11 +0900
Message-ID: <20140222031211.GU25940@sirena.org.uk>
References: <1392907389-21798-1-git-send-email-geert@linux-m68k.org>
 <1392907389-21798-6-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oGy11dVowAZA6eXT"
Cc: Takashi Yoshii <takasi-y@ops.dti.ne.jp>,
	Magnus Damm <magnus.damm@gmail.com>, linux-spi@vger.kernel.org,
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@linux-m68k.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1392907389-21798-6-git-send-email-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--oGy11dVowAZA6eXT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2014 at 03:43:04PM +0100, Geert Uytterhoeven wrote:
> From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
>=20
> In current implementation, CS is controlled by GPIO, which is passed
> through spi->controller_data.  However, the MSIOF HW module has a function
> to output CS by itself, which is already enabled and actual switch will be
> done by pinmux.

Applied, thanks.

--oGy11dVowAZA6eXT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTCBWIAAoJELSic+t+oim9Qm0P/j08p4jDi/VfBIhSdOGzcV2u
Vyz6QkEqy267uMsLkWIDLbJ9JyAE5Bk9OczVLmdXEJoDPtaHNXgxQJRwCjRJ5g+/
m6f28lbU3wRCNH0C8mg5sJyWxQ1dP29f41HfrLmZPeaZ+I+IBli89a3KVey5R0nZ
vksTGydZntYgAGETzif1ajCDf3EizYuV6LfuIxwsD8t/fVXV79jMbrdX5fO7+P+f
wl0tHQEaJcd7lzFNAmohJ0WCqjChuHuRexrngr3hBiS5H3L0ZZl7p1+V9mfowcDk
u8KzGshK/RyA2eVxhPy3C4onsyMogp0Cfs1/yqCdPsy2TAdBnt0f1wQULbDjSLLq
BWN9SRXigO+bmRn5bxvWA7xgACZLSqBwjqmu9P2uM0/RLpAhGRjobRqe0E1tBly9
EenfATCA1oKGKy5kV0goWZucQ+qPOk129hMup0JWquzswpbL+UmBFGNhXUMWxvEG
XBIGWXEiVKC0juilrm7p+gnWCYkBOgChS6GP2HFJFiWmIt2jHvlykw68S7aMhFfS
Hmgv8FHwtacBDj+/sHE+lJM8S9PDeM3ZQz+AY/GyfJhqcG3d4ePgWT9bz89ZiVN+
1gTkfhufFC+EH121ZdMiNAG06BJUorF73QwdfWxgBdxo11fEPrKMZiiVhbIPjpAl
bvFaamQXVAcGCz8wRXU0
=05VQ
-----END PGP SIGNATURE-----

--oGy11dVowAZA6eXT--

From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 03/11] spi: spi-ep93xx: remove bits_per_word() helper
Date: Wed, 3 Jul 2013 19:21:57 +0100
Message-ID: <20130703182157.GB27646@sirena.org.uk>
References: <201307021007.01896.hartleys@visionengravers.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="caqKA7PbDQ8UCDMt"
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	spi-devel-general@lists.sourceforge.net,
	Ryan Mallon <rmallon@gmail.com>, mika.westerberg@iki.fi,
	grant.likely@linaro.org, hsweeten@visionengravers.com
To: H Hartley Sweeten <hartleys@visionengravers.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201307021007.01896.hartleys@visionengravers.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--caqKA7PbDQ8UCDMt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 02, 2013 at 10:07:01AM -0700, H Hartley Sweeten wrote:
> Check t->bits_per_word directly and remove the inline helper function.

Applied, thanks.

--caqKA7PbDQ8UCDMt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR1GvBAAoJELSic+t+oim9sHoP/3QfHSWtPYoqvRwY5e2yTJOy
oC4mW08BAfsW8Yvwxa3SfMp4YsHGE9JzNZgmpzLyxwEtklps8XY7MzC11rMjnYfv
m3BIpQRWyhJTmjcgzT8j+fhcN7QySrgu92p0P7ZP4LR/uweMaXPPOT42mwskFr7e
GsUHzOws5WhebHL9TzsMLXFhEZ/VuxmWcOJSu/HWnlaSSbXnXma2f1ueJLMd7wfJ
XeH+aUzNyCcdWSrhuexwlQD6sBXBqOb4kMLLD+IVf5iS9ejjhrDE3JV0XCvuP36A
02loXAZV8XWx2APjM7nx2M4nwytg2+t5tME1NIVbXSPrgNiiRPY8aazNXpbY789W
xyDIKNQM0i6+OlKj3fAmwlpgC/gWg5Q886WvZgUKUkd5gpUkHTYvW7Lx4mwJJYaw
3F6S46vfTSuWaGEo1zWtaujElb54jkY6P/tSnZeK32dvSNWjey5SBGfTnbXB8x1E
RYpN9zSYBzxflvYQCGN6wEtofGotfyHSi9N+47TWOeI5DYO93SBM+3n1ag6Aufio
4dYKlhRbEbEyYxghyOHiC9qC8upmRofvYysGEJL05afvDtuj2D8xFTXAAvs18PsF
OjyyEkfRnj/lZdMWAi0Gx4XuBrMShLxiNKceC8jdfszxJ9u7RpT2pyjOfoUzs4XO
UXvwGNcL2WNlozW8hEsM
=vvfe
-----END PGP SIGNATURE-----

--caqKA7PbDQ8UCDMt--

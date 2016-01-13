From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [GIT PULL] SPI updates for v4.5
Date: Wed, 13 Jan 2016 20:54:33 +0000
Message-ID: <20160113205433.GO6588@sirena.org.uk>
References: <20160113105009.GG6588@sirena.org.uk>
 <CA+55aFyTMjh43gYU-E6vg0jKTsf9dN+r+OWW5nEuLJLj=hXKFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CD1rT0yj7A8qvce7"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CA+55aFyTMjh43gYU-E6vg0jKTsf9dN+r+OWW5nEuLJLj=hXKFA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--CD1rT0yj7A8qvce7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 13, 2016 at 11:41:48AM -0800, Linus Torvalds wrote:
> Your pull-request script is doing something funky and duplicated the
> summary, shortlog and diffstat..

> Pulled, but thought I'd mention it.

Interesting, thanks...  the actual text should just be git request-pull
output, let me investigate if I've done something fun around it.

--CD1rT0yj7A8qvce7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWlrmIAAoJECTWi3JdVIfQhOYH+wSAyiFXfUajh73NCvMxMzqU
MVhESeI9qOAVcZ1EVp3E1cAjI828Uash4e4vvIwDH4lOhMhhKjIwFtYLXsPcUIy1
tcwauAg8WAiXxr12KDUl83JDc7HsAgFUaW8AjjqOXFimcjeadfyXw7zZG0jzrtf6
5ls9cWcy8tQYoZiLg7jkzqvBoBVz2CMyHiapiJc9hdWezv9Uu4dlVTB5CJeV4M67
eTMu79u8pBJGq76ILA7Wc1tjHXQXMcZQo+H3XwBDsAzSSxm7qpr/IGwTQOQtVM5D
vSB+6UB+5CUZIjVDVBoZ7DV2GvaMWMwy6WpViQVpJuQqxGfPjgabFQYiyHwqG2g=
=jxc9
-----END PGP SIGNATURE-----

--CD1rT0yj7A8qvce7--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

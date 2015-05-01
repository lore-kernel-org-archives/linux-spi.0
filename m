From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: rb4xx: Fix checking return value of
 devm_ioremap_resource()
Date: Fri, 1 May 2015 17:36:02 +0100
Message-ID: <20150501163602.GF22845@sirena.org.uk>
References: <1430359614.2531.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PA6I6Tux0r/NgvnF"
Cc: Bert Vermeulen <bert-Nh2F35Ii2RQ@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1430359614.2531.1.camel-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--PA6I6Tux0r/NgvnF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 30, 2015 at 10:06:54AM +0800, Axel Lin wrote:
> devm_ioremap_resource() returns ERR_PTR on failure.

Applied, thanks.

--PA6I6Tux0r/NgvnF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVQ6tyAAoJECTWi3JdVIfQekAH/jrnppivJUyyagBGMyNIqzUG
ooZXFPHwVvU5YXKVgypImdDZMb3b0uLaRQFzqcVvB1J8FLUZ8Fwh9QcWxxq5bXDl
FqJgLgJAbR3ycRSgDi4KCwBwIkrnJdJS7LcCLibvRWMi3ltmcFFxN3wI5BkTXh2H
R1MhwqJKITAySBjije2Qt5zWm2H04Ez/UZIIawTmUxH6G6JqXlXVxSQMBdguDqyL
zcsXmN12uyvVOj+uCqAnzuLbzH4lPBOyTu8zy2f6p0TPOFWUfxBWAZbuc5lOKQjs
bFvvx0HXwOwjV1lD23Bkoz6jawFkf3AB4SzX1XsEJ3vY+qGlEx7s7NoJuyjt0Qk=
=PRHL
-----END PGP SIGNATURE-----

--PA6I6Tux0r/NgvnF--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

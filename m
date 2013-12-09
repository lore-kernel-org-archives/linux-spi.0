From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH -next] spi: coldfire-qspi: remove redundant return value
 check of platform_get_resource()
Date: Mon, 9 Dec 2013 17:05:45 +0000
Message-ID: <20131209170545.GU29268@sirena.org.uk>
References: <CAPgLHd-tJtLc3o8a=8qbQNB5HzaqeDgOX57HGMiUUE10ehN+tA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aMfmUgCNW/aonds3"
Cc: jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wei Yongjun <weiyj.lk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAPgLHd-tJtLc3o8a=8qbQNB5HzaqeDgOX57HGMiUUE10ehN+tA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--aMfmUgCNW/aonds3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 07, 2013 at 02:00:40PM +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>
>=20
> Remove unneeded error handling on the result of a call
> to platform_get_resource() when the value is passed to
> devm_ioremap_resource().

Applied, thanks.

--aMfmUgCNW/aonds3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSpfhmAAoJELSic+t+oim9vR4QAIRvNShnMP/YGaGq02fn1tsV
ckr6xOZghYxTmjdgzOwWFtnQT9kClUXOAS0PKEW5/wCEkGWNm/c0hzOIDIGQEf5M
movk7rwLE0B9s6v1mrJmorNhQ5LsBZcAgdKa9zi25K9qkkC0jxRXszPufNl375MK
4Fa0keoqygVz4NR5+AnYAm0uBRV6akGZhNgGHl/57BAojhP50C9Gm/sKH9aokBHi
WmPzCSDix6TJhVvdZWMhL0U0zR7KWw+3profDh0k3gy9ARHNy3JC7Iqi6bAfbGFJ
nA5tNTvpI4P5BUik2/kFc2MV5+lJI/fHfGOTX1p4iRZLOAwCL10HIp4jWSXOpUvB
MFgatlf0YIcQJdW+5QQfpP2piyKLklCO/C2vo5uKDzdz0UwTlJvKeeiyemp4Y8zH
JdvpR+aosL3YoOo8f6vQyhEj1Q1l3LqE9RjhffVugRZbvD/M7vsrYKZ5I0HjFlsf
EpXY5W2htEywLZToRhvs+mLQbutN0Y5LmdAoxcluxgL/qyyz6/jvYxcWOqmAVxOO
NB9DjGBKxLc1l+Hhazz+LogHfw66LgTki6R8HFWX/2GkcttKtMJa7hVI4zlFlOos
KSCy+sYWC+wiqGoIfTxbo1yMvA199tk4gmwHQ6iGlgxsmLjY+a10boSEomF/Az2u
k93kFkmg4c0rO6nrOfEv
=hBQc
-----END PGP SIGNATURE-----

--aMfmUgCNW/aonds3--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

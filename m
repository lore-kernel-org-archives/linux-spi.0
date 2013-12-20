From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH -next] spi: nuc900: remove redundant return value check
 of platform_get_resource()
Date: Fri, 20 Dec 2013 12:00:15 +0000
Message-ID: <20131220120015.GT31886@sirena.org.uk>
References: <CAPgLHd9rWo=vAa5xiPhi_FFheGNMOTEvt_0_AFaxMyYEJ8TBrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Zltv+KEU+AMUCOPj"
Cc: mcuos.com-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org,
	yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wei Yongjun <weiyj.lk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAPgLHd9rWo=vAa5xiPhi_FFheGNMOTEvt_0_AFaxMyYEJ8TBrQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Zltv+KEU+AMUCOPj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 20, 2013 at 10:21:54AM +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>
>=20
> Remove unneeded error handling on the result of a call
> to platform_get_resource() when the value is passed to
> devm_ioremap_resource().

Applied, thanks.

--Zltv+KEU+AMUCOPj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJStDFMAAoJELSic+t+oim9gQYP/jAFpaUq5BLxCQ7LOIH41+ja
wD2Z/rN6NdQ6G7Y/RyEAoVleM+oL8eQGnn6cikJ8TJed0J1oDo2IyIBGQ8iMbP7u
IaOcJ6HY38azscv2P+jdnWPjD4A9LczGJnmZ98GaYRh462Ksp9StwvaUKTeGGLPD
5JWrhguiOMr8fjEzmUSDHqImlFSv3+Kha3bGT5skE4OZgO2iJiyPtVXPTpIZ0B3M
9io6t9cSp2lro+MHq/hgnmrwOUPNntIN/OynRnxPKzfWV8Hqf2gOCUGkNAImNSLj
jda9r6+j3JqNIcpBE8O0FhfH0TMRT5QGDQlHIwIM+uyQfuXah+TJ6RxIKonXKAWo
1bYI2XcgsFTBH+8HVjkH8TsoZiepG28rNI0XT7BXa+e0GjDO6Qu30SdxyJLoUpfB
7R2Byb1rcUPlvF//yoESXTWuUXCRB20bq17GzFYl/NIE/CIY0Tj5fguLEka/Ld6N
/RhGLebzZO/KUasl2g1O3NgxBNFRg2pRK31vDKyEYu0jTISQ+tCNfWtRNyGoDUpu
Er4kpBozBfvLawL3ei9iw/+8rAiE+W47swk9eZja04iIoZy0AFH6pmiBta3kfiHg
2GHw/SeMInSaAE2ptWiJiaa0fpnJD+uEge5SdxfOoundFPp639CLGyWLu5Wvltjf
YVKJKVHNdDbzRG5QoM2U
=HQ+Z
-----END PGP SIGNATURE-----

--Zltv+KEU+AMUCOPj--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

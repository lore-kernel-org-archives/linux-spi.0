From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH -next] spi: spi-s3c24xx: remove redundant return value
 check of platform_get_resource()
Date: Fri, 20 Dec 2013 12:01:19 +0000
Message-ID: <20131220120119.GU31886@sirena.org.uk>
References: <CAPgLHd_Dii+mu4GmSUWjxTwy55Xxe6Qoq=TN73jQR1_NQUnAbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Jp4gq2voFtVFKZdE"
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org,
	yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wei Yongjun <weiyj.lk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAPgLHd_Dii+mu4GmSUWjxTwy55Xxe6Qoq=TN73jQR1_NQUnAbA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Jp4gq2voFtVFKZdE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 20, 2013 at 10:22:20AM +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>
>=20
> Remove unneeded error handling on the result of a call
> to platform_get_resource() when the value is passed to
> devm_ioremap_resource().

Applied, thanks.

--Jp4gq2voFtVFKZdE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJStDGMAAoJELSic+t+oim9ZKgP/3OW5yPL9bKG2n1saL4ZMc+S
j+HMbuSKAtwphtD6FFNKV1NILW86tOeE/ymJWeAwpH33aPPbvqirfAPQZjACbsEV
oZ2Cxw7RwOfza/VOHmhLNKcXe1dmvgjRuNkUvzryWWI0GH7JgXIpfMCA/zMXuq2I
aGC8tx8hCk6cVrKklWAEVMbmqjvtzywMJJP6yT/DIubtI3H0X5aaN26DCAu3Sk0o
iWZn0Eze6iJ39ueVX7PqAPoEj/DgsV8y0r9lLdPUHUy4h/FCAutj4DzW1LxmvAOU
e8XLlIx1z+ddaC+Fwt3fA6AiL4AVPSrUtbsBNUExF3b5lj8ovYbxiF8hdfw9Wnx7
MD3UZJnzzJRY6BqnMWmu5qick8TtzRYQ3qLxIeND+X7KbddGDkfgRopy+HwqOzmF
BKTShANNwEGVJLndvgQiTxS3nBIPlfVJJe2htGNWTe95kSXMp1ny9UlzKkZVScGQ
Uw10euNslvLBomVCENcayReXsVhPC3tCwP46ovp3XEKzpDjO6/JI7IOMjA85eRuB
4Hhs53u+XYqmZHaYtZCPLR9yEDkvW8WhKef9jzV3B1mPWT+s6rygenGa1PjRC8qw
ju57EyzEVOGm6WHJpBxU9+JfnP1+Vy1Dl2Zaogz6y9xcptTu80WCA06TnIQE1trj
iuqvosdSOz+I9A43EtcW
=nDIo
-----END PGP SIGNATURE-----

--Jp4gq2voFtVFKZdE--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

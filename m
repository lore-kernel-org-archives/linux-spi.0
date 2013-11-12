From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi/qspi: set correct platform drvdata in ti_qspi_probe()
Date: Tue, 12 Nov 2013 11:20:10 +0000
Message-ID: <20131112112010.GL2674@sirena.org.uk>
References: <CAPgLHd90TnMX_nom0ooTtRmGMmXFp5UkF_kPrioc3V3T5qp2+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YIleam+9adpUeYf+"
Cc: grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org,
	yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wei Yongjun <weiyj.lk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAPgLHd90TnMX_nom0ooTtRmGMmXFp5UkF_kPrioc3V3T5qp2+w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--YIleam+9adpUeYf+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2013 at 02:13:41PM +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>
>=20
> The ti_qspi_remove() use the platform drvdata as a type of
> struct ti_qspi, we should pass correct platform drvdata to
> platform_set_drvdata() in ti_qspi_probe().

Applied, thanks.

--YIleam+9adpUeYf+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSgg7nAAoJELSic+t+oim9cscP/Ax1OlshKUNYmgI8N1/nwRX0
SSN+ZlJm0AkrOkWIX34HRS/DnNhb1DVeEv0newKzSM2MhQgAtbbRmWc+0plABVQX
x1qOMjKF1lwgzDVmRnFgBZ5iSYD2MSFlJIwvIm5amAN+wTLR3l2j3ns1Nv5AV59H
6beXEXfyYUrwKaTEO5L8LBAezCh4HI5qLVvatQOcdn46KJAfZyyVtzVe6lxBqaNQ
xPa6JlmlKsGUvQFvULl1y9RopyShCIvn9zGpGDt7c7sr8To9hfC6coK5lRH+IAMn
niYMVCIJQObi10g0FzED4NFC3byWhVeNPKJNhHdqOgpsscNvhAdNi7CX1qUzSAZS
RyiYamdOKNROdZPTPHvO6DjkXD4e/ORnjeL65zQ4wctByqZ9JieMSn8Na2lbG/9S
JE4tHTRwNgOhDtHaHL+sbfymqBZTpl+jJReTIHP4RBRFaBvUxaif8mfsQq6gkdBW
aou5biiRjbX1BK3yzS8Ouh9nQtSsyvyBnshgTHazMEcnxNf6p2FtYIoL0qiGiT0I
ruQcmAqfDsJhzQPPEhBvpeRRGKHYXLYsihFA9MnFMj3FlG2FyVDBwan2JU9GPM+T
XepXaKkeg3ks89xNJ7WY3QT46adWL9sY5y2LjGOea9bgerlANQh2/EaB7rBJ0xRs
e6+JgkIdgKvfpYPlNujA
=TrjZ
-----END PGP SIGNATURE-----

--YIleam+9adpUeYf+--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

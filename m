From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: fsl: Don't use devm_kzalloc in master->setup
 callback
Date: Sun, 31 Aug 2014 13:51:49 +0100
Message-ID: <20140831125149.GF29327@sirena.org.uk>
References: <1409460249.31873.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="K/+MhuhYzqQJJ3Xj"
Cc: leroy christophe <christophe.leroy-GgN8y9CXRhA@public.gmane.org>,
	Stijn Devriendt <highguy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	LinuxPPC-dev <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1409460249.31873.2.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--K/+MhuhYzqQJJ3Xj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 31, 2014 at 12:44:09PM +0800, Axel Lin wrote:
> device_add() expects that any memory allocated via devm_* API is only
> done in the device's probe function.

Applied, thanks.

--K/+MhuhYzqQJJ3Xj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUAxpiAAoJELSic+t+oim9XOoP/2GKmi2YYyRGRcH8M7IvUYQS
o2yPlZfs273g8asFcOPRtdUMBz97BsvonhScZ76zQ0gQ9ri0J4rNUFyPymAsQkLw
f3XKWjWLZ2bxMPW26ImGxtDwm2fx9q0XF4zbJpopUBsbWTEipdfx1D+z5qtOR8WR
ARtVnDC8x4FdzRQ+QSkbq/sqN/tO2UEV7jZKRGepYpryDNu1Q5hKYdBSLr5ctigT
Iqevx4TRIy45Z6HnWTAc2ezCITtwNQtTtVcQUvt/AwCkqQFz6+6wz4DlrqddJ71a
b8dH1a6zGLidePUgZx2jPXtkh8zh07nmJefKjzqAm2PwaStg03uh+rL3mqcOHega
NmLjgX4yChZCpSBbzUyiun3F/l10bCSJ+2I/bm+OYMKQMF0frFEFKBYcGfeHKd9+
5487RNCj/nhZz7WTi5FOnrNVZQptFIC4L4iJWphJPusLFjT+gz+lmpWoCqK3BwR+
3l3qGqiySAK9vN94lKsfRTvy1DtJiVgFfurlY7MOcjd3TJ9UONmS8c0Qd8AZr9s3
nq0dwgbhLYBMv+ZmcAMZuW4/+16/xFxq4XX2YuvREClWJm+Sxpsfw8OQhy6Jm9bG
Hr3i+erfYZ2R7kKOM+KZ9GKaueYSQWutAdmmtR+MYoNUU3JSDFACK8qcDYrixtev
d5k9pjiwDfK8Cc5SPMlz
=H6Sh
-----END PGP SIGNATURE-----

--K/+MhuhYzqQJJ3Xj--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

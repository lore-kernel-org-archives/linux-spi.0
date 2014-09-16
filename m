From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] spi: pl022: Add support for chip select extension
Date: Tue, 16 Sep 2014 11:34:31 -0700
Message-ID: <20140916183431.GX7960@sirena.org.uk>
References: <1410781132-16223-1-git-send-email-anders.berg@avagotech.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J0QI3A+imHzF1NdR"
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Anders Berg <anders.berg-1wcpHE2jlwO1Z/+hSey0Gg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1410781132-16223-1-git-send-email-anders.berg-1wcpHE2jlwO1Z/+hSey0Gg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--J0QI3A+imHzF1NdR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 15, 2014 at 01:38:52PM +0200, Anders Berg wrote:

> v2:
>     - added constant to <linux/amba/bus.h>

Since you're editing the AMBA code you should also CC Russell so he can
review the AMBA part of the change.

--J0QI3A+imHzF1NdR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUGIK2AAoJECTWi3JdVIfQPqkH/3q6cXYjOeFlqwJk1vqkIt34
O6mh8Lv0eVcdn32ZvzJvX0vnFARbkXhXxuX5viTrbAZ3DnY6J+OJtLqcP9qIv47x
eCSJikvZkSS8PEJKNRRw5ejxBwkjjDHC7BuCGT+jkCogR726e7uJPc1Ss2IsgaTH
uHHQ5xw3Y1qpQThrnAftY/07HCj9+0SGgQBf5Q2GE8nKRaURp58hSYeanOsNOBif
ch820E0ZVG7BMoXsN2q5Y7FP31CtB2fEzEzESaT+2Qg62u1E3ljANlccFh5CAbEB
iDOmDT96XS/syxcr2fl7U1TYvSxUOPZLoFAJ1lrXY89oJ3w4g8sTaaeg8U3f5/0=
=i9bF
-----END PGP SIGNATURE-----

--J0QI3A+imHzF1NdR--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

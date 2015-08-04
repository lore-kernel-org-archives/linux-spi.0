From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: spi-sun4i, spi-sun6i: Fix bit rate calculation
Date: Tue, 4 Aug 2015 18:19:31 +0100
Message-ID: <20150804171931.GZ20873@sirena.org.uk>
References: <op.x2pmc5kiltbbtz@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lNNXyHqbYhwQi65l"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
To: Hermann Kraus <hermr2d2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <op.x2pmc5kiltbbtz@localhost>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--lNNXyHqbYhwQi65l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 02, 2015 at 12:06:31AM +0200, Hermann Kraus wrote:

> +	u32 speed_hz = tfr->speed_hz ? : spi->max_speed_hz;

You don't need to do this anyway since the framework will always ensure
that speed_hz is set so you can just use it unconditionally but in
general please don't use the ternery operator unless it's adding
something, it's not a legibility triumph.

--lNNXyHqbYhwQi65l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVwPQiAAoJECTWi3JdVIfQSE0H/14RQ5gAJX31WksFLjj3TAWa
t4I2ySwi0jPQTO6QuwWOy+zBhOyvqqNbWi6fbxUqsALiqukUvGdUltR7Af6bmnm1
yreS7c06nS/NtWgIhkG1Mm084VWW8TJcCxTsJL2iQ+HGVDYcBVoDyZ2w8TbeIIyH
PzI9+xpAL5NoV8/m1+Oh4wVqgDHRzAKC1qmLc/R0ZCGmSYBbhSU2YbMoi+N8P33T
unSQqAQ04e52Ys+iPQUMMTK++O+eK4sw5RcdayJZYHrfAyhWARV1Qp1ejRLhyiyI
L8c/GAAlsT4BytjRNPHkUAO6Rm3dfd7QRwLSR6tzSrulSLVBOHvePwPwu+F7NzI=
=Pyzi
-----END PGP SIGNATURE-----

--lNNXyHqbYhwQi65l--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: sh-hspi: Remove duplicate code to set default
 transfer speed
Date: Mon, 3 Mar 2014 10:37:56 +0900
Message-ID: <20140303013756.GK2411@sirena.org.uk>
References: <1393772510.4044.9.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tBhgiDt8dP1efIIJ"
Cc: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1393772510.4044.9.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--tBhgiDt8dP1efIIJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 02, 2014 at 11:01:50PM +0800, Axel Lin wrote:
> In the implementation of __spi_validate(), spi core will use spi device's max
> speed as default transfer speed if it is not set for this transfer.
> So we can remove the same logic in hspi_hw_setup().

Applied, thanks.

--tBhgiDt8dP1efIIJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTE9zxAAoJELSic+t+oim9hmUP+gLIDIR2mQkCk0+8ITIPcXJ5
dp8GxcWhphcIylqiNBwZledryeqEDrG0/8J3QFwhYCVPCeW131SgWnB+mas04vyW
GidBsyP3ahhGnJMpC++jjTjWHxQL1UZyGpFNSR8+i+VUk5GTO/dMFbLyttoeIYst
Y7TCbULpG2NTW6GDSRfBaYx4n8ZExNroZt9KtHLTbByXPmGHScYu9ni2qMY3xN7q
4qboqSAf+jWrDkgwry3RJk2yVwIXu5GeoUgmVK5Zyu4LIGNrTZbxJHRncV5ZgbMu
sAusTseyNi4DRrUlOrrXU35NsnEmCkb44vIXxVaE9OJTy0owMSR6ETEgGRuwdeL+
PRXwG6L5FxQE3bZC8mxHwa9sbWmB9sL2PzA8qNtcN9ODwzcMHErsLB08NBLgPQGl
GZyx7yKE+OCn5zqSRLOGFFiJGrsi8zEq36jBItf+DZaT3v0X4k5WhoHB4CH5INah
sWA8GAhNEu8s92osZUPRF0itTij60j7XzDOa+nVVYEuqDmS19vWCDYVFqcDLHLAD
oU6yr1a0VyYpvHnvOUaPvOze2+2UpKH6jPlYYkH8QoMn93pA4ReatouZqK7KnFNk
cS2+xwS6RlMKF7wac1gdWIXgjsviMgWzU3kRNh8DYL4xBLeLNBGnopzLJ+HqzIM4
5wNAXb/FVztdz9cNY8dV
=xZag
-----END PGP SIGNATURE-----

--tBhgiDt8dP1efIIJ--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

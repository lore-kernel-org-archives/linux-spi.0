From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: sc18is602: Remove sc18is602_setup() because it is
 done by spi core
Date: Mon, 20 Jan 2014 18:33:19 +0000
Message-ID: <20140120183319.GX17314@sirena.org.uk>
References: <1390231125.11756.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2EejY7RDPU7h6CFd"
Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1390231125.11756.1.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--2EejY7RDPU7h6CFd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 20, 2014 at 11:18:45PM +0800, Axel Lin wrote:
> The checking for spi->mode is done in the implementation of spi_setup().
> Calling sc18is602_check_transfer(spi, NULL, 0) is pointless because
> the code is equivent to checking if spi->max_speed_hz is 0.
> Note, sc18is602_check_transfer actually allows spi->max_speed_hz is 0
> if t->speed_hz is set. So return error in sc18is602_setup() when
> spi->max_speed_hz is 0 does not make sense.

Applied, thanks.

--2EejY7RDPU7h6CFd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS3WvsAAoJELSic+t+oim9VhAP/0EsndrhLWkPHJvdkLVzo7ye
gCN6Hg0OQAkoLStMcvqurSLRNbsusA/KdyRJCvIe7Xx+OI7gAxADNq/9+o3ewQAN
zdQlAtaeQI7n05jMSGkk1dbqI/rRuMk4BVTOYYfdpM8trbAkyKUAMWeIVDopIlrS
kjsaW3wZNLdPGuTBQY+oaJNGnSPYs+x56Vow1jtKwRF3QgsQ3ko6k1+ow9v7gaCh
MPMHSciMLm7bZtSxcEZm6EfJEyapx2i6PrqNoJOvZ46/mNAF6Je7JA6KlLFtOJv/
RV/cAoKo5utzI8cSxJNfWDEhpEjIvvl+CfCamtmJsf4m0/SP182fxVoYCvaqiG4q
FvfdmGo5rpP1FkCpxcOXcdMxREDV0hBIV4DIpmBrAuIe4Ah6sYZPdjrkAHudx2Tm
LmntWU/8mEI8b7nhvfcLTYJoCUgAJxnaZ9X52y1VqpLTLhvjOtJkQNgva4RY9Y0M
uNZLOUv1/5zSmMkN/9yJv16q9BrStZACsID/xM31HwL/fY6yaTn+yKWRDbD85AgR
/76vqgU3OS8xA3A5oMP5HasdQlE5Ut+gJ6Fd8evFi3SIVAXVS9ZFeTNA1ICbXkjW
maxuAv8/Uxh/u6sm3jPNIjxUvOJY3xGgveTOQxi2ZPhYW2qrm1seU/I9LiibtadT
RhgC3tSc3j9JZKlJSfc1
=xso5
-----END PGP SIGNATURE-----

--2EejY7RDPU7h6CFd--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

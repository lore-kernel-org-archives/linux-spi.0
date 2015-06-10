From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v1] spi: davinci: change the lower limit of pre-scale
 divider to 1
Date: Wed, 10 Jun 2015 18:28:18 +0100
Message-ID: <20150610172818.GG14071@sirena.org.uk>
References: <1433921022-13151-1-git-send-email-m-karicheri2@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HGQiUpf3h2mG3oks"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1433921022-13151-1-git-send-email-m-karicheri2-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--HGQiUpf3h2mG3oks
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 10, 2015 at 03:23:42AM -0400, Murali Karicheri wrote:
> SPI hardware spec for Keystone specify a lower value of 0 for pre-scale
> divider which determine what max value of spi clock (spi-max-frequency)
> the device can support. This translates to a clock divider of 2. So fix
> the lower limit value used for the boundary check in
> davinci_spi_get_prescale() function to 1 so that a maximum of spi device
> clock rate / 2 is possible to be set for spi-max-frequency.

Applied, thanks.

--HGQiUpf3h2mG3oks
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVeHOxAAoJECTWi3JdVIfQw2UH/33fS6TT8KLx0To0TFAKCmJH
x36GIFZFl6FCdOU/wdmFjCVkdyQGS1Rza63MBuXhAk+46Rvq9G4qIayxQdU0Ivv0
nFRcTG+LgHmONL1qm1+m4IPhczXCz431w7m5IoyCyVjA5Dy4GCaOuzd0wD5nlxff
k0m0ilOY890TNNXgvZ/AucSaw0ozgbhPrtfRvwN7XZqUxN0AE7cOJMVPHyYCCEMD
aBUpxpmI4xqqEg1YJn2DXrw0mIjNBS/XGrsrX/rfWqG8pRhXDN3qVx27ffIG/m6r
mxdgeV9geDDzoS/Hgbom7L3wHTtM7loCS2eruO9E2eCOWHvz9p2qAegzgn98pSg=
=jbeP
-----END PGP SIGNATURE-----

--HGQiUpf3h2mG3oks--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

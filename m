From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/3] spi: s3c64xx: Let spi core handle validating
 transfer length
Date: Tue, 25 Feb 2014 21:27:27 +0900
Message-ID: <20140225122727.GD25940@sirena.org.uk>
References: <1393327017.6723.1.camel@phoenix>
 <1393327109.6723.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5+i5DPUbLWybRCWg"
Cc: Jaswinder Singh <jassi.brar-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1393327109.6723.3.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--5+i5DPUbLWybRCWg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 25, 2014 at 07:18:29PM +0800, Axel Lin wrote:
> spi core will handle validating transfer length since commit 4d94bd21b333
> "spi: core: Validate length of the transfers in message".
> So remove the same checking in this driver.

Applied, thanks.

--5+i5DPUbLWybRCWg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTDIwsAAoJELSic+t+oim9ksQP/028XmmLD258Gqs1Oj+RuTMs
1aFQiamjIWGiNBVLMQFqyyJoaMLzCmKMdX2BJrv4CE0SanHXb/xoWoIyqchCRuYk
bsJlLN4A39bkTx2qA4xu9NJGOcoen0PqyX9GOb6986VWOa4Dhapqr3ralPMxHCgu
XijVFE7N+dVCKrkqrqxoSTqFZWEleHaZPpnan0u6didI+ukd2O5h3rWd8BHKFik8
gxqltYj9D3ry630UKyeE6pwS38hU3gM/5RwuEHNQX1UAwOpchwmCzSqTe8ont0Lf
iZNxGxRDZTZMvieQ4DJUHRiKqWNfBuI1FBIU6K3dUDgOFZEbmJErfwKO46IDoWPO
lZYqFL0osO6CnDlG0bgiDUjiSNODIJPoHid122yUVNb0IorhbdBfvgxrsKD0BL9D
76MfwBXo9rSRK5r3k9aqfxQeFsqW156ox9pTju2GOreq3kRakkYsFul7Dp1msaa9
RwftaIipNdRwEth6bRGrUPrKqQJgs+0hcYBXKczQDiC97jIk8BYY9OCrDEDGlT8J
YpuJ4Uu9Fnn2P0bvM0swEJAJg4bFi1Z08IIzTd8gUqZ5ZdlpX0wi5fo8QbG5TH4t
+a6L6tdag8YMYZccHFggxfiRaxSA6U3mZAqDW5CaZHJifpP8Us/NSsxbvoHTk7LK
tAG5J74kIjq1/pJ/d/nc
=LdbJ
-----END PGP SIGNATURE-----

--5+i5DPUbLWybRCWg--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

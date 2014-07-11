From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: cadence: Make sure that clock polarity changes
 are applied
Date: Fri, 11 Jul 2014 14:39:47 +0100
Message-ID: <20140711133947.GV30458@sirena.org.uk>
References: <1404984389-12802-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BO2dbX1J/fdLEy+S"
Cc: Harini Katakam <harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1404984389-12802-1-git-send-email-lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--BO2dbX1J/fdLEy+S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 10, 2014 at 11:26:28AM +0200, Lars-Peter Clausen wrote:
> It seems that the cadence SPI controller does not immediately change the clock
> polarity setting when writing the CR register. Instead the change is delayed
> until the next transfer starts. This happens after the chip select line has

Applied both, thanks.

--BO2dbX1J/fdLEy+S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTv+kgAAoJELSic+t+oim973YP/jqUUwTZIUog41oW7sF5KIIG
dEYEfJUd6psOkcPYc9ub92j44dIUVLIR5FmDpl7AjX63+m1uKcZlXiUtiFg+xNRw
Xoj0hqR4adxglngkX1ouP5EoL7BPsW12JWWPkIYrmx+9oFYaIsh2mn6DbjV31pt6
yWYlvBsSn9gkNhyN+84ICSu7Bx5T+6pV1WZPAD57bA/i0kh6HmMx4+0hK0hdnuwB
mYJdGFwb4PD1FLHna3xfQhe4s1ZUWEIXiG4dRXbcxM44H3aLSdWMVcfxyg1pQ+Cg
ZGowxiLwYTpSW8ipY5v2WOsDPRq2C+jCYc32Lu7721f3IoxmONJkDZ9ZEhD5d/9o
IqEWutBvlsYk3oPZpFLSnfAbDboSR4KwZpCtnjNRtLRnZ4oZDXgwDjxELCJfFv0N
kpPJtqct6Gyu9JoJHl7FZEBDwnYhCLWTL4UiY28K6Xw3TxmhRb692WRwRyUdTCvP
Z2ywagf7qrBFM0bo2LJiC0a6vCylu/kzxz77YZYsuGO6/L+9rj067qhbhcy/i5N0
j+RI0c1A3btSSW6VFpOCW2/St/wBFDD+vuqryTsLbTpxgwR9h3t3Bv/kurvj2ur7
xVjisGfYnqi5jcpkfL84ghFjJu7L/oHULAcpTCHEHXNocOADGyLeIbe0keVjGWOs
YvdBwNHC2zGoKbAdQ10v
=5+b+
-----END PGP SIGNATURE-----

--BO2dbX1J/fdLEy+S--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

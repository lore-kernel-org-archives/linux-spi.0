From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: coldfire-qspi: Simplify the code to set register
 bits for transfer speed
Date: Tue, 25 Mar 2014 18:05:34 +0000
Message-ID: <20140325180534.GC2269@sirena.org.uk>
References: <1395327546.25840.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MHoG8na4IvP3G3ze"
Cc: Steven King <sfking-xS0NTnu2YfYAvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1395327546.25840.1.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--MHoG8na4IvP3G3ze
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 20, 2014 at 10:59:06PM +0800, Axel Lin wrote:
> spi core will use spi->max_speed_hz as transfer speed if the transfer speed was
> not set. So we don't need to test t->speed_hz in mcfqspi_transfer_one().

Applied, thanks.

--MHoG8na4IvP3G3ze
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTMcVrAAoJELSic+t+oim9oGUP/i6m4QJXUOJEngVueSarSAby
ms2J0+SIp8A72FIQeoSL3wT1lyAirDbawqhXfr/qyry6fUPohqKuAu+B4vqJ2B1H
hKDAxADpXzQ94Og2x6o3IwIX0txIjjESUkWfXfvTBpp7zDVaKYS1pfzFlOMiy1dg
BJI/VLN7f5XGjiP5IoDuFoLiT6j1fu0FZXw1CGvra5CumTJx+L0dZf3c/OwI0EZ5
DA8JVbP3uEdd7S6Mhns4KHl3VtX6PUJqjAn6fdw7e8sLjNhZgap6sfJkPlTFWA7Q
kW695WkWI/ZkzrS/+aVrj8L5tUoQGOtIycOtohOpyEPsm51CH3jIc//bCDNZukiM
mgLuKnkhB5W1OHj0KZJiQOHdUKR5mjvtEfPlUWlXOaRhzXke4fF7rO3P8TL4BgPS
IoqzU2BHiPvgxW7j5IonAnEpCQOyBVvvWaOwLg03egSUBy/e7LwmJKyuP+e10mrF
h+7JrN0RVYySTPSA02ieLI1+jM4ZOW638YdqSTRTNgM9vwx34Bwwz8i2IThtqfb1
hwy0tZkRa4oOdh+pQG6U2xKza7s6+QDzwlvXthsu/xqDLupaOy5Ss0kpgaoEhUZt
ToNrlkftUsApEk1YGR237WSd4/tF02gBQh/EYOHuCO9rkp/IPaSLNEjJFxEtBcBk
5rRV+PMpcl6djNGmat+h
=JdBT
-----END PGP SIGNATURE-----

--MHoG8na4IvP3G3ze--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

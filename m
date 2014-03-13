From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RFT] spi: sc18is602: Convert to let spi core validate
 transfer speed
Date: Thu, 13 Mar 2014 09:47:33 +0000
Message-ID: <20140313094733.GI366@sirena.org.uk>
References: <1393583973.18537.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9iyR+p8Z2cn535Lj"
Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1393583973.18537.2.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--9iyR+p8Z2cn535Lj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2014 at 06:39:33PM +0800, Axel Lin wrote:
> Set master->max_speed_hz and master->min_speed_hz then spi core will hand=
le
> checking transfer speed. So we can remove the same checking in this drive=
r.
>=20
> This patch also remove testing if hz is 0 because spi->max_speed_hz will =
be
> default set to master->min_speed_hz if it was not set. So the transfer sp=
eed
> will never set to 0.

Applied, thanks.

--9iyR+p8Z2cn535Lj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTIX6xAAoJELSic+t+oim9NhIP/RjineUnyygvvqLt+Zry4gH6
JPcgfNubUUKkc5OLmYjGDIjI5mzr8MOj48DB/8A0HUP1m313JD27TyV0VfgjzF9h
qf59wJGM0l46d7zRaNfLPlSycwXbr4QhgoXVOYtBA3lV9AdzpFpSsyNNGF83DYz8
E+K/BRfVU/hFsrVaURAMkRE/Iu1Wz+eh2OotSIMcreWNSzMJ3pfa0ssIFEMU0iRk
fVa1nDDVSQSSjMpvxXeTcOucXzh+VDoxY/jiDZqoqh/Q8K7/zRWhT5awdBKD63h8
lPBIEHACr18Cm3d6NF/WwUkHNirfFHelis/vIZKraeH7+HrHU0kJaWXVtgMEKUTz
//GZAp+mk/RKSlnr/GXxp01lYZ1HozoJfHwrERovZMtFjYPmSGJLLfpnQilQc7MU
N76dL4kKKMFdRXTlQIGjI84j58Uo+nvZisR9pyH20Z6WW5xaaNI4uACaXASOcC3c
yKXjNXcjVN1TzhQQWHI5h/wpztNLfc9oUby+bu/GVZTpk3rErX8fde1NyGsOrUXi
V/18cqXY/19vJzAQJHlviM97AJDbI1y0nuHDtz3fT5oT5vvnfKGpug5gz3kn4o2l
uCeunMkI+Ny8us7QgkXnrK3qd+D9wxwW9mubP5voEqnuHL3qaIcVXj2mH0AJ/jxo
YnIGTsT/QpabWNu7cw0M
=1/4o
-----END PGP SIGNATURE-----

--9iyR+p8Z2cn535Lj--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

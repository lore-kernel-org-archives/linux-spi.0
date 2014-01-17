From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: Remove duplicate code to set default bits_per_word
 setting
Date: Fri, 17 Jan 2014 15:58:32 +0000
Message-ID: <20140117155832.GU17314@sirena.org.uk>
References: <1389956020.6412.5.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="B0+HW0pjZ+2jqF7e"
Cc: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>, Alison Wang <b18965-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Chao Fu <b44548-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
	Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>,
	Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>,
	Tomoya MORINAGA <tomoya.rohm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1389956020.6412.5.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--B0+HW0pjZ+2jqF7e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 17, 2014 at 06:53:40PM +0800, Axel Lin wrote:
> The implementation in spi_setup() already set spi->bits_per_word = 8 when
> spi->bits_per_word is 0 before calling spi->master->setup.
> So we don't need to do it again in setup() callback.

Applied, thanks.

--B0+HW0pjZ+2jqF7e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS2VMlAAoJELSic+t+oim9NUwQAJ2364x75JX1vnfl+1uw1ltg
GMOvDl5AMZnhg/RzDU12Lvp0OLBUb4RkrpZEvDEerCEMLYiDbVELwQuhPBAfMab1
ySo6Lman2BAsDEBE1nMw4tbaf+bgOfw9woST+vK3LkoP4++Zg27WeMravXSUS+mI
5P/cRSXh2d4M7trtaTZIIwdMEtRRu+IV3Ou6F/Oirxdky+JD4r/lcWOhxUtO8980
1rIx/8XrNWYX1IfIki/w5fYMPEo26owfZvg6+/n31F6xSnQT34pXzvsQDzC8XRxy
YeBIQdKrvaRF+1b5rfC+YfrEGM961TY/vRSKm6jW7BCrqe/aE2ZsyK9rGBMKmkcI
xchMsrwQggRgSMjzEerrV04nOyoC2R2vb7lAlAwCAGqoJk+dUep9vIm0qIXw+lld
qT9lsS4kvFDLQ9q0tsPxLMAj3BUyxOOAXvcEZMD/+YrzpZxksXwQEPtop1Utn39w
UWFI/c3sQsOm5fL5xI79DN6dTlVBedW9nyc7tlSiW5EYSyydy1CjGrUjt5TLYPIx
SNUT1cHVh2Zi63RydMORk68lT7ZOuG7S2AjYL2IWRZ8UgJ7Kn54+vwuW6Gn/Clmr
GNZs4S283OTdfXMAFpqUg67GIrAmlrgdoi4Q/cZKUE2KIcpFBY4mgIQs5O4joDnv
/zUd7ljZQxbEvq4YMrVm
=Z/SQ
-----END PGP SIGNATURE-----

--B0+HW0pjZ+2jqF7e--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

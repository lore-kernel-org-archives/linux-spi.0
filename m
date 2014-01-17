From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: sc18is602: Convert to use bits_per_word_mask
Date: Fri, 17 Jan 2014 15:58:20 +0000
Message-ID: <20140117155820.GT17314@sirena.org.uk>
References: <1389952842.6412.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RlgFhasKO3bfRJ5j"
Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1389952842.6412.1.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--RlgFhasKO3bfRJ5j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 17, 2014 at 06:00:42PM +0800, Axel Lin wrote:
> Since commit 543bb25 "spi: add ability to validate xfer->bits_per_word in SPI
> core", the driver can set bits_per_word_mask for the master then the SPI core
> will reject transfers that attempt to use an unsupported bits_per_word value.
> So we can remove the bits_per_word checking in sc18is602_check_transfer() and
> let SPI core handle the checking.

Applied, thanks.

--RlgFhasKO3bfRJ5j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS2VMZAAoJELSic+t+oim9MX8P/1B8l3Qy2fIdzOev9M7upKN4
w1FKQHa9r+WWCBYztEMmmloInbMFDXuYfrut2RGytSV547sbfb882QcQXXWD98o3
gY5qIRS/O71B2VhpVrpJuaYg784U0/N2JDAyPd0DlTtoPJ0UNHKWrB0EwSKd/5av
LcnnuIEXBO/NWJdrWqQnZ8otpm2FADLo9nu1ruDxWMexnSsFG8hjMDHyzgGZcEKw
morz7q6nphH2vuYFilOwC2Uyu+wXSlZMv4Pn2pU8GEQYGKlZkIccPiCar2UX8C5q
h5ksDDjecOgfsKlqQlXmH0dt8JMuyD7POXNZlmkz/7bpa0QxyRxZDVPMfFnoGSSd
b4NqrPQ/ZsySsfy3k+EsEAC7xtYeL6uNHhRV+Gn/NyPUGKJXsSNFzlOhClL61jTG
OeUD5xjqvEwNMjWCV0b6O/a3NRtPo2qpxEEbDdq9oElmiIpcizp4VTWZ+WUtbNxF
C73hxWjU5bBmojm/rg8exqpY5Z2qLHbBmwev3LfYo87+SZB8wDeYankokxk1O5Lf
tBIv9/3z7bzfWpMcsfFrO3y2QCRPHmf+QtjU+x3Sgo8YheZOllMbOOeHiXrnRPvQ
epbuk7WFGw5ykHpUiXtcMR3nJCJ67uqKN+uYTu53MhyxWnKHdhZBthzoJ/F1xHXh
wKNLBuqimP/yQ5SuPV4a
=CXLT
-----END PGP SIGNATURE-----

--RlgFhasKO3bfRJ5j--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

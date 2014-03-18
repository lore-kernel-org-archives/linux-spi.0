From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: ti-ssp: Remove duplicate code to check full duplex
 transfer
Date: Tue, 18 Mar 2014 17:35:02 +0000
Message-ID: <20140318173502.GH11706@sirena.org.uk>
References: <1395110917.15410.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OkEUgNLVrkMgtt3o"
Cc: Cyril Chemparathy <cyril-l0cyMroinI0@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1395110917.15410.1.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--OkEUgNLVrkMgtt3o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 18, 2014 at 10:48:37AM +0800, Axel Lin wrote:
> This driver has set SPI_MASTER_HALF_DUPLEX flag, so spi core will reject full
> duplex transfer. We can remove the same checking in ti_ssp_spi_transfer().

Arnd has actually been working on removing this driver since it appears
to be unused - it got a few acks now so I just applied the patch
deleting it entirely.

--OkEUgNLVrkMgtt3o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTKIPCAAoJELSic+t+oim9Ph8P/2fWgCVrePYsYEXxuYp4NIYD
D/Oadn9yaz4mJdqVoTSzgY/nNNZpJrBQXywbZLK01yjrUq5eviL6yNEXvTkFXu8/
unuRXiG25JBUGY61vqokuF70kwC41iSrAE/s5S6hBvMe35ROazFSrdXZGyvd2wLX
+iOVptbW3F13ZdrWWyBTOM2SX+9Xo3ASUAv95Sk9ote65uzwXsZkApLbTp9s4jqA
HHjQimAzSx/awGeZG8XNKkomOeKLU4VY39pW+afym/UD4x/a9B4GOauoKpRXwiOJ
83GKD5Aqm5cvIsv0A1+XSfkaBt0cr79VpP1phRd2Kk8K6RyrZFU3pjIOUWRESB6Y
wA4xfgWPFdn8p/BMuGqAxw+VDDtFQSLV1lYeriqQ9JR4vorkjx4VY4/GT6aF2sOA
QW34lEvcFIUfJYfs9V/cf23WtEJ5kKHqRsDhcUbNSOGJxdvQpPBay7ARZi0xXowy
DmK2RVx/ixnjGtlN1cQ5ZRRyd2OWxbN8kiCUGeKZk8poSZBd3mYk+i6lqGXFO/Em
DFhO8PElHzbY56/JLcpxjB8gacPF+0hYwq9omcx/pIwLAEmxpYPoqE+CxDielksV
DHRXXtivdokM580kSmp5fxXij0ayrorUP1aJM2ZwixU+z7kIuOrm4MY3rf9u4rBW
PLr5q5N9B6V72Hwuwipz
=2NO6
-----END PGP SIGNATURE-----

--OkEUgNLVrkMgtt3o--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

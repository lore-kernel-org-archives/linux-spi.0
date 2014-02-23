From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RESEND][PATCH 1/2] spi: qup: Remove spi_master_put in
 spi_qup_remove
Date: Sun, 23 Feb 2014 12:28:51 +0900
Message-ID: <20140223032851.GZ25940@sirena.org.uk>
References: <1392946396.11510.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CY2AhQJ0E7w8+M5j"
Cc: "Ivan T. Ivanov" <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1392946396.11510.1.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--CY2AhQJ0E7w8+M5j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 21, 2014 at 09:33:16AM +0800, Axel Lin wrote:
> This driver uses devm_spi_register_master() so don't explicitly call
> spi_master_put() in spi_qup_remove().

Applied both, thanks.

--CY2AhQJ0E7w8+M5j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTCWrwAAoJELSic+t+oim9M3EP/Aof41lDJTb2/rNv4OXrB+Jz
OZ/2MI2Ur9apjqmCcsknQfsqFsfMC4Cdb1vtJeB8Zqt7ZXuFb/geOzSUVwggRMjx
Cbe8e02hYNZXQYoCttvM6IJPkRq5UR82WFH8/gyfb/t8HSzSOUmVZHIzrYiH1JJ+
hAHjv4rWPmto2sn3rFtS0xqTl975r1Wg3YCuj6cM2usdvatlpLLFNdRNzFHCeMzw
qWe2/BcbAlXgqjMrLxU/3c+pDpP7G0Lqc7k8pJAu8d5zcusTL24FLcUDqDQ61eJQ
INwbRQCAwv7Kx4OAi25lE2pCspiGw4nDH9HZ2YK+G9vRhJuOEwytmL84tIkIWyyS
CAwWRVtFe88bo647tivbZRHzhIbzHHbztw/79WdT/Jy3NTt+fv9N7y04lUwZbOMr
pi/FCny6D3b4H+dZhoDDezxBxz+dNwhibzS9+Xd4mmw4KTXTdj45FanevimBHqAj
H9yacqd+A+fXPxfgq9233SKSiFpiH1lZwaxNB92WozC0GzE+e9eGKiSE12JYAvHD
LrfF8p99HNBD9+m20olWyzk4aamTnnWzfmS4QiwkKbKnaRMAHbFtiR3MoAE2fcG9
HCFX3wbHfQckQMuF0O5uatX1t1IU/m/r//Ficy45yJZR/Blt8UUMYakwUltcEcff
G22Bzy2qV8wCDbV4DKYE
=7uC2
-----END PGP SIGNATURE-----

--CY2AhQJ0E7w8+M5j--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

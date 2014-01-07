From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] spi: ti-qspi: Fix getting correct address for qspi
Date: Tue, 7 Jan 2014 11:38:28 +0000
Message-ID: <20140107113828.GA31886@sirena.org.uk>
References: <1389092643.3991.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YtwIoJiYGqRe7tYH"
Cc: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1389092643.3991.1.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--YtwIoJiYGqRe7tYH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 07, 2014 at 07:04:03PM +0800, Axel Lin wrote:
> Now platform_get_drvdata() returns the address of qspi rather than master.
> Also drop unneeded spi_unregister_master() call in ti_qspi_remove() because
> we use devm_spi_register_master() in probe.

Applied, thanks.

--YtwIoJiYGqRe7tYH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSy+cxAAoJELSic+t+oim9GBYQAJ3GvCG0bsW9G3J6ZagmFohe
lvELOt4Izx7hZb/M5px7JMtwmR8alxrOD4Dj4Zf5CnoMESK9qaa5n8KzaWWRFTg6
EOI/eGWrCEhBl5HX9uB0xMYUnQ+OudHfsl5onFNR2FUyuO+y3USYRkaBaRGrJ0UC
tRbIJByfbnTCw4fMuiwUeKqF2OB/BMHnUDR+qfyEkDJt1WeoJafzvOWb1qqvrwgz
v++TIacDVmJXI3RX/kOtOkMz1a4JGw5EFGMRZZDYrs0vJmwsuUjBT1d2j26ZSkt/
Yc4GZ35ypAHFZsX/nbH+ZVx6rHQ2ebrvVcI4k10bY7nKLcX21NooxNg7yQS6K7as
0sCBex8YekAiyYn3lB5UiD0monM5GiZpE4XAHxE1Z4IDToPSjqnngzkNd4+Er6Rx
o4o5ThClttgA2wi/aEn7s7wdIMWtnBjSXvTazOT21RybGkDWhXsoYiQKiEXTmPWb
rQNXkjSpAB9ejtisEfgijVOJdxYRzB2s+BkYqQvYCqOUv9PXx5SzUBd+OVqw/2gp
SZ70js0/A8BV3o7DRuAR9qpkqFN6zmavTE+lpL7qm339BK/KeRQtUEulWiDOuB22
xUPMY6g/JXKQTTNfVHfIyUny/HPF/2Z0g1kpcHWqjgr5dj9wVb9ZojCT+1HyYqbW
eUbUa36TU0bLBYB5Mqkp
=yxvz
-----END PGP SIGNATURE-----

--YtwIoJiYGqRe7tYH--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

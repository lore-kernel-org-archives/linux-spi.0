From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: clps711x: Remove duplicate code to set default
 bits_per_word and max speed
Date: Thu, 13 Mar 2014 09:52:57 +0000
Message-ID: <20140313095257.GJ366@sirena.org.uk>
References: <1393773858.4044.12.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="451BZW+OUuJBCAYj"
Cc: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1393773858.4044.12.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--451BZW+OUuJBCAYj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 02, 2014 at 11:24:18PM +0800, Axel Lin wrote:
> In the implementation of __spi_validate(), spi core will set transfer
> bits_per_word and max speed as spi device default if it is not set for
> this transfer. So we can remove the same logic in spi_clps711x_setup_xfer() and
> spi_clps711x_transfer_one().

Applied, thanks.

--451BZW+OUuJBCAYj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTIX/2AAoJELSic+t+oim9yQwP/3Zh1viaAyikZBokPIKNNbfg
z1JZPmkk6YTjt/XEwuJEAH6m7sMWh24lbT0sDnxH3+ioP4p3w4ZoHEW7NRgbrW54
LQilaZSjbf8+RzhJx26sksKjr+RQgqGvELm3eHrRf6xJbbcAp3wSLm5vwTUoTnJa
0KXjZpp5NDslPs6PCYjuTIri1Azvo/2NisaORNLTWZLKQIHdiNSqO95WoWr9UL/t
oyr4C+vg1iARZcwjnohmCz1elwJVRrp1TpVPdQFUTWzAFbtzFBxFpPCfD/LehRUl
YKyyeR1eBSTlT0skB0l74PSRaMv8h1IVkcF9zGSo1gr7zHo+4UGLov2E0SbyNO1H
DA5XjAsw0qrb5cyA0TJOTxQ/fKX2zMAwXYEpfZXDvywwTskkoOVeQ7dgm7Z3kr0C
jZmgySKesS7BESuKTaPwBDQHfdL04vxL3hMh5+smcsKalb+7KAkZvZ08jKxHyFCp
mLkS9Z8VUvsu9REufCvzPsj16DMeg8h2abeZv4lOH/bwgtrxQUrijnSySJFOs32w
nnBsLw92N+KXFlGj4D9i/ZcLzhm66yhwuv30slPjs1lSgXdGD/X2ObC9b7kmUcmK
lot9yz4G9yz9S9fhykM3E9kSstvYraQy5C1QYdCVmb9xLpM67p4MN1CIn/j8c8SK
R50SB3WIu+VK+lM/smGj
=bcEg
-----END PGP SIGNATURE-----

--451BZW+OUuJBCAYj--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

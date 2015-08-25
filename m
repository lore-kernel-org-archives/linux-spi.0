From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/3] spi: fsl-(e)spi: simplify cleanup code
Date: Tue, 25 Aug 2015 18:45:08 +0100
Message-ID: <20150825174508.GF12878@sirena.org.uk>
References: <55D9BAE1.1030306@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hUH5gZbnpyIv7Mn4"
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55D9BAE1.1030306-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--hUH5gZbnpyIv7Mn4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 23, 2015 at 02:21:53PM +0200, Heiner Kallweit wrote:

>  static int of_fsl_espi_remove(struct platform_device *dev)
>  {
> -	return mpc8xxx_spi_remove(&dev->dev);
> +	return 0;
>  }

You should be able to remove empty functions like this one.

--hUH5gZbnpyIv7Mn4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV3KmjAAoJECTWi3JdVIfQcG8H/0DM4APoBqZwJHjB/wEAfBSw
+refStVtli53l6XfVkWuh0XPR1yY7HXBtRuW33zJSKQhfBVRkOwDmrFXa/HGTUyR
9w1ChXas2iDPerjGXSWolSkE3UGdJh6W2KgYsu4wBy6uOa+kmo+F/l+FTewOyUcQ
pQcoayfZ7dXOQtdcklgmxsWGiW+oPJ9lT+2G4lnY8XDUO/EZBxx2BAYsItT9EvnP
s/zrhq2CVKC5abiKoDveSqnEtlg3cKqMqlLEH75/prGs0svQfgzBuOwdQksjnuLf
2Vm+zexTF7R57Ch+brZX7vFR5WwIeqhGljIvJDRx02oQhYE0R+UdIKAazc+hZtQ=
=jkPP
-----END PGP SIGNATURE-----

--hUH5gZbnpyIv7Mn4--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

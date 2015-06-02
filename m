From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: expose spi_master and spi_device statistics via
 sysfs
Date: Tue, 2 Jun 2015 21:02:02 +0100
Message-ID: <20150602200202.GM14071@sirena.org.uk>
References: <1432574909-2326-1-git-send-email-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3TQuZyvpu40ebvIM"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1432574909-2326-1-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--3TQuZyvpu40ebvIM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 25, 2015 at 05:28:28PM +0000, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org wrote:

>   * bytes_histo		transferred bytes/spi_transfer histogram

To repeat my previous review comments: the sysfs ABI requires one value
per file and a histogram is not a single value.  To further repeat
myself either remove this or export it somewhere more appropriate like
debugfs.

--3TQuZyvpu40ebvIM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVbgu5AAoJECTWi3JdVIfQHdYH/3yP7PTy3x9xNeTkk1jMQEsR
MgMTyAYlfdLvrFgq5S9PTpA8jFIZA2e9xy+KrwKRmlcUsyXOuku9iUTue/tVZuZz
x/QM4oEccsHL8tGFcXo2ewfVcE/13rUPQRRBPCEz1csu5gfLRoF7FUJOPXSbRn6i
Cr8dFdRAQoIwphGgaZYX5S9ZIM6XJH5d12WKotk0kzfM2FkSs/RAMDOX//rYJ58G
aZ1yG7WE6rKMJ9w8LRacJfMqjPA+d7OW4fa4xiIcPWlXFztmOLrt+EIo2AXUav4l
ULS7uXWCOswxlEbBOSqVMF+uTON6SeNvx17U9XGIJrbS/g1uR5cYpU5g+Ky4DRs=
=/YtD
-----END PGP SIGNATURE-----

--3TQuZyvpu40ebvIM--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

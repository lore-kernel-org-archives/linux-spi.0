From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v1 1/1] spi: dw-pci: correct number of chip selects
Date: Tue, 24 Feb 2015 16:59:45 +0900
Message-ID: <20150224075945.GO6236@finisterre.sirena.org.uk>
References: <1424706954-6055-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aE2Tjr+Wh4rS13mJ"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1424706954-6055-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--aE2Tjr+Wh4rS13mJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 23, 2015 at 05:55:54PM +0200, Andy Shevchenko wrote:
> The commit d58cf5ff6500 brought a second controller to the list of supported
> devices and changed a number of the chip selects. Besides the previous number

Applied, thanks.

--aE2Tjr+Wh4rS13mJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU7C9wAAoJECTWi3JdVIfQVckH/08E7nb0cQxPUrGiJ8sRSDKF
B1NmwGMEgXchl8FcR3SR9A0C5TJc/XqSN4G731sLzmeU/sXmAjvuPMrRfuGg6QEs
D+g5CKLv/R30lt4o87x3qYQzfr/dvowlwzayLT7UUnevcTlCHvDZTDCyR3G9L1Ia
3/RyQwamsM5wHOx2hWwMG1U3j2tUZNmIE8GeOVzfTyip3+77cNeG3YvSi0AA39dG
S7NeDdLTcolhiVS+8FRan0tlMMA2gGf5krPfUtbvwJemfhx6J48fBUHVcqgUB4B/
uOE9zzLfTKzdfnojPDTM0ioRD/nMHNpPKz8paeBqhpcqkhp6ahxsnQZrilsSRwQ=
=DYbf
-----END PGP SIGNATURE-----

--aE2Tjr+Wh4rS13mJ--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

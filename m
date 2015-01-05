From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/2] spi: dw-mid: fix FIFO size
Date: Mon, 5 Jan 2015 20:22:02 +0000
Message-ID: <20150105202202.GP2634@sirena.org.uk>
References: <1420213732-5141-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yEbVe0JFHWhrOjGA"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1420213732-5141-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--yEbVe0JFHWhrOjGA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 02, 2015 at 05:48:51PM +0200, Andy Shevchenko wrote:
> The FIFO size is 40 accordingly to the specifications, but this means 0x40,
> i.e. 64 bytes. This patch fixes the typo and enables FIFO size autodetection
> for Intel MID devices.

Applied, thanks.

--yEbVe0JFHWhrOjGA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUqvJpAAoJECTWi3JdVIfQ2ykH/0uglbRu3MFU268T+hn6CeYc
Ej2fbzmCPV+axZ8kNwd20zdLepwVDlW/n4BKA+83B00cTP0ASJR/fhNKViKAbWKA
CSRDqDx//i91Ucy8Vzt/Byv5dBHdY3p1VSIEUgmyzohQX7W31sF6zBJERXTKnXac
RuksBz86OIAUAO/GsGI2K+WtbCFs0MEkbGGLwFU6WRz8gpaQmlkCp8x/2UvyGjlF
E+iVkAlejQ5OAehkRqYDQFLJsward/ptUHULOMq5mT4hcevoNVntKjXYpSUjRd/N
MFODM5FFaL3LI0Zq1FSRbFMOajUxl6JR4qg7RHH0udlXp8GwPm+yur0iE+kWoAk=
=lNGX
-----END PGP SIGNATURE-----

--yEbVe0JFHWhrOjGA--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

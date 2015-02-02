From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: spidev: Convert buf pointers for 32-bit compat
 SPI_IOC_MESSAGE(n)
Date: Mon, 2 Feb 2015 19:57:32 +0000
Message-ID: <20150202195732.GB21293@sirena.org.uk>
References: <1422643413-21796-1-git-send-email-abbotti@mev.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="K7b+kcdw8zLASv/V"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ian Abbott <abbotti-GUHe90Wt2aFaa/9Udqfwiw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1422643413-21796-1-git-send-email-abbotti-GUHe90Wt2aFaa/9Udqfwiw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--K7b+kcdw8zLASv/V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 30, 2015 at 06:43:33PM +0000, Ian Abbott wrote:
> The SPI_IOC_MESSAGE(n) ioctl commands' argument points to an array of n
> struct spi_ioc_transfer elements.  The spidev's compat_ioctl handler
> just converts this pointer and passes it on to the unlocked_ioctl
> handler to process it.

Applied, thanks.

--K7b+kcdw8zLASv/V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUz9arAAoJECTWi3JdVIfQeBYH/ivy+qbent4nXm/7PzRf6d4G
F7r3HcXGQiHKzcQ1lG91nJqWzTXj20/WmDbvGAMPvqO3EYwnWOeNwmwgAxMFj4PR
6mxgATu1RwZTn6E+Q4dcEb762i/s1PEl607khvKgtgqwsI8hLxQmYTV1a7tjDgvQ
swG1JYwO5PisYh0iw26pPTmjDdE0KkoWoprUxIhjaGMTkrdc4lD1vSueWbsUgLdU
ohUH+nZRUUgQZ6QtE6/wBMFWGdfTtiXSipVLONWGVt1AhyqUz7nac7LPKVXseH0X
8cqiM7R4h81AXi7YqvV4iBzMYfP77gK4eeW8HVAjUrsSSkUIfh60qkog9w89gMo=
=opkR
-----END PGP SIGNATURE-----

--K7b+kcdw8zLASv/V--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

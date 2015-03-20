From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V2] SPI: BCM2835: fix all checkpath --strict messages
Date: Fri, 20 Mar 2015 18:05:01 +0000
Message-ID: <20150320180501.GQ2869@sirena.org.uk>
References: <1426755714-28130-1-git-send-email-kernel@martin.sperl.org>
 <550BA8FE.7030001@wwwdotorg.org>
 <7727F65E-D8BC-4299-A359-56FA449C3379@martin.sperl.org>
 <20150320134053.GN2869@sirena.org.uk>
 <78137BE7-37A4-4144-BBCC-CBEDA70DD31A@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Gl2oMwHnV9aOxBMt"
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <78137BE7-37A4-4144-BBCC-CBEDA70DD31A-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Gl2oMwHnV9aOxBMt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 20, 2015 at 03:26:11PM +0100, Martin Sperl wrote:
> The following errors/warnings issued by checkpatch.pl --strict have been fixed:
> drivers/spi/spi-bcm2835.c:182: CHECK: Alignment should match open parenthesis

Applied, but please use subject lines matching the style for the
subsystem and don't bury new patches in the middle of existing threads
- both make it hard to find and follow things.

--Gl2oMwHnV9aOxBMt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVDGFMAAoJECTWi3JdVIfQ1gcH/1ARJXwt8G29s3hDvVKlOi+w
ouiwkhg913HgHrQt+xw+QO2+qVPI1OZZJwmoZ2csYqzIkOXtz3CXFADeWNkc8rYL
V4vUiE+k+2C5+jXo/6PgFrMtmsgewea1y1j5FGfeEMX18yMbH5bPQZN4WEFhcich
6xbMXjE2vjemETtCeocc3h7FsYMSTA2QcV+B1ESV18/NVVWiruQ92JgDQzQkqqle
8//SCjYyuChhayyUV/T0Ab0C1oy16v8O7tOLyWs19a77PXb6ejpWxP9hzw0MDj+w
lVMwqYAK5AJR96EemGQzcNNf7rhokhmAbYCnRoL4Z315BdHfv9wvJppvM4Tguts=
=Nxzw
-----END PGP SIGNATURE-----

--Gl2oMwHnV9aOxBMt--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

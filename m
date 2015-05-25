From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V2] spi: add missing cleanup in spi_map_msg on error
Date: Mon, 25 May 2015 14:05:52 +0100
Message-ID: <20150525130552.GT21391@sirena.org.uk>
References: <1432460086-2549-1-git-send-email-kernel@martin.sperl.org>
 <1432548630-2202-1-git-send-email-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UNrMg7q4I5bA1PGX"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1432548630-2202-1-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--UNrMg7q4I5bA1PGX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 25, 2015 at 10:10:29AM +0000, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org wrote:
> From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

Please don't bury patches in reply to existing threads, and especially
don't send streams of multiple new patches in reply to each other at
once.  This makes it harder to spot new patches and confusing what's the
current code intended for review, you end up with a jumbled mess of
possibly related things some of which superceed each other.

--UNrMg7q4I5bA1PGX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVYx4vAAoJECTWi3JdVIfQ2XIH/0oCI+6nvUgp1fRAQ0VOOyFa
keLxjp9lMfgwJ2qNW6IbkJPQ7/+tRosVe+j0TgVLhAndTtVWjaZ6tEZQiWQv7Y11
aS8VTBMFio6R/2z0AqCVgmTwGE4MyOF+kvaEiSyLm46TUUiHn7KLC7kPuAAY/or1
wpBwODLno4zo98W4PcPcf3ygY8nZlFQlV1FCQnpGenhvlm0LICCNN4DyYMumG3G4
VAc/fqVxA1mmy8ZWagN5jAarvsBob+68J7ilyPemMw4C274D0ZmbESsGeqWXy5/4
raB3mrJfklQ4BiD0E17TarpGyNbmGQbOj/Kn+Udpghk2bTxxsTRcZCahGHFZ+Wk=
=Cib4
-----END PGP SIGNATURE-----

--UNrMg7q4I5bA1PGX--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

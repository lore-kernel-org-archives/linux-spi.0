From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3] spi: bitbang: only toggle bitchanges
Date: Sat, 18 Apr 2015 18:16:17 +0100
Message-ID: <20150418171617.GZ26185@sirena.org.uk>
References: <20150331202306.GX2869@sirena.org.uk>
 <1428922770-16955-1-git-send-email-m.grzeschik@pengutronix.de>
 <20150418120926.GL26185@sirena.org.uk>
 <db1d2b9a-730b-40a5-a4f6-091fd3fad0e7@email.android.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DHd0DHvhbdljNSqO"
Cc: Michael Grzeschik <m.grzeschik-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marc Kleine-Budde <mkl-96ES3uSCik0DzuLLRaFpuw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <db1d2b9a-730b-40a5-a4f6-091fd3fad0e7-2ueSQiBKiTY7tOexoI0I+QC/G2K4zDHf@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--DHd0DHvhbdljNSqO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 18, 2015 at 03:18:49PM +0200, Marc Kleine-Budde wrote:

> IIRC we had a reduction of about 30% when programming an FPGA via SPI.
> But Michael can give you the exact numbers.=20

OK, that's definitely worth writing home about - putting that in the
commit message would have helped a lot!  I've applied the patch.

--DHd0DHvhbdljNSqO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVMpFgAAoJECTWi3JdVIfQvmoH/30fdCWwBQbqci52vAZE9ZqV
e7oPY9DQf2QZN//wlIlnPUNBXhiruvZd3828RHVuMZUlbMsqJiV+km8D8XtHVzPy
+awKyK3YS6PegR2/Z4THIbd5PDJWu7NFlQjjnumzInROxjA3659sjPPk5ldf84+l
kjFD+FnqBui5q/FMNkm39lKoZe0qb6xP9IjgzY7aZN8B3RjfOuRSD5B0vnQEKG48
i3YYwxkXKoWgu0zkI+DYmE1JN8a4eGEGSlp36FMTaIRc1vCtjxEAFuR+NPgambun
Wy7Q2gHKnNcRy/v3YVfvJDUwAkcP6B6YmYm2V67rafKRBsPJc30vkNMM97XXDg8=
=5n+w
-----END PGP SIGNATURE-----

--DHd0DHvhbdljNSqO--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

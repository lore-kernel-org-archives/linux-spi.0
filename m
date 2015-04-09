From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] spi: altera: Add empty implementation of
 setup_transfer callback
Date: Thu, 9 Apr 2015 17:23:30 +0100
Message-ID: <20150409162330.GB6023@sirena.org.uk>
References: <1428591822-24279-1-git-send-email-per.nilsson@xelmo.com>
 <1428594853-24640-1-git-send-email-per.nilsson@xelmo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aCwlqFmHKtryFr1f"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	nios2-dev-g9ZBwUv/Ih/yUk5EbOjzuce+I+R0W71w@public.gmane.org
To: Pelle Nilsson <per.nilsson-5TWeZ6kPplYAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1428594853-24640-1-git-send-email-per.nilsson-5TWeZ6kPplYAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--aCwlqFmHKtryFr1f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 09, 2015 at 05:54:13PM +0200, Pelle Nilsson wrote:

> present. It was therefore an error to remove it in commit
> 30af9b558a56. This patch simply adds back an empty implementation of

Please always provide a human readable description of commits as well as
the IDs.  As I said in reply to your previous mail why is this the best
fix?

--aCwlqFmHKtryFr1f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVJqeBAAoJECTWi3JdVIfQ5FMH/0GjC6cXPl9FKHixNdS88Fy7
BiHOJZm7TcD7gzKISy35U1m0WWq7a6LEtA7F9dzAxc2ZKfn8HV5N/Q5Goxj5Cte8
tCzE9R0IjFV+2XgCTR5WgxykoFqle4lqFYpvVVErlMIfLKYgTcUFKGhXY6IUZn5T
61uoeb23elJBEfX3usnGcCppwkyCa+P6JpZFxln+Vpf3EWCYOW6EM4AEnVkmayu9
7kdQ8Qz57tNTpMUK4jLSKl46Xy9mjR5mmzDxk2V0A1oBIJitbFmqNdupQa3mXpW/
bToZsqiQs63Bu7VuGmDMttOYYYdp1TApkNy4FkoiOXHst7Bn25Yf6n75JFBn3Zc=
=srpu
-----END PGP SIGNATURE-----

--aCwlqFmHKtryFr1f--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

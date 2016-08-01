From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/2] spi: octeon: Split driver into Octeon specific
 and common parts
Date: Mon, 1 Aug 2016 18:36:47 +0100
Message-ID: <20160801173646.GX10376@sirena.org.uk>
References: <20160728083144.16625-1-jglauber@cavium.com>
 <20160728083144.16625-2-jglauber@cavium.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gu8wNMO+QVC0jLZM"
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>,
	"Steven J . Hill" <steven.hill-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
To: Jan Glauber <jglauber-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160728083144.16625-2-jglauber-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--gu8wNMO+QVC0jLZM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 28, 2016 at 10:31:43AM +0200, Jan Glauber wrote:
> Separate driver probing from SPI transfer functions.

This doesn't apply against current code as an earlier version of it was
already applied.  Please don't resubmit already applied code, please
send incremental updates against current code for any changes that are
needed.

--gu8wNMO+QVC0jLZM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXn4itAAoJECTWi3JdVIfQM4kH/3hWqr9bAgzRi60pcr2fjC0q
wdKM613vOqFvOLO3eA/ctXFWY3nUPv3HNOSzThI68RYg9ltPnviexcXnQVDBfmKV
lsmpaXzDGdit5KPgCHM89tGOIMQ++n4Kjw6s1CYR2RYyn8Q0y2gyeyCfOHcajG6Q
kuDJGXcebMIa8pr4o2qU2rBKOuJhLGANPxqLSckV+hkvDsTX5ucellip0aTCYhnA
Od2vVMClnUBUFWio1txTW+7x8vhGgE/Db01JGixWuvQc7jNW4niyFJG1ukDIRpqy
brHAEwSs8gVi1ikN9RiYKasy6iFnRKsgbqrtdC7nmgav1rK04+c1MJmmSvrRZiA=
=GiuA
-----END PGP SIGNATURE-----

--gu8wNMO+QVC0jLZM--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

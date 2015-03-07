From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2, resend for stable 1/1] spi: dw-mid: clear BUSY flag
 fist and test other one
Date: Sat, 7 Mar 2015 11:22:38 +0000
Message-ID: <20150307112238.GK28806@sirena.org.uk>
References: <1425645721-18142-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RVlUGXxwBj5SDcM9"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1425645721-18142-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--RVlUGXxwBj5SDcM9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 06, 2015 at 02:42:01PM +0200, Andy Shevchenko wrote:
> The logic of DMA completion is broken now since test_and_clear_bit() never
> returns the other bit is set. It means condition are always false and we have
> spi_finalize_current_transfer() called per each DMA completion which is wrong.

Applied, thanks.  I assume you're also going to resend the other bits if
they're still valid?

--RVlUGXxwBj5SDcM9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU+t99AAoJECTWi3JdVIfQrOQH/31bd+2fVhfBMETTvi7tQRD1
ORp2QKuH/+7gdtBgXQcw2AbEGVaA8M2ignZqk817WCN98AkaN0e+gpPVCyHXdj7B
xbXWKrgsnlAX5cDKdGhLHwa0nAy06mJWSX+p2I7fGwshxA5IP1wzrb4cP3Wm+Mim
wMDNnw+EkpEmhgYw2ArVzUU8uabAvXtRnA1aqf/uK404IGCLR0P3oJ4xlNRropGU
NM/7STHyxWoQ+IG6iJCqJF59U9dtTXPnF5yogGIa60XIYZMGllR+JJHoqe+VNnb2
gwmxODgvJA7T5+mgjvtgaBcEE0Y1C1bU+IBs2nCmtsUX6Msj9fTvfGMCphC11uU=
=3S57
-----END PGP SIGNATURE-----

--RVlUGXxwBj5SDcM9--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

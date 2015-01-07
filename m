From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/2] spi: dw: amend warning message
Date: Wed, 7 Jan 2015 18:01:17 +0000
Message-ID: <20150107180117.GF2634@sirena.org.uk>
References: <1420642615-8986-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RqgulncRPyAsfmIg"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1420642615-8986-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--RqgulncRPyAsfmIg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 07, 2015 at 04:56:54PM +0200, Andy Shevchenko wrote:
> In case of warning message in ->probe() we have to use HW device name instead
> of master because last is not defined yet.

Applied both, thanks.

--RqgulncRPyAsfmIg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUrXRsAAoJECTWi3JdVIfQ23MH/1RUG59d4bUELWyVEIQ47OQx
BHBskdyi3RnA8RoC/btCBlXmnC3r1QAiOa4M+/f9hl5o39ZLUnUZtl5RJGmoc1er
b06/ssI4JCSFwsoi5vYBANkJygUxODSmfVTSGBsYqJwzKncKjS8odM9KXnpBD32T
zmPgNdLkT2ImzVR0+BRoMQ/eDAOwijXQh0iK56KGp/d0h+Wk/VpzoNkEo4yQ2Znf
Pgtbvi5eMRYTUjM+8TqSnSDF3jZr28k00XTVa69K3Sjz5mlcGrGLkUYqhT+THFSM
lwv70leqT86JJNfSY77Ul/KazKCaRQCGxez/X/8AdSpqaYq2W7/GKNdaVC7g7dw=
=kL/3
-----END PGP SIGNATURE-----

--RqgulncRPyAsfmIg--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

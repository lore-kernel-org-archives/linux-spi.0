From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 2/3] spi: dw: program registers as soon as possible
Date: Fri, 6 Mar 2015 20:33:56 +0000
Message-ID: <20150306203356.GG21293@sirena.org.uk>
References: <1425301137-8043-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1425301137-8043-3-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="u9kn8DSmHPCeTdEy"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1425301137-8043-3-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--u9kn8DSmHPCeTdEy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 02, 2015 at 02:58:56PM +0200, Andy Shevchenko wrote:
> This patch refactors the code in pump_transfers() to reprogram the registers
> immediately when we have a new configuration data. The behaviour is slightly
> modified:

Applied, thanks.

--u9kn8DSmHPCeTdEy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU+g8zAAoJECTWi3JdVIfQ8CkH/3PouxFEWKFY2PeG9i1JuNUZ
ojG5t56m0FAi2bdk4YxHjpc+c+eisMxCgmdN4rLMb79EMxra8Pnv2PvOEozb8L3e
E6tuF1a8n4qc57xSE9tsdkqUJIiZYTrefHniWuYyV2GBqWRt1AmuqcLdm8sEQHRg
aKMVjOpmExV6r5E7QqDoxqeN1WklSSbBszLV+f5WqlfMBW4lPWs52AaFY22EdB94
oeTcXcBXsZ+DXYNU2CM0OhC3YPuGFcuU+N8S0AMOgacnqLxte5NCIY2muv/8Raul
IFV0qSa4dvmArKBtGW/YvqxAJUGXg5MpOjibLE+/5cSepN9Y1HUZYYCgsgCuv4M=
=a+3S
-----END PGP SIGNATURE-----

--u9kn8DSmHPCeTdEy--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

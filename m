From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v1 5/5] spi: dw: move to SPI core message handling
Date: Tue, 24 Feb 2015 23:45:15 +0900
Message-ID: <20150224144515.GM6236@finisterre.sirena.org.uk>
References: <1424777534-14246-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1424777534-14246-6-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="M70YYmmjmThh04Jd"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1424777534-14246-6-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--M70YYmmjmThh04Jd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 24, 2015 at 01:32:14PM +0200, Andy Shevchenko wrote:
> This patch removes a lot of duplicate code since SPI core provides a nice
> message handling.

This looks good modulo the issue you identified BTW.

--M70YYmmjmThh04Jd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU7I56AAoJECTWi3JdVIfQhIoH/3deq8VcAbxpqMQ8Em+GtVlL
PM8tWuQ4GL45B+7J/o44mTaIIL43P2sRO64QFsnt0yVEmMlutTrxvALMfTgxgQvr
REjICrwe16X8JeimFSoGgo7Y5HE7HgLnM3476pm5W49vC/UlKA9JrnmMdCOKnR0H
1IfYFF3f+60JRL3zWi9OSO/VOjK3/tKviqTtc7LIeJyzIAFG3FYjuxQVFO4V7jS2
yDPZ9/200OId3Mrh8qtmK9LuvnpnUoRJk5K6ZiRK3bAjM6r2H/FfxfiYLeoNGHg9
MWUlif8O38IWFMxDN7Y6Z+BeNhIeJZRXOjJJNlO1JUU1cYn3NhcedGDjN9dtJxs=
=BlfY
-----END PGP SIGNATURE-----

--M70YYmmjmThh04Jd--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

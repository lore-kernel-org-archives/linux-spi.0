From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v1 1/1] spi: clarify what driver can do with
 message->status
Date: Tue, 24 Feb 2015 22:24:11 +0900
Message-ID: <20150224132411.GF6236@finisterre.sirena.org.uk>
References: <1424772249-9676-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yuedfix5hmtMJRO4"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1424772249-9676-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--yuedfix5hmtMJRO4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 24, 2015 at 12:04:09PM +0200, Andy Shevchenko wrote:
> Currently it's unclear from the documentation if an actual driver may or may
> not override the message->status field. It seems there is no other way to
> indicate an error when transfer is failed, e.g. when gets overrun or underrun
> interrupt. The patch states this clearly in the comments near to field
> definition.

> +
> +	/* The actual driver may set this field to indicate an error, e.g. -EIO
> +	 * for failed transfer. */
>  	int			status;

Let's take a step back here: what documentation are you looking at which
says anything else about status?

I'd also expect this to go with the other kerneldoc for the field.

--yuedfix5hmtMJRO4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU7Ht6AAoJECTWi3JdVIfQ4QkH/08EPt2ZR3UyQHC/zIHx2tNc
ZiSmoc37+q7KJuAI2AMvnjDYJq73QyjoazCSjMOwA+GD2LwG/2qHNr/61qXNbypT
V4LCrFoa7gnuXhOwhq0qUa4wWEHrdT9FSco36++oeQIQehauWUcJk+6uO4+mrUW1
EhOMK2DUXi6L0Hm6RhQ4n+jPufqAlr0T9Q93gGsbuWKzEdesWEdLtMzh+wLQH4aG
JoIPyZNwxloOC86uBMNDnzzLoj1rUWti1A/CRZ+LD2OaXCTTG/W+RXKCYZZYS52Z
J1f6cmRGbkTHifsfWmeC5iSJu5G3U19q1HAS62eA+4d1B4JDpF/VGK1OOr1j2ag=
=Ty4p
-----END PGP SIGNATURE-----

--yuedfix5hmtMJRO4--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

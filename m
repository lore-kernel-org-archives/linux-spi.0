From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V2] spi: bcm2835: enabling polling mode for transfers
 shorter than 30us
Date: Wed, 15 Apr 2015 19:58:24 +0100
Message-ID: <20150415185824.GU6023@sirena.org.uk>
References: <1428340592-3196-1-git-send-email-kernel@martin.sperl.org>
 <20150410185132.GU6023@sirena.org.uk>
 <F35B7C71-1917-40AE-BA42-CB3E63B877EF@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="J3ka6RmEn/3843Zy"
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <F35B7C71-1917-40AE-BA42-CB3E63B877EF-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--J3ka6RmEn/3843Zy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 14, 2015 at 04:29:49PM +0200, Martin Sperl wrote:

> Approaches I can think of to solve the issue:
> * accept this fact as a reality - drivers should be able to handle
>   such situations in a well-behaved manner
> * remove polling mode completely from the spi-bcm2835 driver
> * remove the timeout code when polling
> * make the timeout a warning
> * set the timeout to something much longer say 200ms
> * stop the system from interrupting (either scheduler or interrupt
>   handler) for the next 30us or the calculated timeout-period.
>   Maybe by holding a spinlock (or similar) / disabling interrupts /
>   ...?
> * others

> So the question is: which approach should get implemented?

Running without a timeout doesn't feel safe - the standard thing here is
to busy wait for a short period then fall back to something that sleeps
if that times out.

--J3ka6RmEn/3843Zy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVLrTPAAoJECTWi3JdVIfQ09gH/3Q/+KYksSGr8T+2kicleJ60
9WQGaFv1QNChe+j/RH3Y7Y7FudLkTy5pJSpJhyanw9wN/Fh96koeZ07jaTMoRsUF
gSUjZUzPm67aA4JIWtVueeRPzV1G4LjQRu0Esd00KfrM+NyrKD1ehBZzujEEF0BX
yS7i4jMD8xeDFR15BOxVSbnwTGOhJmjYiq/dCOjsrjhRLdFY3GZDIY27kBsoMajv
rgSCm0REZ+BhEftjVNALo8kCp06w44SbT/d2OPOtE0BHURxPWNpc1zQQVBDWyRCf
nPi/p3ZgQI0pxtQos+QDucfFpl8mjX3AP0wI7bSdhTifZ4gpZRh79sWGkP0t/18=
=V+PE
-----END PGP SIGNATURE-----

--J3ka6RmEn/3843Zy--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

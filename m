From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH resend 1/5] spi: bcm2835: Add GPIOLIB dependency
Date: Tue, 5 May 2015 12:16:46 +0100
Message-ID: <20150505111646.GB22845@sirena.org.uk>
References: <1430778649-28126-1-git-send-email-linux@roeck-us.net>
 <1430778649-28126-2-git-send-email-linux@roeck-us.net>
 <20150504233421.GW22845@sirena.org.uk>
 <55480894.3080200@roeck-us.net>
 <55482457.2020005@roeck-us.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tRxlveiQ0HuQS2ZK"
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55482457.2020005-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--tRxlveiQ0HuQS2ZK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 04, 2015 at 07:00:55PM -0700, Guenter Roeck wrote:
> On 05/04/2015 05:02 PM, Guenter Roeck wrote:

> >not that it matters, but this is the patch in linux-next.

> >I am aware that several other patches have been submitted to fix the
> >problem (I think I have seen at least two); after all, I submitted the

> Follow-up: Since you accepted one of the other patches, please make sure
> to remove my patch from your -next branch; otherwise we might end up
> with dual "depends on GPIOLIB".

*sigh*  So, what you're asking me to do here is remove the one that's
actually been applied as a bugfix for Linus.  Are you *sure* that's what
you think that's a good idea?

--tRxlveiQ0HuQS2ZK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVSKadAAoJECTWi3JdVIfQhx8H/2MZ2zyArdjTl6g6WJ46UKJN
uQEFj8HQKYGEWQg1SlM2yuEAg9bdWGF8yGFue0YWX3pP63G6iDtHf6qeWjRq2QhC
M/968jUxLQZGJaRTdBk9PBbyn5rdyKto+MC+DT/Tiqn4E174O9aGnCMfqnIr0Ibf
VahSqWFFYUHywhb3o8icDH8zn8+9zhiimK2a3RkOSpCM1KfveOtbRTxlsF46rTJ2
A5mFXQilyI3pi/p0txo34CI0duDxNbosavz9HORAUciA1Y58CXTWmocP84J6QbS/
5LZHO5PrpJFckmHqnA/li5CCv1fWT1QlyZFgf7lc2SBDmKMpBCCDxyn0hHopnQw=
=bpgZ
-----END PGP SIGNATURE-----

--tRxlveiQ0HuQS2ZK--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

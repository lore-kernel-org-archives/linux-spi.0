From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: trigger trace event for message-done before
 mesg->complete
Date: Thu, 19 Mar 2015 11:24:30 +0000
Message-ID: <20150319112430.GP2869@sirena.org.uk>
References: <1426674448-8246-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20150318113635.GB2869@sirena.org.uk>
 <20150318133226.GR10068@pengutronix.de>
 <20150318135854.GI2869@sirena.org.uk>
 <20150318144854.GS10068@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="D3I0HgOdJ5+6n+7I"
Cc: kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150318144854.GS10068-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--D3I0HgOdJ5+6n+7I
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2015 at 03:48:54PM +0100, Uwe Kleine-K=F6nig wrote:
> On Wed, Mar 18, 2015 at 01:58:54PM +0000, Mark Brown wrote:

> > My point here is that the analysis of the issue shouldn't depend on
> > spidev in particular, if you need to call out the specific driver you're
> > working with that's an alarm sign that it's doing something weird and
> > perhaps the problem is with the driver.

> This just happens to be the driver I saw the problem with. Don't have
> another spi device on that bus to cross check with other drivers. I
> wouldn't be too concerned here.

Sure, but it's better to write it up in terms of a generic driver - it's
the difference between "let's work around this driver" and "the core
isn't doing the right thing for drivers here".

--D3I0HgOdJ5+6n+7I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVCrHtAAoJECTWi3JdVIfQ2NkH/04maO1uFBn5mpFggbzyuUWm
3oIY7FaYwc4QJKBWAkEUv0x/QvAcaiCA8PBYKFyirAdycu1iSOrI/2BKogu24tNA
zXQscdTOXQMe1v3XLJWhUB79OwFNQKXtMX/mNiFvhVO6W/xLhbwehhvZ/GXdvfcc
/mfJVMN8f5pXvB+OBGMILkDTInzEF/Wroa6NS3TgmaYKrhpMX1ctSt+X1saFSW6q
zw5LOe+uMeJF+t0r37vrjL9VTbw5w5Jb8AaSE9dP59ZNot4v4iPbcZ+QfgGEJvW3
HQ6q7AuBtgyWYzf40pjeq4TDIWQQxKPyszPFGrbHXUoIR8V6KUFxnSTQlzcHkGU=
=FVvE
-----END PGP SIGNATURE-----

--D3I0HgOdJ5+6n+7I--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

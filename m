From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: trigger trace event for message-done before
 mesg->complete
Date: Wed, 18 Mar 2015 13:58:54 +0000
Message-ID: <20150318135854.GI2869@sirena.org.uk>
References: <1426674448-8246-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20150318113635.GB2869@sirena.org.uk>
 <20150318133226.GR10068@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fckbADODYWZD5TdN"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150318133226.GR10068-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--fckbADODYWZD5TdN
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2015 at 02:32:26PM +0100, Uwe Kleine-K=F6nig wrote:
> On Wed, Mar 18, 2015 at 11:36:35AM +0000, Mark Brown wrote:

> > Applied, thanks.  I'm a bit suspicious that the changelog talks only
> > about spidev though...

> That's my workflow. Maybe the important thing here is also that I use
> -rt?!

My point here is that the analysis of the issue shouldn't depend on
spidev in particular, if you need to call out the specific driver you're
working with that's an alarm sign that it's doing something weird and
perhaps the problem is with the driver.

--fckbADODYWZD5TdN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVCYSdAAoJECTWi3JdVIfQLNkH/icYPSWoKuuNylpC8TzXOZDb
kcdh1GSF4f/MpNxfZs67FJZhspTq8LNCFDI1ekKy+/1sXLqWRI5iknOwiM6ZS9Es
ELEY/HZEdKAVBY1JLueq1AnumcGPr5W7JZLZH3JSJB/5jMG95Aq4LOVFFRFA5KMk
6K7sZFYd2A4i4JB7bKNRg6Zdq0ypCHezbUZWckoN0zkIhDEby0sz14Qqe3KWPyZ7
EyCtR9cElH/zzIaffMmGkyIeM90az7cw80qcjp16jwNiQFXnuI9U0nhQ7o06mOZA
TQzHzhQzwUfsHERaR+yW07LR0GCzigGR6k3W+mv696d1AmtmdmkIb52LrFZbYH0=
=iiEC
-----END PGP SIGNATURE-----

--fckbADODYWZD5TdN--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

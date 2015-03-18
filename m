From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: trigger trace event for message-done before
 mesg->complete
Date: Wed, 18 Mar 2015 11:36:35 +0000
Message-ID: <20150318113635.GB2869@sirena.org.uk>
References: <1426674448-8246-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JYK4vJDZwFMowpUq"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1426674448-8246-1-git-send-email-u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--JYK4vJDZwFMowpUq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2015 at 11:27:28AM +0100, Uwe Kleine-K=F6nig wrote:
> With spidev the mesg->complete callback points to spidev_complete.
> Calling this unblocks spidev_sync and so spidev_sync_write finishes. As
> the struct spi_message just read is a local variable in
> spidev_sync_write and recording the trace event accesses this message
> the recording is better done first. The same can happen for
> spidev_sync_read.

Applied, thanks.  I'm a bit suspicious that the changelog talks only
about spidev though...

--JYK4vJDZwFMowpUq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVCWNDAAoJECTWi3JdVIfQtE4H+QGVJRpdG2tCj2PK7jfJOmQI
D5GctIB3BquHHxvub9I5c5nGiyZ7g6RhtA+yLYLRRUMy4PQ3NgF7WoXnt9S/rvHI
xWDkpUid56ohrY+yvVEAZvvcoQlmGsVI1oSAFGvsf4kwjahZjvutqLnSxSM/slM/
cr/bRXgxtwOgHyonnVAnaEitKKwTB1fNe2GyVbImsmrSfxnjX1CdwCqQRkGnGNdk
zLJ1ELCvakzkUqka/6u3vu856fcz/xsW83DFv7JvPRrqlMQcxywtnkzT3HbemJWD
MH574DTtuoeAmXXhMmfsNRYqzJ+0q7Cj+eM9DV6/9Z/8lyvFTkqnZgMekOjDAqI=
=/yoi
-----END PGP SIGNATURE-----

--JYK4vJDZwFMowpUq--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

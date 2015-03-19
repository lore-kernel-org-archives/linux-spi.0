From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: trigger trace event for message-done before
 mesg->complete
Date: Thu, 19 Mar 2015 11:51:12 +0000
Message-ID: <20150319115112.GS2869@sirena.org.uk>
References: <1426674448-8246-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20150318113635.GB2869@sirena.org.uk>
 <20150318133226.GR10068@pengutronix.de>
 <20150318135854.GI2869@sirena.org.uk>
 <20150318144854.GS10068@pengutronix.de>
 <20150319112430.GP2869@sirena.org.uk>
 <20150319114842.GU10068@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FiqEyLLt06qkB6ow"
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150319114842.GU10068-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--FiqEyLLt06qkB6ow
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2015 at 12:48:42PM +0100, Uwe Kleine-K=F6nig wrote:
> On Thu, Mar 19, 2015 at 11:24:30AM +0000, Mark Brown wrote:

> > Sure, but it's better to write it up in terms of a generic driver - it's
> > the difference between "let's work around this driver" and "the core
> > isn't doing the right thing for drivers here".

> OK, so something like:

> spi: trigger trace event for message-done before mesg->complete
>=20
> The message's complete callback might (permissibly) free the memory that
> holds the message. As recording the trace event for the end of a
> transfer accesses this message the recording is better done first.

Yes, that's the sort of thing I was looking for - it just makes the
review a bit easier.

--FiqEyLLt06qkB6ow
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVCrgvAAoJECTWi3JdVIfQ/oIH/jFQvfkKbhj9OT5+LYQBkrCZ
YIwDCxPAwKeRwTSSDveAUwu3tIDBMiU3e0zEKeOqNZMpZvhdSgcl8q8nsM1xi3oN
t4bblLHbTFP8RRGEwoSZkMY1Bk9oQLE+1luet3/Potef4n3+vpCM3A0Y6TWFiIIG
d+8vvac/oEMfhrb52uEbh5FBNbMFG4CjmBHrhdYH5h1uhQ/Ft+nS10yE3ZIMV55g
i8CdrKmf+YBpWBVnZVHb2CI2yrT4UyvCC7ou0+0HMGXdVXEGoHdlId7qUx0zPgGf
n9OTri/Yg4yIxY3WplAX0S6HNcA9vnfP3rwUKlMf5NiBxHL1ioJ12nrs2PXEdBU=
=2WER
-----END PGP SIGNATURE-----

--FiqEyLLt06qkB6ow--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

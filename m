From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v1 1/1] spi: clarify what driver can do with
 message->status
Date: Thu, 26 Feb 2015 11:48:12 +0900
Message-ID: <20150226024812.GK6236@finisterre.sirena.org.uk>
References: <1424772249-9676-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <20150224132411.GF6236@finisterre.sirena.org.uk>
 <1424784807.14897.24.camel@linux.intel.com>
 <20150224141706.GK6236@finisterre.sirena.org.uk>
 <1424788527.14897.27.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kW8VbOAxhix4S1vC"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1424788527.14897.27.camel-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--kW8VbOAxhix4S1vC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 24, 2015 at 04:35:27PM +0200, Andy Shevchenko wrote:
> On Tue, 2015-02-24 at 23:17 +0900, Mark Brown wrote:

> > ...which suggests that anything detecting an error should report it via
> > status, no?

> Unclear. I dived into spi.c to understand if I could override or not.
> There are two fields status and state, the latter is dedicated for an
> actual driver usage, and that is clear. Many (old) drivers are using
> state as a storage for custom status. Newer drivers, that are using SPI
> core, mostly don't care about error handling at all (at least I didn't
> find an existing example of the message->status usage).

This isn't something specific to modern drivers, the status field has
been there since forever and is still widely used.  Almost all error
detection for SPI controllers (especially that's likely to trigger and
therefore have a practical effect) is timeouts and that's been factored
out into the core for the more modern drivers.

> > > > I'd also expect this to go with the other kerneldoc for the field.

> > > Any place that suits better.

> > Well, see above...

> Regarding my above comment can we extend the description of the field
> then?

Let's see what a patch looks like.  I am wary of documentation that's
too verbose since it can cause people to glaze over when reading it.

--kW8VbOAxhix4S1vC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU7olrAAoJECTWi3JdVIfQqbwH/1vvZww01umZqtbrKmFbfSmS
B+moUmiBoFlNaCxPt9EGWSxJv8JoewP/R8OSQpm7UhaV2q0FGtKCgnnlkuab9YCg
nFNBR1VA+vdvCmNgbJrSuvha9AwZmmbJcthgWEX+JAJVhq5JknPuwGdZg0N9/E1u
fPiRNHcDS6rGPK4OjUDHFBMb+1V/42j1HyrAbF8YdR0XXHo7zHYtpJ9JmY5qgKnv
PHblvwV5FkWOFc+FzIGZ4S1L16Kl8sXV9hHT9MNRdMvZeNKqATj3Y3zr/tXIc39D
dTDWBe7MTgNhAXY5g4Kc6BdVfYswYtUIj9ru86UuzZ8ty0FG+JmKl1YXf8ebZYQ=
=zHz5
-----END PGP SIGNATURE-----

--kW8VbOAxhix4S1vC--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

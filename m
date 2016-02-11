From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/4] spi: bcm2835aux: set up spi-mode before asserting
 cs-gpio
Date: Thu, 11 Feb 2016 12:27:36 +0000
Message-ID: <20160211122736.GH13270@sirena.org.uk>
References: <1455041435-8015-1-git-send-email-stephanolbrich@gmx.de>
 <878u2s2xym.fsf@eliezer.anholt.net>
 <20160210190204.GD13270@sirena.org.uk>
 <2743238.b2UJKq0efN@chaos-desktop>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Gs9iBZf6UKWgztis"
Cc: linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Stephan Olbrich <stephanolbrich-Mmb7MZpHnFY@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <2743238.b2UJKq0efN@chaos-desktop>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Gs9iBZf6UKWgztis
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 10, 2016 at 09:26:05PM +0100, Stephan Olbrich wrote:
> Am Wednesday 10 February 2016, 19:02:04 schrieb Mark Brown:

> > No guarantee that they'll not change, especially in a situation where we
> > have two devices on different speeds on a bus working at the same time.

> Are you saying, that between a prepare and unprepare there could be trans=
fers=20
> for another device? Then all the clock setting couldn't be done in prepar=
e=20
> either.
> Apart from that, if two transfers in the same message are not guarantied =
to=20
> have the same speed, this still needs to be fixed. I'll roll a v2.

There are two prepares, I don't know which you're talking about.  The
most common is prepare_transfer_hardware() which is used to power up the
hardware and may have many transfers for many devices before it is
reversed.  The other is prepare_message() which is called once per
message.

--Gs9iBZf6UKWgztis
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWvH43AAoJECTWi3JdVIfQNWAH/jj+uIwVJ13wK7Vx1KQOaul/
1KZktUoph6sQvA3g8g0ENPbpw2+67AmQ3WR0hnDBTk+GJ+jngS5mdtZrwAG5V+LI
5QK4yNidBO8INc1ikrYq4E7HztqbPPvuc5KzI/7Zb8S67jXXCjkR3gEf/ffisihY
ZX9UctmbVEvzoQt8/fMNiMMqJJOdxnuUCT0V4YmNsDmEZC9aeIJM8ng1AMbqs4r/
IJuDtQk8qiPrc4bAxF5QaGHl7z+xWObR9kHmnI0MAEoyDssLJp6RXN+IJA6ZGA8t
TzsGMSCTEwzernm2udNg2b+MHERWoAlr7w5S85JwtLJrvpS7Wvi6dbAZn8Xd2w4=
=5R4b
-----END PGP SIGNATURE-----

--Gs9iBZf6UKWgztis--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

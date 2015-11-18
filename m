From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: RfC: Handle SPI controller limitations like maximum message
 length
Date: Wed, 18 Nov 2015 21:57:55 +0000
Message-ID: <20151118215755.GL31303@sirena.org.uk>
References: <564CEB61.2000601@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Uus2/pBTyv0r7Av1"
Cc: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <564CEB61.2000601-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Uus2/pBTyv0r7Av1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2015 at 10:19:29PM +0100, Heiner Kallweit wrote:
> There have been few discussions in the past about how to handle SPI contr=
oller
> limitations like max message length. However they don't seem to have resu=
lted
> in accepted patches yet.

No, they've resulted in people writing code.  We've got a bunch of
things in the spi_master struct like the limits on speeds and bits per
word.

> Maybe a better approach would be to introduce a new member of spi_master
> dealing with controller limitations.

That's what we've been doing...

> I also add an example how a protocol driver could use this extension.
> Appreciate any comment.
>=20
>=20
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index 269e8af..8a27c66 100644

Please don't send patches without a signoff, see SubmittingPatches.

--Uus2/pBTyv0r7Av1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWTPRiAAoJECTWi3JdVIfQZvcH/ReFJlRpCrsCfb0FcyHU80kT
snkXL/UOZfG0264pl9NFuO4cXCGfYTOE0wobHGptcFn49atVM5ynZtTutBXu/Ray
YeHkWRpKTE/OBQkp/Tw7kMHLGdkgcFiMrSadHHhgrz/igVJPWTkKXJmXvPZAC+nt
PvpWkYKMtRYu6cX76MxfhxtLPg9sNkM24lwZiWMNMi/N4mhh3DfERcIJwVXtZ8Py
YaGTqZjPL1ieNRuPlyEOdB5xXhN8U73ZZKpnBOvyt7FJ9oM7p3ICfwqF4OB1xCIk
KIMX9ntaeg8kk1IL4hAYYTTIDXceLCBqYh6unt9+T812e5W6A7glx2E593sxkEQ=
=Wkp2
-----END PGP SIGNATURE-----

--Uus2/pBTyv0r7Av1--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

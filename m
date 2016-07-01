From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/4] spi: Add option to wake a device by toggling CS
Date: Fri, 1 Jul 2016 09:02:30 +0100
Message-ID: <20160701080230.GB6247@sirena.org.uk>
References: <1467258867-117727-1-git-send-email-apronin@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3IyuMspwcGTbYISR"
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: apronin-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1467258867-117727-1-git-send-email-apronin-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--3IyuMspwcGTbYISR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 29, 2016 at 08:54:24PM -0700, apronin-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org wrote:
> From: Andrey Pronin <apronin-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
>=20
> Some SPI devices may go to sleep after a period of inactivity
> on SPI. For such devices, if enough time has passed since the
> last SPI transaction, toggle CS and wait for the device to
> start before communicating with it.

This seems incredibly specialist, I can imagine someone might implement
something like this but it really feels like something I'd expect the
driver for the device to be doing rather than the core.  Is it really a
bounce that's needed and not something like putting a small delay after
asserting chip select?

--3IyuMspwcGTbYISR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXdiOVAAoJECTWi3JdVIfQZzYH/jyu6+ob5u/vCMMCP7cg/mtA
POCOdrpKt1VT2b4i1pVXMyYrTljguWXWxiG4HvpUgVp+5gLeXvJzqFCl+RkzN4pD
+0aVxVX+17SUQYnJJIYtTeyL3w6wSUfZgnyYqb/WjdCoJyYKruvckOqpz/BVOep3
jrdmtA010vZUhD85CdqrJnNc2XJZKURUqj4eg0R8b87NyFnqAMai0bUMRXZnFkpb
VEeAU2z0ELTgBFvvMqvQkyK44KZxelTBq3y+Hzp/rpau2l5DhzWAwN4WL/nggrZA
ECblOG+5KmxW5qBgN/U3c1ujAIIE5ktAzQrTnUsyOYfdgD1SOjKQR0gmd2lDflM=
=7tz4
-----END PGP SIGNATURE-----

--3IyuMspwcGTbYISR--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

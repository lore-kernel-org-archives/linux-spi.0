From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: fix spi.h kernel-doc warning
Date: Mon, 8 Feb 2016 16:55:56 +0000
Message-ID: <20160208165556.GJ7265@sirena.org.uk>
References: <56B54CFB.9050904@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aznLbwQ42o7LEaqN"
Cc: LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
To: Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56B54CFB.9050904-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--aznLbwQ42o7LEaqN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 05, 2016 at 05:31:39PM -0800, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
>=20
> Fix kernel-doc warning for missing struct field notation.
>=20
> ..//include/linux/spi/spi.h:540: warning: No description found for parame=
ter 'max_transfer_size'

The patch description and especially subject here should be something
along the lines of "Document max_transfer_size" - describe what you
think the change is.

--aznLbwQ42o7LEaqN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWuMibAAoJECTWi3JdVIfQAEgH/jIPh473DFX+9FjO6QrUa2Vh
l8gPzzTyHNNagbYAfKj+P7Hvgd2JeEzC9oE3T+86Jg2Z7HU6s8jdLsaDwbOzi8yM
/nctV09QhgMbKZkzReQYUbxLdstMwTDVGorofDix5EOtbiv80ipH4/6uhnNw1wVW
pV8oKPFl6X58gqU6LwSsEwgRUHIc/f+SozXgCb9Vqh07Dft3/H8byWH5K8w6zuep
nZIsYH17HmOD5ttg0MxNCwEcnVXwcjmWRnWXTFxhhYB16pQox1zysA1vKrNvcN/Y
ByWYBA6hF9Xo5IESrBOCB2RLbJc/hC4OHN3wpbQlR+BtptsX7mFaD/f59u5h3q8=
=14BG
-----END PGP SIGNATURE-----

--aznLbwQ42o7LEaqN--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

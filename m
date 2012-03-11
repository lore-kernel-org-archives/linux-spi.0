From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: mfd: mc13xxx: add I2C support, V2
Date: Sun, 11 Mar 2012 12:50:18 +0100
Message-ID: <20120311115018.GA16825@pengutronix.de>
References: <1331429402-9639-1-git-send-email-marc@cpdesign.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Cc: sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, oskar-fYPSZ7JpQqsAvxtiuMwx3w@public.gmane.org
To: Marc Reilly <marc-DtE7ei5U7Kg0n/F98K4Iww@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1331429402-9639-1-git-send-email-marc-DtE7ei5U7Kg0n/F98K4Iww@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> The only issue from V1 [0] not addressed is the use of regmap - mainly, I=
 don't
> have the time. I accept that this is a lame excuse but hope that use of r=
egmap=20
> can come later if it is required.

I really appreciate the effort, yet I fear that this is a show stopper. It =
gets
open coded what regmap is trying to abstract, adding complexity to the driv=
er
instead of (probably) reducing it. We could also get caching basically for
free, if this is desired. I think the regmap approach should have been tried
before we go custom. sound/soc/codecs/ad193x.c might give an impression how
regmap spi/i2c in one driver could look like.

Thanks,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk9ckXoACgkQD27XaX1/VRu1TQCguTRzuYmuyD51yNY2sSrpVImy
UakAn07LT38X0rmZado25bkDMc1mMGCe
=uJOg
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--

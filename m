From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] spi: pl022: Add support for chip select extension
Date: Wed, 24 Sep 2014 09:33:31 +0100
Message-ID: <20140924083331.GA4015@sirena.org.uk>
References: <20140916183431.GX7960@sirena.org.uk>
 <1410936418-26443-1-git-send-email-anders.berg@avagotech.com>
 <20140924083205.GZ4015@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BERr2LqgA7m/bZG/"
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Russell King <linux@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
To: Anders Berg <anders.berg@avagotech.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140924083205.GZ4015@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--BERr2LqgA7m/bZG/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2014 at 09:32:05AM +0100, Mark Brown wrote:
> On Wed, Sep 17, 2014 at 08:46:58AM +0200, Anders Berg wrote:
> > Add support for a extended PL022 which has an extra register for contro=
lling up
> > to five chip select signals. This controller is found on the AXM5516 So=
C.
> > Unfortunately the PrimeCell identification registers are identical to a
> > standard ARM PL022. To work around this, the peripheral ID must be over=
ridden
> > in the device tree using the "arm,primecell-periphid" property with the=
 value
> > 0x000b6022.
>=20
> Applied, thanks.

Actually there's still the amba/bus.h update in here - I'll hold off for
a while yet so Russell has a chance to review.

--BERr2LqgA7m/bZG/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUIoHaAAoJECTWi3JdVIfQhNoH/2ueMu7JIG+y2Nq9HCvz+H5H
+0VPf5TkeCiLDmPhyDiAZvYY/vmtovTaPKAzxoBoHrU9F3aZtSLmVRbYHz3ZBDSW
lgJpb0sDGRwSDoz8SftxKE2sUHwY3L8GlLBV/zGXyD1T8Ar6u4DPe7tUuiZoDcFq
00RSnysf03O8fBrJzMhZ3rxQUwjtH/whO8FpFZIhFqhpU3Gl3wmEPYT2vG/qaQeu
hLU6EvQqOby8g2Ig5yxyXQxdF8jJC5r7kbePpg/zpPbwHXpIGlOTUW+TQgXWMUig
Q56b9Bm95KJR6etGnD6QNxS0hteFrfSS2izfd965V/2XPavAHXh3VO82IqgapQw=
=fS70
-----END PGP SIGNATURE-----

--BERr2LqgA7m/bZG/--

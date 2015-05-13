From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: Force the registration of the spidev devices
Date: Wed, 13 May 2015 19:32:11 +0100
Message-ID: <20150513183211.GK2761@sirena.org.uk>
References: <1431462804-30467-1-git-send-email-maxime.ripard@free-electrons.com>
 <20150513112604.GI3066@sirena.org.uk>
 <20150513153740.GC11677@kroah.com>
 <20150513171300.GD2761@sirena.org.uk>
 <20150513172028.GA18303@kroah.com>
 <20150513173922.GF2761@sirena.org.uk>
 <20150513181631.GB16811@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/sFzBD2UPiMqxCFT"
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>,
	linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
	linux-spi@vger.kernel.org, Martin Sperl <kernel@martin.sperl.org>,
	Michal Suchanek <hramrach@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150513181631.GB16811@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--/sFzBD2UPiMqxCFT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 13, 2015 at 11:16:31AM -0700, Greg Kroah-Hartman wrote:

> It should "just work" for all busses, but if you want to add a "new_id"
> sysfs file, you need to add the logic for that to your bus.  It's the
> bind/unbind files in the driver directories.

Oh, right.  For this to be useful here we'd need to implement a new_id
file, bind and unbind don't do anything helpful here.  I think I'd have
expected this to have a default implementation that non-enumerable buses
could pick up.

--/sFzBD2UPiMqxCFT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVU5iqAAoJECTWi3JdVIfQXn4H/RZmwErt3j7BC31/skDhFixo
/RoLV/egZ7XJJAqeS4aLBbXMi2QTvyog5L2FHRiIBQoPYGnRzzGzgIkknNDikL+a
g2NeuwcH8hShn1iUTLeGyEGZA3Zvw2FbRbHnA8KeFeFMxs5RgTauYM+M0pfV/FLp
9eIMidzDA+hVvriwaFgNq9/EpSub7Kaq0ES+3mEYUb3UHXFY3seED5w9ypRwvTrO
fCj9X1BSgJW5xLh2BltYq6vWhvbClq4WxBxTbTvl67Yadqb20t9TQTnFmkcqWIOK
+vGodas5r309m2sLjkKlpgZBpD0U2glWtzbBo8eGRwzAZaDFCEvSSgVLVzPt6vY=
=Dahb
-----END PGP SIGNATURE-----

--/sFzBD2UPiMqxCFT--

From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] spi: spi-sun4i, spi-sun6i: Fix bit rate calculation
Date: Fri, 7 Aug 2015 14:16:27 +0100
Message-ID: <20150807131627.GB10301@sirena.org.uk>
References: <op.x2pmc5kiltbbtz@localhost>
 <20150804171931.GZ20873@sirena.org.uk>
 <op.x2yr7kbcltbbtz@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="i0/AhcQY5QxfSsSZ"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
To: Hermann Kraus <hermr2d2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <op.x2yr7kbcltbbtz@localhost>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--i0/AhcQY5QxfSsSZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 06, 2015 at 10:51:10PM +0200, Hermann Kraus wrote:
> Use requested bit rate instead of maximum possible and correctly calculate
> the divider.

This doesn't apply against current code, please check and resend.

--i0/AhcQY5QxfSsSZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVxK+rAAoJECTWi3JdVIfQgbwH/iSn+qq6RPWg3j1gJAJVpJxr
LAHTQl3Su1urNZp6FGHSxmIngERkIv+97P5Fh8W4m4oFPEBDjks7zj7HNsU1GowJ
wTHjp7rPA5q/7tXxUscFIff09QFSJ5c+QpUYgmGeMOJedVqHA8xBaZj8/dXb82y5
xEP9pPGmaojuwp3ruuEh+DuzJd6401aqC2M8wD7KKtkW0Iu+ffpF02Bfq4cpazBT
9L4NH1C/SLcpIgc9QTa3QScY6aN72j51cQWGqlb1C0VZUZN9WGNZWgD31UlCWs4I
YbvlRFgXvnH8c8nwZ1gtole3s05d5Wi355s8RvopNVivzsTNugJqK3Vr4uoo1aQ=
=R8/O
-----END PGP SIGNATURE-----

--i0/AhcQY5QxfSsSZ--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

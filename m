From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] spi: spi-sun4i, spi-sun6i: Fix bit rate calculation
Date: Fri, 7 Aug 2015 14:14:46 +0100
Message-ID: <20150807131446.GA10301@sirena.org.uk>
References: <op.x2pmc5kiltbbtz@localhost>
 <20150804171931.GZ20873@sirena.org.uk>
 <op.x2yr7kbcltbbtz@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
To: Hermann Kraus <hermr2d2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <op.x2yr7kbcltbbtz@localhost>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 06, 2015 at 10:51:10PM +0200, Hermann Kraus wrote:
> Use requested bit rate instead of maximum possible and correctly calculate
> the divider.

Please don't put things like "Re: " at the start of subject lines for
patch submissions, it makes it look like a reply to an existing thread
rather than a patch submission.

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVxK9FAAoJECTWi3JdVIfQofAH/jveG8heTDeQyEbj/8nTPUxA
xC9eV1BEWyZXeQDUMIa8ph9Y+BkMSo/xt71YiSJsbQ656VrG5Q7RpLo7MEvtCUSe
sRkWMaJ+WsM0Z7nIy5z+5NBPt/3aqiWoOgyd6D/m55tXCS5wLnGWFM13sTLBZKd8
gAZB8QrB9xLpNm9iMvx3W7AYvA7WP0NiEQjlRdG4hQ/jc4yMz+XY3qlOvtx5sKDM
RFsx0CtZw7Awmg4FCZvevNV6H2R0DOJhj/sy43s7MuKc2h3gmAPhxywXZAe2c0qF
PtyDTY29Wm2upJYorgiIIH+7AsEbYaAtLcZAKfHSszLZ6L08mXOmEJgBEbSwJJ0=
=Togk
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

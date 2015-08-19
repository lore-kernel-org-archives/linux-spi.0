From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/3] spi: mediatek: fix spi incorrect endian usage
Date: Wed, 19 Aug 2015 10:26:26 -0700
Message-ID: <20150819172626.GV10748@sirena.org.uk>
References: <1439955478-2733-1-git-send-email-leilk.liu@mediatek.com>
 <1439955478-2733-4-git-send-email-leilk.liu@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="D7NAS2w8UwTm8YEa"
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1439955478-2733-4-git-send-email-leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--D7NAS2w8UwTm8YEa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 19, 2015 at 11:37:58AM +0800, Leilk Liu wrote:
> TX_ENDIAN/RX_ENDIAN bits define whether to reverse the endian
> order of the data DMA from/to memory. The endian order should
> keep the same with cpu endian.

This doesn't apply, probably because it depends on your stylistic
changes patch - this is an example of the issues I was mentioning with
stylistic changes getting in the waty of fixes :(

--D7NAS2w8UwTm8YEa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV1Lw9AAoJECTWi3JdVIfQLI4H/1GLBPDiEigCLfVZ1wvQdxf/
HzcqaSmFryw1IDmnLV1qt0s40T6VDsPOFfO1f+tFZeKd3zNZ0BYjgYiysf178SFj
ZBvUZWC2aIQVouWXJh6Y/SLV45L2EYKdmci7ZNH5ylag/u0pmJlCVsaIjb9SfImq
vNBA8FoJE7nNYpTvxd3bZLG8VJQIy8rDviKcAxnmsNswqgMtirnE1VAMftYuVuVd
3NsiSlitYEdyKbU18hI5njm8j987NsdZC9gpVKlC1VzTS/gXxX67xuj15C7wu6Io
+Lp31atq2vxhYNTaXQw52Gfn117odMHBL/YsfEInMJZHnaFUtrWlSABgvhcNk0Q=
=gKBx
-----END PGP SIGNATURE-----

--D7NAS2w8UwTm8YEa--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

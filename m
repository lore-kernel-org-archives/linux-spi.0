From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 1/3] dt-binding: spi: Mediatek: Document devicetree
 bindings for spi bus
Date: Tue, 4 Aug 2015 18:42:26 +0100
Message-ID: <20150804174226.GE20873@sirena.org.uk>
References: <1438167874-1305-1-git-send-email-leilk.liu@mediatek.com>
 <1438167874-1305-2-git-send-email-leilk.liu@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ecKHkrog8duCxGt3"
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1438167874-1305-2-git-send-email-leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--ecKHkrog8duCxGt3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 29, 2015 at 07:04:32PM +0800, Leilk Liu wrote:
> Signed-off-by: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>

Please use subject lines reflecting the style for the subsystem so
people can spot if patches are relevant to them.

> +- clocks: phandles to input clocks.
> +
> +- clock-names: tuple listing input clock names.
> +	Required elements: "main"

...and there are no optional values?

> +- pad-select: should specify spi pad used, only required for MT8173.
> +        This value should be 0~3.

What do the values 0-3 mean?  I guess it's the value for some register
or other part of the device, the binding should say so people can go and
check the datasheet, schematic or whatever to figure out what to set.

This property should be optional, not required

--ecKHkrog8duCxGt3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVwPmCAAoJECTWi3JdVIfQZl4H/3NcxpNuKbxoyAvXkigb2RtW
yJp51kfljB3TuWVtMZ+ixwMkoL49uQI/w3MZd2N6OG5x7NL4hQmIU57pscbjnr+v
XdIecCybNID3M4D86PEDkYYjJww+0tSgASOi6VeK4UFmhkNk6QA5CmPDVamAdmRI
cvV2EebMbeWxrNbRwkIWgh77xUTy9CG1J1PWxXD2iYkEHpBtTnk3Ax8YQM5de2cF
UvuwIYnSd0QylyJXsoai+M2h47U2ybC5qxE1udJChxt9PMed7XaMbxV0p/6DVUTN
zJwTQAGogwQ18BCkkY36JPAYx5fkPP5BEiQu1dt9FGBsCz2HzgqrDx4SQtvVfWM=
=7Ebn
-----END PGP SIGNATURE-----

--ecKHkrog8duCxGt3--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

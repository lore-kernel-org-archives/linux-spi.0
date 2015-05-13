From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/3] spi: mediatek: Add spi bus for Mediatek MT8173
Date: Wed, 13 May 2015 12:10:51 +0100
Message-ID: <20150513111051.GH3066@sirena.org.uk>
References: <1431075343-7887-1-git-send-email-leilk.liu@mediatek.com>
 <1431075343-7887-3-git-send-email-leilk.liu@mediatek.com>
 <20150508175306.GG2761@sirena.org.uk>
 <1431434356.2128.9.camel@mhfsdcap03>
 <20150512160540.GB3066@sirena.org.uk>
 <1431509166.25254.12.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LNKrWK8T5LDJo+fl"
Cc: leilk liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Hongzhou Yang <hongzhou.yang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>,
	Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>,
	Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Yingjoe Chen <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1431509166.25254.12.camel@mtksdaap41>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--LNKrWK8T5LDJo+fl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 13, 2015 at 05:26:06PM +0800, Yingjoe Chen wrote:
> On Tue, 2015-05-12 at 17:05 +0100, Mark Brown wrote:

> > > > There were three compatible strings listed in the DT binding but only
> > > > two here.

> > > And I test it's ok on MT8135 platform. So I add struct of_device_id
> > > mtk_spi_of_match like this in spi driver code.

> > You should list all the compatibles documented in the binding here, if
> > some of them are the same just have them map to a single constant.

> Just for clarification. If we want to add spi support for a new soc, say
> mt8127, which we think is compatible to mt6589. Since it may turn out we
> need special handling for this soc latter, it is suggested to write
> compatible like this in mt8127.dtsi:

>    compatible = "mediatek,mt8127-spi",
>  	        "mediatek,mt6589-spi";

> Device tree binding should list all possible compatible string in .dts,
> so we'll have to add that to binding as well.

>      - mediatek,mt6589-spi: for mt6589 platforms
> +    - mediatek,mt8127-spi: for mt8127 platforms

> Then we'll also need to add this to source code to reflect this.

> 	{ .compatible = "mediatek,mt6589-spi", .data = (void *)COMPAT_MT6589},
> +	{ .compatible = "mediatek,mt8127-spi", .data = (void *)COMPAT_MT6589},

> This seems to introduce lots of trivial patches just to add a compatible
> device to me...

Yes, but that's how DT works and as you say these patches are all
trivial so it's not like they take any appreciable effort.

--LNKrWK8T5LDJo+fl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVUzE7AAoJECTWi3JdVIfQMAYH/19Vg5CJGxrJXpIZAxTxWN7x
YirZDjnjp7jzn+l0q7/JeyLTiYj9c1GhBidFvZ1XNfXiUtEvkcBNriqbvb04dkh1
5p8av1zOEA7z/WZYKiZ5qW99A21fiapozLljrJZzMUUxXWMKfi868OzG3okpQxq6
sWA4ZnSQ1koJ7i3RHnzIpXfbaIKkF/KzgR4+dlx6PUVKEeuBPgTfcfYSIj4X+ft1
Ul3vIE5e99OJsymxXsL1XRZr9+BZaEGknk3GM+maaoJ1x1Ov2bApShd7WJBcefNH
+exK3v5SaLuyUVFvR79cyuB8Qwtklza6pW1uExMdRTmviEbCbDYSI70MDwOGsZs=
=TDyi
-----END PGP SIGNATURE-----

--LNKrWK8T5LDJo+fl--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

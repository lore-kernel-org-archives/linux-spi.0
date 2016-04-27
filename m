From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: spi-fsl-dspi: replace regmap R/W with internal
 implementation
Date: Wed, 27 Apr 2016 16:25:32 +0100
Message-ID: <20160427152532.GX3217@sirena.org.uk>
References: <1461744756-31481-1-git-send-email-yao.yuan@freescale.com>
 <1461744756-31481-2-git-send-email-yao.yuan@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ootmdsr3EpGRXR2m"
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-devel-XDVM779Km55Y1YpKYGMr2+TW4wlIGRCZ@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, yao.yuan-3arQi8VN3Tc@public.gmane.org, leoyang.li-3arQi8VN3Tc@public.gmane.org,
	scott.wood-3arQi8VN3Tc@public.gmane.org
To: Yuan Yao <yao.yuan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1461744756-31481-2-git-send-email-yao.yuan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--ootmdsr3EpGRXR2m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 27, 2016 at 04:12:35PM +0800, Yuan Yao wrote:

> At first we use regmap to cover this issue.
> But the regmap is designed too large and complex.
> The issue for regmap often effect the DSPI's stability.

I'm not convinced that open coding things is going to make life much
easier here.  If there's problems in the underlying code then fixing
those seems like a more generally useful approach to things.  What are
the actual problems this is intended to fix?

--ootmdsr3EpGRXR2m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXINnqAAoJECTWi3JdVIfQnxQH+gK813tyzo7pKrDoMvVQLKSc
Wra2q+IRKTb4F4XfRlvAMmVnHgl1LKn1lXgMWyuBgC2bzYKHPIxdzC7hqSAhvUQs
BQGUGIPkBvgdubFKTWQTG6ZLevfW7bGW7UYeL/B8y4T4bRiK6CkDvJH5rr2/PHdS
i6KLIoaQklAOAysknTZBMcbe9ZzGGpf8SdqR0UQ/B+LlcBS0mGXAgIlSOdF/V2NV
BAVsTDqtNoi2QlfyQIeQh09uEwMdn2mtheKyMfVMmejVN18rgR/uJuu2cI+L9Zdq
AokfA+B9TN+gKhMetDJfT4EHV3IKbnI2Rr52JeSsd9IOpc1p+GGngd3TWVzir7Y=
=hoqu
-----END PGP SIGNATURE-----

--ootmdsr3EpGRXR2m--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

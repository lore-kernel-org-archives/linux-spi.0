From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: spi-fsl-dspi: replace regmap R/W with internal
 implementation
Date: Mon, 9 May 2016 11:28:40 +0100
Message-ID: <20160509102840.GB6292@sirena.org.uk>
References: <1461744756-31481-1-git-send-email-yao.yuan@freescale.com>
 <1461744756-31481-2-git-send-email-yao.yuan@freescale.com>
 <20160427152532.GX3217@sirena.org.uk>
 <AM2PR04MB072250B43DE37A38E374679989700@AM2PR04MB0722.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="f8UppZzm5eRNGSBg"
Cc: Yuan Yao <yao.yuan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	"robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"pawel.moll-5wv7dgnIgG8@public.gmane.org" <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	"shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"linux-devel-XDVM779Km55Y1YpKYGMr2+TW4wlIGRCZ@public.gmane.org" <linux-devel-XDVM779Km55Y1YpKYGMr2+TW4wlIGRCZ@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Yang-Leo Li <leoyang.li-3arQi8VN3Tc@public.gmane.org>,
	Scott Wood <scott.wood-3arQi8VN3Tc@public.gmane.org>
To: Yao Yuan <yao.yuan-3arQi8VN3Tc@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <AM2PR04MB072250B43DE37A38E374679989700-IPoeDzmMJYrzmGvksFXQpM9NdZoXdze2vxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--f8UppZzm5eRNGSBg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 09, 2016 at 08:48:59AM +0000, Yao Yuan wrote:
> Hi Mark Brown,

Please don't top post, reply in line with needed context.  This allows
readers to readily follow the flow of conversation and understand what
you are talking about and also helps ensure that everything in the
discussion is being addressed.

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

> There are two problems we have found for use regmap up to now.

> 1, Regmap will read device value depends on endian in .dtsi(DSPI in .dtsi=
 file is big-endian) and readl()(readl() in arm64 is le32_to_cpu read) in s=
ystem. =20
> That is the value read out is fixed regardless the kernel were compiled w=
ith CONFIG_CPU_BIG_ENDIAN yes or no. That makes the value(read from DSPI)ca=
n't be recognized in one endian mode(CONFIG_CPU_BIG_ENDIAN be set or not).
> The result is: DSPI can't working with CONFIG_CPU_BIG_ENDIAN set.

This doesn't make sense.  If the endianness of the device is specified
in DT then the endianness of the CPU won't make a difference.

> 2, Sometimes regmap will generate some issues. Some regmap issues will ca=
use the DSPI do not working.
> At 2016.4 we find the DSPI was not work, then we found that the regmap R/=
W the controller register sometimes not right.=20
> The result is: DSPI can't working with REGMAP API.
> Although the regmap issues was fast fixed by some giving person. But I'm =
still tend to use the reliable way.

> Regmap is nice and Maybe I should try to fix regmap instead of replacing =
regmap in my driver.
> But regmap is really very large and complex for DSPI driver.

Yes, if you find bugs in generic frameworks you should fix them rather
than just open coding something. =20

--f8UppZzm5eRNGSBg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXMGZWAAoJECTWi3JdVIfQMPcH/RdjCPbu+6zVJfPYp26y7B2H
whuq1IsqB4wFcM+PqbC9cNkdRlIe9iS48FAfdIffurpD9Vkf2Tfela/Ff7YvMT2I
nrn1e1Oto6MRFHWE3bJRGpwPVfr2X7cOrIUDcdLPCxOV/6WP79CPjy3ZG83RCy1W
DmzMeQkhfTy5KS/OQCsvuS5ej07yTTi+cjSe2JcWARyfCjD+hQSlladP5T/kItku
n7PIbjB+6PIKHcva5v3yTrElhxXZoNvg/vNc9fUEueLv8OuRVSLA/KTBMF5PFvrV
khz1eHM/veGap2zkqjixbSykIITgR6QDM3AQzkXmw8QENC45rBJIN2hSg6m0oQs=
=F+MD
-----END PGP SIGNATURE-----

--f8UppZzm5eRNGSBg--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

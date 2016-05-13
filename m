From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: spi-fsl-dspi: replace regmap R/W with internal
 implementation
Date: Fri, 13 May 2016 10:06:57 +0100
Message-ID: <20160513090657.GB10264@sirena.org.uk>
References: <1461744756-31481-1-git-send-email-yao.yuan@freescale.com>
 <1461744756-31481-2-git-send-email-yao.yuan@freescale.com>
 <20160427152532.GX3217@sirena.org.uk>
 <AM2PR04MB072250B43DE37A38E374679989700@AM2PR04MB0722.eurprd04.prod.outlook.com>
 <20160509102840.GB6292@sirena.org.uk>
 <AM2PR04MB0722180ABF5DB9406F56162B89700@AM2PR04MB0722.eurprd04.prod.outlook.com>
 <20160512163131.GF6261@sirena.org.uk>
 <DB5PR0401MB1928FE8EC4E862B1FF2F9BAE91740@DB5PR0401MB1928.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Y7xTucakfITjPcLV"
Cc: Yao Yuan <yao.yuan-3arQi8VN3Tc@public.gmane.org>, Yuan Yao <yao.yuan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	"robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"pawel.moll-5wv7dgnIgG8@public.gmane.org" <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	"shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"linux-devel-XDVM779Km55Y1YpKYGMr2+TW4wlIGRCZ@public.gmane.org" <linux-devel-XDVM779Km55Y1YpKYGMr2+TW4wlIGRCZ@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Yang-Leo Li <leoyang.li-3arQi8VN3Tc@public.gmane.org>
To: Scott Wood <scott.wood-3arQi8VN3Tc@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <DB5PR0401MB1928FE8EC4E862B1FF2F9BAE91740-GXldUsIPo7Z/SeJcUcAJq43W/0Ik+aLCnBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Y7xTucakfITjPcLV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 13, 2016 at 02:29:03AM +0000, Scott Wood wrote:
> On 05/12/2016 11:31 AM, Mark Brown wrote:

> >> That means no matter core is LE or BE, we both need get the value from DSPI register
> >> with big endian.

> > That's not how regmap is intended to be used, the intention is that the
> > driver will interact with native endian values and regmap will hide the
> > endianness changes.  You could mask this with some cpu_to_be() and
> > be_to_cpu() usage but I'm not sure it's a great idea or what it's buying
> > you.

> I don't think that's what Yao Yuan meant.  The driver wants the I/O
> accessor to return native-endian values, just like any other driver.

This really isn't clear to me.

--Y7xTucakfITjPcLV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXNZkwAAoJECTWi3JdVIfQl3UH/2IzfgZ5cTbUQgRhuaDb07m+
FjZ7G6AhqLyzH6HVWC+OiWumIHoCkJWR1lSPadqK5+rtLi/9/KlqAhwXq/HUQVw+
Wh6rWKP8RnXTJmK5gS3DIAiYHIiiyGy5RbtlD1uWGanvdZqJP8cHiCN6+gBqwGzj
bs0y9+xpSjhFa1C2oCbQgsKyRcEa5l5lcdnrwxVjuppnF9Ap2Tl5zHGguegXxkOH
O9jQT6hk/cZYMQZuH/JZp5YZQmF75KIjxDk4xbjLvJC2sGq18o+nP9znLnePdvuG
HakJ8uHHBs0O3Qnsj9DXD82rxCYbBb4iFSlITjBeaoPEx9c2F3fxU5nVonGC70k=
=s6rt
-----END PGP SIGNATURE-----

--Y7xTucakfITjPcLV--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

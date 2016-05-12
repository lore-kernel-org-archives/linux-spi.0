From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: spi-fsl-dspi: replace regmap R/W with internal
 implementation
Date: Thu, 12 May 2016 17:31:31 +0100
Message-ID: <20160512163131.GF6261@sirena.org.uk>
References: <1461744756-31481-1-git-send-email-yao.yuan@freescale.com>
 <1461744756-31481-2-git-send-email-yao.yuan@freescale.com>
 <20160427152532.GX3217@sirena.org.uk>
 <AM2PR04MB072250B43DE37A38E374679989700@AM2PR04MB0722.eurprd04.prod.outlook.com>
 <20160509102840.GB6292@sirena.org.uk>
 <AM2PR04MB0722180ABF5DB9406F56162B89700@AM2PR04MB0722.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ULkDCyeHsmlwbqED"
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
In-Reply-To: <AM2PR04MB0722180ABF5DB9406F56162B89700-IPoeDzmMJYrzmGvksFXQpM9NdZoXdze2vxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--ULkDCyeHsmlwbqED
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 09, 2016 at 10:58:08AM +0000, Yao Yuan wrote:

> For example, if DSPI controller register is BE, so I set big-endian in DT.
> That means we should R/W the DSPI controller register with big-endian.
> Then I can think all of the value we R/W to/from DSPI controller register, we can
> Think they are the BE.
> So that we can understand it easy.

> That means no matter core is LE or BE, we both need get the value from DSPI register
> with big endian.

That's not how regmap is intended to be used, the intention is that the
driver will interact with native endian values and regmap will hide the
endianness changes.  You could mask this with some cpu_to_be() and
be_to_cpu() usage but I'm not sure it's a great idea or what it's buying
you.

--ULkDCyeHsmlwbqED
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXNK/iAAoJECTWi3JdVIfQTtIH/jOoIqmqJRFrGFiiuOzvwcZl
LuGO+au9/oAq6tWxVTSF+84WVzTstHVLFoX4xx2N356XPKstUf8V38gjuuAMP4n4
hdrUVkr+R8iNLRsoHv2D0FV3cUiUHnGmMAkuuikwWHP1clCmQl6554HNtFYHMIHR
APmo7YBG3sv+w5N/D7ztvBlabscdrUOBiz6W3xYmYmBCnkpq7o/7qGxbBB5oqVKJ
tOGX2yMLVyxsMSVGLAaV835URmAApvvYwI9tTVpk4OjrF0Oys5vwLyHKcMCpFrh9
ud2XyS1G9V+pseyMQkZFraeD9aBlXtlPvA+SE6RWcIiniGF1Kz/F3+DBfl37oIA=
=rHFK
-----END PGP SIGNATURE-----

--ULkDCyeHsmlwbqED--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

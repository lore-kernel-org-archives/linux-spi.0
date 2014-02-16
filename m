From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 1/2] spi:fsl-dspi:convert to use regmap and big-endian
 supports
Date: Sun, 16 Feb 2014 09:14:35 +0800
Message-ID: <20140216011435.GT4451@sirena.org.uk>
References: <1392190146-18852-1-git-send-email-b44548@freescale.com>
 <065acacc2f4f461cbd310eb54737a32e@DM2PR03MB509.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4oXbDkBXUa6Hvs/m"
Cc: Chao Fu <B44548-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: "Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <065acacc2f4f461cbd310eb54737a32e-ufbTtyGzTTTFwE0YMf9HFeO6mTEJWrR4XA4E9RH9d+qIuWR1G4zioA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--4oXbDkBXUa6Hvs/m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 14, 2014 at 07:33:17AM +0000, Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org wrote:

> If needed, you should add the callbacks like:
> 	.readable_reg,
> 	.writeable_reg,
> 	.volatile_reg,

They're not 100% needed unless you have a cache in which case
volatile_reg() becomes important but it's definitely good practice to
add them.

--4oXbDkBXUa6Hvs/m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTABD4AAoJELSic+t+oim9Mi0P/jBx7ADRHUA2JV9OWh0TGDGB
RvfMs35heNkbac5h/ewNbLYEVo4bzUvzU/ipI9ZVPBlUNi8oLeRKS5A45TKtXuu9
wO6UlTB8QEvmCpIgBhDXANzao6b+hcfqxq9OkLiA6gNHvwlab4cCo3k72qoMX1Ff
ufAnSuesgNbHG4vILcBmESWpO+4Vbnr9HsEqD+4IdBPXKJsRxHIyMSwiuXeciVwP
Bs/0Osnwcy4qaHON2E2RSjIvAn96X0A+gj8spOGBnjjR+xqhiDdvV17oRfHGn2kI
q7iO77XNmMQ6Py86MXHrTIK1ClurR3skyoIDlINkCpNLuvmijY8vFDykynaJWogY
W4fyuuVTJsAV3ceY15BFTsEuycOEtgx94df8vF/31cRd+N3XOFeCGyVBCaS+TJpT
a8WxLhqcipn4wewhNFg8gufIRr+mNcJMSMflEv+IOFF+B1GvTt/XqYW0QnTGgiXX
fNAx0SXfkRPFD901ZNgiQJe7YEKhm9Pn7/oEuUyvkst9WSY/3YTrnX/01X68ywMj
KpjofU4vINQkCRh+tPcmUvWuPm7vMagKgodmxDCkcRQ9vQKxqJ2wDlV1BYQLPrGC
HDHT//sIyMEfxREwnAH9T+F4F7kTULlc9AD5/w0aVgyI7Bg3oxJyeBKZi+mLzIwN
3ybH5H48ifydGXTt21WY
=cjT7
-----END PGP SIGNATURE-----

--4oXbDkBXUa6Hvs/m--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

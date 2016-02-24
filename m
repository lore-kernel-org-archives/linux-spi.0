From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: imx: initialize usedma earlier
Date: Wed, 24 Feb 2016 12:19:36 +0900
Message-ID: <20160224031936.GI18327@sirena.org.uk>
References: <20160223111559.3c2cb641@ipc1.ka-ro>
 <1456223095-32185-1-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YioeI7PjS1+Wb3xh"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Anton Bondarenko <anton.bondarenko.sama-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
To: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1456223095-32185-1-git-send-email-s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--YioeI7PjS1+Wb3xh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 23, 2016 at 11:24:55AM +0100, Sascha Hauer wrote:
> The SoC specific config function does not know if DMA will be used or
> not. This information will be useful to configure the SPI controller
> correctly for DMA in following patches, so initialize the usedma
> variable before calling into the SoC specific config function.

Don't send new patches in reply to old serieses, especially not in the
middle of them - it makes it confusing to follow what's going on.

--YioeI7PjS1+Wb3xh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWzSE/AAoJECTWi3JdVIfQH/oH/2YMKpzNz2wPSa5hcEYIuVSJ
Oo6jBzzDlbzsytQW0m99SmHty3b796dFu1lr+31lWMUUCJ98uz3VMUJuSZMSDs2G
q5rT1RweXcHL/b3LTL1OWktPTkd5Yhrz6+dcAZdpDlGlnWRCryXO/sLJ4rEO8+hk
c9BcTJ2IeR4h9QVl5EN+vZFW40zbh8mF5veNcj0m5kb1X6jDi2sXb+bxsLfIXdoS
ugMfIc4TMv2zS+FLA2G22W7WJcEkc9QSotRvQOqQUnCAVSvaOCDCQTofnx0LqCf6
eVwviFe2yznn0g5wPfcCJJGZ1DTy6bO1xQTXkOeRV91DlyKOUf4qeKSLOezgpw4=
=WEux
-----END PGP SIGNATURE-----

--YioeI7PjS1+Wb3xh--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

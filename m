From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/4] spi: imx: GPIO based chip selects should not be
 required
Date: Fri, 3 Nov 2017 20:11:50 +0000
Message-ID: <20171103201150.7lt2bc6co7angy5w@sirena.co.uk>
References: <20171027010841.28624-1-tpiepho@impinj.com>
 <20171027010841.28624-2-tpiepho@impinj.com>
 <20171031111919.gocl7wwrhkwnxrya@sirena.co.uk>
 <1509469061.5473.16.camel@impinj.com>
 <20171102151439.6dpfud7a5vtc27dy@sirena.co.uk>
 <1509731639.5473.60.camel@impinj.com>
 <20171103183700.spnqbagr4q7fth4k@sirena.co.uk>
 <1509736735.5473.87.camel@impinj.com>
 <20171103193649.jcoiy3raefikko2h@sirena.co.uk>
 <1509739759.5473.93.camel@impinj.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oryr674mm7p67op2"
Cc: "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
        <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
        "fabio.estevam-3arQi8VN3Tc@public.gmane.org" <fabio.estevam-3arQi8VN3Tc@public.gmane.org>
To: Trent Piepho <tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1509739759.5473.93.camel-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--oryr674mm7p67op2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 03, 2017 at 08:09:19PM +0000, Trent Piepho wrote:
> On Fri, 2017-11-03 at 19:36 +0000, Mark Brown wrote:

> > Is there any documentation of the bindings for this driver at all?  I
> > wasn't able to find it.

> Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt

Ah, good - for some reason I'd thought that was a different IP block
(SPI controllers are like serial ports, endless room for innovation!).

--oryr674mm7p67op2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAln8zYYACgkQJNaLcl1U
h9A68Qf/caLFT6u4KJI1ha+vGu39pyw5/5OMA8bAau/xbFK17LcyXPGBOoHAANOU
mYX9Aw8bZW/uFcAowZj8CMwYxAqoLEiktACkGYMu4x24d5PYayQT3DcpIpSjl4s1
ZgcLYLRLIgr/SO6G4u0wgC37Ppqu6dfwoWROipTFvYs4RPT6/eC+w0aRmNipBUOl
k+9/K5Dkmd2pTOo3wVhKhn4iTu8lgHt+CZhXru+18vnepYCypxQbraagrBcdMw8p
xXCon7wjHlqVmGl5PBSWR18ecqUlBRMq1+7m9eVWHZMash6yX5Gecr0aj2QqqP9i
rpTYUhiwxou8mUaJecNvoxqNTK+DiA==
=7Ffr
-----END PGP SIGNATURE-----

--oryr674mm7p67op2--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

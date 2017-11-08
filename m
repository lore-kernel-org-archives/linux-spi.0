From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 1/3] spi: imx: GPIO chip select DT property should not
 be required
Date: Wed, 8 Nov 2017 19:26:33 +0000
Message-ID: <20171108192633.ssbepmaebzjooa42@sirena.co.uk>
References: <20171106194618.9421-1-tpiepho@impinj.com>
 <20171106194618.9421-2-tpiepho@impinj.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3kbf5ldziwdxtscd"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
        Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
        Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>,
        Oleksij Rempel <o.rempel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
To: Trent Piepho <tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171106194618.9421-2-tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--3kbf5ldziwdxtscd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 06, 2017 at 11:46:16AM -0800, Trent Piepho wrote:
> The driver will fail to load if the device tree property for gpio chip
> selects is not specified.  Change the driver to make the property optional.
> Also have the driver respect the "num-cs" property in the standard way.

This doesn't apply against current code, please check and resend.

--3kbf5ldziwdxtscd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAloDWmgACgkQJNaLcl1U
h9Dr6wf+Pp7k2E+erD6jqX/qMUnp1dAqcG5qr/d/IkZduQ1PkZ7pV/M5jhDzyyD2
GVySvFfXtHaZ3IbY1xSrOAdK0zKS8dq7i3skg+dGg9aUbaio/pzW4bq7SWj01qHL
x+Jk+zm22aS+74PRgk/xg2u1fPkZSLW/2A2TL+mJh/GE1bVNh8YZF6B+zF+iqCXN
i14V3X2RKS7/ySolya627L8YKPGenoip7WWcFd2Flnww6aDvGjG4HCFNfmLGdPFa
1OBtvw5fEBIuwynegwPsUNbzXaRSt0k7OrU867R7ak7x8tUjE05YgrKjTb2IQ2jT
ckM0R7Izzqz/fn4eYRIxXo8xGpwGKg==
=rrbR
-----END PGP SIGNATURE-----

--3kbf5ldziwdxtscd--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

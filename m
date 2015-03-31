From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] spi: bitbang: only toggle bitchanges
Date: Tue, 31 Mar 2015 17:21:58 +0100
Message-ID: <20150331162158.GU2869@sirena.org.uk>
References: <20150331141321.GR2869@sirena.org.uk>
 <1427812501-7194-1-git-send-email-m.grzeschik@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="K8PWEQy9GvKYXNcn"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
To: Michael Grzeschik <m.grzeschik-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1427812501-7194-1-git-send-email-m.grzeschik-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--K8PWEQy9GvKYXNcn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 31, 2015 at 04:35:01PM +0200, Michael Grzeschik wrote:
> The current implementation of bitbang_txrx_be_cpha0 and
> bitbang_txrx_be_cpha1 always call setmosi. That runs into several
> unnecessary calls into the gpiolib when the level of the GPIO actually
> has not to be changed.

Applied, thanks.

--K8PWEQy9GvKYXNcn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVGsmlAAoJECTWi3JdVIfQwLQIAIHV58XCdBOTl8oKcoLFXVYR
K98ctrS0dHwcY3pULACvWlfS9UfSaBbakWcnY98m1wm2BligxI3Oz7znAHUMsfCM
RWCcYkmNjgIpfKZnSddCoTDevgiU+tfC9zl12Z4gBGjK3OoCclKdanAPqy/0SLeX
B5zns+n6c59gxWQwrE9oCcHQ6ifUSxIwaXbItUPyMV96Bw9QMDYcyqrFmk6PZdpf
11snYX27YAzP/3jbcNWMBSSTOb0QyO5dj79uIxYXCxsrOm8E9xG/HlpeEGUoJq75
dn1X2WpOO4HKU0VfOZnkkBRl8FDQ0QUq0vFClCeqDolPn9sv+El2/0kCnmaZ7kM=
=k+vw
-----END PGP SIGNATURE-----

--K8PWEQy9GvKYXNcn--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH linux-next v3 1/4] spi: imx: introduce fifo_size and
 has_dmamode in spi_imx_devtype_data
Date: Wed, 7 Jun 2017 20:09:01 +0100
Message-ID: <20170607190901.eo7nmitwj6v3yw5e@sirena.org.uk>
References: <20170605033809.13726-1-jiada_wang@mentor.com>
 <20170605033809.13726-2-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="icplb52xiufeap5i"
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, fabio.estevam-3arQi8VN3Tc@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Jiada Wang <jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170605033809.13726-2-jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--icplb52xiufeap5i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 05, 2017 at 12:38:06PM +0900, Jiada Wang wrote:
> Different ECSPI controller has different fifosize and DMA capability,
> instead of calling functions to identify these information by check
> devtype. add fifo_size and has_dmamode to spi_imx_devtype_data.
> so that these information can be directly accessed.

This doesn't apply against current code, please check and resend
(probably due to Sascha's cleanup series).

--icplb52xiufeap5i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlk4T00ACgkQJNaLcl1U
h9BaRgf+Kf80tlEIHfMhocfgMIGwG03ytlg6GO5Jeiw99alh9MBNS242YsMH9hW/
CsPb3IxsGmXOS+ka2IYbkMIvtULvVQmzTA2dGcMwZKnClIHrb0MvyovhQUZ+4VfC
oiarGILgYV480I/6kdtgmABglw93OQC337COldDnhXgOCmcj67yQMi8AqYb0hyVB
GrC7/AgN/ltZdr98c+ni3Fz37IAOeyCiEXd1jiHNYTvyrcTSZoXAsTJOPjkyacie
uc5sR2WAprAFwCcQD2mEyi2N1STVJcBm5FQ34Ew+Gj373rTacmqYiia1qJPjoekf
blH03Ss+Un0vYeuTQvHt4UlhClkdEA==
=2+Ci
-----END PGP SIGNATURE-----

--icplb52xiufeap5i--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RFC 0/5] *** SPI Slave mode support ***
Date: Thu, 13 Apr 2017 13:59:29 +0100
Message-ID: <20170413125929.dygodgj6c35ydh5p@sirena.org.uk>
References: <1492085644-4195-1-git-send-email-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2vyyg5ms6wnpv2id"
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, fabio.estevam-3arQi8VN3Tc@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
        Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
To: jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1492085644-4195-1-git-send-email-jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--2vyyg5ms6wnpv2id
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 13, 2017 at 05:13:59AM -0700, jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org wrote:
> From: Jiada Wang <jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
>=20
> v1:
>   add Slave mode support in SPI core
>   spidev create slave device when SPI controller work in slave mode
>   spi-imx support to work in slave mode

Adding Geert who also had a series doing this in progress that was
getting very near to being merged.

>=20
> Jiada Wang (5):
>   spi: core: add support to work in Slave mode
>   spi: spidev: use different name for SPI controller slave mode device
>   spi: imx: add selection for iMX53 and iMX6 controller
>   ARM: dts: imx: change compatiblity for SPI controllers on imx53 later
>     soc
>   spi: imx: Add support for SPI Slave mode for imx53 and imx6 chips
>=20
>  Documentation/devicetree/bindings/spi/spi-bus.txt |  27 ++-
>  Documentation/spi/spi-summary                     |  19 +-
>  arch/arm/boot/dts/imx53.dtsi                      |   4 +-
>  arch/arm/boot/dts/imx6q.dtsi                      |   2 +-
>  arch/arm/boot/dts/imx6qdl.dtsi                    |   8 +-
>  arch/arm/boot/dts/imx6sl.dtsi                     |   8 +-
>  arch/arm/boot/dts/imx6sx.dtsi                     |   8 +-
>  arch/arm/boot/dts/imx6ul.dtsi                     |   8 +-
>  drivers/spi/Kconfig                               |  14 +-
>  drivers/spi/spi-imx.c                             | 216 ++++++++++++++++=
++++--
>  drivers/spi/spi.c                                 |  23 ++-
>  drivers/spi/spidev.c                              |  15 +-
>  include/linux/spi/spi.h                           |  15 ++
>  13 files changed, 310 insertions(+), 57 deletions(-)
>=20
> --=20
> 2.7.4
>=20
>=20

--2vyyg5ms6wnpv2id
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAljvdjEACgkQJNaLcl1U
h9DeVgf+JWpTNpyDnSVvyjWtXJFB+Bln7qRS6mduVicURu12JOcXsV8uSGxDIocY
EGGuS1mvKMY0OoEzqC8EFo55HXcUbqObnEaTXZQu956Ih6x+5BYWnPPkKNEFQKBq
AgdEWYx5UpPBBZ4YHBIocEhUb5ym+NtzPxmBtg5GUnnVgdeb7iPV1XGGlxiaMqte
Ui81i1cPkbOj+/GjLqIKqhEIJ3nhmwejEtcxjvt7lXPoRvmLQN9oc7fCDsIMMi1/
krc/8sU0ZYomYcmQA7xM1V6aD+yO7S2g5ytISVSYgftC3+tuBHNogFxLUyvcUf4Q
CrHT6wFBcRvHqnbeaziUQ8XHZWVIZQ==
=bHod
-----END PGP SIGNATURE-----

--2vyyg5ms6wnpv2id--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Michal Simek <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>
Subject: Re: [PATCH] spi: xilinx: Use standard num-cs binding
Date: Thu, 12 Feb 2015 10:45:02 +0100
Message-ID: <54DC761E.9040701@monstr.eu>
References: <67f3c196833c427a489ca2c530d08987a6b5ee2a.1421412912.git.michal.simek@xilinx.com>
Reply-To: monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="MhCBIBp2M9q31k8TPg7PJgG0BNemOExcG"
Cc: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	=?windows-1252?Q?S=F6ren_Brinkmann?= <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <67f3c196833c427a489ca2c530d08987a6b5ee2a.1421412912.git.michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MhCBIBp2M9q31k8TPg7PJgG0BNemOExcG
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On 01/16/2015 01:55 PM, Michal Simek wrote:
> Use standard num-cs binding property and setup
> "xlnx,num-ss-bits" as deprecated.
>=20
> Signed-off-by: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
> ---
>=20
>  drivers/spi/spi-xilinx.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
> index 79bd84f43430..30e5180195bb 100644
> --- a/drivers/spi/spi-xilinx.c
> +++ b/drivers/spi/spi-xilinx.c
> @@ -338,8 +338,15 @@ static int xilinx_spi_probe(struct platform_device=
 *pdev)
>  		num_cs =3D pdata->num_chipselect;
>  		bits_per_word =3D pdata->bits_per_word;
>  	} else {
> -		of_property_read_u32(pdev->dev.of_node, "xlnx,num-ss-bits",
> -					  &num_cs);
> +		if (of_property_read_u32(pdev->dev.of_node, "num-cs",
> +					 &num_cs)) {
> +			if (!of_property_read_u32(pdev->dev.of_node,
> +						  "xlnx,num-ss-bits",
> +						  &num_cs)) {
> +				dev_err(&pdev->dev,
> +					"property name 'xlnx,num-ss-bits' is deprecated.\n");
> +			}
> +		}
>  	}
>=20
>  	if (!num_cs) {
> --
> 1.8.2.3
>=20

Any update on this one?

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform



--MhCBIBp2M9q31k8TPg7PJgG0BNemOExcG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlTcdh4ACgkQykllyylKDCEFjgCdEXNpW0QF3cii1zQwKBu2Zx5C
zKUAnj3C664yYu9SzIMSuWIzA2Whjgia
=ppFA
-----END PGP SIGNATURE-----

--MhCBIBp2M9q31k8TPg7PJgG0BNemOExcG--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

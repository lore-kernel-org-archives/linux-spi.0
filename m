From: Joakim Tjernlund <Joakim.Tjernlund-27rvihrghlNWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH] spi: spi-fsl-spi: Add OF bus-num property
Date: Fri, 13 Jan 2017 15:41:24 +0000
Message-ID: <1484322082.4044.0.camel@infinera.com>
References: <20161219120942.29022-1-joakim.tjernlund@infinera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
To: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161219120942.29022-1-joakim.tjernlund-27rvihrghlNWk0Htik3J/w@public.gmane.org>
Content-Language: en-US
Content-ID: <B401BF5B59E3E3499F4C209D7B0543EF-27rvihrghlNWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Mon, 2016-12-19 at 13:09 +0100, Joakim Tjernlund wrote:
> Allow OF to specify bus enumeration. This uses the same property
> as spi-fsl-dspi.
>=20
> Signed-off-by: Joakim Tjernlund <joakim.tjernlund-27rvihrghlNWk0Htik3J/w@public.gmane.org>
> ---

Ping?

>  drivers/spi/spi-fsl-lib.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/spi/spi-fsl-lib.c b/drivers/spi/spi-fsl-lib.c
> index cb35d2f..3b06513 100644
> --- a/drivers/spi/spi-fsl-lib.c
> +++ b/drivers/spi/spi-fsl-lib.c
> @@ -140,7 +140,7 @@ int of_mpc8xxx_spi_probe(struct platform_device *ofde=
v)
>  	struct mpc8xxx_spi_probe_info *pinfo;
>  	struct fsl_spi_platform_data *pdata;
>  	const void *prop;
> -	int ret =3D -ENOMEM;
> +	int ret =3D -ENOMEM, bus_num;
> =20
>  	pinfo =3D devm_kzalloc(&ofdev->dev, sizeof(*pinfo), GFP_KERNEL);
>  	if (!pinfo)
> @@ -151,7 +151,9 @@ int of_mpc8xxx_spi_probe(struct platform_device *ofde=
v)
> =20
>  	/* Allocate bus num dynamically. */
>  	pdata->bus_num =3D -1;
> -
> +	ret =3D of_property_read_u32(np, "bus-num", &bus_num);
> +	if (ret >=3D 0)
> +		pdata->bus_num =3D bus_num;
>  #ifdef CONFIG_FSL_SOC
>  	/* SPI controller is either clocked from QE or SoC clock. */
>  	pdata->sysclk =3D get_brgfreq();
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

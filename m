From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] mfd: dln2: add support for USB-SPI module
Date: Mon, 10 Nov 2014 09:30:05 +0000
Message-ID: <20141110093005.GF21424@x1>
References: <1415364314-30320-1-git-send-email-laurentiu.palcu@intel.com>
 <1415364314-30320-3-git-send-email-laurentiu.palcu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Johan Havold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurentiu Palcu <laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1415364314-30320-3-git-send-email-laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Fri, 07 Nov 2014, Laurentiu Palcu wrote:

> Signed-off-by: Laurentiu Palcu <laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/mfd/dln2.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/drivers/mfd/dln2.c b/drivers/mfd/dln2.c
> index 9765a17..0cdad2d 100644
> --- a/drivers/mfd/dln2.c
> +++ b/drivers/mfd/dln2.c
> @@ -52,6 +52,7 @@ enum dln2_handle {
>  	DLN2_HANDLE_CTRL,
>  	DLN2_HANDLE_GPIO,
>  	DLN2_HANDLE_I2C,
> +	DLN2_HANDLE_SPI,
>  	DLN2_HANDLES
>  };
> =20
> @@ -634,6 +635,12 @@ static struct dln2_platform_data dln2_pdata_i2c =
=3D {
>  	.port =3D 0,
>  };
> =20
> +/* Only one SPI port supported */
> +static struct dln2_platform_data dln2_pdata_spi =3D {

Is this ever fiddled with?  If not, const?

> +	.handle =3D DLN2_HANDLE_SPI,
> +	.port =3D 0,
> +};
> +
>  static const struct mfd_cell dln2_devs[] =3D {
>  	{
>  		.name =3D "dln2-gpio",
> @@ -645,6 +652,11 @@ static const struct mfd_cell dln2_devs[] =3D {
>  		.platform_data =3D &dln2_pdata_i2c,
>  		.pdata_size =3D sizeof(struct dln2_platform_data),
>  	},
> +	{
> +		.name =3D "dln2-spi",
> +		.platform_data =3D &dln2_pdata_spi,
> +		.pdata_size =3D sizeof(struct dln2_platform_data),
> +	},
>  };
> =20
>  static void dln2_disconnect(struct usb_interface *interface)

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

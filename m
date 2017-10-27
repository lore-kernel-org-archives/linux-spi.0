From: Oleksij Rempel <ore-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v2 3/4] spi: imx: Don't require platform data chipselect
 array
Date: Fri, 27 Oct 2017 13:14:04 +0200
Message-ID: <20171027111404.nibuwyakef6bvjvn@pengutronix.de>
References: <20171027010841.28624-1-tpiepho@impinj.com>
 <20171027010841.28624-4-tpiepho@impinj.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
To: Trent Piepho <tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171027010841.28624-4-tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Trent,

On Thu, Oct 26, 2017 at 06:08:40PM -0700, Trent Piepho wrote:
> If the array is not present, assume all chip selects are native.  This
> is the standard behavior for SPI masters configured via the device
> tree and the behavior of this driver as well when it is configured via
> device tree.
> 
> This reduces platform data vs DT differences and allows most of the
> platform data based boards to remove their chip select arrays.
> 
> CC: Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> CC: Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> CC: Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>
> CC: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Signed-off-by: Trent Piepho <tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/spi/spi-imx.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index fea46cbf458a..535378ebab18 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -1362,8 +1362,7 @@ static int spi_imx_probe(struct platform_device *pdev)
>  	spi_imx->devtype_data = of_id ? of_id->data :
>  		(struct spi_imx_devtype_data *)pdev->id_entry->driver_data;
>  
> -	if (mxc_platform_info) {
> -		master->num_chipselect = mxc_platform_info->num_chipselect;
> +	if (mxc_platform_info && master->num_chipselect) {

after spi_alloc_master(), master->num_chipselect should be always 1.
This check makes no sense for me. Probably you wonted to use
mxc_platform_info->num_chipselect instead?

>  		master->cs_gpios = devm_kzalloc(&master->dev,
>  			sizeof(int) * master->num_chipselect, GFP_KERNEL);
>  		if (!master->cs_gpios)
> @@ -1371,7 +1370,7 @@ static int spi_imx_probe(struct platform_device *pdev)
>  
>  		for (i = 0; i < master->num_chipselect; i++)
>  			master->cs_gpios[i] = mxc_platform_info->chipselect[i];
> - 	}
> +	}
>  
>  	spi_imx->bitbang.chipselect = spi_imx_chipselect;
>  	spi_imx->bitbang.setup_transfer = spi_imx_setupxfer;
> -- 
> 2.14.3
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

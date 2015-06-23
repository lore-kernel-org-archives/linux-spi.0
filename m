From: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Subject: Re: [PATCH] spi: sh-msiof: Remove obsolete spi_r8a779x_msiof
 platform_device_id entries
Date: Wed, 24 Jun 2015 08:52:14 +0900
Message-ID: <20150623235214.GJ9988@verge.net.au>
References: <1435064564-11877-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1435064564-11877-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, Jun 23, 2015 at 03:02:44PM +0200, Geert Uytterhoeven wrote:
> Since commit a483dcbfa21f919c ("ARM: shmobile: lager: Remove legacy
> board support"), R-Car Gen2 SoCs are only supported in generic DT-only
> ARM multi-platform builds.  The driver doesn't need to match platform
> devices by name anymore, hence remove the corresponding
> platform_device_id entry.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>

Acked-by: Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>

> ---
>  drivers/spi/spi-sh-msiof.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
> index d3370a612d8432cf..118c652d88b570a5 100644
> --- a/drivers/spi/spi-sh-msiof.c
> +++ b/drivers/spi/spi-sh-msiof.c
> @@ -1265,11 +1265,6 @@ static int sh_msiof_spi_remove(struct platform_device *pdev)
>  
>  static const struct platform_device_id spi_driver_ids[] = {
>  	{ "spi_sh_msiof",	(kernel_ulong_t)&sh_data },
> -	{ "spi_r8a7790_msiof",	(kernel_ulong_t)&r8a779x_data },
> -	{ "spi_r8a7791_msiof",	(kernel_ulong_t)&r8a779x_data },
> -	{ "spi_r8a7792_msiof",	(kernel_ulong_t)&r8a779x_data },
> -	{ "spi_r8a7793_msiof",	(kernel_ulong_t)&r8a779x_data },
> -	{ "spi_r8a7794_msiof",	(kernel_ulong_t)&r8a779x_data },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(platform, spi_driver_ids);
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

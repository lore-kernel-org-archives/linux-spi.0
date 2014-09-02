From: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/4] spi: atmel: remove unnecessary #if defined(CONFIG_OF)
Date: Tue, 2 Sep 2014 09:49:53 +0200
Message-ID: <540576A1.3040800@atmel.com>
References: <002a01cfc65d$2dc86640$895932c0$%han@samsung.com> <002b01cfc65d$569ef570$03dce050$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Mark Brown' <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <002b01cfc65d$569ef570$03dce050$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 02/09/2014 05:24, Jingoo Han :
> Remove unnecessary  #if defined(CONFIG_OF), because this is
> already handled by the of_match_ptr macro.
> 
> Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

Ok:
Acked-by: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>

> ---
>  drivers/spi/spi-atmel.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
> index 113c83f44b5c..9f5066fa1473 100644
> --- a/drivers/spi/spi-atmel.c
> +++ b/drivers/spi/spi-atmel.c
> @@ -1481,14 +1481,12 @@ static SIMPLE_DEV_PM_OPS(atmel_spi_pm_ops, atmel_spi_suspend, atmel_spi_resume);
>  #define ATMEL_SPI_PM_OPS	NULL
>  #endif
>  
> -#if defined(CONFIG_OF)
>  static const struct of_device_id atmel_spi_dt_ids[] = {
>  	{ .compatible = "atmel,at91rm9200-spi" },
>  	{ /* sentinel */ }
>  };
>  
>  MODULE_DEVICE_TABLE(of, atmel_spi_dt_ids);
> -#endif
>  
>  static struct platform_driver atmel_spi_driver = {
>  	.driver		= {
> 


-- 
Nicolas Ferre
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

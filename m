From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Subject: Re: [PATCH] spi: dw: Remove unused dw_spi_cleanup function
Date: Thu, 8 May 2014 14:31:51 +0300
Message-ID: <20140508113151.GJ3861@tarshish>
References: <1399547827.1783.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1399547827.1783.1.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Axel Lin,

On Thu, May 08, 2014 at 07:17:07PM +0800, Axel Lin wrote:
> The dw_spi_cleanup() function was removed by commit c63f5da00845
> "spi: dw: Don't call kfree for memory allocated by devm_kzalloc".
> 
> commit ec37e8e1f0e3 "spi: dw: migrate to generic queue infrastructure" added
> dw_spi_cleanup() but never use it. So now I got below build warning:
> 
>   CC [M]  drivers/spi/spi-dw.o
> drivers/spi/spi-dw.c:609:13: warning: 'dw_spi_cleanup' defined but not used [-Wunused-function]
> 
> Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>

Acked-by: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>

Thanks,
baruch

> ---
>  drivers/spi/spi-dw.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
> index 9965e1b..29f3314 100644
> --- a/drivers/spi/spi-dw.c
> +++ b/drivers/spi/spi-dw.c
> @@ -606,12 +606,6 @@ static int dw_spi_setup(struct spi_device *spi)
>  	return 0;
>  }
>  
> -static void dw_spi_cleanup(struct spi_device *spi)
> -{
> -	struct chip_data *chip = spi_get_ctldata(spi);
> -	kfree(chip);
> -}
> -
>  /* Restart the controller, disable all interrupts, clean rx fifo */
>  static void spi_hw_init(struct dw_spi *dws)
>  {
> -- 
> 1.8.3.2

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org - tel: +972.2.679.5364, http://www.tkos.co.il -
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

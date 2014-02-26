From: Barry Song <baohua-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/3] spi: sirf: Use SIMPLE_DEV_PM_OPS macro
Date: Wed, 26 Feb 2014 16:32:14 +0800
Message-ID: <CAGsJ_4whXsMUR_pLjbvraA=pM6fn9b8i_rjSVc6HyM1LQODr1Q@mail.gmail.com>
References: <003801cf3292$0b03b4c0$210b1e40$%han@samsung.com> <003a01cf3292$a85069d0$f8f13d70$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>, Zhiwu Song <Zhiwu.Song-kQvG35nSl+M@public.gmane.org>
To: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <003a01cf3292$a85069d0$f8f13d70$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

2014-02-26 9:32 GMT+08:00 Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>:
> Use SIMPLE_DEV_PM_OPS macro in order to make the code simpler.
>
> Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

thanks, but this has been done and merged.

> ---
>  drivers/spi/spi-sirf.c |    5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/spi/spi-sirf.c b/drivers/spi/spi-sirf.c
> index 5210b94..dc962a1 100644
> --- a/drivers/spi/spi-sirf.c
> +++ b/drivers/spi/spi-sirf.c
> @@ -718,9 +718,8 @@ static int spi_sirfsoc_resume(struct device *dev)
>  }
>  #endif
>
> -static const struct dev_pm_ops spi_sirfsoc_pm_ops = {
> -       SET_SYSTEM_SLEEP_PM_OPS(spi_sirfsoc_suspend, spi_sirfsoc_resume)
> -};
> +static SIMPLE_DEV_PM_OPS(spi_sirfsoc_pm_ops, spi_sirfsoc_suspend,
> +                        spi_sirfsoc_resume);
>
>  static const struct of_device_id spi_sirfsoc_of_match[] = {
>         { .compatible = "sirf,prima2-spi", },
> --
> 1.7.10.4
>
>
-barry
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

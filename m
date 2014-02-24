From: "Ivan T. Ivanov" <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] spi: qup: Remove module version
Date: Mon, 24 Feb 2014 10:24:44 +0200
Message-ID: <1393230284.6481.1.camel@iivanov-dev>
References: <1393220892.2912.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1393220892.2912.0.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Mon, 2014-02-24 at 13:48 +0800, Axel Lin wrote: 
> The module version is unlikely to be updated, use kernel version should be
> enough.
> 
> Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/spi/spi-qup.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
> index 886edb4..203f0d4 100644
> --- a/drivers/spi/spi-qup.c
> +++ b/drivers/spi/spi-qup.c
> @@ -819,5 +819,4 @@ static struct platform_driver spi_qup_driver = {
>  module_platform_driver(spi_qup_driver);
>  
>  MODULE_LICENSE("GPL v2");
> -MODULE_VERSION("0.4");
>  MODULE_ALIAS("platform:spi_qup");

Thanks. 

Acked-by: Ivan T. Ivanov <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

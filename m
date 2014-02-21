From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: dup: Remove spi_master_put in spi_qup_remove
Date: Fri, 21 Feb 2014 09:31:56 +0800
Message-ID: <CAFRkauC5YsWRFpNu9LRFHm1a-T0jAbFYbVhk1UGGGm4bE0LBHA@mail.gmail.com>
References: <1392945066.4125.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "Ivan T. Ivanov" <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1392945066.4125.2.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Just found the subject line is wrong...
Should be spi:qup rather than spi:dup.
I'm going to resend this patch serial.

2014-02-21 9:11 GMT+08:00 Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>:
> This driver uses devm_spi_register_master() so don't explicitly call
> spi_master_put() in spi_qup_remove().
>
> Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/spi/spi-qup.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
> index b0bcc09..5edc56f 100644
> --- a/drivers/spi/spi-qup.c
> +++ b/drivers/spi/spi-qup.c
> @@ -802,7 +802,6 @@ static int spi_qup_remove(struct platform_device *pdev)
>
>         pm_runtime_put_noidle(&pdev->dev);
>         pm_runtime_disable(&pdev->dev);
> -       spi_master_put(master);
>         return 0;
>  }
>
> --
> 1.8.1.2
>
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

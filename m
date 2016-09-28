From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH -next] spi: imx: fix error return code in spi_imx_probe()
Date: Wed, 28 Sep 2016 17:29:45 +0200
Message-ID: <c1565f7c-9287-47fb-71bd-67ce52c4169e@denx.de>
References: <1475074218-13164-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Wei Yongjun <weiyongjun1-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wei Yongjun <weiyj.lk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1475074218-13164-1-git-send-email-weiyj.lk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 09/28/2016 04:50 PM, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
> 
> Fix to return error code -EINVAL if no CS GPIOs available
> instead of 0, as done elsewhere in this function.
> 
> Fixes: f13d4e189d20 ("spi: imx: Gracefully handle NULL master->cs_gpios")
> Signed-off-by: Wei Yongjun <weiyongjun1-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>

Oops, good catch, thanks.

Acked-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>

> ---
>  drivers/spi/spi-imx.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index 1ef5429..deb782f 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -1270,6 +1270,7 @@ static int spi_imx_probe(struct platform_device *pdev)
>  
>  	if (!master->cs_gpios) {
>  		dev_err(&pdev->dev, "No CS GPIOs available\n");
> +		ret = -EINVAL;
>  		goto out_clk_put;
>  	}
> 


-- 
Best regards,
Marek Vasut
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

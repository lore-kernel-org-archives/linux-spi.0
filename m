From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH -next] spi: txx9: drop clk_put for devm_clk_get in
 txx9spi_probe()
Date: Fri, 20 Dec 2013 11:35:08 +0900
Message-ID: <003001cefd2c$1923d490$4b6b7db0$%han@samsung.com>
References: <CAPgLHd_94fMwOm1Z-=4ojrhH35WHve4piJkEC5Fh8k8OZcTfsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
To: 'Wei Yongjun' <weiyj.lk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <CAPgLHd_94fMwOm1Z-=4ojrhH35WHve4piJkEC5Fh8k8OZcTfsQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-language: ko
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Friday, December 20, 2013 11:16 AM, Wei Yongjun wrote:
> 
> From: Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>
> 
> devm_clk_get() is used so there is no reason to explicitly
> call clk_put() in txx9spi_probe() functions.
> 
> Fixes: 18e34d568efa ('spi: txx9: Use devm_clk_get()')
> Signed-off-by: Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>
> ---
>  drivers/spi/spi-txx9.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-txx9.c b/drivers/spi/spi-txx9.c
> index ffbe03d..6191ced 100644
> --- a/drivers/spi/spi-txx9.c
> +++ b/drivers/spi/spi-txx9.c
> @@ -356,7 +356,6 @@ static int txx9spi_probe(struct platform_device *dev)
>  	}
>  	ret = clk_enable(c->clk);
>  	if (ret) {
> -		clk_put(c->clk);

Oops, I didn't remove this clk_put().
You're right. Thank you for fixing this.

Reviewed-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

Best regards,
Jingoo Han

>  		c->clk = NULL;
>  		goto exit;
>  	}

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH -next] spi: tegra20-slink: fix return value check in tegra_slink_init_dma_param()
Date: Mon, 16 Dec 2013 09:59:39 -0700
Message-ID: <52AF317B.2050303@wwwdotorg.org>
References: <CAPgLHd-CMEbwqXXvEK7ybSYrDeJPQfkbi+LgRepke_U=WoKmkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wei Yongjun <weiyj.lk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org,
	broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAPgLHd-CMEbwqXXvEK7ybSYrDeJPQfkbi+LgRepke_U=WoKmkA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 12/13/2013 09:42 PM, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>
> 
> In case of error, the function dma_request_slave_channel() returns
> NULL pointer not ERR_PTR(). The IS_ERR() test in the return value

> diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c

>  	dma_chan = dma_request_slave_channel(tspi->dev,
>  					     dma_to_memory ? "rx" : "tx");
> -	if (IS_ERR(dma_chan)) {
...
> +	if (!dma_chan) {

The code should be calling dma_request_slave_channel_or_reason() rather
than dma_request_slave_channel(). Dan Williams provided a patch to fix
this, which I've now applied.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

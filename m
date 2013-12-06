From: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Subject: Re: [patch v2] spi: bcm63xx-hsspi: checking for ERR_PTR instead of NULL
Date: Fri, 6 Dec 2013 15:48:08 +0100
Message-ID: <CAOiHx=k5NFrCy9yJNdn-wYeYXJixrNXVCcdyy-TOHTMtb5WvxQ@mail.gmail.com>
References: <CAOiHx=k87c_bFqFtJ7zJc9HxnjOEr2oMofNUsLkQbfQPrC04hQ@mail.gmail.com>
 <20131206141212.GA956@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131206141212.GA956-mgFCXtclrQlZLf2FXnZxJA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Fri, Dec 6, 2013 at 3:12 PM, Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org> wrote:
> devm_request_and_ioremap() returns NULL on error, it doesn't return an
> ERR_PTR().  This patch fixes it by switching to devm_ioremap_resource()
> which is the prefered function anyway.
>
> Fixes: 142168eba9dc ('spi: bcm63xx-hsspi: add bcm63xx HSSPI driver')
> Signed-off-by: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>

Thanks.

Acked-by: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>


Jonas

> ---
> v2: switch to devm_ioremap_resource()
>
> diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hsspi.c
> index bc8d848d33b7..2cfe8eb619fd 100644
> --- a/drivers/spi/spi-bcm63xx-hsspi.c
> +++ b/drivers/spi/spi-bcm63xx-hsspi.c
> @@ -338,7 +338,7 @@ static int bcm63xx_hsspi_probe(struct platform_device *pdev)
>         }
>
>         res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       regs = devm_request_and_ioremap(dev, res_mem);
> +       regs = devm_ioremap_resource(dev, res_mem);
>         if (IS_ERR(regs))
>                 return PTR_ERR(regs);
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-spi" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Subject: Re: [patch] spi: bcm63xx-hsspi: checking for ERR_PTR instead of NULL
Date: Fri, 6 Dec 2013 14:08:08 +0100
Message-ID: <CAOiHx=k87c_bFqFtJ7zJc9HxnjOEr2oMofNUsLkQbfQPrC04hQ@mail.gmail.com>
References: <20131206125823.GA32369@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131206125823.GA32369-mgFCXtclrQlZLf2FXnZxJA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Fri, Dec 6, 2013 at 1:58 PM, Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org> wrote:
> devm_request_and_ioremap() returns NULL on error, it doesn't return an
> ERR_PTR().
>
> Fixes: 142168eba9dc ('spi: bcm63xx-hsspi: add bcm63xx HSSPI driver')
> Signed-off-by: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
>
> diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hsspi.c
> index bc8d848d33b7..da9f85d55c81 100644
> --- a/drivers/spi/spi-bcm63xx-hsspi.c
> +++ b/drivers/spi/spi-bcm63xx-hsspi.c
> @@ -339,8 +339,8 @@ static int bcm63xx_hsspi_probe(struct platform_device *pdev)
>
>         res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>         regs = devm_request_and_ioremap(dev, res_mem);
> -       if (IS_ERR(regs))
> -               return PTR_ERR(regs);
> +       if (!regs)
> +               return -EADDRNOTAVAIL;

Instead of fixing the wrong handling of the return value, let's change
it to use devm_ioremap_resource() which actually returns the expected
ERR_PTR() and is preferred over request_and_ioremap().


Regards
Jonas
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

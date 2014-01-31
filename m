From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH 3/3] spi: switch to devm_spi_alloc_master
Date: Fri, 31 Jan 2014 09:18:21 -0700
Message-ID: <52EBCCCD.301@wwwdotorg.org>
References: <1391163792-21819-1-git-send-email-maxime.ripard@free-electrons.com> <1391163792-21819-4-git-send-email-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1391163792-21819-4-git-send-email-maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 01/31/2014 03:23 AM, Maxime Ripard wrote:
> Make the existing users of devm_spi_register_master use the
> devm_spi_alloc_master function to avoid leaking memory.

> diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c

> @@ -1087,14 +1085,13 @@ static int tegra_spi_probe(struct platform_device *pdev)
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "Failed to register ISR for IRQ %d\n",
>  					tspi->irq);
> -		goto exit_free_master;
> +		return ret;
>  	}
>  
>  	tspi->clk = devm_clk_get(&pdev->dev, "spi");
>  	if (IS_ERR(tspi->clk)) {
>  		dev_err(&pdev->dev, "can not get clock\n");
> -		ret = PTR_ERR(tspi->clk);
> -		goto exit_free_irq;
> +		return PTR_ERR(tspi->clk);
>  	}
>  
>  	tspi->max_buf_size = SPI_FIFO_DEPTH << 2;
> @@ -1152,8 +1149,6 @@ exit_rx_dma_free:
>  	tegra_spi_deinit_dma_param(tspi, true);
>  exit_free_irq:
>  	free_irq(spi_irq, tspi);
> -exit_free_master:
> -	spi_master_put(master);
>  	return ret;

Doesn't that s/goto exit_free_irq/return/ leak spi_irq? It's only OK to
replace goto free_master with a direct return.

The other two Tegra drivers don't seem to have this problem.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

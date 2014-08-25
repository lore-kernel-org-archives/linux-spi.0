From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH v4] spi: spi-imx: add DMA support
Date: Mon, 25 Aug 2014 10:07:22 +0200
Message-ID: <201408251007.22393.marex@denx.de>
References: <1408752835-10995-1-git-send-email-b38343@freescale.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Frank.Li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
To: Robin Gong <b38343-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1408752835-10995-1-git-send-email-b38343-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Saturday, August 23, 2014 at 02:13:55 AM, Robin Gong wrote:
> After enable DMA

Please also add a commit message which describes the change, not only some test 
results.

[...]

> @@ -911,6 +1194,13 @@ static int spi_imx_probe(struct platform_device
> *pdev) goto out_put_per;
> 
>  	spi_imx->spi_clk = clk_get_rate(spi_imx->clk_per);
> +	/*
> +	 * Only validated on i.mx6 now, can remove the constrain if validated on
> +	 * other chips.
> +	 */

Given that the check below tests for imx51_ecspi_devtype_data ... does that 
mean, that this code was never tested on MX51 and MX53, yet will be enabled
for those chips and might possibly break them ?

> +	if (spi_imx->devtype_data == &imx51_ecspi_devtype_data
> +	    && spi_imx_sdma_init(&pdev->dev, spi_imx, master, res))
> +		dev_err(&pdev->dev, "dma setup error,use pio instead\n");
> 
>  	spi_imx->devtype_data->reset(spi_imx);
> 
> @@ -949,6 +1239,7 @@ static int spi_imx_remove(struct platform_device
> *pdev) writel(0, spi_imx->base + MXC_CSPICTRL);
>  	clk_unprepare(spi_imx->clk_ipg);
>  	clk_unprepare(spi_imx->clk_per);
> +	spi_imx_sdma_exit(spi_imx);
>  	spi_master_put(master);
> 
>  	return 0;

Best regards,
Marek Vasut
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

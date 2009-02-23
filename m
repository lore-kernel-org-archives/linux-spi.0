From: Paulius Zaleckas <paulius.zaleckas@teltonika.lt>
Subject: Re: [RFC] generic iMX-spi driver
Date: Mon, 23 Feb 2009 10:57:02 +0200
Message-ID: <49A264DE.8080805@teltonika.lt>
References: <20090220144126.GA9203@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general@lists.sourceforge.net,
	linux-arm <linux-arm-kernel@lists.arm.linux.org.uk>
To: Wolfram Sang <public-w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@lo.gmane.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <20090220144126.GA9203@pengutronix.de>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
List-Id: linux-spi.vger.kernel.org

Wolfram Sang wrote:
> @@ -1646,6 +1706,8 @@ static int __exit spi_imx_remove(struct platform_device *pdev)
>  	struct driver_data *drv_data = platform_get_drvdata(pdev);
>  	int irq;
>  	int status = 0;
> +	struct spi_imx_master *platform_info =
> +			(struct spi_imx_master *)pdev->dev.platform_data;
>  
>  	if (!drv_data)
>  		return 0;
> @@ -1659,10 +1721,13 @@ static int __exit spi_imx_remove(struct platform_device *pdev)
>  		return status;
>  	}
>  
> +	if (platform_info->exit)
> +		platform_info->exit(pdev);

platform_info can be NULL here if when declaring platform_device platform data was not set.
In this case you will get crash here.
Should be if (platform_info && platform_info->exit)

> +
>  	/* Reset SPI */
> -	writel(SPI_RESET_START, drv_data->regs + SPI_RESET);
> -	writel(0, drv_data->regs + SPI_RESET);
> +	writel(drv_data->version->reset_val, drv_data->regs + drv_data->version->reset);
>  
> +#ifdef CONFIG_SPI_IMX_DMA
>  	/* Release DMA */
>  	if (drv_data->master_info->enable_dma) {
>  		RSSR(drv_data->rx_channel) = 0;
> @@ -1670,6 +1735,7 @@ static int __exit spi_imx_remove(struct platform_device *pdev)
>  		imx_dma_free(drv_data->tx_channel);
>  		imx_dma_free(drv_data->rx_channel);
>  	}
> +#endif /* DMA */
>  
>  	/* Release IRQ */
>  	irq = platform_get_irq(pdev, 0);
> @@ -1701,8 +1767,7 @@ static void spi_imx_shutdown(struct platform_device *pdev)
>  	struct driver_data *drv_data = platform_get_drvdata(pdev);
>  
>  	/* Reset SPI */
> -	writel(SPI_RESET_START, drv_data->regs + SPI_RESET);
> -	writel(0, drv_data->regs + SPI_RESET);
> +	writel(drv_data->version->reset_val, drv_data->regs + drv_data->version->reset);
>  
>  	dev_dbg(&pdev->dev, "shutdown succeded\n");
>  }
> @@ -1714,12 +1779,20 @@ static int spi_imx_suspend(struct platform_device *pdev, pm_message_t state)
>  	struct driver_data *drv_data = platform_get_drvdata(pdev);
>  	int status = 0;
>  
> +	struct spi_imx_master *platform_info =
> +			(struct spi_imx_master *)pdev->dev.platform_data;
> +
>  	status = stop_queue(drv_data);
>  	if (status != 0) {
>  		dev_warn(&pdev->dev, "suspend cannot stop queue\n");
>  		return status;
>  	}
>  
> +	if (platform_info->exit)
> +		platform_info->exit(pdev);

ditto

> +
> +	clk_disable(drv_data->clk);
> +
>  	dev_dbg(&pdev->dev, "suspended\n");
>  
>  	return 0;
> @@ -1730,6 +1803,14 @@ static int spi_imx_resume(struct platform_device *pdev)
>  	struct driver_data *drv_data = platform_get_drvdata(pdev);
>  	int status = 0;
>  
> +	struct spi_imx_master *platform_info =
> +			(struct spi_imx_master *)pdev->dev.platform_data;
> +
> +	clk_enable(drv_data->clk);
> +
> +	if (platform_info->init)
> +		platform_info->init(pdev);

ditto

> +
>  	/* Start the queue running */
>  	status = start_queue(drv_data);
>  	if (status != 0)


-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php

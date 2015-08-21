From: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 2/4 RESEND] spi: s3c64xx: extend driver to make full use of
 runtime PM autosuspend
Date: Fri, 21 Aug 2015 10:00:40 +0900
Message-ID: <55D67838.4090906@samsung.com>
References: <55D63292.9070703@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <55D63292.9070703-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 21.08.2015 05:03, Heiner Kallweit wrote:
> Extend the driver to make full use of runtime PM autosuspend.
> Before only the SPI core was instructed to use autosuspend
> by setting master->auto_runtime_pm. Nevertheless due to the missing
> pm_runtime_use_autosuspend call autosuspend wasn't active.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
> Changed:
> - Let driver autosuspend also after leaving s3c64xx_spi_setup
> - Enable runtime PM earlier in s3c64xx_spi_probe and prevent
>   suspending in the relevant part of probe
> 
>  drivers/spi/spi-s3c64xx.c | 32 +++++++++++++++++++++-----------
>  1 file changed, 21 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index 8a6ab88..edeac06 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -32,6 +32,7 @@
>  #define MAX_SPI_PORTS		6
>  #define S3C64XX_SPI_QUIRK_POLL		(1 << 0)
>  #define S3C64XX_SPI_QUIRK_CS_AUTO	(1 << 1)
> +#define AUTOSUSPEND_TIMEOUT	2000
>  
>  /* Registers and bit-fields */
>  
> @@ -859,13 +860,15 @@ static int s3c64xx_spi_setup(struct spi_device *spi)
>  		}
>  	}
>  
> -	pm_runtime_put(&sdd->pdev->dev);
> +	pm_runtime_mark_last_busy(&sdd->pdev->dev);
> +	pm_runtime_put_autosuspend(&sdd->pdev->dev);
>  	if (!(sdd->port_conf->quirks & S3C64XX_SPI_QUIRK_CS_AUTO))
>  		writel(S3C64XX_SPI_SLAVE_SIG_INACT, sdd->regs + S3C64XX_SPI_SLAVE_SEL);
>  	return 0;
>  
>  setup_exit:
> -	pm_runtime_put(&sdd->pdev->dev);
> +	pm_runtime_mark_last_busy(&sdd->pdev->dev);
> +	pm_runtime_put_autosuspend(&sdd->pdev->dev);
>  	/* setup() returns with device de-selected */
>  	if (!(sdd->port_conf->quirks & S3C64XX_SPI_QUIRK_CS_AUTO))
>  		writel(S3C64XX_SPI_SLAVE_SIG_INACT, sdd->regs + S3C64XX_SPI_SLAVE_SEL);
> @@ -1133,18 +1136,24 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
>  		goto err0;
>  	}
>  
> +	pm_runtime_set_autosuspend_delay(&pdev->dev, AUTOSUSPEND_TIMEOUT);
> +	pm_runtime_use_autosuspend(&pdev->dev);
> +	pm_runtime_set_active(&pdev->dev);
> +	pm_runtime_enable(&pdev->dev);

I think you should not enable the PM runtime too early. The PM runtime
callbacks can be fired now but driver did not get references to clocks yet.

Best regards,
Krzysztof

> +	pm_runtime_get_noresume(&pdev->dev);
> +
>  	/* Setup clocks */
>  	sdd->clk = devm_clk_get(&pdev->dev, "spi");
>  	if (IS_ERR(sdd->clk)) {
>  		dev_err(&pdev->dev, "Unable to acquire clock 'spi'\n");
>  		ret = PTR_ERR(sdd->clk);
> -		goto err0;
> +		goto err1;
>  	}
>  
>  	if (clk_prepare_enable(sdd->clk)) {
>  		dev_err(&pdev->dev, "Couldn't enable clock 'spi'\n");
>  		ret = -EBUSY;
> -		goto err0;
> +		goto err1;
>  	}
>  
>  	sprintf(clk_name, "spi_busclk%d", sci->src_clk_nr);
> @@ -1180,13 +1189,10 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
>  	       S3C64XX_SPI_INT_TX_OVERRUN_EN | S3C64XX_SPI_INT_TX_UNDERRUN_EN,
>  	       sdd->regs + S3C64XX_SPI_INT_EN);
>  
> -	pm_runtime_set_active(&pdev->dev);
> -	pm_runtime_enable(&pdev->dev);
> -
>  	ret = devm_spi_register_master(&pdev->dev, master);
>  	if (ret != 0) {
>  		dev_err(&pdev->dev, "cannot register SPI master: %d\n", ret);
> -		goto err4;
> +		goto err3;
>  	}
>  
>  	dev_dbg(&pdev->dev, "Samsung SoC SPI Driver loaded for Bus SPI-%d with %d Slaves attached\n",
> @@ -1195,15 +1201,19 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
>  					mem_res, (FIFO_LVL_MASK(sdd) >> 1) + 1,
>  					sdd->rx_dma.dmach, sdd->tx_dma.dmach);
>  
> +	pm_runtime_mark_last_busy(&pdev->dev);
> +	pm_runtime_put_autosuspend(&pdev->dev);
> +
>  	return 0;
>  
> -err4:
> -	pm_runtime_disable(&pdev->dev);
> -	pm_runtime_set_suspended(&pdev->dev);
>  err3:
>  	clk_disable_unprepare(sdd->src_clk);
>  err2:
>  	clk_disable_unprepare(sdd->clk);
> +err1:
> +	pm_runtime_put_noidle(&pdev->dev);
> +	pm_runtime_disable(&pdev->dev);
> +	pm_runtime_set_suspended(&pdev->dev);
>  err0:
>  	spi_master_put(master);
>  
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] pxa2xx_spi.c: remove redundant
	initialization, spelling fix, more verbose error
Date: Wed, 4 Jun 2008 12:32:38 -0700
Message-ID: <200806041232.39106.david-b@pacbell.net>
References: <Pine.LNX.4.64.0806041645070.32657@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guennadi Liakhovetski <g.liakhovetski-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.64.0806041645070.32657-0199iw4Nj15frtckUFj5Ag@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wednesday 04 June 2008, Guennadi Liakhovetski wrote:
> Minor fixes: remove redundant local variable initialization, fix "can not" to
> what I _think_ is a preferred spelling, output IRQ number if requesting it
> failed.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

Acked-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>

> 
> ---
> 
> Nothing urgent, just, please, queue it for 2.6.27. Thanks
> 
> diff --git a/drivers/spi/pxa2xx_spi.c b/drivers/spi/pxa2xx_spi.c
> index 0c452c4..4cf72e9 100644
> --- a/drivers/spi/pxa2xx_spi.c
> +++ b/drivers/spi/pxa2xx_spi.c
> @@ -1342,9 +1342,9 @@ static int __init pxa2xx_spi_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct pxa2xx_spi_master *platform_info;
>  	struct spi_master *master;
> -	struct driver_data *drv_data = NULL;
> +	struct driver_data *drv_data;
>  	struct ssp_device *ssp;
> -	int status = 0;
> +	int status;
>  
>  	platform_info = dev->platform_data;
>  
> @@ -1357,7 +1357,7 @@ static int __init pxa2xx_spi_probe(struct platform_device *pdev)
>  	/* Allocate master with space for drv_data and null dma buffer */
>  	master = spi_alloc_master(dev, sizeof(struct driver_data) + 16);
>  	if (!master) {
> -		dev_err(&pdev->dev, "can not alloc spi_master\n");
> +		dev_err(&pdev->dev, "cannot alloc spi_master\n");
>  		ssp_free(ssp);
>  		return -ENOMEM;
>  	}
> @@ -1393,7 +1393,7 @@ static int __init pxa2xx_spi_probe(struct platform_device *pdev)
>  
>  	status = request_irq(ssp->irq, ssp_int, 0, dev->bus_id, drv_data);
>  	if (status < 0) {
> -		dev_err(&pdev->dev, "can not get IRQ\n");
> +		dev_err(&pdev->dev, "cannot get IRQ %d\n", ssp->irq);
>  		goto out_error_master_alloc;
>  	}
>  
> 



-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php

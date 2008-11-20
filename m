From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 06/16] Blackfin SPI Driver: unify
	duplicated code in dma read/write paths
Date: Thu, 20 Nov 2008 12:32:16 -0800
Message-ID: <200811201232.16712.david-b@pacbell.net>
References: <1226994760-4301-1-git-send-email-cooloney@kernel.org>
	<1226994760-4301-7-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Mike Frysinger <vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1226994760-4301-7-git-send-email-cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Monday 17 November 2008, Bryan Wu wrote:
> From: Mike Frysinger <vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> Signed-off-by: Mike Frysinger <vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

Acked-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>

assuming:  this patch grows a real patch comment
instead of only having the long $SUBJECT ...


> ---
>  drivers/spi/spi_bfin5xx.c |   47 ++++++++++++++++++++------------------------
>  1 files changed, 21 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/spi/spi_bfin5xx.c b/drivers/spi/spi_bfin5xx.c
> index 642c402..df424a2 100644
> --- a/drivers/spi/spi_bfin5xx.c
> +++ b/drivers/spi/spi_bfin5xx.c
> @@ -755,18 +755,19 @@ static void pump_transfers(unsigned long data)
>  	if (!full_duplex && drv_data->cur_chip->enable_dma
>  				&& drv_data->len > 6) {
>  
> +		unsigned long dma_start_addr;
> +
>  		disable_dma(drv_data->dma_channel);
>  		clear_dma_irqstat(drv_data->dma_channel);
>  		bfin_spi_disable(drv_data);
>  
>  		/* config dma channel */
>  		dev_dbg(&drv_data->pdev->dev, "doing dma transfer\n");
> +		set_dma_x_count(drv_data->dma_channel, drv_data->len);
>  		if (width == CFG_SPI_WORDSIZE16) {
> -			set_dma_x_count(drv_data->dma_channel, drv_data->len);
>  			set_dma_x_modify(drv_data->dma_channel, 2);
>  			dma_width = WDSIZE_16;
>  		} else {
> -			set_dma_x_count(drv_data->dma_channel, drv_data->len);
>  			set_dma_x_modify(drv_data->dma_channel, 1);
>  			dma_width = WDSIZE_8;
>  		}
> @@ -801,6 +802,7 @@ static void pump_transfers(unsigned long data)
>  		}
>  
>  		/* In dma mode, rx or tx must be NULL in one transfer */
> +		dma_config = (RESTART | dma_width | DI_EN);
>  		if (drv_data->rx != NULL) {
>  			/* set transfer mode, and enable SPI */
>  			dev_dbg(&drv_data->pdev->dev, "doing DMA in.\n");
> @@ -814,19 +816,9 @@ static void pump_transfers(unsigned long data)
>  			/* clear tx reg soformer data is not shifted out */
>  			write_TDBR(drv_data, 0xFFFF);
>  
> -			set_dma_x_count(drv_data->dma_channel, drv_data->len);
> -
> -			/* start dma */
> -			dma_enable_irq(drv_data->dma_channel);
> -			dma_config = (WNR | RESTART | dma_width | DI_EN);
> -			set_dma_config(drv_data->dma_channel, dma_config);
> -			set_dma_start_addr(drv_data->dma_channel,
> -					(unsigned long)drv_data->rx);
> -			enable_dma(drv_data->dma_channel);
> -
> -			/* start SPI transfer */
> -			write_CTRL(drv_data,
> -				(cr | CFG_SPI_DMAREAD | BIT_CTL_ENABLE));
> +			dma_config |= WNR;
> +			dma_start_addr = (unsigned long)drv_data->rx;
> +			cr |= CFG_SPI_DMAREAD;
>  
>  		} else if (drv_data->tx != NULL) {
>  			dev_dbg(&drv_data->pdev->dev, "doing DMA out.\n");
> @@ -837,18 +829,21 @@ static void pump_transfers(unsigned long data)
>  						(unsigned long) (drv_data->tx +
>  						drv_data->len_in_bytes));
>  
> -			/* start dma */
> -			dma_enable_irq(drv_data->dma_channel);
> -			dma_config = (RESTART | dma_width | DI_EN);
> -			set_dma_config(drv_data->dma_channel, dma_config);
> -			set_dma_start_addr(drv_data->dma_channel,
> -					(unsigned long)drv_data->tx);
> -			enable_dma(drv_data->dma_channel);
> +			dma_start_addr = (unsigned long)drv_data->tx;
> +			cr |= CFG_SPI_DMAWRITE;
> +
> +		} else
> +			BUG();
> +
> +		/* start dma */
> +		dma_enable_irq(drv_data->dma_channel);
> +		set_dma_config(drv_data->dma_channel, dma_config);
> +		set_dma_start_addr(drv_data->dma_channel, dma_start_addr);
> +		enable_dma(drv_data->dma_channel);
> +
> +		/* start SPI transfer */
> +		write_CTRL(drv_data, (cr | BIT_CTL_ENABLE));
>  
> -			/* start SPI transfer */
> -			write_CTRL(drv_data,
> -				(cr | CFG_SPI_DMAWRITE | BIT_CTL_ENABLE));
> -		}
>  	} else {
>  		/* IO mode write then read */
>  		dev_dbg(&drv_data->pdev->dev, "doing IO transfer\n");
> -- 
> 1.5.6.3
> 
> 



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/

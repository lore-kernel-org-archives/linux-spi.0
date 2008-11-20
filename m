From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 12/16] Blackfin SPI Driver: get dma
	working for SPI flashes
Date: Thu, 20 Nov 2008 12:43:32 -0800
Message-ID: <200811201243.32749.david-b@pacbell.net>
References: <1226994760-4301-1-git-send-email-cooloney@kernel.org>
	<1226994760-4301-13-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Mike Frysinger <vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1226994760-4301-13-git-send-email-cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
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
> When using a BF533-STAMP here with a W25X10 SPI flash. It works fine when
> enable_dma is disabled, but doesn't work at all when turning DMA on.
> We get just 0xff bytes back when trying to read the device.
> 
> If change the code around so that it programs the SPI first and then
> enables DMA, it seems to work a lot better ...
> 
> Signed-off-by: Mike Frysinger <vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

Acked-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>

... and I observe some MM patches from you related to bugs
identifying those chips; good to know I wasn't the only
one to trip over those regressions!


> ---
>  drivers/spi/spi_bfin5xx.c |   26 ++++++++++++++++----------
>  1 files changed, 16 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/spi/spi_bfin5xx.c b/drivers/spi/spi_bfin5xx.c
> index fba77c2..5cd4873 100644
> --- a/drivers/spi/spi_bfin5xx.c
> +++ b/drivers/spi/spi_bfin5xx.c
> @@ -760,11 +760,10 @@ static void pump_transfers(unsigned long data)
>  	if (!full_duplex && drv_data->cur_chip->enable_dma
>  				&& drv_data->len > 6) {
>  
> -		unsigned long dma_start_addr;
> +		unsigned long dma_start_addr, flags;
>  
>  		disable_dma(drv_data->dma_channel);
>  		clear_dma_irqstat(drv_data->dma_channel);
> -		bfin_spi_disable(drv_data);
>  
>  		/* config dma channel */
>  		dev_dbg(&drv_data->pdev->dev, "doing dma transfer\n");
> @@ -795,8 +794,7 @@ static void pump_transfers(unsigned long data)
>  			enable_dma(drv_data->dma_channel);
>  
>  			/* start SPI transfer */
> -			write_CTRL(drv_data,
> -				(cr | BIT_CTL_TIMOD_DMA_TX | BIT_CTL_ENABLE));
> +			write_CTRL(drv_data, cr | BIT_CTL_TIMOD_DMA_TX);
>  
>  			/* just return here, there can only be one transfer
>  			 * in this mode
> @@ -838,14 +836,22 @@ static void pump_transfers(unsigned long data)
>  		} else
>  			BUG();
>  
> -		/* start dma */
> -		dma_enable_irq(drv_data->dma_channel);
> -		set_dma_config(drv_data->dma_channel, dma_config);
> +		/* oh man, here there be monsters ... and i dont mean the
> +		 * fluffy cute ones from pixar, i mean the kind that'll eat
> +		 * your data, kick your dog, and love it all.  do *not* try
> +		 * and change these lines unless you (1) heavily test DMA
> +		 * with SPI flashes on a loaded system (e.g. ping floods),
> +		 * (2) know just how broken the DMA engine interaction with
> +		 * the SPI peripheral is, and (3) have someone else to blame
> +		 * when you screw it all up anyways.
> +		 */
>  		set_dma_start_addr(drv_data->dma_channel, dma_start_addr);
> +		set_dma_config(drv_data->dma_channel, dma_config);
> +		local_irq_save(flags);
>  		enable_dma(drv_data->dma_channel);
> -
> -		/* start SPI transfer */
> -		write_CTRL(drv_data, (cr | BIT_CTL_ENABLE));
> +		write_CTRL(drv_data, cr);
> +		dma_enable_irq(drv_data->dma_channel);
> +		local_irq_restore(flags);
>  
>  	} else {
>  		/* IO mode write then read */
> -- 
> 1.5.6.3
> 
> 



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/

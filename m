From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 04/16] Blackfin SPI Driver: use
	len_in_bytes when we care about the number of bytes transferred
Date: Thu, 20 Nov 2008 12:25:28 -0800
Message-ID: <200811201225.28758.david-b@pacbell.net>
References: <1226994760-4301-1-git-send-email-cooloney@kernel.org>
	<1226994760-4301-5-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Mike Frysinger <vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1226994760-4301-5-git-send-email-cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
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
> Use len_in_bytes when we care about the number of bytes transferred
> rather than the number of spi transactions. (this value will be the
> same for 8bit transfers, but not any other sizes)
> 
> Signed-off-by: Mike Frysinger <vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

Acked-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>


> ---
>  drivers/spi/spi_bfin5xx.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/spi/spi_bfin5xx.c b/drivers/spi/spi_bfin5xx.c
> index 6c5671e..cc415e8 100644
> --- a/drivers/spi/spi_bfin5xx.c
> +++ b/drivers/spi/spi_bfin5xx.c
> @@ -803,7 +803,7 @@ static void pump_transfers(unsigned long data)
>  			if (bfin_addr_dcachable((unsigned long) drv_data->rx))
>  				invalidate_dcache_range((unsigned long) drv_data->rx,
>  							(unsigned long) (drv_data->rx +
> -							drv_data->len));
> +							drv_data->len_in_bytes));
>  
>  			/* clear tx reg soformer data is not shifted out */
>  			write_TDBR(drv_data, 0xFFFF);
> @@ -829,7 +829,7 @@ static void pump_transfers(unsigned long data)
>  			if (bfin_addr_dcachable((unsigned long) drv_data->tx))
>  				flush_dcache_range((unsigned long) drv_data->tx,
>  						(unsigned long) (drv_data->tx +
> -						drv_data->len));
> +						drv_data->len_in_bytes));
>  
>  			/* start dma */
>  			dma_enable_irq(drv_data->dma_channel);
> @@ -892,7 +892,7 @@ static void pump_transfers(unsigned long data)
>  			message->state = ERROR_STATE;
>  		} else {
>  			/* Update total byte transfered */
> -			message->actual_length += drv_data->len;
> +			message->actual_length += drv_data->len_in_bytes;
>  
>  			/* Move to next transfer of this msg */
>  			message->state = next_transfer(drv_data);
> -- 
> 1.5.6.3
> 
> 



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/

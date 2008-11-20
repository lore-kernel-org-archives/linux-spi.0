From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 16/16] Blackfin SPI Driver: fix bug
	- correct usage of struct spi_transfer.cs_change
Date: Thu, 20 Nov 2008 12:51:33 -0800
Message-ID: <200811201251.33339.david-b@pacbell.net>
References: <1226994760-4301-1-git-send-email-cooloney@kernel.org>
	<1226994760-4301-17-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Yi Li <yi.li-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1226994760-4301-17-git-send-email-cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
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
> From: Yi Li <yi.li-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
> 
> According to comments in linux/spi/spi.h:
> 
>  * All SPI transfers start with the relevant chipselect active.  Normally
>  * it stays selected until after the last transfer in a message. Drivers
>  * can affect the chipselect signal using cs_change.
>  *
>  * (i) If the transfer isn't the last one in the message, this flag is
>  * used to make the chipselect briefly go inactive in the middle of the
>  * message.  Toggling chipselect in this way may be needed to terminate
>  * a chip command, letting a single spi_message perform all of group of
>  * chip transactions together.
>  *
>  * (ii) When the transfer is the last one in the message, the chip may
>  * stay selected until the next transfer.  On multi-device SPI busses
>  * with nothing blocking messages going to other devices, this is just
>  * a performance hint; starting a message to another device deselects
>  * this one.  But in other cases, this can be used to ensure correctness.
>  * Some devices need protocol transactions to be built from a series of
>  * spi_message submissions, where the content of one message is determined
>  * by the results of previous messages and where the whole transaction
>  * ends when the chipselect goes intactive.
> 
> Signed-off-by: Yi Li <yi.li-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

Acked-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>

> ---
>  drivers/spi/spi_bfin5xx.c |   15 ++++++++-------
>  1 files changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/spi/spi_bfin5xx.c b/drivers/spi/spi_bfin5xx.c
> index 8cf5d6e..0e3102a 100644
> --- a/drivers/spi/spi_bfin5xx.c
> +++ b/drivers/spi/spi_bfin5xx.c
> @@ -540,15 +540,13 @@ static void giveback(struct driver_data *drv_data)
>  
>  	msg->state = NULL;
>  
> -	/* disable chip select signal. And not stop spi in autobuffer mode */
> -	if (drv_data->tx_dma != 0xFFFF) {
> -		cs_deactive(drv_data, chip);
> -		bfin_spi_disable(drv_data);
> -	}
> -
>  	if (!drv_data->cs_change)
>  		cs_deactive(drv_data, chip);
>  
> +	/* Not stop spi in autobuffer mode */
> +	if (drv_data->tx_dma != 0xFFFF)
> +		bfin_spi_disable(drv_data);
> +
>  	if (msg->complete)
>  		msg->complete(msg->context);
>  }
> @@ -757,7 +755,8 @@ static void pump_transfers(unsigned long data)
>  
>  	write_STAT(drv_data, BIT_STAT_CLR);
>  	cr = (read_CTRL(drv_data) & (~BIT_CTL_TIMOD));
> -	cs_active(drv_data, chip);
> +	if (drv_data->cs_change)
> +		cs_active(drv_data, chip);
>  
>  	dev_dbg(&drv_data->pdev->dev,
>  		"now pumping a transfer: width is %d, len is %d\n",
> @@ -920,6 +919,8 @@ static void pump_transfers(unsigned long data)
>  			message->state = next_transfer(drv_data);
>  		}
>  
> +		if (drv_data->cs_change)
> +			cs_active(drv_data, chip);
>  		/* Schedule next transfer tasklet */
>  		tasklet_schedule(&drv_data->pump_transfers);
>  
> -- 
> 1.5.6.3
> 
> 



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/

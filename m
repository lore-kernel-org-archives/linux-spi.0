From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 07/16] Blackfin SPI Driver: drop
	bogus cast and touchup dma label
Date: Thu, 20 Nov 2008 12:34:02 -0800
Message-ID: <200811201234.02701.david-b@pacbell.net>
References: <1226994760-4301-1-git-send-email-cooloney@kernel.org>
	<1226994760-4301-8-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Mike Frysinger <vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1226994760-4301-8-git-send-email-cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
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

... again, please to include real patch comments
not just long $SUBJECT lines

> ---
>  drivers/spi/spi_bfin5xx.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi_bfin5xx.c b/drivers/spi/spi_bfin5xx.c
> index df424a2..a7c8976 100644
> --- a/drivers/spi/spi_bfin5xx.c
> +++ b/drivers/spi/spi_bfin5xx.c
> @@ -1076,13 +1076,13 @@ static int setup(struct spi_device *spi)
>  	 */
>  	if (chip->enable_dma && !drv_data->dma_requested) {
>  		/* register dma irq handler */
> -		if (request_dma(drv_data->dma_channel, "BF53x_SPI_DMA") < 0) {
> +		if (request_dma(drv_data->dma_channel, "BFIN_SPI_DMA") < 0) {
>  			dev_dbg(&spi->dev,
>  				"Unable to request BlackFin SPI DMA channel\n");
>  			return -ENODEV;
>  		}
>  		if (set_dma_callback(drv_data->dma_channel,
> -			(void *)dma_irq_handler, drv_data) < 0) {
> +		    dma_irq_handler, drv_data) < 0) {
>  			dev_dbg(&spi->dev, "Unable to set dma callback\n");
>  			return -EPERM;
>  		}
> -- 
> 1.5.6.3
> 
> 



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/

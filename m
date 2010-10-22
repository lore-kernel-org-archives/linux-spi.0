From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 2/2] spi/bfin_spi: handle
 error/status changes after data interrupts
Date: Fri, 22 Oct 2010 01:28:01 -0600
Message-ID: <20101022072801.GC8205@angua.secretlab.ca>
References: <1287727308-26653-1-git-send-email-vapier@gentoo.org>
	<1287727308-26653-2-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
        David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
        Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>,
        uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1287727308-26653-2-git-send-email-vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Fri, Oct 22, 2010 at 02:01:48AM -0400, Mike Frysinger wrote:
> From: Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
> 
> The error interrupt on the BF537 SIC cannot be enabled on a
> per-peripheral basis.  Once the error interrupt is enabled
> for one peripheral, it is automatically enabled for all.
> 
> So in the Blackfin on-chip SPI driver, we need to clear out
> these known errors in the data interrupt once we've successfully
> finished processing all of the pending data.
> 
> Signed-off-by: Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
> ---

merged, thanks.

g.

>  drivers/spi/spi_bfin5xx.c |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/spi/spi_bfin5xx.c b/drivers/spi/spi_bfin5xx.c
> index a8f276d..3f22351 100644
> --- a/drivers/spi/spi_bfin5xx.c
> +++ b/drivers/spi/spi_bfin5xx.c
> @@ -504,6 +504,15 @@ static irqreturn_t bfin_spi_dma_irq_handler(int irq, void *dev_id)
>  		"in dma_irq_handler dmastat:0x%x spistat:0x%x\n",
>  		dmastat, spistat);
>  
> +	if (drv_data->rx != NULL) {
> +		u16 cr = read_CTRL(drv_data);
> +		/* discard old RX data and clear RXS */
> +		bfin_spi_dummy_read(drv_data);
> +		write_CTRL(drv_data, cr & ~BIT_CTL_ENABLE); /* Disable SPI */
> +		write_CTRL(drv_data, cr & ~BIT_CTL_TIMOD); /* Restore State */
> +		write_STAT(drv_data, BIT_STAT_CLR); /* Clear Status */
> +	}
> +
>  	clear_dma_irqstat(drv_data->dma_channel);
>  
>  	/*
> -- 
> 1.7.3.1
> 

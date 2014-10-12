From: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 07/12] spi/atmel: use dmaengine_terminate_all() API
Date: Sun, 12 Oct 2014 22:06:01 +0200
Message-ID: <543ADF29.9090307@atmel.com>
References: <1413041973-28146-1-git-send-email-vinod.koul@intel.com> <1413042040-28222-7-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, <dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1413042040-28222-7-git-send-email-vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 11/10/2014 17:40, Vinod Koul :
> The drivers should use dmaengine_terminate_all() API instead of
> accessing the device_control which will be deprecated soon
> 
> Signed-off-by: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

sure:
Acked-by: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>

Thanks Vinod.

Bye,

> ---
>  drivers/spi/spi-atmel.c |    6 ++----
>  1 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
> index 113c83f..649dcb5 100644
> --- a/drivers/spi/spi-atmel.c
> +++ b/drivers/spi/spi-atmel.c
> @@ -482,11 +482,9 @@ error:
>  static void atmel_spi_stop_dma(struct atmel_spi *as)
>  {
>  	if (as->dma.chan_rx)
> -		as->dma.chan_rx->device->device_control(as->dma.chan_rx,
> -							DMA_TERMINATE_ALL, 0);
> +		dmaengine_terminate_all(as->dma.chan_rx);
>  	if (as->dma.chan_tx)
> -		as->dma.chan_tx->device->device_control(as->dma.chan_tx,
> -							DMA_TERMINATE_ALL, 0);
> +		dmaengine_terminate_all(as->dma.chan_tx);
>  }
>  
>  static void atmel_spi_release_dma(struct atmel_spi *as)
> 


-- 
Nicolas Ferre
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

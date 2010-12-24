From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 2/4] spi/pl022: pass the returned sglen to the DMA engine
Date: Thu, 23 Dec 2010 21:07:29 -0700
Message-ID: <20101224040729.GH2491@angua.secretlab.ca>
References: <1293056017-12929-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1293056017-12929-1-git-send-email-linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, Dec 22, 2010 at 11:13:37PM +0100, Linus Walleij wrote:
> The sglen return by the dma_map_sg() should be passed to the DMA
> engine, not the one passed in. If we one day have a DMA mapper
> that can coalesce entries, this will bug due to a too large
> number of entries being passed in.
> 
> Reported-by: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
> Signed-off-by: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>

Merged for -next, thanks.

g.

> ---
>  drivers/spi/amba-pl022.c |   14 +++++++-------
>  1 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/spi/amba-pl022.c b/drivers/spi/amba-pl022.c
> index 9a14c45..40189c5 100644
> --- a/drivers/spi/amba-pl022.c
> +++ b/drivers/spi/amba-pl022.c
> @@ -917,7 +917,7 @@ static int configure_dma(struct pl022 *pl022)
>  	};
>  	unsigned int pages;
>  	int ret;
> -	int sglen;
> +	int rx_sglen, tx_sglen;
>  	struct dma_chan *rxchan = pl022->dma_rx_channel;
>  	struct dma_chan *txchan = pl022->dma_tx_channel;
>  	struct dma_async_tx_descriptor *rxdesc;
> @@ -991,20 +991,20 @@ static int configure_dma(struct pl022 *pl022)
>  			  pl022->cur_transfer->len, &pl022->sgt_tx);
>  
>  	/* Map DMA buffers */
> -	sglen = dma_map_sg(rxchan->device->dev, pl022->sgt_rx.sgl,
> +	rx_sglen = dma_map_sg(rxchan->device->dev, pl022->sgt_rx.sgl,
>  			   pl022->sgt_rx.nents, DMA_FROM_DEVICE);
> -	if (!sglen)
> +	if (!rx_sglen)
>  		goto err_rx_sgmap;
>  
> -	sglen = dma_map_sg(txchan->device->dev, pl022->sgt_tx.sgl,
> +	tx_sglen = dma_map_sg(txchan->device->dev, pl022->sgt_tx.sgl,
>  			   pl022->sgt_tx.nents, DMA_TO_DEVICE);
> -	if (!sglen)
> +	if (!tx_sglen)
>  		goto err_tx_sgmap;
>  
>  	/* Send both scatterlists */
>  	rxdesc = rxchan->device->device_prep_slave_sg(rxchan,
>  				      pl022->sgt_rx.sgl,
> -				      pl022->sgt_rx.nents,
> +				      rx_sglen,
>  				      DMA_FROM_DEVICE,
>  				      DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
>  	if (!rxdesc)
> @@ -1012,7 +1012,7 @@ static int configure_dma(struct pl022 *pl022)
>  
>  	txdesc = txchan->device->device_prep_slave_sg(txchan,
>  				      pl022->sgt_tx.sgl,
> -				      pl022->sgt_tx.nents,
> +				      tx_sglen,
>  				      DMA_TO_DEVICE,
>  				      DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
>  	if (!txdesc)
> -- 
> 1.7.3.3
> 

------------------------------------------------------------------------------
Learn how Oracle Real Application Clusters (RAC) One Node allows customers
to consolidate database storage, standardize their database environment, and, 
should the need arise, upgrade to a full multi-node Oracle RAC database 
without downtime or disruption
http://p.sf.net/sfu/oracle-sfdevnl

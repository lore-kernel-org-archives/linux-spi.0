From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH v2 4/4] spi/dw_spi: improve the interrupt mode with the
	batch ops
Date: Wed, 30 Mar 2011 21:32:45 -0600
Message-ID: <20110331033245.GF19333@ponder.secretlab.ca>
References: <1301497795-6924-1-git-send-email-feng.tang@intel.com>
	<1301497795-6924-5-git-send-email-feng.tang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	alek.du-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
To: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1301497795-6924-5-git-send-email-feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, Mar 30, 2011 at 11:09:55PM +0800, Feng Tang wrote:
> From: Alek Du <alek.du-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> 
> leverage the performance gain by change in low level
> read/write batch operations
> 
> Signed-off-by: Alek Du <alek.du-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

Applied, thanks.

g.

> ---
>  drivers/spi/dw_spi.c |   63 ++++++++++++-------------------------------------
>  1 files changed, 16 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/spi/dw_spi.c b/drivers/spi/dw_spi.c
> index 7a2a722..855ac4a 100644
> --- a/drivers/spi/dw_spi.c
> +++ b/drivers/spi/dw_spi.c
> @@ -190,21 +190,7 @@ static inline u32 rx_max(struct dw_spi *dws)
>  	return min(rx_left, (u32)dw_readw(dws, rxflr));
>  }
>  
> -
> -static void wait_till_not_busy(struct dw_spi *dws)
> -{
> -	unsigned long end = jiffies + 1 + usecs_to_jiffies(5000);
> -
> -	while (time_before(jiffies, end)) {
> -		if (!(dw_readw(dws, sr) & SR_BUSY))
> -			return;
> -		cpu_relax();
> -	}
> -	dev_err(&dws->master->dev,
> -		"DW SPI: Status keeps busy for 5000us after a read/write!\n");
> -}
> -
> -static int dw_writer(struct dw_spi *dws)
> +static void dw_writer(struct dw_spi *dws)
>  {
>  	u32 max = tx_max(dws);
>  	u16 txw = 0;
> @@ -220,11 +206,9 @@ static int dw_writer(struct dw_spi *dws)
>  		dw_writew(dws, dr, txw);
>  		dws->tx += dws->n_bytes;
>  	}
> -
> -	return 1;
>  }
>  
> -static int dw_reader(struct dw_spi *dws)
> +static void dw_reader(struct dw_spi *dws)
>  {
>  	u32 max = rx_max(dws);
>  	u16 rxw;
> @@ -240,8 +224,6 @@ static int dw_reader(struct dw_spi *dws)
>  		}
>  		dws->rx += dws->n_bytes;
>  	}
> -
> -	return dws->rx == dws->rx_end;
>  }
>  
>  static void *next_transfer(struct dw_spi *dws)
> @@ -340,35 +322,28 @@ EXPORT_SYMBOL_GPL(dw_spi_xfer_done);
>  
>  static irqreturn_t interrupt_transfer(struct dw_spi *dws)
>  {
> -	u16 irq_status, irq_mask = 0x3f;
> -	u32 int_level = dws->fifo_len / 2;
> -	u32 left;
> +	u16 irq_status = dw_readw(dws, isr);
>  
> -	irq_status = dw_readw(dws, isr) & irq_mask;
>  	/* Error handling */
>  	if (irq_status & (SPI_INT_TXOI | SPI_INT_RXOI | SPI_INT_RXUI)) {
>  		dw_readw(dws, txoicr);
>  		dw_readw(dws, rxoicr);
>  		dw_readw(dws, rxuicr);
> -		int_error_stop(dws, "interrupt_transfer: fifo overrun");
> +		int_error_stop(dws, "interrupt_transfer: fifo overrun/underrun");
>  		return IRQ_HANDLED;
>  	}
>  
> +	dw_reader(dws);
> +	if (dws->rx_end == dws->rx) {
> +		spi_mask_intr(dws, SPI_INT_TXEI);
> +		dw_spi_xfer_done(dws);
> +		return IRQ_HANDLED;
> +	}
>  	if (irq_status & SPI_INT_TXEI) {
>  		spi_mask_intr(dws, SPI_INT_TXEI);
> -
> -		left = (dws->tx_end - dws->tx) / dws->n_bytes;
> -		left = (left > int_level) ? int_level : left;
> -
> -		while (left--)
> -			dw_writer(dws);
> -		dw_reader(dws);
> -
> -		/* Re-enable the IRQ if there is still data left to tx */
> -		if (dws->tx_end > dws->tx)
> -			spi_umask_intr(dws, SPI_INT_TXEI);
> -		else
> -			dw_spi_xfer_done(dws);
> +		dw_writer(dws);
> +		/* Enable TX irq always, it will be disabled when RX finished */
> +		spi_umask_intr(dws, SPI_INT_TXEI);
>  	}
>  
>  	return IRQ_HANDLED;
> @@ -377,15 +352,13 @@ static irqreturn_t interrupt_transfer(struct dw_spi *dws)
>  static irqreturn_t dw_spi_irq(int irq, void *dev_id)
>  {
>  	struct dw_spi *dws = dev_id;
> -	u16 irq_status, irq_mask = 0x3f;
> +	u16 irq_status = dw_readw(dws, isr) & 0x3f;
>  
> -	irq_status = dw_readw(dws, isr) & irq_mask;
>  	if (!irq_status)
>  		return IRQ_NONE;
>  
>  	if (!dws->cur_msg) {
>  		spi_mask_intr(dws, SPI_INT_TXEI);
> -		/* Never fail */
>  		return IRQ_HANDLED;
>  	}
>  
> @@ -492,12 +465,8 @@ static void pump_transfers(unsigned long data)
>  
>  		switch (bits) {
>  		case 8:
> -			dws->n_bytes = 1;
> -			dws->dma_width = 1;
> -			break;
>  		case 16:
> -			dws->n_bytes = 2;
> -			dws->dma_width = 2;
> +			dws->n_bytes = dws->dma_width = bits >> 3;
>  			break;
>  		default:
>  			printk(KERN_ERR "MRST SPI0: unsupported bits:"
> @@ -541,7 +510,7 @@ static void pump_transfers(unsigned long data)
>  		txint_level = dws->fifo_len / 2;
>  		txint_level = (templen > txint_level) ? txint_level : templen;
>  
> -		imask |= SPI_INT_TXEI;
> +		imask |= SPI_INT_TXEI | SPI_INT_TXOI | SPI_INT_RXUI | SPI_INT_RXOI;
>  		dws->transfer_handler = interrupt_transfer;
>  	}
>  
> -- 
> 1.7.0.4
> 

------------------------------------------------------------------------------
Create and publish websites with WebMatrix
Use the most popular FREE web apps or write code yourself; 
WebMatrix provides all the features you need to develop and 
publish your website. http://p.sf.net/sfu/ms-webmatrix-sf

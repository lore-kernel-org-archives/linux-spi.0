From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH v2 1/4] spi/dw_spi: unify the low level read/write routines
Date: Wed, 30 Mar 2011 21:32:29 -0600
Message-ID: <20110331033229.GC19333@ponder.secretlab.ca>
References: <1301497795-6924-1-git-send-email-feng.tang@intel.com>
	<1301497795-6924-2-git-send-email-feng.tang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	alek.du-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
To: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1301497795-6924-2-git-send-email-feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, Mar 30, 2011 at 11:09:52PM +0800, Feng Tang wrote:
> The original version has many duplicated codes for null/u8/u16 case,
> so unify them to make it cleaner
> 
> Signed-off-by: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

Applied, thanks.

g.

> ---
>  drivers/spi/dw_spi.c |  103 +++++++++++++-------------------------------------
>  drivers/spi/dw_spi.h |    2 -
>  2 files changed, 26 insertions(+), 79 deletions(-)
> 
> diff --git a/drivers/spi/dw_spi.c b/drivers/spi/dw_spi.c
> index 9a61964..c4fca3d 100644
> --- a/drivers/spi/dw_spi.c
> +++ b/drivers/spi/dw_spi.c
> @@ -58,8 +58,6 @@ struct chip_data {
>  	u8 bits_per_word;
>  	u16 clk_div;		/* baud rate divider */
>  	u32 speed_hz;		/* baud rate */
> -	int (*write)(struct dw_spi *dws);
> -	int (*read)(struct dw_spi *dws);
>  	void (*cs_control)(u32 command);
>  };
>  
> @@ -185,80 +183,45 @@ static void flush(struct dw_spi *dws)
>  	wait_till_not_busy(dws);
>  }
>  
> -static int null_writer(struct dw_spi *dws)
> -{
> -	u8 n_bytes = dws->n_bytes;
> -
> -	if (!(dw_readw(dws, sr) & SR_TF_NOT_FULL)
> -		|| (dws->tx == dws->tx_end))
> -		return 0;
> -	dw_writew(dws, dr, 0);
> -	dws->tx += n_bytes;
>  
> -	wait_till_not_busy(dws);
> -	return 1;
> -}
> -
> -static int null_reader(struct dw_spi *dws)
> +static int dw_writer(struct dw_spi *dws)
>  {
> -	u8 n_bytes = dws->n_bytes;
> +	u16 txw = 0;
>  
> -	while ((dw_readw(dws, sr) & SR_RF_NOT_EMPT)
> -		&& (dws->rx < dws->rx_end)) {
> -		dw_readw(dws, dr);
> -		dws->rx += n_bytes;
> -	}
> -	wait_till_not_busy(dws);
> -	return dws->rx == dws->rx_end;
> -}
> -
> -static int u8_writer(struct dw_spi *dws)
> -{
>  	if (!(dw_readw(dws, sr) & SR_TF_NOT_FULL)
>  		|| (dws->tx == dws->tx_end))
>  		return 0;
>  
> -	dw_writew(dws, dr, *(u8 *)(dws->tx));
> -	++dws->tx;
> -
> -	wait_till_not_busy(dws);
> -	return 1;
> -}
> -
> -static int u8_reader(struct dw_spi *dws)
> -{
> -	while ((dw_readw(dws, sr) & SR_RF_NOT_EMPT)
> -		&& (dws->rx < dws->rx_end)) {
> -		*(u8 *)(dws->rx) = dw_readw(dws, dr);
> -		++dws->rx;
> +	/* Set the tx word if the transfer's original "tx" is not null */
> +	if (dws->tx_end - dws->len) {
> +		if (dws->n_bytes == 1)
> +			txw = *(u8 *)(dws->tx);
> +		else
> +			txw = *(u16 *)(dws->tx);
>  	}
>  
> -	wait_till_not_busy(dws);
> -	return dws->rx == dws->rx_end;
> -}
> -
> -static int u16_writer(struct dw_spi *dws)
> -{
> -	if (!(dw_readw(dws, sr) & SR_TF_NOT_FULL)
> -		|| (dws->tx == dws->tx_end))
> -		return 0;
> -
> -	dw_writew(dws, dr, *(u16 *)(dws->tx));
> -	dws->tx += 2;
> +	dw_writew(dws, dr, txw);
> +	dws->tx += dws->n_bytes;
>  
>  	wait_till_not_busy(dws);
>  	return 1;
>  }
>  
> -static int u16_reader(struct dw_spi *dws)
> +static int dw_reader(struct dw_spi *dws)
>  {
> -	u16 temp;
> +	u16 rxw;
>  
>  	while ((dw_readw(dws, sr) & SR_RF_NOT_EMPT)
>  		&& (dws->rx < dws->rx_end)) {
> -		temp = dw_readw(dws, dr);
> -		*(u16 *)(dws->rx) = temp;
> -		dws->rx += 2;
> +		rxw = dw_readw(dws, dr);
> +		/* Care rx only if the transfer's original "rx" is not null */
> +		if (dws->rx_end - dws->len) {
> +			if (dws->n_bytes == 1)
> +				*(u8 *)(dws->rx) = rxw;
> +			else
> +				*(u16 *)(dws->rx) = rxw;
> +		}
> +		dws->rx += dws->n_bytes;
>  	}
>  
>  	wait_till_not_busy(dws);
> @@ -383,8 +346,8 @@ static irqreturn_t interrupt_transfer(struct dw_spi *dws)
>  		left = (left > int_level) ? int_level : left;
>  
>  		while (left--)
> -			dws->write(dws);
> -		dws->read(dws);
> +			dw_writer(dws);
> +		dw_reader(dws);
>  
>  		/* Re-enable the IRQ if there is still data left to tx */
>  		if (dws->tx_end > dws->tx)
> @@ -417,13 +380,13 @@ static irqreturn_t dw_spi_irq(int irq, void *dev_id)
>  /* Must be called inside pump_transfers() */
>  static void poll_transfer(struct dw_spi *dws)
>  {
> -	while (dws->write(dws))
> -		dws->read(dws);
> +	while (dw_writer(dws))
> +		dw_reader(dws);
>  	/*
>  	 * There is a possibility that the last word of a transaction
>  	 * will be lost if data is not ready. Re-read to solve this issue.
>  	 */
> -	dws->read(dws);
> +	dw_reader(dws);
>  
>  	dw_spi_xfer_done(dws);
>  }
> @@ -483,8 +446,6 @@ static void pump_transfers(unsigned long data)
>  	dws->tx_end = dws->tx + transfer->len;
>  	dws->rx = transfer->rx_buf;
>  	dws->rx_end = dws->rx + transfer->len;
> -	dws->write = dws->tx ? chip->write : null_writer;
> -	dws->read = dws->rx ? chip->read : null_reader;
>  	dws->cs_change = transfer->cs_change;
>  	dws->len = dws->cur_transfer->len;
>  	if (chip != dws->prev_chip)
> @@ -520,18 +481,10 @@ static void pump_transfers(unsigned long data)
>  		case 8:
>  			dws->n_bytes = 1;
>  			dws->dma_width = 1;
> -			dws->read = (dws->read != null_reader) ?
> -					u8_reader : null_reader;
> -			dws->write = (dws->write != null_writer) ?
> -					u8_writer : null_writer;
>  			break;
>  		case 16:
>  			dws->n_bytes = 2;
>  			dws->dma_width = 2;
> -			dws->read = (dws->read != null_reader) ?
> -					u16_reader : null_reader;
> -			dws->write = (dws->write != null_writer) ?
> -					u16_writer : null_writer;
>  			break;
>  		default:
>  			printk(KERN_ERR "MRST SPI0: unsupported bits:"
> @@ -733,13 +686,9 @@ static int dw_spi_setup(struct spi_device *spi)
>  	if (spi->bits_per_word <= 8) {
>  		chip->n_bytes = 1;
>  		chip->dma_width = 1;
> -		chip->read = u8_reader;
> -		chip->write = u8_writer;
>  	} else if (spi->bits_per_word <= 16) {
>  		chip->n_bytes = 2;
>  		chip->dma_width = 2;
> -		chip->read = u16_reader;
> -		chip->write = u16_writer;
>  	} else {
>  		/* Never take >16b case for MRST SPIC */
>  		dev_err(&spi->dev, "invalid wordsize\n");
> diff --git a/drivers/spi/dw_spi.h b/drivers/spi/dw_spi.h
> index fb0bce5..d8aac1f 100644
> --- a/drivers/spi/dw_spi.h
> +++ b/drivers/spi/dw_spi.h
> @@ -137,8 +137,6 @@ struct dw_spi {
>  	u8			max_bits_per_word;	/* maxim is 16b */
>  	u32			dma_width;
>  	int			cs_change;
> -	int			(*write)(struct dw_spi *dws);
> -	int			(*read)(struct dw_spi *dws);
>  	irqreturn_t		(*transfer_handler)(struct dw_spi *dws);
>  	void			(*cs_control)(u32 command);
>  
> -- 
> 1.7.0.4
> 

------------------------------------------------------------------------------
Create and publish websites with WebMatrix
Use the most popular FREE web apps or write code yourself; 
WebMatrix provides all the features you need to develop and 
publish your website. http://p.sf.net/sfu/ms-webmatrix-sf

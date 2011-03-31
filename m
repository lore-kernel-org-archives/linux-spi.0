From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH v2 3/4] spi/dw_spi: change poll mode transfer from byte
	ops to batch ops
Date: Wed, 30 Mar 2011 21:32:39 -0600
Message-ID: <20110331033239.GE19333@ponder.secretlab.ca>
References: <1301497795-6924-1-git-send-email-feng.tang@intel.com>
	<1301497795-6924-4-git-send-email-feng.tang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	alek.du-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
To: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1301497795-6924-4-git-send-email-feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, Mar 30, 2011 at 11:09:54PM +0800, Feng Tang wrote:
> From: Alek Du <alek.du-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> 
> Current poll transfer will read/write one word, then wait till the
> hw is non-busy, it's not efficient. This patch will try to read/write
> as many words as permitted by hardware FIFO depth.
> 
> Signed-off-by: Alek Du <alek.du-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

Applied, thanks.

g.

> ---
>  drivers/spi/dw_spi.c |   71 +++++++++++++++++++++++++++++++++----------------
>  1 files changed, 48 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/spi/dw_spi.c b/drivers/spi/dw_spi.c
> index d3aaf8d..7a2a722 100644
> --- a/drivers/spi/dw_spi.c
> +++ b/drivers/spi/dw_spi.c
> @@ -160,6 +160,37 @@ static inline void mrst_spi_debugfs_remove(struct dw_spi *dws)
>  }
>  #endif /* CONFIG_DEBUG_FS */
>  
> +/* Return the max entries we can fill into tx fifo */
> +static inline u32 tx_max(struct dw_spi *dws)
> +{
> +	u32 tx_left, tx_room, rxtx_gap;
> +
> +	tx_left = (dws->tx_end - dws->tx) / dws->n_bytes;
> +	tx_room = dws->fifo_len - dw_readw(dws, txflr);
> +
> +	/*
> +	 * Another concern is about the tx/rx mismatch, we
> +	 * though to use (dws->fifo_len - rxflr - txflr) as
> +	 * one maximum value for tx, but it doesn't cover the
> +	 * data which is out of tx/rx fifo and inside the
> +	 * shift registers. So a control from sw point of
> +	 * view is taken.
> +	 */
> +	rxtx_gap =  ((dws->rx_end - dws->rx) - (dws->tx_end - dws->tx))
> +			/ dws->n_bytes;
> +
> +	return min3(tx_left, tx_room, (u32) (dws->fifo_len - rxtx_gap));
> +}
> +
> +/* Return the max entries we should read out of rx fifo */
> +static inline u32 rx_max(struct dw_spi *dws)
> +{
> +	u32 rx_left = (dws->rx_end - dws->rx) / dws->n_bytes;
> +
> +	return min(rx_left, (u32)dw_readw(dws, rxflr));
> +}
> +
> +
>  static void wait_till_not_busy(struct dw_spi *dws)
>  {
>  	unsigned long end = jiffies + 1 + usecs_to_jiffies(5000);
> @@ -175,33 +206,30 @@ static void wait_till_not_busy(struct dw_spi *dws)
>  
>  static int dw_writer(struct dw_spi *dws)
>  {
> +	u32 max = tx_max(dws);
>  	u16 txw = 0;
>  
> -	if (!(dw_readw(dws, sr) & SR_TF_NOT_FULL)
> -		|| (dws->tx == dws->tx_end))
> -		return 0;
> -
> -	/* Set the tx word if the transfer's original "tx" is not null */
> -	if (dws->tx_end - dws->len) {
> -		if (dws->n_bytes == 1)
> -			txw = *(u8 *)(dws->tx);
> -		else
> -			txw = *(u16 *)(dws->tx);
> +	while (max--) {
> +		/* Set the tx word if the transfer's original "tx" is not null */
> +		if (dws->tx_end - dws->len) {
> +			if (dws->n_bytes == 1)
> +				txw = *(u8 *)(dws->tx);
> +			else
> +				txw = *(u16 *)(dws->tx);
> +		}
> +		dw_writew(dws, dr, txw);
> +		dws->tx += dws->n_bytes;
>  	}
>  
> -	dw_writew(dws, dr, txw);
> -	dws->tx += dws->n_bytes;
> -
> -	wait_till_not_busy(dws);
>  	return 1;
>  }
>  
>  static int dw_reader(struct dw_spi *dws)
>  {
> +	u32 max = rx_max(dws);
>  	u16 rxw;
>  
> -	while ((dw_readw(dws, sr) & SR_RF_NOT_EMPT)
> -		&& (dws->rx < dws->rx_end)) {
> +	while (max--) {
>  		rxw = dw_readw(dws, dr);
>  		/* Care rx only if the transfer's original "rx" is not null */
>  		if (dws->rx_end - dws->len) {
> @@ -213,7 +241,6 @@ static int dw_reader(struct dw_spi *dws)
>  		dws->rx += dws->n_bytes;
>  	}
>  
> -	wait_till_not_busy(dws);
>  	return dws->rx == dws->rx_end;
>  }
>  
> @@ -368,13 +395,11 @@ static irqreturn_t dw_spi_irq(int irq, void *dev_id)
>  /* Must be called inside pump_transfers() */
>  static void poll_transfer(struct dw_spi *dws)
>  {
> -	while (dw_writer(dws))
> +	do {
> +		dw_writer(dws);
>  		dw_reader(dws);
> -	/*
> -	 * There is a possibility that the last word of a transaction
> -	 * will be lost if data is not ready. Re-read to solve this issue.
> -	 */
> -	dw_reader(dws);
> +		cpu_relax();
> +	} while (dws->rx_end > dws->rx);
>  
>  	dw_spi_xfer_done(dws);
>  }
> -- 
> 1.7.0.4
> 

------------------------------------------------------------------------------
Create and publish websites with WebMatrix
Use the most popular FREE web apps or write code yourself; 
WebMatrix provides all the features you need to develop and 
publish your website. http://p.sf.net/sfu/ms-webmatrix-sf

From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 1/4] spi/pl022: initialize burstsize from FIFO trigger
	level
Date: Thu, 16 Jun 2011 08:27:23 -0600
Message-ID: <20110616142723.GA2255@ponder.secretlab.ca>
References: <1308212068-22472-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1308212068-22472-1-git-send-email-linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, Jun 16, 2011 at 10:14:28AM +0200, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> 
> Configure the DMA burstsize from the FIFO trigger level supplied
> with the controller configuration data. This is based on a patch
> from Virupax, but I rewrote it differently.
> 
> Reported-by: Virupax Sadashivpetimath <virupax.sadashivpetimath-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
> Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Applied, thanks.

g.

> ---
>  drivers/spi/spi-pl022.c |   55 +++++++++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 53 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
> index b3bd8d8..ac7c727 100644
> --- a/drivers/spi/spi-pl022.c
> +++ b/drivers/spi/spi-pl022.c
> @@ -381,6 +381,8 @@ struct pl022 {
>  	enum ssp_reading		read;
>  	enum ssp_writing		write;
>  	u32				exp_fifo_level;
> +	enum ssp_rx_level_trig		rx_lev_trig;
> +	enum ssp_tx_level_trig		tx_lev_trig;
>  	/* DMA settings */
>  #ifdef CONFIG_DMA_ENGINE
>  	struct dma_chan			*dma_rx_channel;
> @@ -907,12 +909,10 @@ static int configure_dma(struct pl022 *pl022)
>  	struct dma_slave_config rx_conf = {
>  		.src_addr = SSP_DR(pl022->phybase),
>  		.direction = DMA_FROM_DEVICE,
> -		.src_maxburst = pl022->vendor->fifodepth >> 1,
>  	};
>  	struct dma_slave_config tx_conf = {
>  		.dst_addr = SSP_DR(pl022->phybase),
>  		.direction = DMA_TO_DEVICE,
> -		.dst_maxburst = pl022->vendor->fifodepth >> 1,
>  	};
>  	unsigned int pages;
>  	int ret;
> @@ -926,6 +926,54 @@ static int configure_dma(struct pl022 *pl022)
>  	if (!rxchan || !txchan)
>  		return -ENODEV;
>  
> +	/*
> +	 * If supplied, the DMA burstsize should equal the FIFO trigger level.
> +	 * Notice that the DMA engine uses one-to-one mapping. Since we can
> +	 * not trigger on 2 elements this needs explicit mapping rather than
> +	 * calculation.
> +	 */
> +	switch (pl022->rx_lev_trig) {
> +	case SSP_RX_1_OR_MORE_ELEM:
> +		rx_conf.src_maxburst = 1;
> +		break;
> +	case SSP_RX_4_OR_MORE_ELEM:
> +		rx_conf.src_maxburst = 4;
> +		break;
> +	case SSP_RX_8_OR_MORE_ELEM:
> +		rx_conf.src_maxburst = 8;
> +		break;
> +	case SSP_RX_16_OR_MORE_ELEM:
> +		rx_conf.src_maxburst = 16;
> +		break;
> +	case SSP_RX_32_OR_MORE_ELEM:
> +		rx_conf.src_maxburst = 32;
> +		break;
> +	default:
> +		rx_conf.src_maxburst = pl022->vendor->fifodepth >> 1;
> +		break;
> +	}
> +
> +	switch (pl022->tx_lev_trig) {
> +	case SSP_TX_1_OR_MORE_EMPTY_LOC:
> +		tx_conf.dst_maxburst = 1;
> +		break;
> +	case SSP_TX_4_OR_MORE_EMPTY_LOC:
> +		tx_conf.dst_maxburst = 4;
> +		break;
> +	case SSP_TX_8_OR_MORE_EMPTY_LOC:
> +		tx_conf.dst_maxburst = 8;
> +		break;
> +	case SSP_TX_16_OR_MORE_EMPTY_LOC:
> +		tx_conf.dst_maxburst = 16;
> +		break;
> +	case SSP_TX_32_OR_MORE_EMPTY_LOC:
> +		tx_conf.dst_maxburst = 32;
> +		break;
> +	default:
> +		tx_conf.dst_maxburst = pl022->vendor->fifodepth >> 1;
> +		break;
> +	}
> +
>  	switch (pl022->read) {
>  	case READING_NULL:
>  		/* Use the same as for writing */
> @@ -1872,6 +1920,9 @@ static int pl022_setup(struct spi_device *spi)
>  		goto err_config_params;
>  	}
>  
> +	pl022->rx_lev_trig = chip_info->rx_lev_trig;
> +	pl022->tx_lev_trig = chip_info->tx_lev_trig;
> +
>  	/* Now set controller state based on controller data */
>  	chip->xfer_type = chip_info->com_mode;
>  	if (!chip_info->cs_control) {
> -- 
> 1.7.3.2
> 

------------------------------------------------------------------------------
EditLive Enterprise is the world's most technically advanced content
authoring tool. Experience the power of Track Changes, Inline Image
Editing and ensure content is compliant with Accessibility Checking.
http://p.sf.net/sfu/ephox-dev2dev

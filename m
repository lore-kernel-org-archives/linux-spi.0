From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] spi/spi-ep93xx.c: use dma_transfer_direction instead of
	dma_data_direction
Date: Fri, 27 Apr 2012 11:11:46 -0600
Message-ID: <20120427171146.B18373E0B4D@localhost>
References: <201204171846.37245.hartleys@visionengravers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, vinod.koul-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
To: H Hartley Sweeten <hartleys-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>,
	Linux Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <201204171846.37245.hartleys-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, 17 Apr 2012 18:46:36 -0700, H Hartley Sweeten <hartleys-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org> wrote:
> A new enum indicating the dma channel direction was introduced by:
> 
> commit 49920bc66984a512f4bcc7735a61642cd0e4d6f2
>     dmaengine: add new enum dma_transfer_direction
> 
> The following commit changed spi-ep93xx to use the new enum:
> 
> commit a485df4b4404379786c4bdd258bc528b2617449d
>     spi, serial: move to dma_transfer_direction
> 
> In doing so a sparse warning was introduced: 
> 
> warning: mixing different enum types
>    int enum dma_data_direction  versus
>    int enum dma_transfer_direction
> 
> This is produced because the 'dir' passed in ep93xx_spi_dma_prepare
> is an enum dma_data_direction and is being used to set the
> dma_slave_config 'direction' which is now an enum dma_transfer_direction.
> 
> Fix this by converting spi-ep93xx to use the new enum type in all
> places.
> 
> Signed-off-by: H Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
> Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
> Cc: Vinod Koul <vinod.koul-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

Applied, thanks.

g.

> 
> ---
> 
> diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
> index 6db2887..e805507 100644
> --- a/drivers/spi/spi-ep93xx.c
> +++ b/drivers/spi/spi-ep93xx.c
> @@ -545,13 +545,12 @@ static void ep93xx_spi_pio_transfer(struct ep93xx_spi *espi)
>   * in case of failure.
>   */
>  static struct dma_async_tx_descriptor *
> -ep93xx_spi_dma_prepare(struct ep93xx_spi *espi, enum dma_data_direction dir)
> +ep93xx_spi_dma_prepare(struct ep93xx_spi *espi, enum dma_transfer_direction dir)
>  {
>  	struct spi_transfer *t = espi->current_msg->state;
>  	struct dma_async_tx_descriptor *txd;
>  	enum dma_slave_buswidth buswidth;
>  	struct dma_slave_config conf;
> -	enum dma_transfer_direction slave_dirn;
>  	struct scatterlist *sg;
>  	struct sg_table *sgt;
>  	struct dma_chan *chan;
> @@ -567,14 +566,13 @@ ep93xx_spi_dma_prepare(struct ep93xx_spi *espi, enum dma_data_direction dir)
>  	memset(&conf, 0, sizeof(conf));
>  	conf.direction = dir;
>  
> -	if (dir == DMA_FROM_DEVICE) {
> +	if (dir == DMA_DEV_TO_MEM) {
>  		chan = espi->dma_rx;
>  		buf = t->rx_buf;
>  		sgt = &espi->rx_sgt;
>  
>  		conf.src_addr = espi->sspdr_phys;
>  		conf.src_addr_width = buswidth;
> -		slave_dirn = DMA_DEV_TO_MEM;
>  	} else {
>  		chan = espi->dma_tx;
>  		buf = t->tx_buf;
> @@ -582,7 +580,6 @@ ep93xx_spi_dma_prepare(struct ep93xx_spi *espi, enum dma_data_direction dir)
>  
>  		conf.dst_addr = espi->sspdr_phys;
>  		conf.dst_addr_width = buswidth;
> -		slave_dirn = DMA_MEM_TO_DEV;
>  	}
>  
>  	ret = dmaengine_slave_config(chan, &conf);
> @@ -633,8 +630,7 @@ ep93xx_spi_dma_prepare(struct ep93xx_spi *espi, enum dma_data_direction dir)
>  	if (!nents)
>  		return ERR_PTR(-ENOMEM);
>  
> -	txd = dmaengine_prep_slave_sg(chan, sgt->sgl, nents,
> -					slave_dirn, DMA_CTRL_ACK);
> +	txd = dmaengine_prep_slave_sg(chan, sgt->sgl, nents, dir, DMA_CTRL_ACK);
>  	if (!txd) {
>  		dma_unmap_sg(chan->device->dev, sgt->sgl, sgt->nents, dir);
>  		return ERR_PTR(-ENOMEM);
> @@ -651,12 +647,12 @@ ep93xx_spi_dma_prepare(struct ep93xx_spi *espi, enum dma_data_direction dir)
>   * unmapped.
>   */
>  static void ep93xx_spi_dma_finish(struct ep93xx_spi *espi,
> -				  enum dma_data_direction dir)
> +				  enum dma_transfer_direction dir)
>  {
>  	struct dma_chan *chan;
>  	struct sg_table *sgt;
>  
> -	if (dir == DMA_FROM_DEVICE) {
> +	if (dir == DMA_DEV_TO_MEM) {
>  		chan = espi->dma_rx;
>  		sgt = &espi->rx_sgt;
>  	} else {
> @@ -677,16 +673,16 @@ static void ep93xx_spi_dma_transfer(struct ep93xx_spi *espi)
>  	struct spi_message *msg = espi->current_msg;
>  	struct dma_async_tx_descriptor *rxd, *txd;
>  
> -	rxd = ep93xx_spi_dma_prepare(espi, DMA_FROM_DEVICE);
> +	rxd = ep93xx_spi_dma_prepare(espi, DMA_DEV_TO_MEM);
>  	if (IS_ERR(rxd)) {
>  		dev_err(&espi->pdev->dev, "DMA RX failed: %ld\n", PTR_ERR(rxd));
>  		msg->status = PTR_ERR(rxd);
>  		return;
>  	}
>  
> -	txd = ep93xx_spi_dma_prepare(espi, DMA_TO_DEVICE);
> +	txd = ep93xx_spi_dma_prepare(espi, DMA_MEM_TO_DEV);
>  	if (IS_ERR(txd)) {
> -		ep93xx_spi_dma_finish(espi, DMA_FROM_DEVICE);
> +		ep93xx_spi_dma_finish(espi, DMA_DEV_TO_MEM);
>  		dev_err(&espi->pdev->dev, "DMA TX failed: %ld\n", PTR_ERR(rxd));
>  		msg->status = PTR_ERR(txd);
>  		return;
> @@ -705,8 +701,8 @@ static void ep93xx_spi_dma_transfer(struct ep93xx_spi *espi)
>  
>  	wait_for_completion(&espi->wait);
>  
> -	ep93xx_spi_dma_finish(espi, DMA_TO_DEVICE);
> -	ep93xx_spi_dma_finish(espi, DMA_FROM_DEVICE);
> +	ep93xx_spi_dma_finish(espi, DMA_MEM_TO_DEV);
> +	ep93xx_spi_dma_finish(espi, DMA_DEV_TO_MEM);
>  }
>  
>  /**

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/

From: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: spi: omap2-mcspi: Cleanup the omap2_mcspi_txrx_dma function
Date: Fri, 11 Apr 2014 14:29:13 +0300
Message-ID: <20140411112913.GP4963@mwanda>
References: <20140411112021.GA9166@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140411112021.GA9166@mwanda>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Shubhrajyoti's email address is dead.  Also the rx function
omap2_mcspi_rx_dma() has the same issue.

regards,
dan carpenter

On Fri, Apr 11, 2014 at 02:20:21PM +0300, Dan Carpenter wrote:
> Hello Shubhrajyoti D,
> 
> This is a semi-automatic email about new static checker warnings.
> 
> The patch d7b4394e780b: "spi: omap2-mcspi: Cleanup the 
> omap2_mcspi_txrx_dma function" from Sep 11, 2012, leads to the 
> following Smatch complaint:
> 
> drivers/spi/spi-omap2-mcspi.c:425 omap2_mcspi_tx_dma()
> 	 error: we previously assumed 'mcspi_dma->dma_tx' could be null (see line 405)
> 
> drivers/spi/spi-omap2-mcspi.c
>    404	
>    405		if (mcspi_dma->dma_tx) {
>                     ^^^^^^^^^^^^^^^^^
> Check for NULL.
> 
>    406			struct dma_async_tx_descriptor *tx;
>    407			struct scatterlist sg;
>    408	
>    409			dmaengine_slave_config(mcspi_dma->dma_tx, &cfg);
>    410	
>    411			sg_init_table(&sg, 1);
>    412			sg_dma_address(&sg) = xfer->tx_dma;
>    413			sg_dma_len(&sg) = xfer->len;
>    414	
>    415			tx = dmaengine_prep_slave_sg(mcspi_dma->dma_tx, &sg, 1,
>    416			DMA_MEM_TO_DEV, DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
>    417			if (tx) {
>    418				tx->callback = omap2_mcspi_tx_callback;
>    419				tx->callback_param = spi;
>    420				dmaengine_submit(tx);
>    421			} else {
>    422				/* FIXME: fall back to PIO? */
>    423			}
>    424		}
>    425		dma_async_issue_pending(mcspi_dma->dma_tx);
>                                         ^^^^^^^^^^^^^^^^^
> Dereferenced inside the function call.  Probably it should be moved
> inside the if condition.
> 
>    426		omap2_mcspi_set_dma_req(spi, 0, 1);
>    427	
> 
> regards,
> dan carpenter
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: re: spi: omap2-mcspi: Cleanup the omap2_mcspi_txrx_dma function
Date: Fri, 1 Nov 2013 13:32:02 +0300
Message-ID: <20131101103202.GM29795@longonot.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: shubhrajyoti-l0cyMroinI0@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hello Shubhrajyoti D,

This is a semi-automatic email about new static checker warnings.

The patch d7b4394e780b: "spi: omap2-mcspi: Cleanup the 
omap2_mcspi_txrx_dma function" from Sep 11, 2012, leads to the 
following Smatch complaint:

drivers/spi/spi-omap2-mcspi.c:417 omap2_mcspi_tx_dma()
	 error: we previously assumed 'mcspi_dma->dma_tx' could be null (see line 397)

drivers/spi/spi-omap2-mcspi.c
   396	
   397		if (mcspi_dma->dma_tx) {
                    ^^^^^^^^^^^^^^^^^
Existing check.

   398			struct dma_async_tx_descriptor *tx;
   399			struct scatterlist sg;
   400	
   401			dmaengine_slave_config(mcspi_dma->dma_tx, &cfg);
   402	
   403			sg_init_table(&sg, 1);
   404			sg_dma_address(&sg) = xfer->tx_dma;
   405			sg_dma_len(&sg) = xfer->len;
   406	
   407			tx = dmaengine_prep_slave_sg(mcspi_dma->dma_tx, &sg, 1,
   408			DMA_MEM_TO_DEV, DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
   409			if (tx) {
   410				tx->callback = omap2_mcspi_tx_callback;
   411				tx->callback_param = spi;
   412				dmaengine_submit(tx);
   413			} else {
   414				/* FIXME: fall back to PIO? */
   415			}
   416		}
   417		dma_async_issue_pending(mcspi_dma->dma_tx);
                                        ^^^^^^^^^^^^^^^^^
Patch introduces a new unchecked dereference.

   418		omap2_mcspi_set_dma_req(spi, 0, 1);
   419	

See also:

	drivers/spi/spi-omap2-mcspi.c:477 omap2_mcspi_rx_dma() error:
	    we previously assumed 'mcspi_dma->dma_rx' could be null
	    (see line 452)

regards,
dan carpenter
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

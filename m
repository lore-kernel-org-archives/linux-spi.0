From: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: re: spi/tegra114: add spi driver
Date: Fri, 1 Apr 2016 16:52:27 +0300
Message-ID: <20160401135227.GA24190@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hello Laxman Dewangan,

The patch f333a331adfa: "spi/tegra114: add spi driver" from Feb 22,
2013, leads to the following static checker warning:

	drivers/spi/spi-tegra114.c:621 tegra_spi_init_dma_param()
	error: uninitialized variable 'dma_phys'.

drivers/spi/spi-tegra114.c
   583          dma_addr_t dma_phys;
                ^^^^^^^^^^^^^^^^^^^
   584          int ret;
   585          struct dma_slave_config dma_sconfig;
   586  
   587          dma_chan = dma_request_slave_channel_reason(tspi->dev,
   588                                          dma_to_memory ? "rx" : "tx");
   589          if (IS_ERR(dma_chan)) {
   590                  ret = PTR_ERR(dma_chan);
   591                  if (ret != -EPROBE_DEFER)
   592                          dev_err(tspi->dev,
   593                                  "Dma channel is not available: %d\n", ret);
   594                  return ret;
   595          }
   596  
   597          dma_buf = dma_alloc_coherent(tspi->dev, tspi->dma_buf_size,
   598                                  &dma_phys, GFP_KERNEL);

The issue is that in dma_alloc_attrs() if we can dma_alloc_from_coherent()
then dma_phys is not set.  I'm getting a couple similar errors and I'm
not certian what to do about it.

   599          if (!dma_buf) {
   600                  dev_err(tspi->dev, " Not able to allocate the dma buffer\n");
   601                  dma_release_channel(dma_chan);
   602                  return -ENOMEM;
   603          }
   604  
   605          if (dma_to_memory) {
   606                  dma_sconfig.src_addr = tspi->phys + SPI_RX_FIFO;
   607                  dma_sconfig.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
   608                  dma_sconfig.src_maxburst = 0;
   609          } else {
   610                  dma_sconfig.dst_addr = tspi->phys + SPI_TX_FIFO;
   611                  dma_sconfig.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
   612                  dma_sconfig.dst_maxburst = 0;
   613          }
   614  
   615          ret = dmaengine_slave_config(dma_chan, &dma_sconfig);
   616          if (ret)
   617                  goto scrub;
   618          if (dma_to_memory) {
   619                  tspi->rx_dma_chan = dma_chan;
   620                  tspi->rx_dma_buf = dma_buf;
   621                  tspi->rx_dma_phys = dma_phys;
                                            ^^^^^^^^
Uninitialized.

   622          } else {
   623                  tspi->tx_dma_chan = dma_chan;
   624                  tspi->tx_dma_buf = dma_buf;
   625                  tspi->tx_dma_phys = dma_phys;

regards,
dan carpenter
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

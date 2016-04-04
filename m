From: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: spi/tegra114: add spi driver
Date: Mon, 4 Apr 2016 11:33:29 +0530
Message-ID: <570203B1.3040304@nvidia.com>
References: <20160401135227.GA24190@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160401135227.GA24190@mwanda>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


On Friday 01 April 2016 07:22 PM, Dan Carpenter wrote:
> Hello Laxman Dewangan,
>
> The patch f333a331adfa: "spi/tegra114: add spi driver" from Feb 22,
> 2013, leads to the following static checker warning:
>
> 	drivers/spi/spi-tegra114.c:621 tegra_spi_init_dma_param()
> 	error: uninitialized variable 'dma_phys'.
>
> drivers/spi/spi-tegra114.c
>     583          dma_addr_t dma_phys;
>                  ^^^^^^^^^^^^^^^^^^^
>     584          int ret;
>     585          struct dma_slave_config dma_sconfig;
>     586
>     587          dma_chan = dma_request_slave_channel_reason(tspi->dev,
>     588                                          dma_to_memory ? "rx" : "tx");
>     589          if (IS_ERR(dma_chan)) {
>     590                  ret = PTR_ERR(dma_chan);
>     591                  if (ret != -EPROBE_DEFER)
>     592                          dev_err(tspi->dev,
>     593                                  "Dma channel is not available: %d\n", ret);
>     594                  return ret;
>     595          }
>     596
>     597          dma_buf = dma_alloc_coherent(tspi->dev, tspi->dma_buf_size,
>     598                                  &dma_phys, GFP_KERNEL);
>
> The issue is that in dma_alloc_attrs() if we can dma_alloc_from_coherent()
> then dma_phys is not set.  I'm getting a couple similar errors and I'm
> not certian what to do about it.
>


The issue is with compiler actually.
we have code as
         dma_buf = dma_alloc_coherent(tspi->dev, tspi->dma_buf_size,
                                 &dma_phys, GFP_KERNEL);
         if (!dma_buf) {
                 dev_err(tspi->dev, " Not able to allocate the dma 
buffer\n");
                 dma_release_channel(dma_chan);
                 return -ENOMEM;
         }

So if returned value "dma_buf" is not NULL then we can assume that 
dma_phy is initialized other wise it should return NULL.

The static check is not able to find out that calling function has 
initialized it or not.

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

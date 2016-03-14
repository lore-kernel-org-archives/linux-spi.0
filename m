From: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: re: spi: rockchip: check requesting dma channel with EPROBE_DEFER
Date: Mon, 14 Mar 2016 12:48:45 +0300
Message-ID: <20160314094844.GA12754@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hello Shawn Lin,

The patch 61cadcf46cfd: "spi: rockchip: check requesting dma channel
with EPROBE_DEFER" from Mar 9, 2016, leads to the following static
checker warning:

	drivers/spi/spi-rockchip.c:742 rockchip_spi_probe()
	warn: passing zero to 'PTR_ERR'

drivers/spi/spi-rockchip.c
   732  
   733          rs->dma_tx.ch = dma_request_slave_channel(rs->dev, "tx");
   734          if (IS_ERR_OR_NULL(rs->dma_tx.ch)) {
   735                  /* Check tx to see if we need defer probing driver */
   736                  if (PTR_ERR(rs->dma_tx.ch) == -EPROBE_DEFER) {
   737                          ret = -EPROBE_DEFER;
   738                          goto err_get_fifo_len;

What's going on here?  Are we planning to change dma_request_slave_channel()
to return error pointers?  Also what about other error pointers besides
EPROBE_DEFER it seems dangerous to leave rs->dma_tx.ch as an error
pointer.  We probably eventually try to free it if it's non-NULL.

   739                  }
   740                  dev_warn(rs->dev, "Failed to request TX DMA channel\n");
   741          }
   742  

regards,
dan carpenter
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

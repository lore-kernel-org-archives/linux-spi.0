From: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: re: spi: imx: initialize usedma earlier
Date: Wed, 16 Mar 2016 10:42:38 +0300
Message-ID: <20160316074238.GD12860@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hello Sascha Hauer,

This is a semi-automatic email about new static checker warnings.

The patch c008a8007162: "spi: imx: initialize usedma earlier" from
Feb 24, 2016, leads to the following Smatch complaint:

drivers/spi/spi-imx.c:870 spi_imx_setupxfer()
	 error: we previously assumed 't' could be null (see line 848)

drivers/spi/spi-imx.c
   847	
   848		config.bpw = t ? t->bits_per_word : spi->bits_per_word;
                             ^
   849		config.speed_hz  = t ? t->speed_hz : spi->max_speed_hz;
                                   ^
Old code checks for NULL.

   850		config.mode = spi->mode;
   851		config.cs = spi->chip_select;
   852	
   853		if (!config.speed_hz)
   854			config.speed_hz = spi->max_speed_hz;
   855		if (!config.bpw)
   856			config.bpw = spi->bits_per_word;
   857	
   858		/* Initialize the functions for transfer */
   859		if (config.bpw <= 8) {
   860			spi_imx->rx = spi_imx_buf_rx_u8;
   861			spi_imx->tx = spi_imx_buf_tx_u8;
   862		} else if (config.bpw <= 16) {
   863			spi_imx->rx = spi_imx_buf_rx_u16;
   864			spi_imx->tx = spi_imx_buf_tx_u16;
   865		} else {
   866			spi_imx->rx = spi_imx_buf_rx_u32;
   867			spi_imx->tx = spi_imx_buf_tx_u32;
   868		}
   869	
   870		if (spi_imx_can_dma(spi_imx->bitbang.master, spi, t))
                                                                  ^
Patch adds a new unchecked dereference (inside the function call).

   871			spi_imx->usedma = 1;
   872		else

regards,
dan carpenter
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

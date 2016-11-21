From: Sanchayan Maity <maitysanchayan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 2/4] spi: spi-fsl-dspi: Fix continuous selection format
Date: Mon, 21 Nov 2016 11:24:02 +0530
Message-ID: <1317eff8a40789c47311c219d9cfb4105863bd9f.1479706671.git.maitysanchayan@gmail.com>
References: <cover.1479706671.git.maitysanchayan@gmail.com>
Cc: stefan-XLVq0VzYD2Y@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Sanchayan Maity <maitysanchayan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1479706671.git.maitysanchayan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
In-Reply-To: <cover.1479706671.git.maitysanchayan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
References: <cover.1479706671.git.maitysanchayan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Current DMA implementation was not handling the continuous selection
format viz. SPI chip select would be deasserted even between sequential
serial transfers. Use the cs_change variable and correctly set or
reset the CONT bit accordingly for case where peripherals require
the chip select to be asserted between sequential transfers.

Signed-off-by: Sanchayan Maity <maitysanchayan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-fsl-dspi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index b1ee1f5..41422cd 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -261,6 +261,8 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
 	dspi->dma->tx_dma_buf[i] = SPI_PUSHR_TXDATA(val) |
 					SPI_PUSHR_PCS(dspi->cs) |
 					SPI_PUSHR_CTAS(0);
+	if (!dspi->cs_change)
+		dspi->dma->tx_dma_buf[i] |= SPI_PUSHR_CONT;
 	dspi->tx += tx_word + 1;
 
 	dma->tx_desc = dmaengine_prep_slave_single(dma->chan_tx,
-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

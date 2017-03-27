From: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] spi: spi-ti-qspi: Remove unused dma_dev variable
Date: Mon, 27 Mar 2017 10:59:28 +0530
Message-ID: <20170327052928.21236-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

commit 1351aaeb50b2 ("spi: spi-ti-qspi: Use dma_engine wrapper for dma
memcpy call") introduced this warning:

drivers/spi/spi-ti-qspi.c: In function 'ti_qspi_dma_xfer':
drivers/spi/spi-ti-qspi.c:398:21: warning: unused variable 'dma_dev' [-Wunused-variable]
  struct dma_device *dma_dev = chan->device;

Fix it by removing the unused variable.

Signed-off-by: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Reported-by: Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>
---

Based on
git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git  for-next

 drivers/spi/spi-ti-qspi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 5c8b48e39715..7b39bc204a30 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -395,7 +395,6 @@ static int ti_qspi_dma_xfer(struct ti_qspi *qspi, dma_addr_t dma_dst,
 			    dma_addr_t dma_src, size_t len)
 {
 	struct dma_chan *chan = qspi->rx_chan;
-	struct dma_device *dma_dev = chan->device;
 	dma_cookie_t cookie;
 	enum dma_ctrl_flags flags = DMA_CTRL_ACK | DMA_PREP_INTERRUPT;
 	struct dma_async_tx_descriptor *tx;
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

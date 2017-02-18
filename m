From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] spi: spi-ti-qspi: Fix error handling
Date: Sat, 18 Feb 2017 10:42:02 +0100
Message-ID: <20170218094202.6454-1-christophe.jaillet@wanadoo.fr>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: broonie@kernel.org
Return-path: <kernel-janitors-owner@vger.kernel.org>
Sender: kernel-janitors-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

'dma_request_chan_by_mask()' can not return NULL.
Try to keep the logic in 'no_dma:' by resetting 'qspi->rx_chan' in case
of error.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/spi/spi-ti-qspi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index ec6fb09e2e17..0fefa6423ff4 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -714,9 +714,10 @@ static int ti_qspi_probe(struct platform_device *pdev)
 	dma_cap_set(DMA_MEMCPY, mask);
 
 	qspi->rx_chan = dma_request_chan_by_mask(&mask);
-	if (!qspi->rx_chan) {
+	if (IS_ERR(qspi->rx_chan)) {
 		dev_err(qspi->dev,
 			"No Rx DMA available, trying mmap mode\n");
+		qspi->rx_chan = NULL;
 		ret = 0;
 		goto no_dma;
 	}
-- 
2.9.3


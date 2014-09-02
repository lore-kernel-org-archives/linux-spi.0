From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 1/9] spi: davinci: Fix checkpatch issue
Date: Tue, 02 Sep 2014 11:48:00 +0900
Message-ID: <002101cfc658$4f627cf0$ee2776d0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	'Grygorii Strashko' <grygorii.strashko-l0cyMroinI0@public.gmane.org>,
	'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
To: 'Mark Brown' <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-language: ko
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Fix the following checkpatch warnings.

  WARNING: Missing a blank line after declarations
  WARNING: quoted string split across lines

Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/spi/spi-davinci.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index 48f1d26e6ad9..cb20d6c482a6 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -167,8 +167,10 @@ static void davinci_spi_rx_buf_u16(u32 data, struct davinci_spi *dspi)
 static u32 davinci_spi_tx_buf_u8(struct davinci_spi *dspi)
 {
 	u32 data = 0;
+
 	if (dspi->tx) {
 		const u8 *tx = dspi->tx;
+
 		data = *tx++;
 		dspi->tx = tx;
 	}
@@ -178,8 +180,10 @@ static u32 davinci_spi_tx_buf_u8(struct davinci_spi *dspi)
 static u32 davinci_spi_tx_buf_u16(struct davinci_spi *dspi)
 {
 	u32 data = 0;
+
 	if (dspi->tx) {
 		const u16 *tx = dspi->tx;
+
 		data = *tx++;
 		dspi->tx = tx;
 	}
@@ -985,8 +989,8 @@ static int davinci_spi_probe(struct platform_device *pdev)
 			goto free_clk;
 
 		dev_info(&pdev->dev, "DMA: supported\n");
-		dev_info(&pdev->dev, "DMA: RX channel: %pa, TX channel: %pa, "
-				"event queue: %d\n", &dma_rx_chan, &dma_tx_chan,
+		dev_info(&pdev->dev, "DMA: RX channel: %pa, TX channel: %pa, event queue: %d\n",
+				&dma_rx_chan, &dma_tx_chan,
 				pdata->dma_event_q);
 	}
 
-- 
2.0.0


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/2] spi: sirf: remove the allocation of dummypage
Date: Tue, 26 May 2015 05:21:01 +0000
Message-ID: <1432617661-15901-1-git-send-email-21cnbao@gmail.com>
Cc: workgroup.linux-kQvG35nSl+M@public.gmane.org, Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>,
	Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>

this job has been done by spi core.

Cc: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Signed-off-by: Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>
Signed-off-by: Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
---
 drivers/spi/spi-sirf.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-sirf.c b/drivers/spi/spi-sirf.c
index dd87ba6f..f9b864f 100644
--- a/drivers/spi/spi-sirf.c
+++ b/drivers/spi/spi-sirf.c
@@ -303,7 +303,6 @@ struct sirfsoc_spi {
 	struct dma_chan *tx_chan;
 	dma_addr_t src_start;
 	dma_addr_t dst_start;
-	void *dummypage;
 	int word_width; /* in bytes */
 
 	/*
@@ -719,8 +718,8 @@ static int spi_sirfsoc_transfer(struct spi_device *spi, struct spi_transfer *t)
 	struct sirfsoc_spi *sspi;
 
 	sspi = spi_master_get_devdata(spi->master);
-	sspi->tx = t->tx_buf ? t->tx_buf : sspi->dummypage;
-	sspi->rx = t->rx_buf ? t->rx_buf : sspi->dummypage;
+	sspi->tx = t->tx_buf;
+	sspi->rx = t->rx_buf;
 	sspi->left_tx_word = sspi->left_rx_word = t->len / sspi->word_width;
 	reinit_completion(&sspi->rx_done);
 	reinit_completion(&sspi->tx_done);
@@ -1114,6 +1113,7 @@ static int spi_sirfsoc_probe(struct platform_device *pdev)
 	master->bits_per_word_mask = SPI_BPW_MASK(8) | SPI_BPW_MASK(12) |
 					SPI_BPW_MASK(16) | SPI_BPW_MASK(32);
 	master->max_speed_hz = SIRFSOC_SPI_DEFAULT_FRQ;
+	master->flags = SPI_MASTER_MUST_RX | SPI_MASTER_MUST_TX;
 	sspi->bitbang.master->dev.of_node = pdev->dev.of_node;
 
 	/* request DMA channels */
@@ -1141,12 +1141,6 @@ static int spi_sirfsoc_probe(struct platform_device *pdev)
 	init_completion(&sspi->rx_done);
 	init_completion(&sspi->tx_done);
 
-	sspi->dummypage = devm_kzalloc(&pdev->dev, 2 * PAGE_SIZE, GFP_KERNEL);
-	if (!sspi->dummypage) {
-		ret = -ENOMEM;
-		goto free_clk;
-	}
-
 	ret = spi_bitbang_start(&sspi->bitbang);
 	if (ret)
 		goto free_clk;
-- 
2.3.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

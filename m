From: Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: [PATCH] spi: pic32-sqi: remove unnecessary of_node_get()
Date: Fri, 14 Sep 2018 23:05:34 +0300
Message-ID: <1536955534-22978-1-git-send-email-khoroshilov@ispras.ru>
Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Almost all spi drivers assign spi master->dev.of_node from
its parent platform device without additional refcounting.
It seems of_node_get() in pic32_sqi_probe() is unnecessary
and there is no corresponding of_node_put().

Found by Linux Driver Verification project (linuxtesting.org)

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 drivers/spi/spi-pic32-sqi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pic32-sqi.c b/drivers/spi/spi-pic32-sqi.c
index bd1c6b53283f..62e6bf1f50b1 100644
--- a/drivers/spi/spi-pic32-sqi.c
+++ b/drivers/spi/spi-pic32-sqi.c
@@ -656,7 +656,7 @@ static int pic32_sqi_probe(struct platform_device *pdev)
 	master->max_speed_hz	= clk_get_rate(sqi->base_clk);
 	master->dma_alignment	= 32;
 	master->max_dma_len	= PESQI_BD_BUF_LEN_MAX;
-	master->dev.of_node	= of_node_get(pdev->dev.of_node);
+	master->dev.of_node	= pdev->dev.of_node;
 	master->mode_bits	= SPI_MODE_3 | SPI_MODE_0 | SPI_TX_DUAL |
 				  SPI_RX_DUAL | SPI_TX_QUAD | SPI_RX_QUAD;
 	master->flags		= SPI_MASTER_HALF_DUPLEX;
-- 
2.7.4

From: Jaewon Kim <jaewon02.kim@gmail.com>
Subject: [PATCH] spi: dw: fix buffer end address
Date: Thu, 25 Oct 2018 00:37:17 +0900
Message-ID: <1540395437-6623-1-git-send-email-jaewon02.kim@samsung.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Mark Brown <broonie@kernel.org>,
        Jaewon Kim <jaewon02.kim@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Buffer address can be NULL, if user does not want to receive TX/RX data.
In this case, driver should not set the rx/tx_end value with len.

Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
---
 drivers/spi/spi-dw.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index b705f2b..34e6fca 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -293,9 +293,13 @@ static int dw_spi_transfer_one(struct spi_controller *master,
 	dws->dma_mapped = 0;
 
 	dws->tx = (void *)transfer->tx_buf;
-	dws->tx_end = dws->tx + transfer->len;
+	dws->tx_end = dws->tx;
+	if (dws->tx)
+		dws->tx_end += transfer->len;
 	dws->rx = transfer->rx_buf;
-	dws->rx_end = dws->rx + transfer->len;
+	dws->rx_end = dws->rx;
+	if (dws->rx)
+		dws->rx_end += transfer->len;
 	dws->len = transfer->len;
 
 	spi_enable_chip(dws, 0);
-- 
2.7.4

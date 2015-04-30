From: Cao Minh Hiep <cm-hiep@jinso.co.jp>
Subject: [PATCH 1/1 v2] spi: Re-do the returning value of rspi_dma_check_then_transfer
Date: Thu, 30 Apr 2015 11:12:12 +0900
Message-ID: <1430359932-13245-2-git-send-email-cm-hiep@jinso.co.jp>
References: <1430359932-13245-1-git-send-email-cm-hiep@jinso.co.jp>
Cc: broonie@kernel.org, linux-spi@vger.kernel.org,
	kuninori.morimoto.gx@renesas.com, yoshihiro.shimoda.uh@renesas.com,
	ryusuke.sakato.bx@renesas.com, linux-sh@vger.kernel.org
To: geert+renesas@glider.be
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1430359932-13245-1-git-send-email-cm-hiep@jinso.co.jp>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Hiep Cao Minh <cm-hiep@jinso.co.jp>

To reduce indentation and complexity of code, insteeds of returning zero
the function rspi_dma_check_then_transfer should return rspi_dma_transfer
directly after checking error.

Signed-off-by: Hiep Cao Minh <cm-hiep@jinso.co.jp>
---
 drivers/spi/spi-rspi.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 186924a..0061e28 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -665,15 +665,12 @@ static bool rspi_can_dma(struct spi_master *master, struct spi_device *spi,
 static int rspi_dma_check_then_transfer(struct rspi_data *rspi,
 					 struct spi_transfer *xfer)
 {
-	if (rspi->master->can_dma && __rspi_can_dma(rspi, xfer)) {
-		/* rx_buf can be NULL on RSPI on SH in TX-only Mode */
-		int ret = rspi_dma_transfer(rspi, &xfer->tx_sg,
-					xfer->rx_buf ? &xfer->rx_sg : NULL);
-		if (ret != -EAGAIN)
-			return 0;
-	}
+	if (!rspi->master->can_dma || !__rspi_can_dma(rspi, xfer))
+		return -EAGAIN;
 
-	return -EAGAIN;
+	/* rx_buf can be NULL on RSPI on SH in TX-only Mode */
+	return rspi_dma_transfer(rspi, &xfer->tx_sg,
+				xfer->rx_buf ? &xfer->rx_sg : NULL);
 }
 
 static int rspi_common_transfer(struct rspi_data *rspi,
-- 
1.9.1


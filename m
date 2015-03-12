From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Subject: [PATCH] spi: sh-msiof: Fix limit maximum word transfer size of FIFO size
Date: Thu, 12 Mar 2015 11:31:16 +0900
Message-ID: <1426127476-18456-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
Cc: linux-sh@vger.kernel.org, linux-spi@vger.kernel.org,
	yoshihiro.shimoda.uh@renesas.com,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
To: broonie@kernel.org
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This driver is the case of tx_buf was set or SPI_MASTER_MUST_TX is set to
master_flags, will be transmit mode. However, the current code, when
transmit mode and buffer is NULL, will be set to value of receive mode
size.
This is when the SPI_MASTER_MUST_TX is set to master_flags, sets to
transmit and receive either small size of FIFO, so as not to set the
actual size larger than value of FIFO.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
---
 drivers/spi/spi-sh-msiof.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index e57eec0..260f433 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -606,12 +606,26 @@ static int sh_msiof_spi_txrx_once(struct sh_msiof_spi_priv *p,
 {
 	int fifo_shift;
 	int ret;
+	int rx_words = min_t(int, words, p->rx_fifo_size);
+	int tx_words = min_t(int, words, p->tx_fifo_size);
 
-	/* limit maximum word transfer to rx/tx fifo size */
-	if (tx_buf)
-		words = min_t(int, words, p->tx_fifo_size);
-	if (rx_buf)
-		words = min_t(int, words, p->rx_fifo_size);
+	/*
+	 * limit maximum word transfer to rx/tx fifo size.
+	 *
+	 * If SPI_MASTER_MUST_TX was enabled in master_flags, words was
+	 * set to small value of FIFO.
+	 */
+	if (p->chipdata->master_flags & SPI_MASTER_MUST_TX) {
+		if (rx_words > tx_words)
+			words = tx_words;
+		else
+			words = rx_words;
+	} else {
+		if (tx_buf)
+			words = tx_words;
+		if (rx_buf)
+			words = rx_words;
+	}
 
 	/* the fifo contents need shifting */
 	fifo_shift = 32 - bits;
-- 
2.1.3


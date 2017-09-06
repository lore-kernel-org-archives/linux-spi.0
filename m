From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: [PATCH 5/8] spi: sh-msiof: Wait for Tx FIFO empty after DMA
Date: Wed, 6 Sep 2017 09:05:04 +0200
Message-ID: <20170906070507.26223-6-dirk.behme@de.bosch.com>
References: <20170906070507.26223-1-dirk.behme@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>,
        Dirk Behme <dirk.behme@de.bosch.com>
To: <linux-renesas-soc@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170906070507.26223-1-dirk.behme@de.bosch.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>

When Tx DMA is only used, Tx FIFO is still not empty after DMA callback.
This patch waits for sweeping data out of the Tx FIFO.

Signed-off-by: Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>
[adjust context]
Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
---
 drivers/spi/spi-sh-msiof.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 660b03ed6770..a960e8da123d 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -638,6 +638,17 @@ static int sh_msiof_wait_for_completion(struct sh_msiof_spi_priv *p,
 				dev_err(&p->pdev->dev, "Tx DMA timeout\n");
 				return -ETIMEDOUT;
 			}
+			if (!rx) {
+				sh_msiof_write(p, IER, IER_TEOFE);
+
+				/* wait for tx fifo to be emptied */
+				if (!wait_for_completion_timeout(&p->done,
+								 HZ)) {
+					dev_err(&p->pdev->dev,
+					"Tx fifo to be emptied timeout\n");
+					return -ETIMEDOUT;
+				}
+			}
 		}
 		if (rx) {
 			if (!wait_for_completion_timeout(&p->done_dma_rx,
@@ -805,7 +816,7 @@ static int sh_msiof_dma_once(struct sh_msiof_spi_priv *p, const void *tx,
 		goto stop_dma;
 	}
 
-	/* wait for tx fifo to be emptied / rx fifo to be filled */
+	/* wait for Tx/Rx DMA completion */
 	ret = sh_msiof_wait_for_completion(p, tx, rx);
 	if (ret)
 		goto stop_reset;
-- 
2.14.1

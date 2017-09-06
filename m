From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: [PATCH 4/8] spi: sh-msiof: Fix DMA completion
Date: Wed, 6 Sep 2017 09:05:03 +0200
Message-ID: <20170906070507.26223-5-dirk.behme@de.bosch.com>
References: <20170906070507.26223-1-dirk.behme@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ryo Kataoka <ryo.kataoka.wt@renesas.com>,
        Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>,
        Dirk Behme <dirk.behme@de.bosch.com>
To: <linux-renesas-soc@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170906070507.26223-1-dirk.behme@de.bosch.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Ryo Kataoka <ryo.kataoka.wt@renesas.com>

When reception DMA completes before transmission DMA, next transmission
DMA may not be able to start. This patch adds wait_for_completion_timeout()
to both of reception DMA and transmission DMA.

If the driver waits only for the Rx DMA completion, the Tx DMA completion
thread of DMA Engine may be still processing.

Signed-off-by: Ryo Kataoka <ryo.kataoka.wt@renesas.com>
[reword commit message]
Signed-off-by: Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>
[adjust context]
Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
---
 drivers/spi/spi-sh-msiof.c | 53 +++++++++++++++++++++++++++++++---------------
 1 file changed, 36 insertions(+), 17 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 24b49d3ca9a8..660b03ed6770 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -52,6 +52,7 @@ struct sh_msiof_spi_priv {
 	struct platform_device *pdev;
 	struct sh_msiof_spi_info *info;
 	struct completion done;
+	struct completion done_dma_tx, done_dma_rx;
 	unsigned int tx_fifo_size;
 	unsigned int rx_fifo_size;
 	unsigned int min_div;
@@ -621,7 +622,8 @@ static int sh_msiof_slave_abort(struct spi_master *master)
 	return 0;
 }
 
-static int sh_msiof_wait_for_completion(struct sh_msiof_spi_priv *p)
+static int sh_msiof_wait_for_completion(struct sh_msiof_spi_priv *p,
+					const void *tx, void *rx)
 {
 	if (spi_controller_is_slave(p->master)) {
 		if (wait_for_completion_interruptible(&p->done) ||
@@ -630,10 +632,22 @@ static int sh_msiof_wait_for_completion(struct sh_msiof_spi_priv *p)
 			return -EINTR;
 		}
 	} else {
-		if (!wait_for_completion_timeout(&p->done, HZ)) {
-			dev_err(&p->pdev->dev, "timeout\n");
-			return -ETIMEDOUT;
+		if (tx) {
+			if (!wait_for_completion_timeout(&p->done_dma_tx,
+							 HZ)) {
+				dev_err(&p->pdev->dev, "Tx DMA timeout\n");
+				return -ETIMEDOUT;
+			}
 		}
+		if (rx) {
+			if (!wait_for_completion_timeout(&p->done_dma_rx,
+							 HZ)) {
+				dev_err(&p->pdev->dev, "Rx DMA timeout\n");
+				return -ETIMEDOUT;
+			}
+		}
+
+		sh_msiof_write(p, IER, 0);
 	}
 
 	return 0;
@@ -680,7 +694,7 @@ static int sh_msiof_spi_txrx_once(struct sh_msiof_spi_priv *p,
 	}
 
 	/* wait for tx fifo to be emptied / rx fifo to be filled */
-	ret = sh_msiof_wait_for_completion(p);
+	ret = sh_msiof_wait_for_completion(p, tx_buf, rx_buf);
 	if (ret)
 		goto stop_reset;
 
@@ -707,12 +721,18 @@ static int sh_msiof_spi_txrx_once(struct sh_msiof_spi_priv *p,
 	return ret;
 }
 
-static void sh_msiof_dma_complete(void *arg)
+static void sh_msiof_tx_dma_complete(void *arg)
 {
 	struct sh_msiof_spi_priv *p = arg;
 
-	sh_msiof_write(p, IER, 0);
-	complete(&p->done);
+	complete(&p->done_dma_tx);
+}
+
+static void sh_msiof_rx_dma_complete(void *arg)
+{
+	struct sh_msiof_spi_priv *p = arg;
+
+	complete(&p->done_dma_rx);
 }
 
 static int sh_msiof_dma_once(struct sh_msiof_spi_priv *p, const void *tx,
@@ -732,7 +752,7 @@ static int sh_msiof_dma_once(struct sh_msiof_spi_priv *p, const void *tx,
 		if (!desc_rx)
 			return -EAGAIN;
 
-		desc_rx->callback = sh_msiof_dma_complete;
+		desc_rx->callback = sh_msiof_rx_dma_complete;
 		desc_rx->callback_param = p;
 		cookie = dmaengine_submit(desc_rx);
 		if (dma_submit_error(cookie))
@@ -751,13 +771,8 @@ static int sh_msiof_dma_once(struct sh_msiof_spi_priv *p, const void *tx,
 			goto no_dma_tx;
 		}
 
-		if (rx) {
-			/* No callback */
-			desc_tx->callback = NULL;
-		} else {
-			desc_tx->callback = sh_msiof_dma_complete;
-			desc_tx->callback_param = p;
-		}
+		desc_tx->callback = sh_msiof_tx_dma_complete;
+		desc_tx->callback_param = p;
 		cookie = dmaengine_submit(desc_tx);
 		if (dma_submit_error(cookie)) {
 			ret = cookie;
@@ -774,6 +789,8 @@ static int sh_msiof_dma_once(struct sh_msiof_spi_priv *p, const void *tx,
 	sh_msiof_write(p, IER, ier_bits);
 
 	reinit_completion(&p->done);
+	reinit_completion(&p->done_dma_tx);
+	reinit_completion(&p->done_dma_rx);
 	p->slave_aborted = false;
 
 	/* Now start DMA */
@@ -789,7 +806,7 @@ static int sh_msiof_dma_once(struct sh_msiof_spi_priv *p, const void *tx,
 	}
 
 	/* wait for tx fifo to be emptied / rx fifo to be filled */
-	ret = sh_msiof_wait_for_completion(p);
+	ret = sh_msiof_wait_for_completion(p, tx, rx);
 	if (ret)
 		goto stop_reset;
 
@@ -1258,6 +1275,8 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
 	p->min_div = chipdata->min_div;
 
 	init_completion(&p->done);
+	init_completion(&p->done_dma_tx);
+	init_completion(&p->done_dma_rx);
 
 	p->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(p->clk)) {
-- 
2.14.1

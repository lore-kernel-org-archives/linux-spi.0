From: Gerhard Sittig <gsi-ynQEQJNshbs@public.gmane.org>
Subject: [PATCH v1 1/3] spi: mpc512x: minor prep before feature change
Date: Mon,  3 Jun 2013 14:03:49 +0200
Message-ID: <1370261031-28572-2-git-send-email-gsi@denx.de>
References: <1370261031-28572-1-git-send-email-gsi@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Gerhard Sittig <gsi-ynQEQJNshbs@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, dzu-ynQEQJNshbs@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1370261031-28572-1-git-send-email-gsi-ynQEQJNshbs@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

mechanical edits before changing functionality, to reduce diffs
- rename variables to later tell remaining TX and RX apart
- use size_t for the current TX and RX length
  (for better compatibility with the min() macro)
- remove unused members from the master data (sysclk, eofbyte)
- silence a checkpatch warning (braces around single statement)

Signed-off-by: Gerhard Sittig <gsi-ynQEQJNshbs@public.gmane.org>
---
 drivers/spi/spi-mpc512x-psc.c |   43 ++++++++++++++++++-----------------------
 1 file changed, 19 insertions(+), 24 deletions(-)


this patch triggers a checkpatch warning which IMO is acceptable
(see the cover letter for the details)


diff --git a/drivers/spi/spi-mpc512x-psc.c b/drivers/spi/spi-mpc512x-psc.c
index dfddf33..759a937 100644
--- a/drivers/spi/spi-mpc512x-psc.c
+++ b/drivers/spi/spi-mpc512x-psc.c
@@ -33,7 +33,6 @@
 
 struct mpc512x_psc_spi {
 	void (*cs_control)(struct spi_device *spi, bool on);
-	u32 sysclk;
 
 	/* driver internal data */
 	struct mpc52xx_psc __iomem *psc;
@@ -42,7 +41,6 @@ struct mpc512x_psc_spi {
 	u8 bits_per_word;
 	u8 busy;
 	u32 mclk;
-	u8 eofbyte;
 
 	struct workqueue_struct *workqueue;
 	struct work_struct work;
@@ -50,7 +48,7 @@ struct mpc512x_psc_spi {
 	struct list_head queue;
 	spinlock_t lock;	/* Message queue lock */
 
-	struct completion done;
+	struct completion txisrdone;
 };
 
 /* controller state */
@@ -138,7 +136,7 @@ static int mpc512x_psc_spi_transfer_rxtx(struct spi_device *spi,
 	struct mpc512x_psc_spi *mps = spi_master_get_devdata(spi->master);
 	struct mpc52xx_psc __iomem *psc = mps->psc;
 	struct mpc512x_psc_fifo __iomem *fifo = mps->fifo;
-	size_t len = t->len;
+	size_t tx_len = t->len;
 	u8 *tx_buf = (u8 *)t->tx_buf;
 	u8 *rx_buf = (u8 *)t->rx_buf;
 
@@ -152,58 +150,57 @@ static int mpc512x_psc_spi_transfer_rxtx(struct spi_device *spi,
 	/* enable transmiter/receiver */
 	out_8(&psc->command, MPC52xx_PSC_TX_ENABLE | MPC52xx_PSC_RX_ENABLE);
 
-	while (len) {
-		int count;
+	while (tx_len) {
+		size_t txcount;
 		int i;
 		u8 data;
 		size_t fifosz;
-		int rxcount;
+		size_t rxcount;
 
 		/*
 		 * The number of bytes that can be sent at a time
 		 * depends on the fifo size.
 		 */
 		fifosz = MPC512x_PSC_FIFO_SZ(in_be32(&fifo->txsz));
-		count = min(fifosz, len);
+		txcount = min(fifosz, tx_len);
 
-		for (i = count; i > 0; i--) {
+		for (i = txcount; i > 0; i--) {
 			data = tx_buf ? *tx_buf++ : 0;
-			if (len == EOFBYTE && t->cs_change)
+			if (tx_len == EOFBYTE && t->cs_change)
 				setbits32(&fifo->txcmd, MPC512x_PSC_FIFO_EOF);
 			out_8(&fifo->txdata_8, data);
-			len--;
+			tx_len--;
 		}
 
-		INIT_COMPLETION(mps->done);
+		INIT_COMPLETION(mps->txisrdone);
 
 		/* interrupt on tx fifo empty */
 		out_be32(&fifo->txisr, MPC512x_PSC_FIFO_EMPTY);
 		out_be32(&fifo->tximr, MPC512x_PSC_FIFO_EMPTY);
 
-		wait_for_completion(&mps->done);
+		wait_for_completion(&mps->txisrdone);
 
 		mdelay(1);
 
-		/* rx fifo should have count bytes in it */
+		/* rx fifo should have txcount bytes in it */
 		rxcount = in_be32(&fifo->rxcnt);
-		if (rxcount != count)
+		if (rxcount != txcount)
 			mdelay(1);
 
 		rxcount = in_be32(&fifo->rxcnt);
-		if (rxcount != count) {
+		if (rxcount != txcount) {
 			dev_warn(&spi->dev, "expected %d bytes in rx fifo "
-				 "but got %d\n", count, rxcount);
+				 "but got %d\n", txcount, rxcount);
 		}
 
-		rxcount = min(rxcount, count);
+		rxcount = min(rxcount, txcount);
 		for (i = rxcount; i > 0; i--) {
 			data = in_8(&fifo->rxdata_8);
 			if (rx_buf)
 				*rx_buf++ = data;
 		}
-		while (in_be32(&fifo->rxcnt)) {
+		while (in_be32(&fifo->rxcnt))
 			in_8(&fifo->rxdata_8);
-		}
 	}
 	/* disable transmiter/receiver and fifo interrupt */
 	out_8(&psc->command, MPC52xx_PSC_TX_DISABLE | MPC52xx_PSC_RX_DISABLE);
@@ -412,7 +409,7 @@ static irqreturn_t mpc512x_psc_spi_isr(int irq, void *dev_id)
 	    in_be32(&fifo->tximr) & MPC512x_PSC_FIFO_EMPTY) {
 		out_be32(&fifo->txisr, MPC512x_PSC_FIFO_EMPTY);
 		out_be32(&fifo->tximr, 0);
-		complete(&mps->done);
+		complete(&mps->txisrdone);
 		return IRQ_HANDLED;
 	}
 	return IRQ_NONE;
@@ -444,11 +441,9 @@ static int mpc512x_psc_spi_do_probe(struct device *dev, u32 regaddr,
 
 	if (pdata == NULL) {
 		mps->cs_control = mpc512x_spi_cs_control;
-		mps->sysclk = 0;
 		master->bus_num = bus_num;
 	} else {
 		mps->cs_control = pdata->cs_control;
-		mps->sysclk = pdata->sysclk;
 		master->bus_num = pdata->bus_num;
 		master->num_chipselect = pdata->max_chipselect;
 	}
@@ -479,7 +474,7 @@ static int mpc512x_psc_spi_do_probe(struct device *dev, u32 regaddr,
 		goto free_irq;
 
 	spin_lock_init(&mps->lock);
-	init_completion(&mps->done);
+	init_completion(&mps->txisrdone);
 	INIT_WORK(&mps->work, mpc512x_psc_spi_work);
 	INIT_LIST_HEAD(&mps->queue);
 
-- 
1.7.10.4


------------------------------------------------------------------------------
Get 100% visibility into Java/.NET code with AppDynamics Lite
It's a free troubleshooting tool designed for production
Get down to code-level detail for bottlenecks, with <2% overhead.
Download for free and get started troubleshooting in minutes.
http://p.sf.net/sfu/appdyn_d2d_ap2

From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH V2 1/9] spi: bcm2835aux: unifying code between polling and
 interrupt driven code
Date: Sun, 24 Mar 2019 17:49:54 +0000
Message-ID: <20190324175002.28969-2-kernel@martin.sperl.org>
References: <20190324175002.28969-1-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>,
 Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>,
 Hubert Denkmair <h.denkmair-4pT7WzY1KUiELgA04lAiVw@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
 linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20190324175002.28969-1-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rpi-kernel/>
List-Post: <mailto:linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "linux-rpi-kernel" <linux-rpi-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

Sharing more code between polling and interrupt-driven mode.

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
---
 drivers/spi/spi-bcm2835aux.c | 51 ++++++++++++++++----------------------------
 1 file changed, 18 insertions(+), 33 deletions(-)

diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
index f7e054848ca5..41366d0a16af 100644
--- a/drivers/spi/spi-bcm2835aux.c
+++ b/drivers/spi/spi-bcm2835aux.c
@@ -178,23 +178,13 @@ static void bcm2835aux_spi_reset_hw(struct bcm2835aux_spi *bs)
 		      BCM2835_AUX_SPI_CNTL0_CLEARFIFO);
 }

-static irqreturn_t bcm2835aux_spi_interrupt(int irq, void *dev_id)
+static void bcm2835aux_spi_transfer_helper(struct bcm2835aux_spi *bs)
 {
-	struct spi_master *master = dev_id;
-	struct bcm2835aux_spi *bs = spi_master_get_devdata(master);
-	irqreturn_t ret = IRQ_NONE;
-
-	/* IRQ may be shared, so return if our interrupts are disabled */
-	if (!(bcm2835aux_rd(bs, BCM2835_AUX_SPI_CNTL1) &
-	      (BCM2835_AUX_SPI_CNTL1_TXEMPTY | BCM2835_AUX_SPI_CNTL1_IDLE)))
-		return ret;
-
 	/* check if we have data to read */
 	while (bs->rx_len &&
 	       (!(bcm2835aux_rd(bs, BCM2835_AUX_SPI_STAT) &
 		  BCM2835_AUX_SPI_STAT_RX_EMPTY))) {
 		bcm2835aux_rd_fifo(bs);
-		ret = IRQ_HANDLED;
 	}

 	/* check if we have data to write */
@@ -203,7 +193,6 @@ static irqreturn_t bcm2835aux_spi_interrupt(int irq, void *dev_id)
 	       (!(bcm2835aux_rd(bs, BCM2835_AUX_SPI_STAT) &
 		  BCM2835_AUX_SPI_STAT_TX_FULL))) {
 		bcm2835aux_wr_fifo(bs);
-		ret = IRQ_HANDLED;
 	}

 	/* and check if we have reached "done" */
@@ -211,8 +200,21 @@ static irqreturn_t bcm2835aux_spi_interrupt(int irq, void *dev_id)
 	       (!(bcm2835aux_rd(bs, BCM2835_AUX_SPI_STAT) &
 		  BCM2835_AUX_SPI_STAT_BUSY))) {
 		bcm2835aux_rd_fifo(bs);
-		ret = IRQ_HANDLED;
 	}
+}
+
+static irqreturn_t bcm2835aux_spi_interrupt(int irq, void *dev_id)
+{
+	struct spi_master *master = dev_id;
+	struct bcm2835aux_spi *bs = spi_master_get_devdata(master);
+
+	/* IRQ may be shared, so return if our interrupts are disabled */
+	if (!(bcm2835aux_rd(bs, BCM2835_AUX_SPI_CNTL1) &
+	      (BCM2835_AUX_SPI_CNTL1_TXEMPTY | BCM2835_AUX_SPI_CNTL1_IDLE)))
+		return IRQ_NONE;
+
+	/* do common fifo handling */
+	bcm2835aux_spi_transfer_helper(bs);

 	if (!bs->tx_len) {
 		/* disable tx fifo empty interrupt */
@@ -226,8 +228,7 @@ static irqreturn_t bcm2835aux_spi_interrupt(int irq, void *dev_id)
 		complete(&master->xfer_completion);
 	}

-	/* and return */
-	return ret;
+	return IRQ_HANDLED;
 }

 static int __bcm2835aux_spi_transfer_one_irq(struct spi_master *master,
@@ -273,7 +274,6 @@ static int bcm2835aux_spi_transfer_one_poll(struct spi_master *master,
 {
 	struct bcm2835aux_spi *bs = spi_master_get_devdata(master);
 	unsigned long timeout;
-	u32 stat;

 	/* configure spi */
 	bcm2835aux_wr(bs, BCM2835_AUX_SPI_CNTL1, bs->cntl[1]);
@@ -284,24 +284,9 @@ static int bcm2835aux_spi_transfer_one_poll(struct spi_master *master,

 	/* loop until finished the transfer */
 	while (bs->rx_len) {
-		/* read status */
-		stat = bcm2835aux_rd(bs, BCM2835_AUX_SPI_STAT);
-
-		/* fill in tx fifo with remaining data */
-		if ((bs->tx_len) && (!(stat & BCM2835_AUX_SPI_STAT_TX_FULL))) {
-			bcm2835aux_wr_fifo(bs);
-			continue;
-		}

-		/* read data from fifo for both cases */
-		if (!(stat & BCM2835_AUX_SPI_STAT_RX_EMPTY)) {
-			bcm2835aux_rd_fifo(bs);
-			continue;
-		}
-		if (!(stat & BCM2835_AUX_SPI_STAT_BUSY)) {
-			bcm2835aux_rd_fifo(bs);
-			continue;
-		}
+		/* do common fifo handling */
+		bcm2835aux_spi_transfer_helper(bs);

 		/* there is still data pending to read check the timeout */
 		if (bs->rx_len && time_after(jiffies, timeout)) {
--
2.11.0

From: kernel@martin.sperl.org
Subject: [PATCH 6/9] spi: bcm2835aux: unifying code between polling and
 interrupt driven code
Date: Sun, 24 Feb 2019 12:54:37 +0000
Message-ID: <20190224125440.16117-7-kernel@martin.sperl.org>
References: <20190224125440.16117-1-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Martin Sperl <kernel@martin.sperl.org>
To: Mark Brown <broonie@kernel.org>, Eric Anholt <eric@anholt.net>,
 Stefan Wahren <stefan.wahren@i2se.com>,
 Hubert Denkmair <h.denkmair@intence.de>, linux-spi@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190224125440.16117-1-kernel@martin.sperl.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

From: Martin Sperl <kernel@martin.sperl.org>

Sharing code between polling and interrupt-driven mode.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 drivers/spi/spi-bcm2835aux.c | 51 ++++++++++++++++----------------------------
 1 file changed, 18 insertions(+), 33 deletions(-)

diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
index af668cb6b38b..9552f5343982 100644
--- a/drivers/spi/spi-bcm2835aux.c
+++ b/drivers/spi/spi-bcm2835aux.c
@@ -230,23 +230,13 @@ static void bcm2835aux_spi_reset_hw(struct bcm2835aux_spi *bs)
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
@@ -255,7 +245,6 @@ static irqreturn_t bcm2835aux_spi_interrupt(int irq, void *dev_id)
 	       (!(bcm2835aux_rd(bs, BCM2835_AUX_SPI_STAT) &
 		  BCM2835_AUX_SPI_STAT_TX_FULL))) {
 		bcm2835aux_wr_fifo(bs);
-		ret = IRQ_HANDLED;
 	}

 	/* and check if we have reached "done" */
@@ -263,8 +252,21 @@ static irqreturn_t bcm2835aux_spi_interrupt(int irq, void *dev_id)
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
@@ -278,8 +280,7 @@ static irqreturn_t bcm2835aux_spi_interrupt(int irq, void *dev_id)
 		complete(&master->xfer_completion);
 	}

-	/* and return */
-	return ret;
+	return IRQ_HANDLED;
 }

 static int __bcm2835aux_spi_transfer_one_irq(struct spi_master *master,
@@ -328,7 +329,6 @@ static int bcm2835aux_spi_transfer_one_poll(struct spi_master *master,
 {
 	struct bcm2835aux_spi *bs = spi_master_get_devdata(master);
 	unsigned long timeout;
-	u32 stat;

 	/* update statistics */
 	BCM2835_AUX_INCR(bs->count_transfer_polling);
@@ -342,24 +342,9 @@ static int bcm2835aux_spi_transfer_one_poll(struct spi_master *master,

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

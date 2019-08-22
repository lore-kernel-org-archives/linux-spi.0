From: Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH v2 1/5] spi: spi-fsl-dspi: Reduce indentation level in dspi_interrupt
Date: Fri, 23 Aug 2019 00:15:10 +0300
Message-ID: <20190822211514.19288-2-olteanv@gmail.com>
References: <20190822211514.19288-1-olteanv@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, netdev@vger.kernel.org,
        Vladimir Oltean <olteanv@gmail.com>
To: broonie@kernel.org
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190822211514.19288-1-olteanv@gmail.com>
Sender: netdev-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

If the entire function depends on the SPI status register having the
interrupt bits asserted, then just check it and exit early if those bits
aren't set (such as in the case of the shared IRQ being triggered for
the other peripheral). Cosmetic patch.

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
---
 drivers/spi/spi-fsl-dspi.c | 79 +++++++++++++++++++-------------------
 1 file changed, 40 insertions(+), 39 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 790cb02fc181..c90db7db4121 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -658,47 +658,48 @@ static irqreturn_t dspi_interrupt(int irq, void *dev_id)
 	regmap_read(dspi->regmap, SPI_SR, &spi_sr);
 	regmap_write(dspi->regmap, SPI_SR, spi_sr);
 
+	if (!(spi_sr & (SPI_SR_EOQF | SPI_SR_TCFQF)))
+		return IRQ_HANDLED;
+
+	/* Get transfer counter (in number of SPI transfers). It was
+	 * reset to 0 when transfer(s) were started.
+	 */
+	regmap_read(dspi->regmap, SPI_TCR, &spi_tcr);
+	spi_tcnt = SPI_TCR_GET_TCNT(spi_tcr);
+	/* Update total number of bytes that were transferred */
+	msg->actual_length += spi_tcnt * dspi->bytes_per_word;
+
+	trans_mode = dspi->devtype_data->trans_mode;
+	switch (trans_mode) {
+	case DSPI_EOQ_MODE:
+		dspi_eoq_read(dspi);
+		break;
+	case DSPI_TCFQ_MODE:
+		dspi_tcfq_read(dspi);
+		break;
+	default:
+		dev_err(&dspi->pdev->dev, "unsupported trans_mode %u\n",
+			trans_mode);
+			return IRQ_HANDLED;
+	}
 
-	if (spi_sr & (SPI_SR_EOQF | SPI_SR_TCFQF)) {
-		/* Get transfer counter (in number of SPI transfers). It was
-		 * reset to 0 when transfer(s) were started.
-		 */
-		regmap_read(dspi->regmap, SPI_TCR, &spi_tcr);
-		spi_tcnt = SPI_TCR_GET_TCNT(spi_tcr);
-		/* Update total number of bytes that were transferred */
-		msg->actual_length += spi_tcnt * dspi->bytes_per_word;
-
-		trans_mode = dspi->devtype_data->trans_mode;
-		switch (trans_mode) {
-		case DSPI_EOQ_MODE:
-			dspi_eoq_read(dspi);
-			break;
-		case DSPI_TCFQ_MODE:
-			dspi_tcfq_read(dspi);
-			break;
-		default:
-			dev_err(&dspi->pdev->dev, "unsupported trans_mode %u\n",
-				trans_mode);
-				return IRQ_HANDLED;
-		}
+	if (!dspi->len) {
+		dspi->waitflags = 1;
+		wake_up_interruptible(&dspi->waitq);
+		return IRQ_HANDLED;
+	}
 
-		if (!dspi->len) {
-			dspi->waitflags = 1;
-			wake_up_interruptible(&dspi->waitq);
-		} else {
-			switch (trans_mode) {
-			case DSPI_EOQ_MODE:
-				dspi_eoq_write(dspi);
-				break;
-			case DSPI_TCFQ_MODE:
-				dspi_tcfq_write(dspi);
-				break;
-			default:
-				dev_err(&dspi->pdev->dev,
-					"unsupported trans_mode %u\n",
-					trans_mode);
-			}
-		}
+	switch (trans_mode) {
+	case DSPI_EOQ_MODE:
+		dspi_eoq_write(dspi);
+		break;
+	case DSPI_TCFQ_MODE:
+		dspi_tcfq_write(dspi);
+		break;
+	default:
+		dev_err(&dspi->pdev->dev,
+			"unsupported trans_mode %u\n",
+			trans_mode);
 	}
 
 	return IRQ_HANDLED;
-- 
2.17.1

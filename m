From: Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH v2 3/5] spi: spi-fsl-dspi: Remove impossible to reach error check
Date: Fri, 23 Aug 2019 00:15:12 +0300
Message-ID: <20190822211514.19288-4-olteanv@gmail.com>
References: <20190822211514.19288-1-olteanv@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, netdev@vger.kernel.org,
        Vladimir Oltean <olteanv@gmail.com>
To: broonie@kernel.org
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190822211514.19288-1-olteanv@gmail.com>
Sender: netdev-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

dspi->devtype_data is under the total control of the driver. Therefore,
a bad value is a driver bug and checking it at runtime (and during an
ISR, at that!) is pointless.

The second "else if" check is only for clarity (instead of a broader
"else") in case other transfer modes are added in the future. But the
printing is dead code and can be removed.

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
---
 drivers/spi/spi-fsl-dspi.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 6ef2279a3699..6d2c7984ab0e 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -670,18 +670,10 @@ static irqreturn_t dspi_interrupt(int irq, void *dev_id)
 	msg->actual_length += spi_tcnt * dspi->bytes_per_word;
 
 	trans_mode = dspi->devtype_data->trans_mode;
-	switch (trans_mode) {
-	case DSPI_EOQ_MODE:
+	if (trans_mode == DSPI_EOQ_MODE)
 		dspi_eoq_read(dspi);
-		break;
-	case DSPI_TCFQ_MODE:
+	else if (trans_mode == DSPI_TCFQ_MODE)
 		dspi_tcfq_read(dspi);
-		break;
-	default:
-		dev_err(&dspi->pdev->dev, "unsupported trans_mode %u\n",
-			trans_mode);
-			return IRQ_HANDLED;
-	}
 
 	if (!dspi->len) {
 		dspi->waitflags = 1;
@@ -689,18 +681,10 @@ static irqreturn_t dspi_interrupt(int irq, void *dev_id)
 		return IRQ_HANDLED;
 	}
 
-	switch (trans_mode) {
-	case DSPI_EOQ_MODE:
+	if (trans_mode == DSPI_EOQ_MODE)
 		dspi_eoq_write(dspi);
-		break;
-	case DSPI_TCFQ_MODE:
+	else if (trans_mode == DSPI_TCFQ_MODE)
 		dspi_tcfq_write(dspi);
-		break;
-	default:
-		dev_err(&dspi->pdev->dev,
-			"unsupported trans_mode %u\n",
-			trans_mode);
-	}
 
 	return IRQ_HANDLED;
 }
-- 
2.17.1

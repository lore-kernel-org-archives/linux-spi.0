From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: spi-fsl-dspi: Remove impossible to reach error check" to the spi tree
Date: Fri, 23 Aug 2019 12:02:27 +0100 (BST)
Message-ID: <20190823110227.24769D02CD0@fitzroy.sirena.org.uk>
References: <20190822211514.19288-4-olteanv@gmail.com>
Cc: broonie@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, netdev@vger.kernel.org
To: Vladimir Oltean <olteanv@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190822211514.19288-4-olteanv@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: spi-fsl-dspi: Remove impossible to reach error check

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.4

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 1eaeba70738e723be1e5787bdfd9a30f7471d730 Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <olteanv@gmail.com>
Date: Fri, 23 Aug 2019 00:15:12 +0300
Subject: [PATCH] spi: spi-fsl-dspi: Remove impossible to reach error check

dspi->devtype_data is under the total control of the driver. Therefore,
a bad value is a driver bug and checking it at runtime (and during an
ISR, at that!) is pointless.

The second "else if" check is only for clarity (instead of a broader
"else") in case other transfer modes are added in the future. But the
printing is dead code and can be removed.

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
Link: https://lore.kernel.org/r/20190822211514.19288-4-olteanv@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.20.1

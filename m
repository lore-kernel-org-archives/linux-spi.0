From: Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [RFC PATCH 03/15] spi: make `cs_change_delay` the first user of the `spi_delay` logic
Date: Fri, 13 Sep 2019 14:45:38 +0300
Message-ID: <20190913114550.956-4-alexandru.ardelean@analog.com>
References: <20190913114550.956-1-alexandru.ardelean@analog.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Cc: <jic23@kernel.org>, <broonie@kernel.org>, <f.fainelli@gmail.com>,
        <linus.walleij@linaro.org>, <orsonzhai@gmail.com>,
        <baolin.wang@linaro.org>, <zhang.lyra@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
To: <linux-spi@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bcm-kernel-feedback-list@broadcom.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190913114550.956-1-alexandru.ardelean@analog.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Since the logic for `spi_delay` struct + `spi_delay_exec()` has been copied
from the `cs_change_delay` logic, it's natural to make this delay, the
first user.

The `cs_change_delay` logic requires that the default remain 10 uS, in case
it is unspecified/unconfigured. So, there is some special handling needed
to do that.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/spi/spi.c       | 28 +++++++---------------------
 include/linux/spi/spi.h |  4 +---
 2 files changed, 8 insertions(+), 24 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 1883de8ffa82..d0bf0ffca042 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1160,9 +1160,9 @@ EXPORT_SYMBOL_GPL(spi_delay_exec);
 static void _spi_transfer_cs_change_delay(struct spi_message *msg,
 					  struct spi_transfer *xfer)
 {
-	u32 delay = xfer->cs_change_delay;
-	u32 unit = xfer->cs_change_delay_unit;
-	u32 hz;
+	u32 delay = xfer->cs_change_delay.value;
+	u32 unit = xfer->cs_change_delay.unit;
+	int ret;
 
 	/* return early on "fast" mode - for everything but USECS */
 	if (!delay) {
@@ -1171,27 +1171,13 @@ static void _spi_transfer_cs_change_delay(struct spi_message *msg,
 		return;
 	}
 
-	switch (unit) {
-	case SPI_DELAY_UNIT_USECS:
-		delay *= 1000;
-		break;
-	case SPI_DELAY_UNIT_NSECS: /* nothing to do here */
-		break;
-	case SPI_DELAY_UNIT_SCK:
-		/* if there is no effective speed know, then approximate
-		 * by underestimating with half the requested hz
-		 */
-		hz = xfer->effective_speed_hz ?: xfer->speed_hz / 2;
-		delay *= DIV_ROUND_UP(1000000000, hz);
-		break;
-	default:
+	ret = spi_delay_exec(&xfer->cs_change_delay, xfer);
+	if (ret) {
 		dev_err_once(&msg->spi->dev,
 			     "Use of unsupported delay unit %i, using default of 10us\n",
-			     xfer->cs_change_delay_unit);
-		delay = 10000;
+			     unit);
+		_spi_transfer_delay_ns(10000);
 	}
-	/* now sleep for the requested amount of time */
-	_spi_transfer_delay_ns(delay);
 }
 
 /*
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index c18cfa7cda35..9ded3f44d58e 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -754,7 +754,6 @@ extern void spi_res_release(struct spi_controller *ctlr,
  * @cs_change: affects chipselect after this transfer completes
  * @cs_change_delay: delay between cs deassert and assert when
  *      @cs_change is set and @spi_transfer is not the last in @spi_message
- * @cs_change_delay_unit: unit of cs_change_delay
  * @delay_usecs: microseconds to delay after this transfer before
  *	(optionally) changing the chipselect status, then starting
  *	the next transfer or completing this @spi_message.
@@ -847,8 +846,7 @@ struct spi_transfer {
 	u8		bits_per_word;
 	u8		word_delay_usecs;
 	u16		delay_usecs;
-	u16		cs_change_delay;
-	u8		cs_change_delay_unit;
+	struct spi_delay	cs_change_delay;
 	u32		speed_hz;
 	u16		word_delay;
 
-- 
2.20.1

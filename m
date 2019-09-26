From: Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v4 16/19] spi: spi-fsl-espi: convert transfer delay to `spi_delay` format
Date: Thu, 26 Sep 2019 13:51:44 +0300
Message-ID: <20190926105147.7839-17-alexandru.ardelean@analog.com>
References: <20190926105147.7839-1-alexandru.ardelean@analog.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Cc: <jic23@kernel.org>, <broonie@kernel.org>, <f.fainelli@gmail.com>,
        <linus.walleij@linaro.org>, <orsonzhai@gmail.com>,
        <baolin.wang@linaro.org>, <zhang.lyra@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
To: <bcm-kernel-feedback-list@broadcom.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-tegra@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190926105147.7839-1-alexandru.ardelean@analog.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The way the max delay is computed for this controller, it looks like it is
searching for the max delay from an SPI message a using that.

No idea if this is valid. But this change should support both `delay_usecs`
and the new `delay` data which is of `spi_delay` type.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/spi/spi-fsl-espi.c | 16 +++++++++++++---
 drivers/spi/spi.c          |  9 +++++----
 include/linux/spi/spi.h    |  1 +
 3 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 732bf3195917..e60581283a24 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -436,6 +436,7 @@ static int fsl_espi_do_one_msg(struct spi_master *master,
 			       struct spi_message *m)
 {
 	unsigned int delay_usecs = 0, rx_nbits = 0;
+	unsigned int delay_nsecs = 0, delay_nsecs1 = 0;
 	struct spi_transfer *t, trans = {};
 	int ret;
 
@@ -444,8 +445,16 @@ static int fsl_espi_do_one_msg(struct spi_master *master,
 		goto out;
 
 	list_for_each_entry(t, &m->transfers, transfer_list) {
-		if (t->delay_usecs > delay_usecs)
-			delay_usecs = t->delay_usecs;
+		if (t->delay_usecs) {
+			if (t->delay_usecs > delay_usecs) {
+				delay_usecs = t->delay_usecs;
+				delay_nsecs = delay_usecs * 1000;
+			}
+		} else {
+			delay_nsecs1 = spi_delay_to_ns(&t->delay, t);
+			if (delay_nsecs1 > delay_nsecs)
+				delay_nsecs = delay_nsecs1;
+		}
 		if (t->rx_nbits > rx_nbits)
 			rx_nbits = t->rx_nbits;
 	}
@@ -456,7 +465,8 @@ static int fsl_espi_do_one_msg(struct spi_master *master,
 	trans.len = m->frame_length;
 	trans.speed_hz = t->speed_hz;
 	trans.bits_per_word = t->bits_per_word;
-	trans.delay_usecs = delay_usecs;
+	trans.delay.value = delay_nsecs;
+	trans.delay.unit = SPI_DELAY_UNIT_NSECS;
 	trans.rx_nbits = rx_nbits;
 
 	if (trans.len)
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 61ef286f954a..1f0b55c9e2e8 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1120,7 +1120,7 @@ static void _spi_transfer_delay_ns(u32 ns)
 	}
 }
 
-static int _spi_delay_to_ns(struct spi_delay *_delay, struct spi_transfer *xfer)
+int spi_delay_to_ns(struct spi_delay *_delay, struct spi_transfer *xfer)
 {
 	u32 delay = _delay->value;
 	u32 unit = _delay->unit;
@@ -1153,6 +1153,7 @@ static int _spi_delay_to_ns(struct spi_delay *_delay, struct spi_transfer *xfer)
 
 	return delay;
 }
+EXPORT_SYMBOL_GPL(spi_delay_to_ns);
 
 int spi_delay_exec(struct spi_delay *_delay, struct spi_transfer *xfer)
 {
@@ -1161,7 +1162,7 @@ int spi_delay_exec(struct spi_delay *_delay, struct spi_transfer *xfer)
 	if (!_delay)
 		return -EINVAL;
 
-	delay = _spi_delay_to_ns(_delay, xfer);
+	delay = spi_delay_to_ns(_delay, xfer);
 	if (delay < 0)
 		return delay;
 
@@ -3211,11 +3212,11 @@ static int _spi_xfer_word_delay_update(struct spi_transfer *xfer,
 {
 	int delay1, delay2;
 
-	delay1 = _spi_delay_to_ns(&xfer->word_delay, xfer);
+	delay1 = spi_delay_to_ns(&xfer->word_delay, xfer);
 	if (delay1 < 0)
 		return delay1;
 
-	delay2 = _spi_delay_to_ns(&spi->word_delay, xfer);
+	delay2 = spi_delay_to_ns(&spi->word_delay, xfer);
 	if (delay2 < 0)
 		return delay2;
 
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 66031c8d0093..3bc5912fca36 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -102,6 +102,7 @@ struct spi_delay {
 	u8	unit;
 };
 
+extern int spi_delay_to_ns(struct spi_delay *_delay, struct spi_transfer *xfer);
 extern int spi_delay_exec(struct spi_delay *_delay, struct spi_transfer *xfer);
 
 /**
-- 
2.20.1

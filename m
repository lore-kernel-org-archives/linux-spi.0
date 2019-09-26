From: Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v4 02/19] spi: introduce spi_delay struct as "value + unit" &
 spi_delay_exec()
Date: Thu, 26 Sep 2019 13:51:30 +0300
Message-ID: <20190926105147.7839-3-alexandru.ardelean@analog.com>
References: <20190926105147.7839-1-alexandru.ardelean@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: f.fainelli@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com,
 linus.walleij@linaro.org, broonie@kernel.org, orsonzhai@gmail.com,
 Alexandru Ardelean <alexandru.ardelean@analog.com>, jic23@kernel.org
To: <bcm-kernel-feedback-list@broadcom.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190926105147.7839-1-alexandru.ardelean@analog.com>
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

There are plenty of delays that have been introduced in SPI core. Most of
them are in micro-seconds, some need to be in nano-seconds, and some in
clock-cycles.

For some of these delays (related to transfers & CS timing) it may make
sense to have a `spi_delay` struct that abstracts these a bit.

The important element of these delays [for unification] seems to be the
`unit` of the delay.
It looks like micro-seconds is good enough for most people, but every-once
in a while, some delays seem to require other units of measurement.

This change adds the `spi_delay` struct & a `spi_delay_exec()` function
that processes a `spi_delay` object/struct to execute the delay.
It's a copy of the `cs_change_delay` mechanism, but without the default
for 10 uS.

The clock-cycle delay unit is a bit special, as it needs to be bound to an
`spi_transfer` object to execute.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/spi/spi.c       | 51 +++++++++++++++++++++++++++++++++++++++++
 include/linux/spi/spi.h | 18 ++++++++++++---
 2 files changed, 66 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index c90e02e6d62f..1883de8ffa82 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1106,6 +1106,57 @@ static void _spi_transfer_delay_ns(u32 ns)
 	}
 }
 
+static int _spi_delay_to_ns(struct spi_delay *_delay, struct spi_transfer *xfer)
+{
+	u32 delay = _delay->value;
+	u32 unit = _delay->unit;
+	u32 hz;
+
+	if (!delay)
+		return 0;
+
+	switch (unit) {
+	case SPI_DELAY_UNIT_USECS:
+		delay *= 1000;
+		break;
+	case SPI_DELAY_UNIT_NSECS: /* nothing to do here */
+		break;
+	case SPI_DELAY_UNIT_SCK:
+		/* clock cycles need to be obtained from spi_transfer */
+		if (!xfer)
+			return -EINVAL;
+		/* if there is no effective speed know, then approximate
+		 * by underestimating with half the requested hz
+		 */
+		hz = xfer->effective_speed_hz ?: xfer->speed_hz / 2;
+		if (!hz)
+			return -EINVAL;
+		delay *= DIV_ROUND_UP(1000000000, hz);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return delay;
+}
+
+int spi_delay_exec(struct spi_delay *_delay, struct spi_transfer *xfer)
+{
+	int delay;
+
+	if (!_delay)
+		return -EINVAL;
+
+	delay = _spi_delay_to_ns(_delay, xfer);
+	if (delay < 0)
+		return delay;
+
+	_spi_transfer_delay_ns(delay);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(spi_delay_exec);
+
 static void _spi_transfer_cs_change_delay(struct spi_message *msg,
 					  struct spi_transfer *xfer)
 {
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index af4f265d0f67..c18cfa7cda35 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -89,6 +89,21 @@ void spi_statistics_add_transfer_stats(struct spi_statistics *stats,
 #define SPI_STATISTICS_INCREMENT_FIELD(stats, field)	\
 	SPI_STATISTICS_ADD_TO_FIELD(stats, field, 1)
 
+/**
+ * struct spi_delay - SPI delay information
+ * @value: Value for the delay
+ * @unit: Unit for the delay
+ */
+struct spi_delay {
+#define SPI_DELAY_UNIT_USECS	0
+#define SPI_DELAY_UNIT_NSECS	1
+#define SPI_DELAY_UNIT_SCK	2
+	u16	value;
+	u8	unit;
+};
+
+extern int spi_delay_exec(struct spi_delay *_delay, struct spi_transfer *xfer);
+
 /**
  * struct spi_device - Controller side proxy for an SPI slave device
  * @dev: Driver model representation of the device.
@@ -834,9 +849,6 @@ struct spi_transfer {
 	u16		delay_usecs;
 	u16		cs_change_delay;
 	u8		cs_change_delay_unit;
-#define SPI_DELAY_UNIT_USECS	0
-#define SPI_DELAY_UNIT_NSECS	1
-#define SPI_DELAY_UNIT_SCK	2
 	u32		speed_hz;
 	u16		word_delay;
 
-- 
2.20.1

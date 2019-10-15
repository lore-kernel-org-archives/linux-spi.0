From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: introduce spi_delay struct as "value + unit" & spi_delay_exec()" to the spi tree
Date: Tue, 15 Oct 2019 12:12:28 +0100 (BST)
Message-ID: <20191015111228.9F7E527419E4@ypsilon.sirena.org.uk>
References: <20190926105147.7839-3-alexandru.ardelean@analog.com>
Cc: baolin.wang@linaro.org, bcm-kernel-feedback-list@broadcom.com,
        broonie@kernel.org, f.fainelli@gmail.com, jic23@kernel.org,
        linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, orsonzhai@gmail.com,
        zhang.lyra@gmail.com
To: Alexandru Ardelean <alexandru.ardelean@analog.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190926105147.7839-3-alexandru.ardelean@analog.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: introduce spi_delay struct as "value + unit" & spi_delay_exec()

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.5

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

>From b2c98153f45fc17b9fcb241000f2d131ddea6030 Mon Sep 17 00:00:00 2001
From: Alexandru Ardelean <alexandru.ardelean@analog.com>
Date: Thu, 26 Sep 2019 13:51:30 +0300
Subject: [PATCH] spi: introduce spi_delay struct as "value + unit" &
 spi_delay_exec()

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
Link: https://lore.kernel.org/r/20190926105147.7839-3-alexandru.ardelean@analog.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi.c       | 51 +++++++++++++++++++++++++++++++++++++++++
 include/linux/spi/spi.h | 18 ++++++++++++---
 2 files changed, 66 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 7ba981cdb86b..7499a4efbaba 100644
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
index 27f6b046cf92..8f643de3197b 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -90,6 +90,21 @@ void spi_statistics_add_transfer_stats(struct spi_statistics *stats,
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
@@ -887,9 +902,6 @@ struct spi_transfer {
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

From: Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v4 07/19] spi: core,atmel: convert `word_delay_usecs` -> `word_delay` for spi_device
Date: Thu, 26 Sep 2019 13:51:35 +0300
Message-ID: <20190926105147.7839-8-alexandru.ardelean@analog.com>
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

This change does a conversion from the `word_delay_usecs` -> `word_delay`
for the `spi_device` struct.

This allows users to specify inter-word delays in other unit types
(nano-seconds or clock cycles), depending on how users want.

The Atmel SPI driver is the only current user of the `word_delay_usecs`
field (from the `spi_device` struct).
So, it needed a slight conversion to use the `word_delay` as an `spi_delay`
struct.

In SPI core, the only required mechanism is to update the `word_delay`
information per `spi_transfer`. This requires a bit more logic than before,
because it needs that both delays be converted to a common unit
(nano-seconds) for comparison.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/spi/spi-atmel.c | 26 ++++++++++++++++++++++++--
 drivers/spi/spi.c       | 24 ++++++++++++++++++++++--
 include/linux/spi/spi.h |  7 ++-----
 3 files changed, 48 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index f00b367523cd..f04b92791515 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -1172,12 +1172,31 @@ atmel_spi_pdc_interrupt(int irq, void *dev_id)
 	return ret;
 }
 
+static int atmel_word_delay_csr(struct spi_device *spi, struct atmel_spi *as)
+{
+	struct spi_delay *delay = &spi->word_delay;
+	u32 value = delay->value;
+
+	switch (delay->unit) {
+	case SPI_DELAY_UNIT_NSECS:
+		value /= 1000;
+		break;
+	case SPI_DELAY_UNIT_USECS:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return (as->spi_clk / 1000000 * value) >> 5;
+}
+
 static int atmel_spi_setup(struct spi_device *spi)
 {
 	struct atmel_spi	*as;
 	struct atmel_spi_device	*asd;
 	u32			csr;
 	unsigned int		bits = spi->bits_per_word;
+	int			word_delay_csr;
 
 	as = spi_master_get_devdata(spi->master);
 
@@ -1201,11 +1220,14 @@ static int atmel_spi_setup(struct spi_device *spi)
 	 */
 	csr |= SPI_BF(DLYBS, 0);
 
+	word_delay_csr = atmel_word_delay_csr(spi, as);
+	if (word_delay_csr < 0)
+		return word_delay_csr;
+
 	/* DLYBCT adds delays between words.  This is useful for slow devices
 	 * that need a bit of time to setup the next transfer.
 	 */
-	csr |= SPI_BF(DLYBCT,
-			(as->spi_clk / 1000000 * spi->word_delay_usecs) >> 5);
+	csr |= SPI_BF(DLYBCT, word_delay_csr);
 
 	asd = spi->controller_state;
 	if (!asd) {
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index d0bf0ffca042..ba8731b77753 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3159,6 +3159,26 @@ void spi_set_cs_timing(struct spi_device *spi, u8 setup, u8 hold,
 }
 EXPORT_SYMBOL_GPL(spi_set_cs_timing);
 
+static int _spi_xfer_word_delay_update(struct spi_transfer *xfer,
+				       struct spi_device *spi)
+{
+	int delay1, delay2;
+
+	delay1 = _spi_delay_to_ns(&xfer->word_delay, xfer);
+	if (delay1 < 0)
+		return delay1;
+
+	delay2 = _spi_delay_to_ns(&spi->word_delay, xfer);
+	if (delay2 < 0)
+		return delay2;
+
+	if (delay1 < delay2)
+		memcpy(&xfer->word_delay, &spi->word_delay,
+		       sizeof(xfer->word_delay));
+
+	return 0;
+}
+
 static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 {
 	struct spi_controller *ctlr = spi->controller;
@@ -3294,8 +3314,8 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 				return -EINVAL;
 		}
 
-		if (xfer->word_delay_usecs < spi->word_delay_usecs)
-			xfer->word_delay_usecs = spi->word_delay_usecs;
+		if (_spi_xfer_word_delay_update(xfer, spi))
+			return -EINVAL;
 	}
 
 	message->status = -EINPROGRESS;
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 16397b210e0c..e7ec0be16a82 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -138,7 +138,7 @@ extern int spi_delay_exec(struct spi_delay *_delay, struct spi_transfer *xfer);
  *	the spi_master.
  * @cs_gpiod: gpio descriptor of the chipselect line (optional, NULL when
  *	not using a GPIO line)
- * @word_delay_usecs: microsecond delay to be inserted between consecutive
+ * @word_delay: delay to be inserted between consecutive
  *	words of a transfer
  *
  * @statistics: statistics for the spi_device
@@ -188,7 +188,7 @@ struct spi_device {
 	const char		*driver_override;
 	int			cs_gpio;	/* LEGACY: chip select gpio */
 	struct gpio_desc	*cs_gpiod;	/* chip select gpio desc */
-	uint8_t			word_delay_usecs; /* inter-word delay */
+	struct spi_delay	word_delay; /* inter-word delay */
 
 	/* the statistics */
 	struct spi_statistics	statistics;
@@ -757,8 +757,6 @@ extern void spi_res_release(struct spi_controller *ctlr,
  * @delay_usecs: microseconds to delay after this transfer before
  *	(optionally) changing the chipselect status, then starting
  *	the next transfer or completing this @spi_message.
- * @word_delay_usecs: microseconds to inter word delay after each word size
- *	(set by bits_per_word) transmission.
  * @word_delay: inter word delay to be introduced after each word size
  *	(set by bits_per_word) transmission.
  * @effective_speed_hz: the effective SCK-speed that was used to
@@ -844,7 +842,6 @@ struct spi_transfer {
 #define	SPI_NBITS_DUAL		0x02 /* 2bits transfer */
 #define	SPI_NBITS_QUAD		0x04 /* 4bits transfer */
 	u8		bits_per_word;
-	u8		word_delay_usecs;
 	u16		delay_usecs;
 	struct spi_delay	cs_change_delay;
 	struct spi_delay	word_delay;
-- 
2.20.1

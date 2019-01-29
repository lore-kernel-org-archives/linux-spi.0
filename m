From: Jonas Bonn <jonas@norrbonn.se>
Subject: [PATCH v4 1/2] spi: support inter-word delay requirement for devices
Date: Tue, 29 Jan 2019 09:38:43 +0100
Message-ID: <20190129083844.20572-2-jonas@norrbonn.se>
References: <20190129083844.20572-1-jonas@norrbonn.se>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Jonas Bonn <jonas@norrbonn.se>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
To: linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190129083844.20572-1-jonas@norrbonn.se>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Some devices are slow and cannot keep up with the SPI bus and therefore
require a short delay between words of the SPI transfer.

The example of this that I'm looking at is a SAMA5D2 with a minimum SPI
clock of 400kHz talking to an AVR-based SPI slave.  The AVR cannot put
bytes on the bus fast enough to keep up with the SoC's SPI controller
even at the lowest bus speed.

This patch introduces the ability to specify a required inter-word
delay for SPI devices.  It is up to the controller driver to configure
itself accordingly in order to introduce the requested delay.

Note that, for spi_transfer, there is already a field word_delay that
provides similar functionality.  This field, however, is specified in
clock cycles (and worse, SPI controller cycles, not SCK cycles); that
makes this value dependent on the master clock instead of the device
clock for which the delay is intended to provide some relief.  This
patch leaves this old word_delay in place and provides a time-based
word_delay_us alongside it; the new field fits in the struct padding
so struct size is constant.  There is only one in-kernel user of the
word_delay field and presumably that driver could be reworked to use
the time-based value instead.

The time-based delay is limited to 8 bits as these delays are intended
to be short.  The SAMA5D2 that I've tested this on limits delays to a
maximum of ~100us, which is already many word-transfer periods even at
the minimum transfer speed supported by the controller.

Signed-off-by: Jonas Bonn <jonas@norrbonn.se>
CC: Mark Brown <broonie@kernel.org>
CC: Rob Herring <robh+dt@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>
CC: linux-spi@vger.kernel.org
CC: devicetree@vger.kernel.org
---
 drivers/spi/spi.c       | 5 +++++
 include/linux/spi/spi.h | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 9a7def7c3237..64f13204bcb7 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2961,6 +2961,8 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 	 * it is not set for this transfer.
 	 * Set transfer tx_nbits and rx_nbits as single transfer default
 	 * (SPI_NBITS_SINGLE) if it is not set for this transfer.
+	 * Ensure transfer word_delay is at least as long as that required by
+	 * device itself.
 	 */
 	message->frame_length = 0;
 	list_for_each_entry(xfer, &message->transfers, transfer_list) {
@@ -3031,6 +3033,9 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 				!(spi->mode & SPI_RX_QUAD))
 				return -EINVAL;
 		}
+
+		if (xfer->word_delay_us < spi->word_delay_us)
+			xfer->word_delay_us = spi->word_delay_us;
 	}
 
 	message->status = -EINPROGRESS;
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 314d922ca607..e04622a01836 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -118,6 +118,8 @@ void spi_statistics_add_transfer_stats(struct spi_statistics *stats,
  *	for driver coldplugging, and in uevents used for hotplugging
  * @cs_gpio: gpio number of the chipselect line (optional, -ENOENT when
  *	not using a GPIO line)
+ * @word_delay_us: microsecond delay to be inserted between consecutive
+ *	words of a transfer
  *
  * @statistics: statistics for the spi_device
  *
@@ -164,6 +166,7 @@ struct spi_device {
 	char			modalias[SPI_NAME_SIZE];
 	const char		*driver_override;
 	int			cs_gpio;	/* chip select gpio */
+	uint8_t			word_delay_us;	/* inter-word delay */
 
 	/* the statistics */
 	struct spi_statistics	statistics;
@@ -706,6 +709,8 @@ extern void spi_res_release(struct spi_controller *ctlr,
  * @delay_usecs: microseconds to delay after this transfer before
  *	(optionally) changing the chipselect status, then starting
  *	the next transfer or completing this @spi_message.
+ * @word_delay_us: microseconds to inter word delay after each word size
+ *	(set by bits_per_word) transmission.
  * @word_delay: clock cycles to inter word delay after each word size
  *	(set by bits_per_word) transmission.
  * @transfer_list: transfers are sequenced through @spi_message.transfers
@@ -788,6 +793,7 @@ struct spi_transfer {
 #define	SPI_NBITS_DUAL		0x02 /* 2bits transfer */
 #define	SPI_NBITS_QUAD		0x04 /* 4bits transfer */
 	u8		bits_per_word;
+	u8		word_delay_us;
 	u16		delay_usecs;
 	u32		speed_hz;
 	u16		word_delay;
-- 
2.19.1

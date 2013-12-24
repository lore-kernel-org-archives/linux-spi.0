From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
Subject: [PATCH 8/8] spi: rspi: Add support for loopback mode
Date: Tue, 24 Dec 2013 12:40:48 +0100
Message-ID: <1387885248-28425-9-git-send-email-geert+renesas@linux-m68k.org>
References: <1387885248-28425-1-git-send-email-geert+renesas@linux-m68k.org>
Cc: linux-sh@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@linux-m68k.org>
To: linux-spi@vger.kernel.org
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1387885248-28425-1-git-send-email-geert+renesas@linux-m68k.org>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Add support for specifying loopback mode for RSPI only, based on the SDK
reference code.

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
---
 drivers/spi/spi-rspi.c |   59 +++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 48 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 850025278519..c8f51a3978e1 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -161,8 +161,8 @@
 #define SPCMD_SPRW		0x0060	/* SPI Read/Write Access */
 
 /* SPBFCR - Buffer Control Register */
-#define SPBFCR_TXRST		0x80	/* Transmit Buffer Data Reset (qspi only) */
-#define SPBFCR_RXRST		0x40	/* Receive Buffer Data Reset (qspi only) */
+#define SPBFCR_TXRST		0x80	/* Transmit Buffer Data Reset */
+#define SPBFCR_RXRST		0x40	/* Receive Buffer Data Reset */
 #define SPBFCR_TXTRG_MASK	0x30	/* Transmit Buffer Data Triggering Number */
 #define SPBFCR_RXTRG_MASK	0x07	/* Receive Buffer Data Triggering Number */
 
@@ -179,6 +179,7 @@ struct rspi_data {
 	spinlock_t lock;
 	struct clk *clk;
 	u8 spsr;
+	u8 sppcr;
 	u8 spdcr;
 	u8 data_width;
 	u16 spcmd;
@@ -248,7 +249,7 @@ struct spi_ops {
 			struct spi_transfer *t);
 	int (*receive_pio)(struct rspi_data *rspi, struct spi_message *mesg,
 			   struct spi_transfer *t);
-
+	u16 mode_bits;
 };
 
 /*
@@ -309,8 +310,8 @@ static int rspi_set_config_register(const struct rspi_data *rspi,
 {
 	int spbr;
 
-	/* Sets output mode(CMOS) and MOSI signal(from previous transfer) */
-	rspi_write8(rspi, 0x00, RSPI_SPPCR);
+	/* Sets output mode */
+	rspi_write8(rspi, rspi->sppcr, RSPI_SPPCR);
 
 	/* Sets transfer bit rate */
 	spbr = clk_get_rate(rspi->clk) / (2 * rspi->max_speed_hz) - 1;
@@ -361,8 +362,8 @@ static int qspi_set_config_register(const struct rspi_data *rspi,
 	u16 spcmd;
 	int spbr;
 
-	/* Sets output mode(CMOS) and MOSI signal(from previous transfer) */
-	rspi_write8(rspi, 0x00, RSPI_SPPCR);
+	/* Sets output mode */
+	rspi_write8(rspi, rspi->sppcr, RSPI_SPPCR);
 
 	/* Sets transfer bit rate */
 	spbr = clk_get_rate(rspi->clk) / (2 * rspi->max_speed_hz);
@@ -405,6 +406,21 @@ static int qspi_set_config_register(const struct rspi_data *rspi,
 
 #define set_config_register(spi, n) spi->ops->set_config_register(spi, n)
 
+static void rspi_clear_rxbuf(struct rspi_data *rspi)
+{
+	rspi_write8(rspi, rspi_read8(rspi, RSPI_SPBFCR) | SPBFCR_RXRST,
+		    RSPI_SPBFCR);
+	rspi_write8(rspi, rspi_read8(rspi, RSPI_SPBFCR) & (~SPBFCR_RXRST),
+		    RSPI_SPBFCR);
+}
+static void rspi_clear_txbuf(struct rspi_data *rspi)
+{
+	rspi_write8(rspi, rspi_read8(rspi, RSPI_SPBFCR) | SPBFCR_TXRST,
+		    RSPI_SPBFCR);
+	rspi_write8(rspi, rspi_read8(rspi, RSPI_SPBFCR) & (~SPBFCR_TXRST),
+		    RSPI_SPBFCR);
+}
+
 static void rspi_enable_irq(const struct rspi_data *rspi, u8 enable)
 {
 	rspi_write8(rspi, rspi_read8(rspi, RSPI_SPCR) | enable, RSPI_SPCR);
@@ -444,6 +460,13 @@ static int rspi_send_pio(struct rspi_data *rspi, struct spi_message *mesg,
 {
 	int remain = t->len;
 	const u8 *data = t->tx_buf;
+
+	if (rspi->sppcr & SPPCR_SPLP) {
+		/* loopback mode */
+		rspi_clear_txbuf(rspi);
+		rspi_clear_rxbuf(rspi);
+	}
+
 	while (remain > 0) {
 		rspi_set_txmode(rspi);
 
@@ -453,7 +476,8 @@ static int rspi_send_pio(struct rspi_data *rspi, struct spi_message *mesg,
 			return -ETIMEDOUT;
 		}
 
-		if (!rspi->txmode && remain != t->len) {
+		if (!rspi->txmode && remain != t->len &&
+		    !(rspi->sppcr & SPPCR_SPLP)) {
 			if (rspi_wait_for_interrupt(rspi, SPSR_SPRF,
 						    SPCR_SPRIE) < 0) {
 				dev_err(&rspi->master->dev,
@@ -470,7 +494,7 @@ static int rspi_send_pio(struct rspi_data *rspi, struct spi_message *mesg,
 	/* Waiting for the last transmition */
 	rspi_wait_for_interrupt(rspi, SPSR_SPTEF, SPCR_SPTIE);
 
-	if (!rspi->txmode) {
+	if (!rspi->txmode && !(rspi->sppcr & SPPCR_SPLP)) {
 		if (rspi_wait_for_interrupt(rspi, SPSR_SPRF, SPCR_SPRIE) < 0) {
 			dev_err(&rspi->master->dev,
 				"%s: receive timeout\n", __func__);
@@ -643,7 +667,7 @@ static void rspi_receive_init(const struct rspi_data *rspi)
 	u8 spsr;
 
 	spsr = rspi_read8(rspi, RSPI_SPSR);
-	if (spsr & SPSR_SPRF)
+	if (spsr & SPSR_SPRF && !(rspi->sppcr & SPPCR_SPLP))
 		rspi_read_data(rspi);	/* dummy read */
 	if (spsr & SPSR_OVRF)
 		rspi_write8(rspi, rspi_read8(rspi, RSPI_SPSR) & ~SPSR_OVRF,
@@ -681,6 +705,12 @@ static int rspi_receive_pio(struct rspi_data *rspi, struct spi_message *mesg,
 		remain--;
 	}
 
+	if (rspi->sppcr & SPPCR_SPLP) {
+		/* loopback mode */
+		rspi_clear_txbuf(rspi);
+		rspi_clear_rxbuf(rspi);
+	}
+
 	return 0;
 }
 
@@ -910,6 +940,11 @@ static int rspi_setup(struct spi_device *spi)
 	if (spi->mode & SPI_CPHA)
 		rspi->spcmd |= SPCMD_CPHA;
 
+	/* CMOS output mode and MOSI signal from previous transfer */
+	rspi->sppcr = 0;
+	if (spi->mode & SPI_LOOP)
+		rspi->sppcr |= SPPCR_SPLP;
+
 	set_config_register(rspi, 8);
 
 	return 0;
@@ -1099,7 +1134,7 @@ static int rspi_probe(struct platform_device *pdev)
 	master->setup = rspi_setup;
 	master->transfer = rspi_transfer;
 	master->cleanup = rspi_cleanup;
-	master->mode_bits = SPI_CPHA | SPI_CPOL;
+	master->mode_bits = ops->mode_bits;
 
 	for (i = 0; i < rspi->numirq; i++) {
 		ret = devm_request_irq(&pdev->dev, rspi->irq[i], rspi_irq, 0,
@@ -1146,6 +1181,7 @@ static struct spi_ops rspi_ops = {
 	.set_config_register =		rspi_set_config_register,
 	.send_pio =			rspi_send_pio,
 	.receive_pio =			rspi_receive_pio,
+	.mode_bits =			SPI_CPHA | SPI_CPOL | SPI_LOOP,
 };
 
 static struct spi_ops qspi_ops = {
@@ -1153,6 +1189,7 @@ static struct spi_ops qspi_ops = {
 	.set_config_register =		qspi_set_config_register,
 	.send_pio =			qspi_send_pio,
 	.receive_pio =			qspi_receive_pio,
+	.mode_bits =			SPI_CPHA | SPI_CPOL,
 };
 
 static struct platform_device_id spi_driver_ids[] = {
-- 
1.7.9.5


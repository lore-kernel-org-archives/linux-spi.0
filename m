From: Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: [PATCH 2/5] spi: rspi: Remove casts
Date: Tue, 24 Dec 2013 10:49:31 +0100
Message-ID: <1387878574-21445-3-git-send-email-geert+renesas@linux-m68k.org>
References: <1387878574-21445-1-git-send-email-geert+renesas@linux-m68k.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1387878574-21445-1-git-send-email-geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Remove useless casts, and do not cast away const.

Signed-off-by: Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
---
 drivers/spi/spi-rspi.c |   29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 08861b5db893..a0038687a8fd 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -330,9 +330,7 @@ static int rspi_send_pio(struct rspi_data *rspi, struct spi_message *mesg,
 			 struct spi_transfer *t)
 {
 	int remain = t->len;
-	u8 *data;
-
-	data = (u8 *)t->tx_buf;
+	const u8 *data = t->tx_buf;
 	while (remain > 0) {
 		rspi_write8(rspi, rspi_read8(rspi, RSPI_SPCR) | SPCR_TXMD,
 			    RSPI_SPCR);
@@ -358,12 +356,11 @@ static int qspi_send_pio(struct rspi_data *rspi, struct spi_message *mesg,
 			 struct spi_transfer *t)
 {
 	int remain = t->len;
-	u8 *data;
+	const u8 *data = t->tx_buf;
 
 	rspi_write8(rspi, SPBFCR_TXRST, QSPI_SPBFCR);
 	rspi_write8(rspi, 0x00, QSPI_SPBFCR);
 
-	data = (u8 *)t->tx_buf;
 	while (remain > 0) {
 
 		if (rspi_wait_for_interrupt(rspi, SPSR_SPTEF, SPCR_SPTIE) < 0) {
@@ -399,8 +396,8 @@ static void rspi_dma_complete(void *arg)
 	wake_up_interruptible(&rspi->wait);
 }
 
-static int rspi_dma_map_sg(struct scatterlist *sg, void *buf, unsigned len,
-			   struct dma_chan *chan,
+static int rspi_dma_map_sg(struct scatterlist *sg, const void *buf,
+			   unsigned len, struct dma_chan *chan,
 			   enum dma_transfer_direction dir)
 {
 	sg_init_table(sg, 1);
@@ -440,12 +437,13 @@ static void rspi_memory_from_8bit(void *buf, const void *data, unsigned len)
 static int rspi_send_dma(struct rspi_data *rspi, struct spi_transfer *t)
 {
 	struct scatterlist sg;
-	void *buf = NULL;
+	const void *buf = NULL;
 	struct dma_async_tx_descriptor *desc;
 	unsigned len;
 	int ret = 0;
 
 	if (rspi->dma_width_16bit) {
+		void *tmp;
 		/*
 		 * If DMAC bus width is 16-bit, the driver allocates a dummy
 		 * buffer. And, the driver converts original data into the
@@ -454,13 +452,14 @@ static int rspi_send_dma(struct rspi_data *rspi, struct spi_transfer *t)
 		 *  DMAC data:     1st byte, dummy, 2nd byte, dummy ...
 		 */
 		len = t->len * 2;
-		buf = kmalloc(len, GFP_KERNEL);
-		if (!buf)
+		tmp = kmalloc(len, GFP_KERNEL);
+		if (!tmp)
 			return -ENOMEM;
-		rspi_memory_to_8bit(buf, t->tx_buf, t->len);
+		rspi_memory_to_8bit(tmp, t->tx_buf, t->len);
+		buf = tmp;
 	} else {
 		len = t->len;
-		buf = (void *)t->tx_buf;
+		buf = t->tx_buf;
 	}
 
 	if (!rspi_dma_map_sg(&sg, buf, len, rspi->chan_tx, DMA_TO_DEVICE)) {
@@ -528,7 +527,7 @@ static int rspi_receive_pio(struct rspi_data *rspi, struct spi_message *mesg,
 
 	rspi_receive_init(rspi);
 
-	data = (u8 *)t->rx_buf;
+	data = t->rx_buf;
 	while (remain > 0) {
 		rspi_write8(rspi, rspi_read8(rspi, RSPI_SPCR) & ~SPCR_TXMD,
 			    RSPI_SPCR);
@@ -575,7 +574,7 @@ static int qspi_receive_pio(struct rspi_data *rspi, struct spi_message *mesg,
 
 	qspi_receive_init(rspi);
 
-	data = (u8 *)t->rx_buf;
+	data = t->rx_buf;
 	while (remain > 0) {
 
 		if (rspi_wait_for_interrupt(rspi, SPSR_SPTEF, SPCR_SPTIE) < 0) {
@@ -802,7 +801,7 @@ static void rspi_cleanup(struct spi_device *spi)
 
 static irqreturn_t rspi_irq(int irq, void *_sr)
 {
-	struct rspi_data *rspi = (struct rspi_data *)_sr;
+	struct rspi_data *rspi = _sr;
 	unsigned long spsr;
 	irqreturn_t ret = IRQ_NONE;
 	unsigned char disable_irq = 0;
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

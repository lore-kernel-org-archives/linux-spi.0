From: Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: [PATCH 4/8] spi: rspi: Add support for 8-bit Data Register access
Date: Tue, 24 Dec 2013 12:40:44 +0100
Message-ID: <1387885248-28425-5-git-send-email-geert+renesas@linux-m68k.org>
References: <1387885248-28425-1-git-send-email-geert+renesas@linux-m68k.org>
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1387885248-28425-1-git-send-email-geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Add support for accessing the RSPI Data Register using 8-bit operations,
based on the SDK reference code.  This is needed for RZ/A1H.

The data width is passed using platform data, defaulting to 16-bit for
legacy RSPI. QSPI always uses 8-bit accesses.

Signed-off-by: Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
---
 drivers/spi/spi-rspi.c   |   90 +++++++++++++++++++++++++++++++++++++++-------
 include/linux/spi/rspi.h |    2 ++
 2 files changed, 79 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index c7bbc54ef785..00788091fc16 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -179,6 +179,8 @@ struct rspi_data {
 	spinlock_t lock;
 	struct clk *clk;
 	u8 spsr;
+	u8 spdcr;
+	u8 data_width;
 	int irq[MAX_NUM_IRQ];
 	unsigned int numirq;
 	const struct spi_ops *ops;
@@ -216,8 +218,27 @@ static u16 rspi_read16(const struct rspi_data *rspi, u16 offset)
 	return ioread16(rspi->addr + offset);
 }
 
+static void rspi_write_data(const struct rspi_data *rspi, u16 data)
+{
+	if (rspi->data_width == 8)
+		rspi_write8(rspi, data, RSPI_SPDR);
+	else if (rspi->data_width == 16)
+		rspi_write16(rspi, data, RSPI_SPDR);
+}
+
+static u16 rspi_read_data(const struct rspi_data *rspi)
+{
+	if (rspi->data_width == 8)
+		return rspi_read8(rspi, RSPI_SPDR);
+	else if (rspi->data_width == 16)
+		return rspi_read16(rspi, RSPI_SPDR);
+	return 0;
+}
+
 /* optional functions */
 struct spi_ops {
+	int (*parse_platform_data)(struct rspi_data *rspi,
+				   const struct rspi_plat_data *rspi_pd);
 	int (*set_config_register)(const struct rspi_data *rspi,
 				   int access_size);
 	int (*send_pio)(struct rspi_data *rspi, struct spi_message *mesg,
@@ -230,6 +251,33 @@ struct spi_ops {
 /*
  * functions for RSPI
  */
+static int rspi_parse_platform_data(struct rspi_data *rspi,
+				    const struct rspi_plat_data *rspi_pd)
+{
+	if (rspi_pd && rspi_pd->data_width) {
+		rspi->data_width = rspi_pd->data_width;
+		switch (rspi_pd->data_width) {
+		case 8:
+			rspi->spdcr = SPDCR_SPLBYTE;
+			break;
+		case 16:
+			rspi->spdcr = SPDCR_SPLWORD;
+			break;
+		default:
+			return -1;
+		}
+	} else {
+		/*
+		 * Use legacy 16-bit width data access if a data_width value
+		 * isn't defined in the platform data.
+		 */
+		rspi->data_width = 16;
+		rspi->spdcr = 0;
+	}
+
+	return 0;
+}
+
 static int rspi_set_config_register(const struct rspi_data *rspi,
 				    int access_size)
 {
@@ -243,7 +291,7 @@ static int rspi_set_config_register(const struct rspi_data *rspi,
 	rspi_write8(rspi, clamp(spbr, 0, 255), RSPI_SPBR);
 
 	/* Sets number of frames to be used: 1 frame */
-	rspi_write8(rspi, 0x00, RSPI_SPDCR);
+	rspi_write8(rspi, rspi->spdcr, RSPI_SPDCR);
 
 	/* Sets RSPCK, SSL, next-access delay value */
 	rspi_write8(rspi, 0x00, RSPI_SPCKD);
@@ -266,6 +314,16 @@ static int rspi_set_config_register(const struct rspi_data *rspi,
 /*
  * functions for QSPI
  */
+static int qspi_parse_platform_data(struct rspi_data *rspi,
+				    const struct rspi_plat_data *rspi_pd)
+{
+	/* Fixed 8-bit for now */
+	rspi->data_width = 8;
+	rspi->spdcr = 0;
+
+	return 0;
+}
+
 static int qspi_set_config_register(const struct rspi_data *rspi,
 				    int access_size)
 {
@@ -280,7 +338,7 @@ static int qspi_set_config_register(const struct rspi_data *rspi,
 	rspi_write8(rspi, clamp(spbr, 0, 255), RSPI_SPBR);
 
 	/* Sets number of frames to be used: 1 frame */
-	rspi_write8(rspi, 0x00, RSPI_SPDCR);
+	rspi_write8(rspi, rspi->spdcr, RSPI_SPDCR);
 
 	/* Sets RSPCK, SSL, next-access delay value */
 	rspi_write8(rspi, 0x00, RSPI_SPCKD);
@@ -365,7 +423,7 @@ static int rspi_send_pio(struct rspi_data *rspi, struct spi_message *mesg,
 			return -ETIMEDOUT;
 		}
 
-		rspi_write16(rspi, *data, RSPI_SPDR);
+		rspi_write_data(rspi, *data);
 		data++;
 		remain--;
 	}
@@ -392,14 +450,14 @@ static int qspi_send_pio(struct rspi_data *rspi, struct spi_message *mesg,
 				"%s: tx empty timeout\n", __func__);
 			return -ETIMEDOUT;
 		}
-		rspi_write8(rspi, *data++, RSPI_SPDR);
+		rspi_write_data(rspi, *data++);
 
 		if (rspi_wait_for_interrupt(rspi, SPSR_SPRF, SPCR_SPRIE) < 0) {
 			dev_err(&rspi->master->dev,
 				"%s: receive timeout\n", __func__);
 			return -ETIMEDOUT;
 		}
-		rspi_read8(rspi, RSPI_SPDR);
+		rspi_read_data(rspi);
 
 		remain--;
 	}
@@ -539,7 +597,7 @@ static void rspi_receive_init(const struct rspi_data *rspi)
 
 	spsr = rspi_read8(rspi, RSPI_SPSR);
 	if (spsr & SPSR_SPRF)
-		rspi_read16(rspi, RSPI_SPDR);	/* dummy read */
+		rspi_read_data(rspi);	/* dummy read */
 	if (spsr & SPSR_OVRF)
 		rspi_write8(rspi, rspi_read8(rspi, RSPI_SPSR) & ~SPSR_OVRF,
 			    RSPI_SPSR);
@@ -564,15 +622,14 @@ static int rspi_receive_pio(struct rspi_data *rspi, struct spi_message *mesg,
 			return -ETIMEDOUT;
 		}
 		/* dummy write for generate clock */
-		rspi_write16(rspi, DUMMY_DATA, RSPI_SPDR);
+		rspi_write_data(rspi, DUMMY_DATA);
 
 		if (rspi_wait_for_interrupt(rspi, SPSR_SPRF, SPCR_SPRIE) < 0) {
 			dev_err(&rspi->master->dev,
 				"%s: receive timeout\n", __func__);
 			return -ETIMEDOUT;
 		}
-		/* SPDR allows 16 or 32-bit access only */
-		*data = (u8)rspi_read16(rspi, RSPI_SPDR);
+		*data = rspi_read_data(rspi);
 
 		data++;
 		remain--;
@@ -587,7 +644,7 @@ static void qspi_receive_init(const struct rspi_data *rspi)
 
 	spsr = rspi_read8(rspi, RSPI_SPSR);
 	if (spsr & SPSR_SPRF)
-		rspi_read8(rspi, RSPI_SPDR);   /* dummy read */
+		rspi_read_data(rspi);   /* dummy read */
 	rspi_write8(rspi, SPBFCR_TXRST | SPBFCR_RXRST, QSPI_SPBFCR);
 	rspi_write8(rspi, 0x00, QSPI_SPBFCR);
 }
@@ -609,15 +666,14 @@ static int qspi_receive_pio(struct rspi_data *rspi, struct spi_message *mesg,
 			return -ETIMEDOUT;
 		}
 		/* dummy write for generate clock */
-		rspi_write8(rspi, DUMMY_DATA, RSPI_SPDR);
+		rspi_write_data(rspi, DUMMY_DATA);
 
 		if (rspi_wait_for_interrupt(rspi, SPSR_SPRF, SPCR_SPRIE) < 0) {
 			dev_err(&rspi->master->dev,
 				"%s: receive timeout\n", __func__);
 			return -ETIMEDOUT;
 		}
-		/* SPDR allows 8, 16 or 32-bit access */
-		*data++ = rspi_read8(rspi, RSPI_SPDR);
+		*data++ = rspi_read_data(rspi);
 		remain--;
 	}
 
@@ -1002,6 +1058,12 @@ static int rspi_probe(struct platform_device *pdev)
 		}
 	}
 
+	ret = ops->parse_platform_data(rspi, rspi_pd);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "rspi invalid platform data.\n");
+		goto error1;
+	}
+
 	ret = rspi_request_dma(rspi, pdev);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "rspi_request_dma failed.\n");
@@ -1027,12 +1089,14 @@ error1:
 }
 
 static struct spi_ops rspi_ops = {
+	.parse_platform_data =		rspi_parse_platform_data,
 	.set_config_register =		rspi_set_config_register,
 	.send_pio =			rspi_send_pio,
 	.receive_pio =			rspi_receive_pio,
 };
 
 static struct spi_ops qspi_ops = {
+	.parse_platform_data =		qspi_parse_platform_data,
 	.set_config_register =		qspi_set_config_register,
 	.send_pio =			qspi_send_pio,
 	.receive_pio =			qspi_receive_pio,
diff --git a/include/linux/spi/rspi.h b/include/linux/spi/rspi.h
index 3f55232f74ff..7316dd9c7ba9 100644
--- a/include/linux/spi/rspi.h
+++ b/include/linux/spi/rspi.h
@@ -22,6 +22,8 @@
 #define __LINUX_SPI_RENESAS_SPI_H__
 
 struct rspi_plat_data {
+	u8 data_width;			/* Data register access width */
+
 	unsigned int dma_tx_id;
 	unsigned int dma_rx_id;
 
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

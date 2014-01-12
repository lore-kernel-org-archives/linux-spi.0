From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: [PATCH V2 4/8] spi: rspi: Add support for 8-bit Data Register access
Date: Sun, 12 Jan 2014 11:27:40 +0100
Message-ID: <1389522464-1569-5-git-send-email-geert@linux-m68k.org>
References: <1389522464-1569-1-git-send-email-geert@linux-m68k.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1389522464-1569-1-git-send-email-geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>

Add support for accessing the RSPI Data Register using 8-bit operations,
based on the SDK reference code.  This is needed for RZ/A1H.

The data width is passed using platform data, defaulting to 16-bit for
legacy RSPI. QSPI always uses 8-bit accesses.

Signed-off-by: Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
---
v2:
  - Drop last if clause in rspi{write,read}_data(), and document we fall
    back to 16-bit there
  - Return sensible error value in rspi_parse_platform_data()
  - Update copyright header in rspi.h

 drivers/spi/spi-rspi.c   |   89 +++++++++++++++++++++++++++++++++++++++-------
 include/linux/spi/rspi.h |    4 ++-
 2 files changed, 79 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 45da760281f9..c3332d2b48e9 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -188,6 +188,8 @@ struct rspi_data {
 	spinlock_t lock;
 	struct clk *clk;
 	u8 spsr;
+	u8 spdcr;
+	u8 data_width;
 	int irqs[MAX_NUM_IRQ];
 	unsigned int num_irqs;
 	const struct spi_ops *ops;
@@ -225,8 +227,26 @@ static u16 rspi_read16(const struct rspi_data *rspi, u16 offset)
 	return ioread16(rspi->addr + offset);
 }
 
+static void rspi_write_data(const struct rspi_data *rspi, u16 data)
+{
+	if (rspi->data_width == 8)
+		rspi_write8(rspi, data, RSPI_SPDR);
+	else /* 16 bit only */
+		rspi_write16(rspi, data, RSPI_SPDR);
+}
+
+static u16 rspi_read_data(const struct rspi_data *rspi)
+{
+	if (rspi->data_width == 8)
+		return rspi_read8(rspi, RSPI_SPDR);
+	else /* 16 bit only */
+		return rspi_read16(rspi, RSPI_SPDR);
+}
+
 /* optional functions */
 struct spi_ops {
+	int (*parse_platform_data)(struct rspi_data *rspi,
+				   const struct rspi_plat_data *rspi_pd);
 	int (*set_config_register)(const struct rspi_data *rspi,
 				   int access_size);
 	int (*send_pio)(struct rspi_data *rspi, struct spi_message *mesg,
@@ -239,6 +259,33 @@ struct spi_ops {
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
+			return -EINVAL;
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
@@ -252,7 +299,7 @@ static int rspi_set_config_register(const struct rspi_data *rspi,
 	rspi_write8(rspi, clamp(spbr, 0, 255), RSPI_SPBR);
 
 	/* Sets number of frames to be used: 1 frame */
-	rspi_write8(rspi, 0x00, RSPI_SPDCR);
+	rspi_write8(rspi, rspi->spdcr, RSPI_SPDCR);
 
 	/* Sets RSPCK, SSL, next-access delay value */
 	rspi_write8(rspi, 0x00, RSPI_SPCKD);
@@ -275,6 +322,16 @@ static int rspi_set_config_register(const struct rspi_data *rspi,
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
@@ -289,7 +346,7 @@ static int qspi_set_config_register(const struct rspi_data *rspi,
 	rspi_write8(rspi, clamp(spbr, 0, 255), RSPI_SPBR);
 
 	/* Sets number of frames to be used: 1 frame */
-	rspi_write8(rspi, 0x00, RSPI_SPDCR);
+	rspi_write8(rspi, rspi->spdcr, RSPI_SPDCR);
 
 	/* Sets RSPCK, SSL, next-access delay value */
 	rspi_write8(rspi, 0x00, RSPI_SPCKD);
@@ -374,7 +431,7 @@ static int rspi_send_pio(struct rspi_data *rspi, struct spi_message *mesg,
 			return -ETIMEDOUT;
 		}
 
-		rspi_write16(rspi, *data, RSPI_SPDR);
+		rspi_write_data(rspi, *data);
 		data++;
 		remain--;
 	}
@@ -401,14 +458,14 @@ static int qspi_send_pio(struct rspi_data *rspi, struct spi_message *mesg,
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
@@ -548,7 +605,7 @@ static void rspi_receive_init(const struct rspi_data *rspi)
 
 	spsr = rspi_read8(rspi, RSPI_SPSR);
 	if (spsr & SPSR_SPRF)
-		rspi_read16(rspi, RSPI_SPDR);	/* dummy read */
+		rspi_read_data(rspi);	/* dummy read */
 	if (spsr & SPSR_OVRF)
 		rspi_write8(rspi, rspi_read8(rspi, RSPI_SPSR) & ~SPSR_OVRF,
 			    RSPI_SPSR);
@@ -573,15 +630,14 @@ static int rspi_receive_pio(struct rspi_data *rspi, struct spi_message *mesg,
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
@@ -596,7 +652,7 @@ static void qspi_receive_init(const struct rspi_data *rspi)
 
 	spsr = rspi_read8(rspi, RSPI_SPSR);
 	if (spsr & SPSR_SPRF)
-		rspi_read8(rspi, RSPI_SPDR);   /* dummy read */
+		rspi_read_data(rspi);   /* dummy read */
 	rspi_write8(rspi, SPBFCR_TXRST | SPBFCR_RXRST, QSPI_SPBFCR);
 	rspi_write8(rspi, 0x00, QSPI_SPBFCR);
 }
@@ -618,15 +674,14 @@ static int qspi_receive_pio(struct rspi_data *rspi, struct spi_message *mesg,
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
 
@@ -989,6 +1044,12 @@ static int rspi_probe(struct platform_device *pdev)
 	master->transfer = rspi_transfer;
 	master->cleanup = rspi_cleanup;
 
+	ret = ops->parse_platform_data(rspi, rspi_pd);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "rspi invalid platform data.\n");
+		goto error1;
+	}
+
 	for (i = 0; i < MAX_NUM_IRQ; i++) {
 		irq = platform_get_irq(pdev, i);
 		if (irq < 0) {
@@ -1033,12 +1094,14 @@ error1:
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
index a25bd6f65e7f..7316dd9c7ba9 100644
--- a/include/linux/spi/rspi.h
+++ b/include/linux/spi/rspi.h
@@ -1,7 +1,7 @@
 /*
  * Renesas SPI driver
  *
- * Copyright (C) 2012  Renesas Solutions Corp.
+ * Copyright (C) 2012, 2013  Renesas Solutions Corp.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
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

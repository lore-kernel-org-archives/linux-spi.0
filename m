From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 2/2] spi: omap-100k: fix spacing coding style issue
Date: Wed, 26 Feb 2014 10:27:10 +0900
Message-ID: <003701cf3291$def77600$9ce66200$%han@samsung.com>
References: <003101cf3291$8948f3a0$9bdadae0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	'Cory Maccarrone' <darkstar6262-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	'Michal Nazarewicz' <mina86-deATy8a+UHjQT0dZR+AlfA@public.gmane.org>
To: 'Mark Brown' <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <003101cf3291$8948f3a0$9bdadae0$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Content-language: ko
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Fix the following checkpatch issues.

  ERROR: space prohibited after that open parenthesis '('
  ERROR: space required before the open parenthesis '('
  ERROR: trailing statements should be on next line
  ERROR: space required after that ',' (ctx:VxV)
  ERROR: spaces required around that '-=' (ctx:VxV)
  WARNING: sizeof *cs should be sizeof(*cs)

Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/spi/spi-omap-100k.c |   36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/drivers/spi/spi-omap-100k.c b/drivers/spi/spi-omap-100k.c
index 3b8b36a..c9e2282 100644
--- a/drivers/spi/spi-omap-100k.c
+++ b/drivers/spi/spi-omap-100k.c
@@ -128,7 +128,7 @@ static void spi100k_write_data(struct spi_master *master, int len, int data)
 	}
 
 	spi100k_enable_clock(master);
-	writew( data , spi100k->base + SPI_TX_MSB);
+	writew(data , spi100k->base + SPI_TX_MSB);
 
 	writew(SPI_CTRL_SEN(0) |
 	       SPI_CTRL_WORD_SIZE(len) |
@@ -136,7 +136,8 @@ static void spi100k_write_data(struct spi_master *master, int len, int data)
 	       spi100k->base + SPI_CTRL);
 
 	/* Wait for bit ack send change */
-	while((readw(spi100k->base + SPI_STATUS) & SPI_STATUS_WE) != SPI_STATUS_WE);
+	while ((readw(spi100k->base + SPI_STATUS) & SPI_STATUS_WE) != SPI_STATUS_WE)
+		;
 	udelay(1000);
 
 	spi100k_disable_clock(master);
@@ -144,7 +145,7 @@ static void spi100k_write_data(struct spi_master *master, int len, int data)
 
 static int spi100k_read_data(struct spi_master *master, int len)
 {
-	int dataH,dataL;
+	int dataH, dataL;
 	struct omap1_spi100k *spi100k = spi_master_get_devdata(master);
 
 	/* Always do at least 16 bits */
@@ -157,7 +158,8 @@ static int spi100k_read_data(struct spi_master *master, int len)
 	       SPI_CTRL_RD,
 	       spi100k->base + SPI_CTRL);
 
-	while((readw(spi100k->base + SPI_STATUS) & SPI_STATUS_RD) != SPI_STATUS_RD);
+	while ((readw(spi100k->base + SPI_STATUS) & SPI_STATUS_RD) != SPI_STATUS_RD)
+		;
 	udelay(1000);
 
 	dataL = readw(spi100k->base + SPI_RX_LSB);
@@ -208,12 +210,12 @@ omap1_spi100k_txrx_pio(struct spi_device *spi, struct spi_transfer *xfer)
 		rx = xfer->rx_buf;
 		tx = xfer->tx_buf;
 		do {
-			c-=1;
+			c -= 1;
 			if (xfer->tx_buf != NULL)
 				spi100k_write_data(spi->master, word_len, *tx++);
 			if (xfer->rx_buf != NULL)
 				*rx++ = spi100k_read_data(spi->master, word_len);
-		} while(c);
+		} while (c);
 	} else if (word_len <= 16) {
 		u16             *rx;
 		const u16       *tx;
@@ -221,12 +223,12 @@ omap1_spi100k_txrx_pio(struct spi_device *spi, struct spi_transfer *xfer)
 		rx = xfer->rx_buf;
 		tx = xfer->tx_buf;
 		do {
-			c-=2;
+			c -= 2;
 			if (xfer->tx_buf != NULL)
-				spi100k_write_data(spi->master,word_len, *tx++);
+				spi100k_write_data(spi->master, word_len, *tx++);
 			if (xfer->rx_buf != NULL)
-				*rx++ = spi100k_read_data(spi->master,word_len);
-		} while(c);
+				*rx++ = spi100k_read_data(spi->master, word_len);
+		} while (c);
 	} else if (word_len <= 32) {
 		u32             *rx;
 		const u32       *tx;
@@ -234,12 +236,12 @@ omap1_spi100k_txrx_pio(struct spi_device *spi, struct spi_transfer *xfer)
 		rx = xfer->rx_buf;
 		tx = xfer->tx_buf;
 		do {
-			c-=4;
+			c -= 4;
 			if (xfer->tx_buf != NULL)
-				spi100k_write_data(spi->master,word_len, *tx);
+				spi100k_write_data(spi->master, word_len, *tx);
 			if (xfer->rx_buf != NULL)
-				*rx = spi100k_read_data(spi->master,word_len);
-		} while(c);
+				*rx = spi100k_read_data(spi->master, word_len);
+		} while (c);
 	}
 	return count - c;
 }
@@ -281,7 +283,7 @@ static int omap1_spi100k_setup(struct spi_device *spi)
 	spi100k = spi_master_get_devdata(spi->master);
 
 	if (!cs) {
-		cs = kzalloc(sizeof *cs, GFP_KERNEL);
+		cs = kzalloc(sizeof(*cs), GFP_KERNEL);
 		if (!cs)
 			return -ENOMEM;
 		cs->base = spi100k->base + spi->chip_select * 0x14;
@@ -398,14 +400,14 @@ static int omap1_spi100k_probe(struct platform_device *pdev)
 	if (!pdev->id)
 		return -EINVAL;
 
-	master = spi_alloc_master(&pdev->dev, sizeof *spi100k);
+	master = spi_alloc_master(&pdev->dev, sizeof(*spi100k));
 	if (master == NULL) {
 		dev_dbg(&pdev->dev, "master allocation failed\n");
 		return -ENOMEM;
 	}
 
 	if (pdev->id != -1)
-	       master->bus_num = pdev->id;
+		master->bus_num = pdev->id;
 
 	master->setup = omap1_spi100k_setup;
 	master->transfer_one_message = omap1_spi100k_transfer_one_message;
-- 
1.7.10.4


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

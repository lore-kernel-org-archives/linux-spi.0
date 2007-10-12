From: Bryan Wu <bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 10/10] Blackfin SPI driver: Clean up
	useless wait in bfin SPI driver
Date: Fri, 12 Oct 2007 11:05:04 +0800
Message-ID: <1192158304-8277-11-git-send-email-bryan.wu@analog.com>
References: <1192158304-8277-1-git-send-email-bryan.wu@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Bryan Wu <bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>,
	Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
To: david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1192158304-8277-1-git-send-email-bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>

Signed-off-by: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Bryan Wu <bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi_bfin5xx.c |   84 ++++++++++++++++++++++++++++-----------------
 1 files changed, 52 insertions(+), 32 deletions(-)

diff --git a/drivers/spi/spi_bfin5xx.c b/drivers/spi/spi_bfin5xx.c
index 0cdfc2b..bfeaa7c 100644
--- a/drivers/spi/spi_bfin5xx.c
+++ b/drivers/spi/spi_bfin5xx.c
@@ -276,22 +276,26 @@ static void u8_writer(struct driver_data *drv_data)
 	dev_dbg(&drv_data->pdev->dev,
 		"cr8-s is 0x%x\n", read_STAT());
 
+	/* poll for SPI completion before start */
+	while (!(read_STAT() & BIT_STAT_SPIF))
+		continue;
+
 	while (drv_data->tx < drv_data->tx_end) {
 		write_TDBR(*(u8 *) (drv_data->tx));
 		while (read_STAT() & BIT_STAT_TXS)
 			continue;
 		++drv_data->tx;
 	}
-
-	/* poll for SPI completion before returning */
-	while (!(read_STAT() & BIT_STAT_SPIF))
-		continue;
 }
 
 static void u8_cs_chg_writer(struct driver_data *drv_data)
 {
 	struct chip_data *chip = drv_data->cur_chip;
 
+	/* poll for SPI completion before start */
+	while (!(read_STAT() & BIT_STAT_SPIF))
+		continue;
+
 	while (drv_data->tx < drv_data->tx_end) {
 		cs_active(chip);
 
@@ -304,10 +308,6 @@ static void u8_cs_chg_writer(struct driver_data *drv_data)
 			udelay(chip->cs_chg_udelay);
 		++drv_data->tx;
 	}
-
-	/* poll for SPI completion before returning */
-	while (!(read_STAT() & BIT_STAT_SPIF))
-		continue;
 }
 
 static void u8_reader(struct driver_data *drv_data)
@@ -315,6 +315,10 @@ static void u8_reader(struct driver_data *drv_data)
 	dev_dbg(&drv_data->pdev->dev,
 		"cr-8 is 0x%x\n", read_STAT());
 
+	/* poll for SPI completion before start */
+	while (!(read_STAT() & BIT_STAT_SPIF))
+		continue;
+
 	/* clear TDBR buffer before read(else it will be shifted out) */
 	write_TDBR(0xFFFF);
 
@@ -337,6 +341,10 @@ static void u8_cs_chg_reader(struct driver_data *drv_data)
 {
 	struct chip_data *chip = drv_data->cur_chip;
 
+	/* poll for SPI completion before start */
+	while (!(read_STAT() & BIT_STAT_SPIF))
+		continue;
+
 	/* clear TDBR buffer before read(else it will be shifted out) */
 	write_TDBR(0xFFFF);
 
@@ -365,6 +373,10 @@ static void u8_cs_chg_reader(struct driver_data *drv_data)
 
 static void u8_duplex(struct driver_data *drv_data)
 {
+	/* poll for SPI completion before start */
+	while (!(read_STAT() & BIT_STAT_SPIF))
+		continue;
+
 	/* in duplex mode, clk is triggered by writing of TDBR */
 	while (drv_data->rx < drv_data->rx_end) {
 		write_TDBR(*(u8 *) (drv_data->tx));
@@ -376,16 +388,16 @@ static void u8_duplex(struct driver_data *drv_data)
 		++drv_data->rx;
 		++drv_data->tx;
 	}
-
-	/* poll for SPI completion before returning */
-	while (!(read_STAT() & BIT_STAT_SPIF))
-		continue;
 }
 
 static void u8_cs_chg_duplex(struct driver_data *drv_data)
 {
 	struct chip_data *chip = drv_data->cur_chip;
 
+	/* poll for SPI completion before start */
+	while (!(read_STAT() & BIT_STAT_SPIF))
+		continue;
+
 	while (drv_data->rx < drv_data->rx_end) {
 		cs_active(chip);
 
@@ -402,10 +414,6 @@ static void u8_cs_chg_duplex(struct driver_data *drv_data)
 		++drv_data->rx;
 		++drv_data->tx;
 	}
-
-	/* poll for SPI completion before returning */
-	while (!(read_STAT() & BIT_STAT_SPIF))
-		continue;
 }
 
 static void u16_writer(struct driver_data *drv_data)
@@ -413,22 +421,26 @@ static void u16_writer(struct driver_data *drv_data)
 	dev_dbg(&drv_data->pdev->dev,
 		"cr16 is 0x%x\n", read_STAT());
 
+	/* poll for SPI completion before start */
+	while (!(read_STAT() & BIT_STAT_SPIF))
+		continue;
+
 	while (drv_data->tx < drv_data->tx_end) {
 		write_TDBR(*(u16 *) (drv_data->tx));
 		while ((read_STAT() & BIT_STAT_TXS))
 			continue;
 		drv_data->tx += 2;
 	}
-
-	/* poll for SPI completion before returning */
-	while (!(read_STAT() & BIT_STAT_SPIF))
-		continue;
 }
 
 static void u16_cs_chg_writer(struct driver_data *drv_data)
 {
 	struct chip_data *chip = drv_data->cur_chip;
 
+	/* poll for SPI completion before start */
+	while (!(read_STAT() & BIT_STAT_SPIF))
+		continue;
+
 	while (drv_data->tx < drv_data->tx_end) {
 		cs_active(chip);
 
@@ -441,10 +453,6 @@ static void u16_cs_chg_writer(struct driver_data *drv_data)
 			udelay(chip->cs_chg_udelay);
 		drv_data->tx += 2;
 	}
-
-	/* poll for SPI completion before returning */
-	while (!(read_STAT() & BIT_STAT_SPIF))
-		continue;
 }
 
 static void u16_reader(struct driver_data *drv_data)
@@ -452,6 +460,10 @@ static void u16_reader(struct driver_data *drv_data)
 	dev_dbg(&drv_data->pdev->dev,
 		"cr-16 is 0x%x\n", read_STAT());
 
+	/* poll for SPI completion before start */
+	while (!(read_STAT() & BIT_STAT_SPIF))
+		continue;
+
 	/* clear TDBR buffer before read(else it will be shifted out) */
 	write_TDBR(0xFFFF);
 
@@ -474,6 +486,10 @@ static void u16_cs_chg_reader(struct driver_data *drv_data)
 {
 	struct chip_data *chip = drv_data->cur_chip;
 
+	/* poll for SPI completion before start */
+	while (!(read_STAT() & BIT_STAT_SPIF))
+		continue;
+
 	/* clear TDBR buffer before read(else it will be shifted out) */
 	write_TDBR(0xFFFF);
 
@@ -502,6 +518,10 @@ static void u16_cs_chg_reader(struct driver_data *drv_data)
 
 static void u16_duplex(struct driver_data *drv_data)
 {
+	/* poll for SPI completion before start */
+	while (!(read_STAT() & BIT_STAT_SPIF))
+		continue;
+
 	/* in duplex mode, clk is triggered by writing of TDBR */
 	while (drv_data->tx < drv_data->tx_end) {
 		write_TDBR(*(u16 *) (drv_data->tx));
@@ -513,16 +533,16 @@ static void u16_duplex(struct driver_data *drv_data)
 		drv_data->rx += 2;
 		drv_data->tx += 2;
 	}
-
-	/* poll for SPI completion before returning */
-	while (!(read_STAT() & BIT_STAT_SPIF))
-		continue;
 }
 
 static void u16_cs_chg_duplex(struct driver_data *drv_data)
 {
 	struct chip_data *chip = drv_data->cur_chip;
 
+	/* poll for SPI completion before start */
+	while (!(read_STAT() & BIT_STAT_SPIF))
+		continue;
+
 	while (drv_data->tx < drv_data->tx_end) {
 		cs_active(chip);
 
@@ -539,10 +559,6 @@ static void u16_cs_chg_duplex(struct driver_data *drv_data)
 		drv_data->rx += 2;
 		drv_data->tx += 2;
 	}
-
-	/* poll for SPI completion before returning */
-	while (!(read_STAT() & BIT_STAT_SPIF))
-		continue;
 }
 
 /* test if ther is more transfer to be done */
@@ -765,6 +781,10 @@ static void pump_transfers(unsigned long data)
 			dma_width = WDSIZE_8;
 		}
 
+		/* poll for SPI completion before start */
+		while (!(read_STAT() & BIT_STAT_SPIF))
+			continue;
+
 		/* dirty hack for autobuffer DMA mode */
 		if (drv_data->tx_dma == 0xFFFF) {
 			dev_dbg(&drv_data->pdev->dev,
-- 
1.5.3.4

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/

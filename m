From: Bryan Wu <bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/4] Blackfin SPI driver: use
	cpu_relax() to replace continue in while busywait
Date: Fri,  2 Nov 2007 10:38:29 +0800
Message-ID: <1193971112-7744-2-git-send-email-bryan.wu@analog.com>
References: <1193971112-7744-1-git-send-email-bryan.wu@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Bryan Wu <bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1193971112-7744-1-git-send-email-bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
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

Signed-off-by: Bryan Wu <bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi_bfin5xx.c |   78 ++++++++++++++++++++++----------------------
 1 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/drivers/spi/spi_bfin5xx.c b/drivers/spi/spi_bfin5xx.c
index 83c866d..fc0c374 100644
--- a/drivers/spi/spi_bfin5xx.c
+++ b/drivers/spi/spi_bfin5xx.c
@@ -186,7 +186,7 @@ static int flush(struct driver_data *drv_data)
 
 	/* wait for stop and clear stat */
 	while (!(read_STAT(drv_data) & BIT_STAT_SPIF) && limit--)
-		continue;
+		cpu_relax();
 
 	write_STAT(drv_data, BIT_STAT_CLR);
 
@@ -262,7 +262,7 @@ static void null_writer(struct driver_data *drv_data)
 	while (drv_data->tx < drv_data->tx_end) {
 		write_TDBR(drv_data, 0);
 		while ((read_STAT(drv_data) & BIT_STAT_TXS))
-			continue;
+			cpu_relax();
 		drv_data->tx += n_bytes;
 	}
 }
@@ -274,7 +274,7 @@ static void null_reader(struct driver_data *drv_data)
 
 	while (drv_data->rx < drv_data->rx_end) {
 		while (!(read_STAT(drv_data) & BIT_STAT_RXS))
-			continue;
+			cpu_relax();
 		dummy_read(drv_data);
 		drv_data->rx += n_bytes;
 	}
@@ -287,12 +287,12 @@ static void u8_writer(struct driver_data *drv_data)
 
 	/* poll for SPI completion before start */
 	while (!(read_STAT(drv_data) & BIT_STAT_SPIF))
-		continue;
+		cpu_relax();
 
 	while (drv_data->tx < drv_data->tx_end) {
 		write_TDBR(drv_data, (*(u8 *) (drv_data->tx)));
 		while (read_STAT(drv_data) & BIT_STAT_TXS)
-			continue;
+			cpu_relax();
 		++drv_data->tx;
 	}
 }
@@ -303,14 +303,14 @@ static void u8_cs_chg_writer(struct driver_data *drv_data)
 
 	/* poll for SPI completion before start */
 	while (!(read_STAT(drv_data) & BIT_STAT_SPIF))
-		continue;
+		cpu_relax();
 
 	while (drv_data->tx < drv_data->tx_end) {
 		cs_active(drv_data, chip);
 
 		write_TDBR(drv_data, (*(u8 *) (drv_data->tx)));
 		while (read_STAT(drv_data) & BIT_STAT_TXS)
-			continue;
+			cpu_relax();
 
 		cs_deactive(drv_data, chip);
 
@@ -325,7 +325,7 @@ static void u8_reader(struct driver_data *drv_data)
 
 	/* poll for SPI completion before start */
 	while (!(read_STAT(drv_data) & BIT_STAT_SPIF))
-		continue;
+		cpu_relax();
 
 	/* clear TDBR buffer before read(else it will be shifted out) */
 	write_TDBR(drv_data, 0xFFFF);
@@ -334,13 +334,13 @@ static void u8_reader(struct driver_data *drv_data)
 
 	while (drv_data->rx < drv_data->rx_end - 1) {
 		while (!(read_STAT(drv_data) & BIT_STAT_RXS))
-			continue;
+			cpu_relax();
 		*(u8 *) (drv_data->rx) = read_RDBR(drv_data);
 		++drv_data->rx;
 	}
 
 	while (!(read_STAT(drv_data) & BIT_STAT_RXS))
-		continue;
+		cpu_relax();
 	*(u8 *) (drv_data->rx) = read_SHAW(drv_data);
 	++drv_data->rx;
 }
@@ -351,7 +351,7 @@ static void u8_cs_chg_reader(struct driver_data *drv_data)
 
 	/* poll for SPI completion before start */
 	while (!(read_STAT(drv_data) & BIT_STAT_SPIF))
-		continue;
+		cpu_relax();
 
 	/* clear TDBR buffer before read(else it will be shifted out) */
 	write_TDBR(drv_data, 0xFFFF);
@@ -363,7 +363,7 @@ static void u8_cs_chg_reader(struct driver_data *drv_data)
 		cs_deactive(drv_data, chip);
 
 		while (!(read_STAT(drv_data) & BIT_STAT_RXS))
-			continue;
+			cpu_relax();
 		cs_active(drv_data, chip);
 		*(u8 *) (drv_data->rx) = read_RDBR(drv_data);
 		++drv_data->rx;
@@ -371,7 +371,7 @@ static void u8_cs_chg_reader(struct driver_data *drv_data)
 	cs_deactive(drv_data, chip);
 
 	while (!(read_STAT(drv_data) & BIT_STAT_RXS))
-		continue;
+		cpu_relax();
 	*(u8 *) (drv_data->rx) = read_SHAW(drv_data);
 	++drv_data->rx;
 }
@@ -380,15 +380,15 @@ static void u8_duplex(struct driver_data *drv_data)
 {
 	/* poll for SPI completion before start */
 	while (!(read_STAT(drv_data) & BIT_STAT_SPIF))
-		continue;
+		cpu_relax();
 
 	/* in duplex mode, clk is triggered by writing of TDBR */
 	while (drv_data->rx < drv_data->rx_end) {
 		write_TDBR(drv_data, (*(u8 *) (drv_data->tx)));
 		while (read_STAT(drv_data) & BIT_STAT_TXS)
-			continue;
+			cpu_relax();
 		while (!(read_STAT(drv_data) & BIT_STAT_RXS))
-			continue;
+			cpu_relax();
 		*(u8 *) (drv_data->rx) = read_RDBR(drv_data);
 		++drv_data->rx;
 		++drv_data->tx;
@@ -401,16 +401,16 @@ static void u8_cs_chg_duplex(struct driver_data *drv_data)
 
 	/* poll for SPI completion before start */
 	while (!(read_STAT(drv_data) & BIT_STAT_SPIF))
-		continue;
+		cpu_relax();
 
 	while (drv_data->rx < drv_data->rx_end) {
 		cs_active(drv_data, chip);
 
 		write_TDBR(drv_data, (*(u8 *) (drv_data->tx)));
 		while (read_STAT(drv_data) & BIT_STAT_TXS)
-			continue;
+			cpu_relax();
 		while (!(read_STAT(drv_data) & BIT_STAT_RXS))
-			continue;
+			cpu_relax();
 		*(u8 *) (drv_data->rx) = read_RDBR(drv_data);
 
 		cs_deactive(drv_data, chip);
@@ -427,12 +427,12 @@ static void u16_writer(struct driver_data *drv_data)
 
 	/* poll for SPI completion before start */
 	while (!(read_STAT(drv_data) & BIT_STAT_SPIF))
-		continue;
+		cpu_relax();
 
 	while (drv_data->tx < drv_data->tx_end) {
 		write_TDBR(drv_data, (*(u16 *) (drv_data->tx)));
 		while ((read_STAT(drv_data) & BIT_STAT_TXS))
-			continue;
+			cpu_relax();
 		drv_data->tx += 2;
 	}
 }
@@ -443,14 +443,14 @@ static void u16_cs_chg_writer(struct driver_data *drv_data)
 
 	/* poll for SPI completion before start */
 	while (!(read_STAT(drv_data) & BIT_STAT_SPIF))
-		continue;
+		cpu_relax();
 
 	while (drv_data->tx < drv_data->tx_end) {
 		cs_active(drv_data, chip);
 
 		write_TDBR(drv_data, (*(u16 *) (drv_data->tx)));
 		while ((read_STAT(drv_data) & BIT_STAT_TXS))
-			continue;
+			cpu_relax();
 
 		cs_deactive(drv_data, chip);
 
@@ -465,7 +465,7 @@ static void u16_reader(struct driver_data *drv_data)
 
 	/* poll for SPI completion before start */
 	while (!(read_STAT(drv_data) & BIT_STAT_SPIF))
-		continue;
+		cpu_relax();
 
 	/* clear TDBR buffer before read(else it will be shifted out) */
 	write_TDBR(drv_data, 0xFFFF);
@@ -474,13 +474,13 @@ static void u16_reader(struct driver_data *drv_data)
 
 	while (drv_data->rx < (drv_data->rx_end - 2)) {
 		while (!(read_STAT(drv_data) & BIT_STAT_RXS))
-			continue;
+			cpu_relax();
 		*(u16 *) (drv_data->rx) = read_RDBR(drv_data);
 		drv_data->rx += 2;
 	}
 
 	while (!(read_STAT(drv_data) & BIT_STAT_RXS))
-		continue;
+		cpu_relax();
 	*(u16 *) (drv_data->rx) = read_SHAW(drv_data);
 	drv_data->rx += 2;
 }
@@ -491,7 +491,7 @@ static void u16_cs_chg_reader(struct driver_data *drv_data)
 
 	/* poll for SPI completion before start */
 	while (!(read_STAT(drv_data) & BIT_STAT_SPIF))
-		continue;
+		cpu_relax();
 
 	/* clear TDBR buffer before read(else it will be shifted out) */
 	write_TDBR(drv_data, 0xFFFF);
@@ -503,7 +503,7 @@ static void u16_cs_chg_reader(struct driver_data *drv_data)
 		cs_deactive(drv_data, chip);
 
 		while (!(read_STAT(drv_data) & BIT_STAT_RXS))
-			continue;
+			cpu_relax();
 		cs_active(drv_data, chip);
 		*(u16 *) (drv_data->rx) = read_RDBR(drv_data);
 		drv_data->rx += 2;
@@ -511,7 +511,7 @@ static void u16_cs_chg_reader(struct driver_data *drv_data)
 	cs_deactive(drv_data, chip);
 
 	while (!(read_STAT(drv_data) & BIT_STAT_RXS))
-		continue;
+		cpu_relax();
 	*(u16 *) (drv_data->rx) = read_SHAW(drv_data);
 	drv_data->rx += 2;
 }
@@ -520,15 +520,15 @@ static void u16_duplex(struct driver_data *drv_data)
 {
 	/* poll for SPI completion before start */
 	while (!(read_STAT(drv_data) & BIT_STAT_SPIF))
-		continue;
+		cpu_relax();
 
 	/* in duplex mode, clk is triggered by writing of TDBR */
 	while (drv_data->tx < drv_data->tx_end) {
 		write_TDBR(drv_data, (*(u16 *) (drv_data->tx)));
 		while (read_STAT(drv_data) & BIT_STAT_TXS)
-			continue;
+			cpu_relax();
 		while (!(read_STAT(drv_data) & BIT_STAT_RXS))
-			continue;
+			cpu_relax();
 		*(u16 *) (drv_data->rx) = read_RDBR(drv_data);
 		drv_data->rx += 2;
 		drv_data->tx += 2;
@@ -541,16 +541,16 @@ static void u16_cs_chg_duplex(struct driver_data *drv_data)
 
 	/* poll for SPI completion before start */
 	while (!(read_STAT(drv_data) & BIT_STAT_SPIF))
-		continue;
+		cpu_relax();
 
 	while (drv_data->tx < drv_data->tx_end) {
 		cs_active(drv_data, chip);
 
 		write_TDBR(drv_data, (*(u16 *) (drv_data->tx)));
 		while (read_STAT(drv_data) & BIT_STAT_TXS)
-			continue;
+			cpu_relax();
 		while (!(read_STAT(drv_data) & BIT_STAT_RXS))
-			continue;
+			cpu_relax();
 		*(u16 *) (drv_data->rx) = read_RDBR(drv_data);
 
 		cs_deactive(drv_data, chip);
@@ -624,7 +624,7 @@ static irqreturn_t dma_irq_handler(int irq, void *dev_id)
 
 	/* Wait for DMA to complete */
 	while (get_dma_curr_irqstat(drv_data->dma_channel) & DMA_RUN)
-		continue;
+		cpu_relax();
 
 	/*
 	 * wait for the last transaction shifted out.  HRM states:
@@ -635,11 +635,11 @@ static irqreturn_t dma_irq_handler(int irq, void *dev_id)
 	if (drv_data->tx != NULL) {
 		while ((read_STAT(drv_data) & TXS) ||
 		       (read_STAT(drv_data) & TXS))
-			continue;
+			cpu_relax();
 	}
 
 	while (!(read_STAT(drv_data) & SPIF))
-		continue;
+		cpu_relax();
 
 	msg->actual_length += drv_data->len_in_bytes;
 
@@ -783,7 +783,7 @@ static void pump_transfers(unsigned long data)
 
 		/* poll for SPI completion before start */
 		while (!(read_STAT(drv_data) & BIT_STAT_SPIF))
-			continue;
+			cpu_relax();
 
 		/* dirty hack for autobuffer DMA mode */
 		if (drv_data->tx_dma == 0xFFFF) {
-- 
1.5.3.4

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/

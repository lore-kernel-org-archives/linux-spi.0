From: Bryan Wu <bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 13/14] Blackfin SPI driver: Move
	cs_chg_udelay to cs_deactive to fix bug when some SPI LCD
	driver needs delay after cs_deactive
Date: Tue, 30 Oct 2007 17:18:04 +0800
Message-ID: <1193735885-8202-14-git-send-email-bryan.wu@analog.com>
References: <1193735885-8202-1-git-send-email-bryan.wu@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Bryan Wu <bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Cameron Barfield <cbarfield-uxMF5PKaPIoXhy9q4Lf3Ug@public.gmane.org>
To: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1193735885-8202-1-git-send-email-bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
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

Fix bug reported by Cameron Barfield <cbarfield-uxMF5PKaPIoXhy9q4Lf3Ug@public.gmane.org>
https://blackfin.uclinux.org/gf/project/uclinux-dist/forum/?action=ForumBrowse&forum_id=39&_forum_action=ForumMessageBrowse&thread_id=23630&feedback=Message%20replied.

Cc: Cameron Barfield <cbarfield-uxMF5PKaPIoXhy9q4Lf3Ug@public.gmane.org>
Signed-off-by: Bryan Wu <bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi_bfin5xx.c          |   24 +++++++++---------------
 include/asm-blackfin/bfin5xx_spi.h |    2 +-
 2 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi_bfin5xx.c b/drivers/spi/spi_bfin5xx.c
index 41282bf..0b22932 100644
--- a/drivers/spi/spi_bfin5xx.c
+++ b/drivers/spi/spi_bfin5xx.c
@@ -132,7 +132,7 @@ struct chip_data {
 	u8 enable_dma;
 	u8 bits_per_word;	/* 8 or 16 */
 	u8 cs_change_per_word;
-	u8 cs_chg_udelay;
+	u16 cs_chg_udelay;	/* Some devices require > 255usec delay */
 	void (*write) (struct driver_data *);
 	void (*read) (struct driver_data *);
 	void (*duplex) (struct driver_data *);
@@ -211,6 +211,10 @@ static void cs_deactive(struct driver_data *drv_data, struct chip_data *chip)
 	flag |= (chip->flag << 8);
 
 	write_FLAG(drv_data, flag);
+
+	/* Move delay here for consistency */
+	if (chip->cs_chg_udelay)
+		udelay(chip->cs_chg_udelay);
 }
 
 #define MAX_SPI_SSEL	7
@@ -307,10 +311,9 @@ static void u8_cs_chg_writer(struct driver_data *drv_data)
 		write_TDBR(drv_data, (*(u8 *) (drv_data->tx)));
 		while (read_STAT(drv_data) & BIT_STAT_TXS)
 			continue;
+
 		cs_deactive(drv_data, chip);
 
-		if (chip->cs_chg_udelay)
-			udelay(chip->cs_chg_udelay);
 		++drv_data->tx;
 	}
 }
@@ -359,9 +362,6 @@ static void u8_cs_chg_reader(struct driver_data *drv_data)
 	while (drv_data->rx < drv_data->rx_end - 1) {
 		cs_deactive(drv_data, chip);
 
-		if (chip->cs_chg_udelay)
-			udelay(chip->cs_chg_udelay);
-
 		while (!(read_STAT(drv_data) & BIT_STAT_RXS))
 			continue;
 		cs_active(drv_data, chip);
@@ -412,10 +412,9 @@ static void u8_cs_chg_duplex(struct driver_data *drv_data)
 		while (!(read_STAT(drv_data) & BIT_STAT_RXS))
 			continue;
 		*(u8 *) (drv_data->rx) = read_RDBR(drv_data);
+
 		cs_deactive(drv_data, chip);
 
-		if (chip->cs_chg_udelay)
-			udelay(chip->cs_chg_udelay);
 		++drv_data->rx;
 		++drv_data->tx;
 	}
@@ -452,10 +451,9 @@ static void u16_cs_chg_writer(struct driver_data *drv_data)
 		write_TDBR(drv_data, (*(u16 *) (drv_data->tx)));
 		while ((read_STAT(drv_data) & BIT_STAT_TXS))
 			continue;
+
 		cs_deactive(drv_data, chip);
 
-		if (chip->cs_chg_udelay)
-			udelay(chip->cs_chg_udelay);
 		drv_data->tx += 2;
 	}
 }
@@ -504,9 +502,6 @@ static void u16_cs_chg_reader(struct driver_data *drv_data)
 	while (drv_data->rx < drv_data->rx_end - 2) {
 		cs_deactive(drv_data, chip);
 
-		if (chip->cs_chg_udelay)
-			udelay(chip->cs_chg_udelay);
-
 		while (!(read_STAT(drv_data) & BIT_STAT_RXS))
 			continue;
 		cs_active(drv_data, chip);
@@ -557,10 +552,9 @@ static void u16_cs_chg_duplex(struct driver_data *drv_data)
 		while (!(read_STAT(drv_data) & BIT_STAT_RXS))
 			continue;
 		*(u16 *) (drv_data->rx) = read_RDBR(drv_data);
+
 		cs_deactive(drv_data, chip);
 
-		if (chip->cs_chg_udelay)
-			udelay(chip->cs_chg_udelay);
 		drv_data->rx += 2;
 		drv_data->tx += 2;
 	}
diff --git a/include/asm-blackfin/bfin5xx_spi.h b/include/asm-blackfin/bfin5xx_spi.h
index f617d87..d4485b3 100644
--- a/include/asm-blackfin/bfin5xx_spi.h
+++ b/include/asm-blackfin/bfin5xx_spi.h
@@ -162,7 +162,7 @@ struct bfin5xx_spi_chip {
 	u8 enable_dma;
 	u8 bits_per_word;
 	u8 cs_change_per_word;
-	u8 cs_chg_udelay;
+	u16 cs_chg_udelay; /* Some devices require 16-bit delays */
 };
 
 #endif /* _SPI_CHANNEL_H_ */
-- 
1.5.3.4

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/

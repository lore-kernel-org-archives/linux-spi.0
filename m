From: Bryan Wu <bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 4/4] Blackfin SPI driver: reconfigure
	speed_hz and bits_per_word in each spi transfer
Date: Fri,  2 Nov 2007 10:38:32 +0800
Message-ID: <1193971112-7744-5-git-send-email-bryan.wu@analog.com>
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

 - reconfigure SPI baud from speed_hz of each spi transfer
 - according to spi_transfer.bits_per_word to reprogram register and setup
   correct SPI operation handlers

Signed-off-by: Bryan Wu <bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi_bfin5xx.c |   54 ++++++++++++++++++++++++++++++++++++++------
 1 files changed, 46 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi_bfin5xx.c b/drivers/spi/spi_bfin5xx.c
index f466fa0..3e5126e 100644
--- a/drivers/spi/spi_bfin5xx.c
+++ b/drivers/spi/spi_bfin5xx.c
@@ -234,10 +234,8 @@ static int restore_state(struct driver_data *drv_data)
 	dev_dbg(&drv_data->pdev->dev, "restoring spi ctl state\n");
 
 	/* Load the registers */
-	write_BAUD(drv_data, chip->baud);
-	chip->ctl_reg &= (~BIT_CTL_TIMOD);
-	chip->ctl_reg |= (chip->width << 8);
 	write_CTRL(drv_data, chip->ctl_reg);
+	write_BAUD(drv_data, chip->baud);
 
 	bfin_spi_enable(drv_data);
 	cs_active(drv_data, chip);
@@ -679,6 +677,7 @@ static void pump_transfers(unsigned long data)
 	message = drv_data->cur_msg;
 	transfer = drv_data->cur_transfer;
 	chip = drv_data->cur_chip;
+
 	/*
 	 * if msg is error or done, report it back using complete() callback
 	 */
@@ -736,23 +735,62 @@ static void pump_transfers(unsigned long data)
 	drv_data->len_in_bytes = transfer->len;
 	drv_data->cs_change = transfer->cs_change;
 
-	width = chip->width;
+	/* Bits per word setup */
+	switch (transfer->bits_per_word) {
+	case 8:
+		drv_data->n_bytes = 1;
+		width = CFG_SPI_WORDSIZE8;
+		drv_data->read = chip->cs_change_per_word ?
+			u8_cs_chg_reader : u8_reader;
+		drv_data->write = chip->cs_change_per_word ?
+			u8_cs_chg_writer : u8_writer;
+		drv_data->duplex = chip->cs_change_per_word ?
+			u8_cs_chg_duplex : u8_duplex;
+		break;
+
+	case 16:
+		drv_data->n_bytes = 2;
+		width = CFG_SPI_WORDSIZE16;
+		drv_data->read = chip->cs_change_per_word ?
+			u16_cs_chg_reader : u16_reader;
+		drv_data->write = chip->cs_change_per_word ?
+			u16_cs_chg_writer : u16_writer;
+		drv_data->duplex = chip->cs_change_per_word ?
+			u16_cs_chg_duplex : u16_duplex;
+		break;
+
+	default:
+		/* No change, the same as default setting */
+		drv_data->n_bytes = chip->n_bytes;
+		width = chip->width;
+		drv_data->write = drv_data->tx ? chip->write : null_writer;
+		drv_data->read = drv_data->rx ? chip->read : null_reader;
+		drv_data->duplex = chip->duplex ? chip->duplex : null_writer;
+		break;
+	}
+	cr = (read_CTRL(drv_data) & (~BIT_CTL_TIMOD));
+	cr |= (width << 8);
+	write_CTRL(drv_data, cr);
+
 	if (width == CFG_SPI_WORDSIZE16) {
 		drv_data->len = (transfer->len) >> 1;
 	} else {
 		drv_data->len = transfer->len;
 	}
-	drv_data->write = drv_data->tx ? chip->write : null_writer;
-	drv_data->read = drv_data->rx ? chip->read : null_reader;
-	drv_data->duplex = chip->duplex ? chip->duplex : null_writer;
 	dev_dbg(&drv_data->pdev->dev,
 		"transfer: drv_data->write is %p, chip->write is %p, null_wr is %p\n",
-   		drv_data->write, chip->write, null_writer);
+		drv_data->write, chip->write, null_writer);
 
 	/* speed and width has been set on per message */
 	message->state = RUNNING_STATE;
 	dma_config = 0;
 
+	/* Speed setup (surely valid because already checked) */
+	if (transfer->speed_hz)
+		write_BAUD(drv_data, hz_to_spi_baud(transfer->speed_hz));
+	else
+		write_BAUD(drv_data, chip->baud);
+
 	write_STAT(drv_data, BIT_STAT_CLR);
 	cr = (read_CTRL(drv_data) & (~BIT_CTL_TIMOD));
 	cs_active(drv_data, chip);
-- 
1.5.3.4

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/

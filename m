From: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 21/28] Blackfin SPI: combine duplicate SPI_CTL read/write logic
Date: Sun, 17 Oct 2010 18:59:34 -0400
Message-ID: <1287356381-31495-22-git-send-email-vapier@gentoo.org>
References: <1287356381-31495-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1287356381-31495-1-git-send-email-vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

While combining things, also switch to the proper SPI bit define names.
This lets us punt the rarely used SPI defines.

Signed-off-by: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
---
 arch/blackfin/include/asm/bfin5xx_spi.h |   68 -------------------------------
 drivers/spi/spi_bfin5xx.c               |   40 ++++++++----------
 2 files changed, 18 insertions(+), 90 deletions(-)

diff --git a/arch/blackfin/include/asm/bfin5xx_spi.h b/arch/blackfin/include/asm/bfin5xx_spi.h
index 6f011da..4223cf0 100644
--- a/arch/blackfin/include/asm/bfin5xx_spi.h
+++ b/arch/blackfin/include/asm/bfin5xx_spi.h
@@ -11,18 +11,6 @@
 
 #define MIN_SPI_BAUD_VAL	2
 
-#define SPI_READ              0
-#define SPI_WRITE             1
-
-#define SPI_CTRL_OFF            0x0
-#define SPI_FLAG_OFF            0x4
-#define SPI_STAT_OFF            0x8
-#define SPI_TXBUFF_OFF          0xc
-#define SPI_RXBUFF_OFF          0x10
-#define SPI_BAUD_OFF            0x14
-#define SPI_SHAW_OFF            0x18
-
-
 #define BIT_CTL_ENABLE      0x4000
 #define BIT_CTL_OPENDRAIN   0x2000
 #define BIT_CTL_MASTER      0x1000
@@ -53,62 +41,6 @@
 #define BIT_STU_SENDOVER    0x0001
 #define BIT_STU_RECVFULL    0x0020
 
-#define CFG_SPI_ENABLE      1
-#define CFG_SPI_DISABLE     0
-
-#define CFG_SPI_OUTENABLE   1
-#define CFG_SPI_OUTDISABLE  0
-
-#define CFG_SPI_ACTLOW      1
-#define CFG_SPI_ACTHIGH     0
-
-#define CFG_SPI_PHASESTART  1
-#define CFG_SPI_PHASEMID    0
-
-#define CFG_SPI_MASTER      1
-#define CFG_SPI_SLAVE       0
-
-#define CFG_SPI_SENELAST    0
-#define CFG_SPI_SENDZERO    1
-
-#define CFG_SPI_RCVFLUSH    1
-#define CFG_SPI_RCVDISCARD  0
-
-#define CFG_SPI_LSBFIRST    1
-#define CFG_SPI_MSBFIRST    0
-
-#define CFG_SPI_WORDSIZE16  1
-#define CFG_SPI_WORDSIZE8   0
-
-#define CFG_SPI_MISOENABLE   1
-#define CFG_SPI_MISODISABLE  0
-
-#define CFG_SPI_READ      0x00
-#define CFG_SPI_WRITE     0x01
-#define CFG_SPI_DMAREAD   0x02
-#define CFG_SPI_DMAWRITE  0x03
-
-#define CFG_SPI_CSCLEARALL  0
-#define CFG_SPI_CHIPSEL1    1
-#define CFG_SPI_CHIPSEL2    2
-#define CFG_SPI_CHIPSEL3    3
-#define CFG_SPI_CHIPSEL4    4
-#define CFG_SPI_CHIPSEL5    5
-#define CFG_SPI_CHIPSEL6    6
-#define CFG_SPI_CHIPSEL7    7
-
-#define CFG_SPI_CS1VALUE    1
-#define CFG_SPI_CS2VALUE    2
-#define CFG_SPI_CS3VALUE    3
-#define CFG_SPI_CS4VALUE    4
-#define CFG_SPI_CS5VALUE    5
-#define CFG_SPI_CS6VALUE    6
-#define CFG_SPI_CS7VALUE    7
-
-#define CMD_SPI_SET_BAUDRATE  2
-#define CMD_SPI_GET_SYSTEMCLOCK   25
-#define CMD_SPI_SET_WRITECONTINUOUS     26
-
 #define MAX_CTRL_CS          8  /* cs in spi controller */
 
 /* device.platform_data for SSP controller devices */
diff --git a/drivers/spi/spi_bfin5xx.c b/drivers/spi/spi_bfin5xx.c
index 376f2f0..b3450b7 100644
--- a/drivers/spi/spi_bfin5xx.c
+++ b/drivers/spi/spi_bfin5xx.c
@@ -560,8 +560,7 @@ static void bfin_spi_pump_transfers(unsigned long data)
 	struct spi_transfer *previous = NULL;
 	struct slave_data *chip = NULL;
 	unsigned int bits_per_word;
-	u8 width;
-	u16 cr, dma_width, dma_config;
+	u16 cr, cr_width, dma_width, dma_config;
 	u32 tranf_success = 1;
 	u8 full_duplex = 0;
 
@@ -642,22 +641,19 @@ static void bfin_spi_pump_transfers(unsigned long data)
 	bits_per_word = transfer->bits_per_word ? : message->spi->bits_per_word;
 	if (bits_per_word == 8) {
 		drv_data->n_bytes = 1;
-		width = CFG_SPI_WORDSIZE8;
+		drv_data->len = transfer->len;
+		cr_width = 0;
 		drv_data->ops = &bfin_transfer_ops_u8;
 	} else {
 		drv_data->n_bytes = 2;
-		width = CFG_SPI_WORDSIZE16;
+		drv_data->len = (transfer->len) >> 1;
+		cr_width = BIT_CTL_WORDSIZE;
 		drv_data->ops = &bfin_transfer_ops_u16;
 	}
-	cr = (read_CTRL(drv_data) & (~BIT_CTL_TIMOD));
-	cr |= (width << 8);
+	cr = read_CTRL(drv_data) & ~(BIT_CTL_TIMOD | BIT_CTL_WORDSIZE);
+	cr |= cr_width;
 	write_CTRL(drv_data, cr);
 
-	if (width == CFG_SPI_WORDSIZE16) {
-		drv_data->len = (transfer->len) >> 1;
-	} else {
-		drv_data->len = transfer->len;
-	}
 	dev_dbg(&drv_data->pdev->dev,
 		"transfer: drv_data->ops is %p, chip->ops is %p, u8_ops is %p\n",
 		drv_data->ops, chip->ops, &bfin_transfer_ops_u8);
@@ -672,13 +668,12 @@ static void bfin_spi_pump_transfers(unsigned long data)
 		write_BAUD(drv_data, chip->baud);
 
 	write_STAT(drv_data, BIT_STAT_CLR);
-	cr = (read_CTRL(drv_data) & (~BIT_CTL_TIMOD));
 	if (drv_data->cs_change)
 		bfin_spi_cs_active(drv_data, chip);
 
 	dev_dbg(&drv_data->pdev->dev,
 		"now pumping a transfer: width is %d, len is %d\n",
-		width, transfer->len);
+		cr_width, transfer->len);
 
 	/*
 	 * Try to map dma buffer and do a dma transfer.  If successful use,
@@ -697,7 +692,7 @@ static void bfin_spi_pump_transfers(unsigned long data)
 		/* config dma channel */
 		dev_dbg(&drv_data->pdev->dev, "doing dma transfer\n");
 		set_dma_x_count(drv_data->dma_channel, drv_data->len);
-		if (width == CFG_SPI_WORDSIZE16) {
+		if (cr_width == BIT_CTL_WORDSIZE) {
 			set_dma_x_modify(drv_data->dma_channel, 2);
 			dma_width = WDSIZE_16;
 		} else {
@@ -786,10 +781,16 @@ static void bfin_spi_pump_transfers(unsigned long data)
 		return;
 	}
 
+	/*
+	 * We always use SPI_WRITE mode (transfer starts with TDBR write).
+	 * SPI_READ mode (transfer starts with RDBR read) seems to have
+	 * problems with setting up the output value in TDBR prior to the
+	 * start of the transfer.
+	 */
+	write_CTRL(drv_data, cr | BIT_CTL_TXMOD);
+
 	if (chip->pio_interrupt) {
-		/* use write mode. spi irq should have been disabled */
-		cr = (read_CTRL(drv_data) & (~BIT_CTL_TIMOD));
-		write_CTRL(drv_data, (cr | CFG_SPI_WRITE));
+		/* SPI irq should have been disabled by now */
 
 		/* discard old RX data and clear RXS */
 		bfin_spi_dummy_read(drv_data);
@@ -813,11 +814,6 @@ static void bfin_spi_pump_transfers(unsigned long data)
 	/* IO mode */
 	dev_dbg(&drv_data->pdev->dev, "doing IO transfer\n");
 
-	/* we always use SPI_WRITE mode. SPI_READ mode
-	   seems to have problems with setting up the
-	   output value in TDBR prior to the transfer. */
-	write_CTRL(drv_data, (cr | CFG_SPI_WRITE));
-
 	if (full_duplex) {
 		/* full duplex mode */
 		BUG_ON((drv_data->tx_end - drv_data->tx) !=
-- 
1.7.3.1


------------------------------------------------------------------------------
Download new Adobe(R) Flash(R) Builder(TM) 4
The new Adobe(R) Flex(R) 4 and Flash(R) Builder(TM) 4 (formerly 
Flex(R) Builder(TM)) enable the development of rich applications that run
across multiple browsers and platforms. Download your free trials today!
http://p.sf.net/sfu/adobe-dev2dev

From: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 19/28] Blackfin SPI: push all size checks into the transfer
	function
Date: Sun, 17 Oct 2010 18:59:32 -0400
Message-ID: <1287356381-31495-20-git-send-email-vapier@gentoo.org>
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

This reduces duplication between the setup/transfer functions and keeps
values cached during setup from overriding values changed on a transfer
basis (like bits_per_word).

Signed-off-by: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi_bfin5xx.c |   57 +++++++++++----------------------------------
 1 files changed, 14 insertions(+), 43 deletions(-)

diff --git a/drivers/spi/spi_bfin5xx.c b/drivers/spi/spi_bfin5xx.c
index d446524..830c705 100644
--- a/drivers/spi/spi_bfin5xx.c
+++ b/drivers/spi/spi_bfin5xx.c
@@ -114,10 +114,7 @@ struct slave_data {
 	u16 flag;
 
 	u8 chip_select_num;
-	u8 n_bytes;
-	u8 width;		/* 0 or 1 */
 	u8 enable_dma;
-	u8 bits_per_word;	/* 8 or 16 */
 	u16 cs_chg_udelay;	/* Some devices require > 255usec delay */
 	u32 cs_gpio;
 	u16 idle_tx_val;
@@ -562,6 +559,7 @@ static void bfin_spi_pump_transfers(unsigned long data)
 	struct spi_transfer *transfer = NULL;
 	struct spi_transfer *previous = NULL;
 	struct slave_data *chip = NULL;
+	unsigned int bits_per_word;
 	u8 width;
 	u16 cr, dma_width, dma_config;
 	u32 tranf_success = 1;
@@ -641,26 +639,15 @@ static void bfin_spi_pump_transfers(unsigned long data)
 	drv_data->cs_change = transfer->cs_change;
 
 	/* Bits per word setup */
-	switch (transfer->bits_per_word) {
-	case 8:
+	bits_per_word = transfer->bits_per_word ? : message->spi->bits_per_word;
+	if (bits_per_word == 8) {
 		drv_data->n_bytes = 1;
 		width = CFG_SPI_WORDSIZE8;
 		drv_data->ops = &bfin_transfer_ops_u8;
-		break;
-
-	case 16:
+	} else {
 		drv_data->n_bytes = 2;
 		width = CFG_SPI_WORDSIZE16;
 		drv_data->ops = &bfin_transfer_ops_u16;
-		break;
-
-	default:
-		/* No change, the same as default setting */
-		transfer->bits_per_word = chip->bits_per_word;
-		drv_data->n_bytes = chip->n_bytes;
-		width = chip->width;
-		drv_data->ops = chip->ops;
-		break;
 	}
 	cr = (read_CTRL(drv_data) & (~BIT_CTL_TIMOD));
 	cr |= (width << 8);
@@ -811,9 +798,9 @@ static void bfin_spi_pump_transfers(unsigned long data)
 		if (drv_data->tx == NULL)
 			write_TDBR(drv_data, chip->idle_tx_val);
 		else {
-			if (transfer->bits_per_word == 8)
+			if (bits_per_word == 8)
 				write_TDBR(drv_data, (*(u8 *) (drv_data->tx)));
-			else if (transfer->bits_per_word == 16)
+			else
 				write_TDBR(drv_data, (*(u16 *) (drv_data->tx)));
 			drv_data->tx += drv_data->n_bytes;
 		}
@@ -987,9 +974,6 @@ static int bfin_spi_setup(struct spi_device *spi)
 	struct master_data *drv_data = spi_master_get_devdata(spi->master);
 	int ret = -EINVAL;
 
-	if (spi->bits_per_word != 8 && spi->bits_per_word != 16)
-		goto error;
-
 	/* Only alloc (or use chip_info) on first setup */
 	chip_info = NULL;
 	chip = spi_get_ctldata(spi);
@@ -1023,10 +1007,16 @@ static int bfin_spi_setup(struct spi_device *spi)
 		chip->enable_dma = chip_info->enable_dma != 0
 		    && drv_data->master_info->enable_dma;
 		chip->ctl_reg = chip_info->ctl_reg;
-		chip->bits_per_word = chip_info->bits_per_word;
 		chip->cs_chg_udelay = chip_info->cs_chg_udelay;
 		chip->idle_tx_val = chip_info->idle_tx_val;
 		chip->pio_interrupt = chip_info->pio_interrupt;
+		spi->bits_per_word = chip_info->bits_per_word;
+	}
+
+	if (spi->bits_per_word != 8 && spi->bits_per_word != 16) {
+		dev_err(&spi->dev, "%d bits_per_word is not supported\n",
+				spi->bits_per_word);
+		goto error;
 	}
 
 	/* translate common spi framework into our register */
@@ -1050,25 +1040,6 @@ static int bfin_spi_setup(struct spi_device *spi)
 	else
 		chip->cs_gpio = chip->chip_select_num - MAX_CTRL_CS;
 
-	switch (chip->bits_per_word) {
-	case 8:
-		chip->n_bytes = 1;
-		chip->width = CFG_SPI_WORDSIZE8;
-		chip->ops = &bfin_transfer_ops_u8;
-		break;
-
-	case 16:
-		chip->n_bytes = 2;
-		chip->width = CFG_SPI_WORDSIZE16;
-		chip->ops = &bfin_transfer_ops_u16;
-		break;
-
-	default:
-		dev_err(&spi->dev, "%d bits_per_word is not supported\n",
-				chip->bits_per_word);
-		goto error;
-	}
-
 	if (chip->enable_dma && chip->pio_interrupt) {
 		dev_err(&spi->dev, "enable_dma is set, "
 				"do not set pio_interrupt\n");
@@ -1119,7 +1090,7 @@ static int bfin_spi_setup(struct spi_device *spi)
 	}
 
 	dev_dbg(&spi->dev, "setup spi chip %s, width is %d, dma is %d\n",
-			spi->modalias, chip->width, chip->enable_dma);
+			spi->modalias, spi->bits_per_word, chip->enable_dma);
 	dev_dbg(&spi->dev, "ctl_reg is 0x%x, flag_reg is 0x%x\n",
 			chip->ctl_reg, chip->flag);
 
-- 
1.7.3.1


------------------------------------------------------------------------------
Download new Adobe(R) Flash(R) Builder(TM) 4
The new Adobe(R) Flex(R) 4 and Flash(R) Builder(TM) 4 (formerly 
Flex(R) Builder(TM)) enable the development of rich applications that run
across multiple browsers and platforms. Download your free trials today!
http://p.sf.net/sfu/adobe-dev2dev

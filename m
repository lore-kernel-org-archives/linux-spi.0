From: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 06/28] Blackfin SPI: drop custom
	cs_change_per_word support
Date: Sun, 17 Oct 2010 18:59:19 -0400
Message-ID: <1287356381-31495-7-git-send-email-vapier@gentoo.org>
References: <1287356381-31495-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
        David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
        Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
In-Reply-To: <1287356381-31495-1-git-send-email-vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
List-Id: linux-spi.vger.kernel.org

As David points out, the cs_change_per_word option isn't standard, nor is
anyone actually using it.  So punt all of the dead code considering it
makes up ~10% of the code size.

Reported-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Signed-off-by: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
---
 arch/blackfin/include/asm/bfin5xx_spi.h |    1 -
 drivers/spi/spi_bfin5xx.c               |  148 +++----------------------------
 2 files changed, 12 insertions(+), 137 deletions(-)

diff --git a/arch/blackfin/include/asm/bfin5xx_spi.h b/arch/blackfin/include/asm/bfin5xx_spi.h
index ed4f8c6..ee3ecb9 100644
--- a/arch/blackfin/include/asm/bfin5xx_spi.h
+++ b/arch/blackfin/include/asm/bfin5xx_spi.h
@@ -120,7 +120,6 @@ struct bfin5xx_spi_chip {
 	u16 ctl_reg;
 	u8 enable_dma;
 	u8 bits_per_word;
-	u8 cs_change_per_word;
 	u16 cs_chg_udelay; /* Some devices require 16-bit delays */
 	u32 cs_gpio;
 	/* Value to send if no TX value is supplied, usually 0x0 or 0xFFFF */
diff --git a/drivers/spi/spi_bfin5xx.c b/drivers/spi/spi_bfin5xx.c
index 6150a8c..f4023a7 100644
--- a/drivers/spi/spi_bfin5xx.c
+++ b/drivers/spi/spi_bfin5xx.c
@@ -114,7 +114,6 @@ struct chip_data {
 	u8 width;		/* 0 or 1 */
 	u8 enable_dma;
 	u8 bits_per_word;	/* 8 or 16 */
-	u8 cs_change_per_word;
 	u16 cs_chg_udelay;	/* Some devices require > 255usec delay */
 	u32 cs_gpio;
 	u16 idle_tx_val;
@@ -309,24 +308,6 @@ static void bfin_spi_u8_writer(struct driver_data *drv_data)
 	}
 }
 
-static void bfin_spi_u8_cs_chg_writer(struct driver_data *drv_data)
-{
-	struct chip_data *chip = drv_data->cur_chip;
-
-	/* clear RXS (we check for RXS inside the loop) */
-	bfin_spi_dummy_read(drv_data);
-
-	while (drv_data->tx < drv_data->tx_end) {
-		bfin_spi_cs_active(drv_data, chip);
-		write_TDBR(drv_data, (*(u8 *) (drv_data->tx++)));
-		/* make sure transfer finished before deactiving CS */
-		while (!(read_STAT(drv_data) & BIT_STAT_RXS))
-			cpu_relax();
-		bfin_spi_dummy_read(drv_data);
-		bfin_spi_cs_deactive(drv_data, chip);
-	}
-}
-
 static void bfin_spi_u8_reader(struct driver_data *drv_data)
 {
 	u16 tx_val = drv_data->cur_chip->idle_tx_val;
@@ -342,24 +323,6 @@ static void bfin_spi_u8_reader(struct driver_data *drv_data)
 	}
 }
 
-static void bfin_spi_u8_cs_chg_reader(struct driver_data *drv_data)
-{
-	struct chip_data *chip = drv_data->cur_chip;
-	u16 tx_val = chip->idle_tx_val;
-
-	/* discard old RX data and clear RXS */
-	bfin_spi_dummy_read(drv_data);
-
-	while (drv_data->rx < drv_data->rx_end) {
-		bfin_spi_cs_active(drv_data, chip);
-		write_TDBR(drv_data, tx_val);
-		while (!(read_STAT(drv_data) & BIT_STAT_RXS))
-			cpu_relax();
-		*(u8 *) (drv_data->rx++) = read_RDBR(drv_data);
-		bfin_spi_cs_deactive(drv_data, chip);
-	}
-}
-
 static void bfin_spi_u8_duplex(struct driver_data *drv_data)
 {
 	/* discard old RX data and clear RXS */
@@ -373,23 +336,6 @@ static void bfin_spi_u8_duplex(struct driver_data *drv_data)
 	}
 }
 
-static void bfin_spi_u8_cs_chg_duplex(struct driver_data *drv_data)
-{
-	struct chip_data *chip = drv_data->cur_chip;
-
-	/* discard old RX data and clear RXS */
-	bfin_spi_dummy_read(drv_data);
-
-	while (drv_data->rx < drv_data->rx_end) {
-		bfin_spi_cs_active(drv_data, chip);
-		write_TDBR(drv_data, (*(u8 *) (drv_data->tx++)));
-		while (!(read_STAT(drv_data) & BIT_STAT_RXS))
-			cpu_relax();
-		*(u8 *) (drv_data->rx++) = read_RDBR(drv_data);
-		bfin_spi_cs_deactive(drv_data, chip);
-	}
-}
-
 static void bfin_spi_u16_writer(struct driver_data *drv_data)
 {
 	/* clear RXS (we check for RXS inside the loop) */
@@ -407,25 +353,6 @@ static void bfin_spi_u16_writer(struct driver_data *drv_data)
 	}
 }
 
-static void bfin_spi_u16_cs_chg_writer(struct driver_data *drv_data)
-{
-	struct chip_data *chip = drv_data->cur_chip;
-
-	/* clear RXS (we check for RXS inside the loop) */
-	bfin_spi_dummy_read(drv_data);
-
-	while (drv_data->tx < drv_data->tx_end) {
-		bfin_spi_cs_active(drv_data, chip);
-		write_TDBR(drv_data, (*(u16 *) (drv_data->tx)));
-		drv_data->tx += 2;
-		/* make sure transfer finished before deactiving CS */
-		while (!(read_STAT(drv_data) & BIT_STAT_RXS))
-			cpu_relax();
-		bfin_spi_dummy_read(drv_data);
-		bfin_spi_cs_deactive(drv_data, chip);
-	}
-}
-
 static void bfin_spi_u16_reader(struct driver_data *drv_data)
 {
 	u16 tx_val = drv_data->cur_chip->idle_tx_val;
@@ -442,25 +369,6 @@ static void bfin_spi_u16_reader(struct driver_data *drv_data)
 	}
 }
 
-static void bfin_spi_u16_cs_chg_reader(struct driver_data *drv_data)
-{
-	struct chip_data *chip = drv_data->cur_chip;
-	u16 tx_val = chip->idle_tx_val;
-
-	/* discard old RX data and clear RXS */
-	bfin_spi_dummy_read(drv_data);
-
-	while (drv_data->rx < drv_data->rx_end) {
-		bfin_spi_cs_active(drv_data, chip);
-		write_TDBR(drv_data, tx_val);
-		while (!(read_STAT(drv_data) & BIT_STAT_RXS))
-			cpu_relax();
-		*(u16 *) (drv_data->rx) = read_RDBR(drv_data);
-		drv_data->rx += 2;
-		bfin_spi_cs_deactive(drv_data, chip);
-	}
-}
-
 static void bfin_spi_u16_duplex(struct driver_data *drv_data)
 {
 	/* discard old RX data and clear RXS */
@@ -476,25 +384,6 @@ static void bfin_spi_u16_duplex(struct driver_data *drv_data)
 	}
 }
 
-static void bfin_spi_u16_cs_chg_duplex(struct driver_data *drv_data)
-{
-	struct chip_data *chip = drv_data->cur_chip;
-
-	/* discard old RX data and clear RXS */
-	bfin_spi_dummy_read(drv_data);
-
-	while (drv_data->rx < drv_data->rx_end) {
-		bfin_spi_cs_active(drv_data, chip);
-		write_TDBR(drv_data, (*(u16 *) (drv_data->tx)));
-		drv_data->tx += 2;
-		while (!(read_STAT(drv_data) & BIT_STAT_RXS))
-			cpu_relax();
-		*(u16 *) (drv_data->rx) = read_RDBR(drv_data);
-		drv_data->rx += 2;
-		bfin_spi_cs_deactive(drv_data, chip);
-	}
-}
-
 /* test if ther is more transfer to be done */
 static void *bfin_spi_next_transfer(struct driver_data *drv_data)
 {
@@ -773,23 +662,17 @@ static void bfin_spi_pump_transfers(unsigned long data)
 	case 8:
 		drv_data->n_bytes = 1;
 		width = CFG_SPI_WORDSIZE8;
-		drv_data->read = chip->cs_change_per_word ?
-			bfin_spi_u8_cs_chg_reader : bfin_spi_u8_reader;
-		drv_data->write = chip->cs_change_per_word ?
-			bfin_spi_u8_cs_chg_writer : bfin_spi_u8_writer;
-		drv_data->duplex = chip->cs_change_per_word ?
-			bfin_spi_u8_cs_chg_duplex : bfin_spi_u8_duplex;
+		drv_data->read = bfin_spi_u8_reader;
+		drv_data->write = bfin_spi_u8_writer;
+		drv_data->duplex = bfin_spi_u8_duplex;
 		break;
 
 	case 16:
 		drv_data->n_bytes = 2;
 		width = CFG_SPI_WORDSIZE16;
-		drv_data->read = chip->cs_change_per_word ?
-			bfin_spi_u16_cs_chg_reader : bfin_spi_u16_reader;
-		drv_data->write = chip->cs_change_per_word ?
-			bfin_spi_u16_cs_chg_writer : bfin_spi_u16_writer;
-		drv_data->duplex = chip->cs_change_per_word ?
-			bfin_spi_u16_cs_chg_duplex : bfin_spi_u16_duplex;
+		drv_data->read = bfin_spi_u16_reader;
+		drv_data->write = bfin_spi_u16_writer;
+		drv_data->duplex = bfin_spi_u16_duplex;
 		break;
 
 	default:
@@ -1164,7 +1047,6 @@ static int bfin_spi_setup(struct spi_device *spi)
 		    && drv_data->master_info->enable_dma;
 		chip->ctl_reg = chip_info->ctl_reg;
 		chip->bits_per_word = chip_info->bits_per_word;
-		chip->cs_change_per_word = chip_info->cs_change_per_word;
 		chip->cs_chg_udelay = chip_info->cs_chg_udelay;
 		chip->cs_gpio = chip_info->cs_gpio;
 		chip->idle_tx_val = chip_info->idle_tx_val;
@@ -1193,23 +1075,17 @@ static int bfin_spi_setup(struct spi_device *spi)
 	case 8:
 		chip->n_bytes = 1;
 		chip->width = CFG_SPI_WORDSIZE8;
-		chip->read = chip->cs_change_per_word ?
-			bfin_spi_u8_cs_chg_reader : bfin_spi_u8_reader;
-		chip->write = chip->cs_change_per_word ?
-			bfin_spi_u8_cs_chg_writer : bfin_spi_u8_writer;
-		chip->duplex = chip->cs_change_per_word ?
-			bfin_spi_u8_cs_chg_duplex : bfin_spi_u8_duplex;
+		chip->read = bfin_spi_u8_reader;
+		chip->write = bfin_spi_u8_writer;
+		chip->duplex = bfin_spi_u8_duplex;
 		break;
 
 	case 16:
 		chip->n_bytes = 2;
 		chip->width = CFG_SPI_WORDSIZE16;
-		chip->read = chip->cs_change_per_word ?
-			bfin_spi_u16_cs_chg_reader : bfin_spi_u16_reader;
-		chip->write = chip->cs_change_per_word ?
-			bfin_spi_u16_cs_chg_writer : bfin_spi_u16_writer;
-		chip->duplex = chip->cs_change_per_word ?
-			bfin_spi_u16_cs_chg_duplex : bfin_spi_u16_duplex;
+		chip->read = bfin_spi_u16_reader;
+		chip->write = bfin_spi_u16_writer;
+		chip->duplex = bfin_spi_u16_duplex;
 		break;
 
 	default:
-- 
1.7.3.1

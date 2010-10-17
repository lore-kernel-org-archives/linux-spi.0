From: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 15/28] Blackfin SPI: redo GPIO CS handling
Date: Sun, 17 Oct 2010 18:59:28 -0400
Message-ID: <1287356381-31495-16-git-send-email-vapier@gentoo.org>
References: <1287356381-31495-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, Barry Song <barry.song-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
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

From: Barry Song <barry.song-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>

The common SPI layers take care of detecting CS conflicts and preventing
two devices from claiming the same CS.  This causes problems for the GPIO
CS support we currently have as we are using CS0 to mean "GPIO CS".  But
if we have multiple devices using a GPIO CS, the common SPI layers see
multiple devices using the virtual "CS0" and reject any such attempts.

To make both work, we introduce an offset define.  This represents the
max number of hardware CS values that the SPI peripheral supports.  If
the CS is below this limit, we know we can use the hardware CS.  If it's
above, we treat it as a GPIO CS.  This keeps the CS unique as seen by
the common code and prevents conflicts.

Signed-off-by: Barry Song <barry.song-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
---
 arch/blackfin/include/asm/bfin5xx_spi.h |    3 +-
 drivers/spi/spi_bfin5xx.c               |   40 ++++++++++++++++--------------
 2 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/arch/blackfin/include/asm/bfin5xx_spi.h b/arch/blackfin/include/asm/bfin5xx_spi.h
index 126d25e..6f011da 100644
--- a/arch/blackfin/include/asm/bfin5xx_spi.h
+++ b/arch/blackfin/include/asm/bfin5xx_spi.h
@@ -109,6 +109,8 @@
 #define CMD_SPI_GET_SYSTEMCLOCK   25
 #define CMD_SPI_SET_WRITECONTINUOUS     26
 
+#define MAX_CTRL_CS          8  /* cs in spi controller */
+
 /* device.platform_data for SSP controller devices */
 struct bfin5xx_spi_master {
 	u16 num_chipselect;
@@ -124,7 +126,6 @@ struct bfin5xx_spi_chip {
 	u8 enable_dma;
 	u8 bits_per_word;
 	u16 cs_chg_udelay; /* Some devices require 16-bit delays */
-	u32 cs_gpio;
 	/* Value to send if no TX value is supplied, usually 0x0 or 0xFFFF */
 	u16 idle_tx_val;
 	u8 pio_interrupt; /* Enable spi data irq */
diff --git a/drivers/spi/spi_bfin5xx.c b/drivers/spi/spi_bfin5xx.c
index 07044d7..278fe0a 100644
--- a/drivers/spi/spi_bfin5xx.c
+++ b/drivers/spi/spi_bfin5xx.c
@@ -183,7 +183,7 @@ static int bfin_spi_flush(struct master_data *drv_data)
 /* Chip select operation functions for cs_change flag */
 static void bfin_spi_cs_active(struct master_data *drv_data, struct slave_data *chip)
 {
-	if (likely(chip->chip_select_num)) {
+	if (likely(chip->chip_select_num < MAX_CTRL_CS)) {
 		u16 flag = read_FLAG(drv_data);
 
 		flag &= ~chip->flag;
@@ -196,7 +196,7 @@ static void bfin_spi_cs_active(struct master_data *drv_data, struct slave_data *
 
 static void bfin_spi_cs_deactive(struct master_data *drv_data, struct slave_data *chip)
 {
-	if (likely(chip->chip_select_num)) {
+	if (likely(chip->chip_select_num < MAX_CTRL_CS)) {
 		u16 flag = read_FLAG(drv_data);
 
 		flag |= chip->flag;
@@ -214,20 +214,24 @@ static void bfin_spi_cs_deactive(struct master_data *drv_data, struct slave_data
 /* enable or disable the pin muxed by GPIO and SPI CS to work as SPI CS */
 static inline void bfin_spi_cs_enable(struct master_data *drv_data, struct slave_data *chip)
 {
-	u16 flag = read_FLAG(drv_data);
+	if (chip->chip_select_num < MAX_CTRL_CS) {
+		u16 flag = read_FLAG(drv_data);
 
-	flag |= (chip->flag >> 8);
+		flag |= (chip->flag >> 8);
 
-	write_FLAG(drv_data, flag);
+		write_FLAG(drv_data, flag);
+	}
 }
 
 static inline void bfin_spi_cs_disable(struct master_data *drv_data, struct slave_data *chip)
 {
-	u16 flag = read_FLAG(drv_data);
+	if (chip->chip_select_num < MAX_CTRL_CS) {
+		u16 flag = read_FLAG(drv_data);
 
-	flag &= ~(chip->flag >> 8);
+		flag &= ~(chip->flag >> 8);
 
-	write_FLAG(drv_data, flag);
+		write_FLAG(drv_data, flag);
+	}
 }
 
 /* stop controller and re-config current chip*/
@@ -1016,7 +1020,6 @@ static int bfin_spi_setup(struct spi_device *spi)
 		chip->ctl_reg = chip_info->ctl_reg;
 		chip->bits_per_word = chip_info->bits_per_word;
 		chip->cs_chg_udelay = chip_info->cs_chg_udelay;
-		chip->cs_gpio = chip_info->cs_gpio;
 		chip->idle_tx_val = chip_info->idle_tx_val;
 		chip->pio_interrupt = chip_info->pio_interrupt;
 	}
@@ -1036,8 +1039,11 @@ static int bfin_spi_setup(struct spi_device *spi)
 	 * SPI_BAUD, not the real baudrate
 	 */
 	chip->baud = hz_to_spi_baud(spi->max_speed_hz);
-	chip->flag = (1 << (spi->chip_select)) << 8;
 	chip->chip_select_num = spi->chip_select;
+	if (chip->chip_select_num < MAX_CTRL_CS)
+		chip->flag = (1 << spi->chip_select) << 8;
+	else
+		chip->cs_gpio = chip->chip_select_num - MAX_CTRL_CS;
 
 	switch (chip->bits_per_word) {
 	case 8:
@@ -1098,7 +1104,7 @@ static int bfin_spi_setup(struct spi_device *spi)
 		disable_irq(drv_data->spi_irq);
 	}
 
-	if (chip->chip_select_num == 0) {
+	if (chip->chip_select_num >= MAX_CTRL_CS) {
 		ret = gpio_request(chip->cs_gpio, spi->modalias);
 		if (ret) {
 			dev_err(&spi->dev, "gpio_request() error\n");
@@ -1115,8 +1121,7 @@ static int bfin_spi_setup(struct spi_device *spi)
 	spi_set_ctldata(spi, chip);
 
 	dev_dbg(&spi->dev, "chip select number is %d\n", chip->chip_select_num);
-	if (chip->chip_select_num > 0 &&
-	    chip->chip_select_num <= spi->master->num_chipselect) {
+	if (chip->chip_select_num < MAX_CTRL_CS) {
 		ret = peripheral_request(ssel[spi->master->bus_num]
 		                         [chip->chip_select_num-1], spi->modalias);
 		if (ret) {
@@ -1131,7 +1136,7 @@ static int bfin_spi_setup(struct spi_device *spi)
 	return 0;
 
  pin_error:
-	if (chip->chip_select_num == 0)
+	if (chip->chip_select_num >= MAX_CTRL_CS)
 		gpio_free(chip->cs_gpio);
 	else
 		peripheral_free(ssel[spi->master->bus_num]
@@ -1162,14 +1167,11 @@ static void bfin_spi_cleanup(struct spi_device *spi)
 	if (!chip)
 		return;
 
-	if ((chip->chip_select_num > 0)
-		&& (chip->chip_select_num <= spi->master->num_chipselect)) {
+	if (chip->chip_select_num < MAX_CTRL_CS) {
 		peripheral_free(ssel[spi->master->bus_num]
 					[chip->chip_select_num-1]);
 		bfin_spi_cs_disable(drv_data, chip);
-	}
-
-	if (chip->chip_select_num == 0)
+	} else
 		gpio_free(chip->cs_gpio);
 
 	kfree(chip);
-- 
1.7.3.1


------------------------------------------------------------------------------
Download new Adobe(R) Flash(R) Builder(TM) 4
The new Adobe(R) Flex(R) 4 and Flash(R) Builder(TM) 4 (formerly 
Flex(R) Builder(TM)) enable the development of rich applications that run
across multiple browsers and platforms. Download your free trials today!
http://p.sf.net/sfu/adobe-dev2dev

From: Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 19/20] Blackfin SPI Driver: Add GPIO
	controlled SPI Slave Select support
Date: Fri,  6 Feb 2009 15:13:07 +0800
Message-ID: <1233904388-5765-20-git-send-email-cooloney@kernel.org>
References: <1233904388-5765-1-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
To: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1233904388-5765-1-git-send-email-cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>

This patch adds support for GPIO controlled SPI Chip Selects.
To make use of this feature, set chip_select = 0 and add a proper
cs_gpio to your controller_data.

struct spi_board_info
        .chip_select = 0

struct bfin5xx_spi_chip
        .cs_gpio = GPIO_P###

There are various SPI devices that require SPI MODE_0,
and need to have the Chip Selects asserted during the entire transfer.
Consider using SPI_MODE_3 (SPI_CPHA | SPI_CPOL) if your device allows
it.

Signed-off-by: Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 arch/blackfin/include/asm/bfin5xx_spi.h |    1 +
 drivers/spi/spi_bfin5xx.c               |   40 ++++++++++++++++++++++++------
 2 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/arch/blackfin/include/asm/bfin5xx_spi.h b/arch/blackfin/include/asm/bfin5xx_spi.h
index e1bb164..da8b9ca 100644
--- a/arch/blackfin/include/asm/bfin5xx_spi.h
+++ b/arch/blackfin/include/asm/bfin5xx_spi.h
@@ -124,6 +124,7 @@ struct bfin5xx_spi_chip {
 	u8 bits_per_word;
 	u8 cs_change_per_word;
 	u16 cs_chg_udelay; /* Some devices require 16-bit delays */
+	u32 cs_gpio;
 };
 
 #endif /* _SPI_CHANNEL_H_ */
diff --git a/drivers/spi/spi_bfin5xx.c b/drivers/spi/spi_bfin5xx.c
index 9459c42..3e63a5d 100644
--- a/drivers/spi/spi_bfin5xx.c
+++ b/drivers/spi/spi_bfin5xx.c
@@ -111,6 +111,7 @@ struct chip_data {
 	u8 bits_per_word;	/* 8 or 16 */
 	u8 cs_change_per_word;
 	u16 cs_chg_udelay;	/* Some devices require > 255usec delay */
+	u32 cs_gpio;
 	void (*write) (struct driver_data *);
 	void (*read) (struct driver_data *);
 	void (*duplex) (struct driver_data *);
@@ -177,22 +178,30 @@ static int bfin_spi_flush(struct driver_data *drv_data)
 /* Chip select operation functions for cs_change flag */
 static void bfin_spi_cs_active(struct driver_data *drv_data, struct chip_data *chip)
 {
-	u16 flag = read_FLAG(drv_data);
+	if (likely(chip->chip_select_num)) {
+		u16 flag = read_FLAG(drv_data);
 
-	flag |= chip->flag;
-	flag &= ~(chip->flag << 8);
+		flag |= chip->flag;
+		flag &= ~(chip->flag << 8);
 
-	write_FLAG(drv_data, flag);
+		write_FLAG(drv_data, flag);
+	} else {
+		gpio_set_value(chip->cs_gpio, 0);
+	}
 }
 
 static void bfin_spi_cs_deactive(struct driver_data *drv_data, struct chip_data *chip)
 {
-	u16 flag = read_FLAG(drv_data);
+	if (likely(chip->chip_select_num)) {
+		u16 flag = read_FLAG(drv_data);
 
-	flag &= ~chip->flag;
-	flag |= (chip->flag << 8);
+		flag &= ~chip->flag;
+		flag |= (chip->flag << 8);
 
-	write_FLAG(drv_data, flag);
+		write_FLAG(drv_data, flag);
+	} else {
+		gpio_set_value(chip->cs_gpio, 1);
+	}
 
 	/* Move delay here for consistency */
 	if (chip->cs_chg_udelay)
@@ -1036,6 +1045,7 @@ static int bfin_spi_setup(struct spi_device *spi)
 	struct bfin5xx_spi_chip *chip_info = NULL;
 	struct chip_data *chip;
 	struct driver_data *drv_data = spi_master_get_devdata(spi->master);
+	int ret;
 
 	/* Abort device setup if requested features are not supported */
 	if (spi->mode & ~(SPI_CPOL | SPI_CPHA | SPI_LSB_FIRST)) {
@@ -1081,6 +1091,7 @@ static int bfin_spi_setup(struct spi_device *spi)
 		chip->bits_per_word = chip_info->bits_per_word;
 		chip->cs_change_per_word = chip_info->cs_change_per_word;
 		chip->cs_chg_udelay = chip_info->cs_chg_udelay;
+		chip->cs_gpio = chip_info->cs_gpio;
 	}
 
 	/* translate common spi framework into our register */
@@ -1121,6 +1132,16 @@ static int bfin_spi_setup(struct spi_device *spi)
 	chip->flag = 1 << (spi->chip_select);
 	chip->chip_select_num = spi->chip_select;
 
+	if (chip->chip_select_num == 0) {
+		ret = gpio_request(chip->cs_gpio, spi->modalias);
+		if (ret) {
+			if (drv_data->dma_requested)
+				free_dma(drv_data->dma_channel);
+			return ret;
+		}
+		gpio_direction_output(chip->cs_gpio, 1);
+	}
+
 	switch (chip->bits_per_word) {
 	case 8:
 		chip->n_bytes = 1;
@@ -1186,6 +1207,9 @@ static void bfin_spi_cleanup(struct spi_device *spi)
 		peripheral_free(ssel[spi->master->bus_num]
 					[chip->chip_select_num-1]);
 
+	if (chip->chip_select_num == 0)
+		gpio_free(chip->cs_gpio);
+
 	kfree(chip);
 }
 
-- 
1.5.6.3

------------------------------------------------------------------------------
Create and Deploy Rich Internet Apps outside the browser with Adobe(R)AIR(TM)
software. With Adobe AIR, Ajax developers can use existing skills and code to
build responsive, highly engaging applications that combine the power of local
resources and data with the reach of the web. Download the Adobe AIR SDK and
Ajax docs to start building applications today-http://p.sf.net/sfu/adobe-com

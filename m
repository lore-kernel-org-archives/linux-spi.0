From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Subject: [PATCH RFC 3/4] spi: dw: add support for gpio controlled chip select
Date: Thu, 23 Jan 2014 15:05:58 +0200
Message-ID: <cc63df805aa126eede50aa11b3fb3c5bdef67f65.1390481413.git.baruch@tkos.co.il>
References: <cover.1390481412.git.baruch@tkos.co.il>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1390481412.git.baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Signed-off-by: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
---
 drivers/spi/spi-dw.c | 33 ++++++++++++++++++++++++++++++---
 drivers/spi/spi-dw.h |  6 +++++-
 2 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index bf98d63d92b3..595761593492 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -24,6 +24,7 @@
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
+#include <linux/gpio.h>
 
 #include "spi-dw.h"
 
@@ -265,6 +266,8 @@ static void giveback(struct dw_spi *dws)
 	struct spi_transfer *last_transfer;
 	unsigned long flags;
 	struct spi_message *msg;
+	int cs_gpio = dws->cur_msg->spi->cs_gpio;
+	u16 mode = dws->cur_msg->spi->mode;
 
 	spin_lock_irqsave(&dws->lock, flags);
 	msg = dws->cur_msg;
@@ -280,8 +283,12 @@ static void giveback(struct dw_spi *dws)
 					struct spi_transfer,
 					transfer_list);
 
-	if (!last_transfer->cs_change && dws->cs_control)
-		dws->cs_control(MRST_SPI_DEASSERT);
+	if (!last_transfer->cs_change) {
+		if (dws->cs_control)
+			dws->cs_control(MRST_SPI_DEASSERT);
+		if (gpio_is_valid(cs_gpio))
+			gpio_set_value(cs_gpio, !(mode & SPI_CS_HIGH));
+	}
 
 	msg->state = NULL;
 	if (msg->complete)
@@ -509,7 +516,8 @@ static void pump_transfers(unsigned long data)
 			dw_writew(dws, DW_SPI_CTRL0, cr0);
 
 		spi_set_clk(dws, clk_div ? clk_div : chip->clk_div);
-		spi_chip_sel(dws, spi->chip_select);
+		spi_chip_sel(dws, spi->chip_select, spi->cs_gpio,
+				spi->mode & SPI_CS_HIGH);
 
 		/* Set the interrupt mask, for poll mode just disable all int */
 		spi_mask_intr(dws, 0xff);
@@ -615,6 +623,7 @@ static int dw_spi_setup(struct spi_device *spi)
 {
 	struct dw_spi_chip *chip_info = NULL;
 	struct chip_data *chip;
+	int ret;
 
 	/* Only alloc on first setup */
 	chip = spi_get_ctldata(spi);
@@ -668,12 +677,30 @@ static int dw_spi_setup(struct spi_device *spi)
 			| (spi->mode  << SPI_MODE_OFFSET)
 			| (chip->tmode << SPI_TMOD_OFFSET);
 
+	if (gpio_is_valid(spi->cs_gpio)) {
+		ret = gpio_request(spi->cs_gpio, dev_name(&spi->dev));
+		if (ret)
+			return ret;
+		ret = gpio_direction_output(spi->cs_gpio,
+				!(spi->mode & SPI_CS_HIGH));
+		if (ret)
+			goto err_gpio_free;
+	}
+
 	return 0;
+
+err_gpio_free:
+	if (gpio_is_valid(spi->cs_gpio))
+		gpio_free(spi->cs_gpio);
+
+	return ret;
 }
 
 static void dw_spi_cleanup(struct spi_device *spi)
 {
 	struct chip_data *chip = spi_get_ctldata(spi);
+	if (gpio_is_valid(spi->cs_gpio))
+		gpio_free(spi->cs_gpio);
 	kfree(chip);
 }
 
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 587643dae11e..4a3a6d764b48 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -3,6 +3,7 @@
 
 #include <linux/io.h>
 #include <linux/scatterlist.h>
+#include <linux/gpio.h>
 
 /* Register offsets */
 #define DW_SPI_CTRL0			0x00
@@ -186,13 +187,16 @@ static inline void spi_set_clk(struct dw_spi *dws, u16 div)
 	dw_writel(dws, DW_SPI_BAUDR, div);
 }
 
-static inline void spi_chip_sel(struct dw_spi *dws, u16 cs)
+static inline void spi_chip_sel(struct dw_spi *dws, u16 cs, int cs_gpio,
+		int gpio_active_val)
 {
 	if (cs > dws->num_cs)
 		return;
 
 	if (dws->cs_control)
 		dws->cs_control(1);
+	if (gpio_is_valid(cs_gpio))
+		gpio_set_value(cs_gpio, gpio_active_val);
 
 	dw_writel(dws, DW_SPI_SER, 1 << cs);
 }
-- 
1.8.5.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

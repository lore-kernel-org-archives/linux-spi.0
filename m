From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 2/2] drivers: spi-gpio: add support for
 controllers without MISO or MOSI pin
Date: Fri, 18 Jun 2010 08:11:04 +0200
Message-ID: <1276841464-7984-3-git-send-email-m.szyprowski@samsung.com>
References: <1276841464-7984-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Grant Likely <glikely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <1276841464-7984-1-git-send-email-m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

There are some boards that do not strictly follow SPI standard and use
only 3 wires (SCLK, MOSI or MISO, SS) for connecting some simple auxiliary
chips and controls them with GPIO based 'spi controller'. In this
configuration the MISO or MOSI line is missing (it is not required if the
chip does not transfer any data back to host or host only reads data from
chip).

This patch adds support for such non-standard configuration in GPIO-based
SPI controller. It has been tested in configuration without MISO pin.

Reviewed-by: Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/spi/spi_gpio.c       |  101 ++++++++++++++++++++++++++++++++++-------
 include/linux/spi/spi_gpio.h |    5 ++
 2 files changed, 88 insertions(+), 18 deletions(-)

diff --git a/drivers/spi/spi_gpio.c b/drivers/spi/spi_gpio.c
index 82b480c..e24a634 100644
--- a/drivers/spi/spi_gpio.c
+++ b/drivers/spi/spi_gpio.c
@@ -167,6 +167,44 @@ static u32 spi_gpio_txrx_word_mode3(struct spi_device *spi,
 	return bitbang_txrx_be_cpha1(spi, nsecs, 1, 0, word, bits);
 }
 
+/*
+ * These functions do not call setmosi or getmiso if respective flag
+ * (SPI_MASTER_NO_RX or SPI_MASTER_NO_TX) is set, so they are safe to
+ * call when such pin is not present or defined in the controller.
+ * A separate set of callbacks is defined to get highest possible
+ * speed in the generic case (when both MISO and MOSI lines are
+ * available), as optimiser will remove the checks when argument is
+ * constant.
+ */
+
+static u32 spi_gpio_spec_txrx_word_mode0(struct spi_device *spi,
+		unsigned nsecs, u32 word, u8 bits)
+{
+	unsigned flags = spi->master->flags;
+	return bitbang_txrx_be_cpha0(spi, nsecs, 0, flags, word, bits);
+}
+
+static u32 spi_gpio_spec_txrx_word_mode1(struct spi_device *spi,
+		unsigned nsecs, u32 word, u8 bits)
+{
+	unsigned flags = spi->master->flags;
+	return bitbang_txrx_be_cpha1(spi, nsecs, 0, flags, word, bits);
+}
+
+static u32 spi_gpio_spec_txrx_word_mode2(struct spi_device *spi,
+		unsigned nsecs, u32 word, u8 bits)
+{
+	unsigned flags = spi->master->flags;
+	return bitbang_txrx_be_cpha0(spi, nsecs, 1, flags, word, bits);
+}
+
+static u32 spi_gpio_spec_txrx_word_mode3(struct spi_device *spi,
+		unsigned nsecs, u32 word, u8 bits)
+{
+	unsigned flags = spi->master->flags;
+	return bitbang_txrx_be_cpha1(spi, nsecs, 1, flags, word, bits);
+}
+
 /*----------------------------------------------------------------------*/
 
 static void spi_gpio_chipselect(struct spi_device *spi, int is_active)
@@ -232,19 +270,30 @@ static int __init spi_gpio_alloc(unsigned pin, const char *label, bool is_in)
 }
 
 static int __init
-spi_gpio_request(struct spi_gpio_platform_data *pdata, const char *label)
+spi_gpio_request(struct spi_gpio_platform_data *pdata, const char *label,
+	u16 *res_flags)
 {
 	int value;
 
 	/* NOTE:  SPI_*_GPIO symbols may reference "pdata" */
 
-	value = spi_gpio_alloc(SPI_MOSI_GPIO, label, false);
-	if (value)
-		goto done;
+	if (SPI_MOSI_GPIO != SPI_GPIO_NO_MOSI) {
+		value = spi_gpio_alloc(SPI_MOSI_GPIO, label, false);
+		if (value)
+			goto done;
+	} else {
+		/* HW configuration without MOSI pin */
+		*res_flags |= SPI_MASTER_NO_TX;
+	}
 
-	value = spi_gpio_alloc(SPI_MISO_GPIO, label, true);
-	if (value)
-		goto free_mosi;
+	if (SPI_MISO_GPIO != SPI_GPIO_NO_MISO) {
+		value = spi_gpio_alloc(SPI_MISO_GPIO, label, true);
+		if (value)
+			goto free_mosi;
+	} else {
+		/* HW configuration without MISO pin */
+		*res_flags |= SPI_MASTER_NO_RX;
+	}
 
 	value = spi_gpio_alloc(SPI_SCK_GPIO, label, false);
 	if (value)
@@ -253,9 +302,11 @@ spi_gpio_request(struct spi_gpio_platform_data *pdata, const char *label)
 	goto done;
 
 free_miso:
-	gpio_free(SPI_MISO_GPIO);
+	if (SPI_MISO_GPIO != SPI_GPIO_NO_MISO)
+		gpio_free(SPI_MISO_GPIO);
 free_mosi:
-	gpio_free(SPI_MOSI_GPIO);
+	if (SPI_MOSI_GPIO != SPI_GPIO_NO_MOSI)
+		gpio_free(SPI_MOSI_GPIO);
 done:
 	return value;
 }
@@ -266,6 +317,7 @@ static int __init spi_gpio_probe(struct platform_device *pdev)
 	struct spi_master		*master;
 	struct spi_gpio			*spi_gpio;
 	struct spi_gpio_platform_data	*pdata;
+	u16 master_flags = 0;
 
 	pdata = pdev->dev.platform_data;
 #ifdef GENERIC_BITBANG
@@ -273,7 +325,7 @@ static int __init spi_gpio_probe(struct platform_device *pdev)
 		return -ENODEV;
 #endif
 
-	status = spi_gpio_request(pdata, dev_name(&pdev->dev));
+	status = spi_gpio_request(pdata, dev_name(&pdev->dev), &master_flags);
 	if (status < 0)
 		return status;
 
@@ -289,6 +341,7 @@ static int __init spi_gpio_probe(struct platform_device *pdev)
 	if (pdata)
 		spi_gpio->pdata = *pdata;
 
+	master->flags = master_flags;
 	master->bus_num = pdev->id;
 	master->num_chipselect = SPI_N_CHIPSEL;
 	master->setup = spi_gpio_setup;
@@ -296,10 +349,18 @@ static int __init spi_gpio_probe(struct platform_device *pdev)
 
 	spi_gpio->bitbang.master = spi_master_get(master);
 	spi_gpio->bitbang.chipselect = spi_gpio_chipselect;
-	spi_gpio->bitbang.txrx_word[SPI_MODE_0] = spi_gpio_txrx_word_mode0;
-	spi_gpio->bitbang.txrx_word[SPI_MODE_1] = spi_gpio_txrx_word_mode1;
-	spi_gpio->bitbang.txrx_word[SPI_MODE_2] = spi_gpio_txrx_word_mode2;
-	spi_gpio->bitbang.txrx_word[SPI_MODE_3] = spi_gpio_txrx_word_mode3;
+
+	if ((master_flags & (SPI_MASTER_NO_RX | SPI_MASTER_NO_RX)) == 0) {
+		spi_gpio->bitbang.txrx_word[SPI_MODE_0] = spi_gpio_txrx_word_mode0;
+		spi_gpio->bitbang.txrx_word[SPI_MODE_1] = spi_gpio_txrx_word_mode1;
+		spi_gpio->bitbang.txrx_word[SPI_MODE_2] = spi_gpio_txrx_word_mode2;
+		spi_gpio->bitbang.txrx_word[SPI_MODE_3] = spi_gpio_txrx_word_mode3;
+	} else {
+		spi_gpio->bitbang.txrx_word[SPI_MODE_0] = spi_gpio_spec_txrx_word_mode0;
+		spi_gpio->bitbang.txrx_word[SPI_MODE_1] = spi_gpio_spec_txrx_word_mode1;
+		spi_gpio->bitbang.txrx_word[SPI_MODE_2] = spi_gpio_spec_txrx_word_mode2;
+		spi_gpio->bitbang.txrx_word[SPI_MODE_3] = spi_gpio_spec_txrx_word_mode3;
+	}
 	spi_gpio->bitbang.setup_transfer = spi_bitbang_setup_transfer;
 	spi_gpio->bitbang.flags = SPI_CS_HIGH;
 
@@ -307,8 +368,10 @@ static int __init spi_gpio_probe(struct platform_device *pdev)
 	if (status < 0) {
 		spi_master_put(spi_gpio->bitbang.master);
 gpio_free:
-		gpio_free(SPI_MISO_GPIO);
-		gpio_free(SPI_MOSI_GPIO);
+		if (SPI_MISO_GPIO != SPI_GPIO_NO_MISO)
+			gpio_free(SPI_MISO_GPIO);
+		if (SPI_MOSI_GPIO != SPI_GPIO_NO_MOSI)
+			gpio_free(SPI_MOSI_GPIO);
 		gpio_free(SPI_SCK_GPIO);
 		spi_master_put(master);
 	}
@@ -331,8 +394,10 @@ static int __exit spi_gpio_remove(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, NULL);
 
-	gpio_free(SPI_MISO_GPIO);
-	gpio_free(SPI_MOSI_GPIO);
+	if (SPI_MISO_GPIO != SPI_GPIO_NO_MISO)
+		gpio_free(SPI_MISO_GPIO);
+	if (SPI_MOSI_GPIO != SPI_GPIO_NO_MOSI)
+		gpio_free(SPI_MOSI_GPIO);
 	gpio_free(SPI_SCK_GPIO);
 
 	return status;
diff --git a/include/linux/spi/spi_gpio.h b/include/linux/spi/spi_gpio.h
index ca6782e..369b3d7 100644
--- a/include/linux/spi/spi_gpio.h
+++ b/include/linux/spi/spi_gpio.h
@@ -29,11 +29,16 @@
  * SPI_GPIO_NO_CHIPSELECT to the controller_data:
  *		.controller_data = (void *) SPI_GPIO_NO_CHIPSELECT;
  *
+ * If the MISO or MOSI pin is not available then it should be set to
+ * SPI_GPIO_NO_MISO or SPI_GPIO_NO_MOSI.
+ *
  * If the bitbanged bus is later switched to a "native" controller,
  * that platform_device and controller_data should be removed.
  */
 
 #define SPI_GPIO_NO_CHIPSELECT		((unsigned long)-1l)
+#define SPI_GPIO_NO_MISO		((unsigned long)-1l)
+#define SPI_GPIO_NO_MOSI		((unsigned long)-1l)
 
 /**
  * struct spi_gpio_platform_data - parameter for bitbanged SPI master
-- 
1.7.1.240.g225c


------------------------------------------------------------------------------
ThinkGeek and WIRED's GeekDad team up for the Ultimate 
GeekDad Father's Day Giveaway. ONE MASSIVE PRIZE to the 
lucky parental unit.  See the prize list and enter to win: 
http://p.sf.net/sfu/thinkgeek-promo

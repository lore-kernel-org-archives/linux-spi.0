From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] drivers: spi-gpio: add support for
 controllers without MISO or MOSI pin
Date: Thu, 01 Apr 2010 12:35:51 +0200
Message-ID: <1270118151-13286-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	'David Brownell' <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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
 drivers/spi/spi_gpio.c       |   55 +++++++++++++++++++++++++++++------------
 include/linux/spi/spi_gpio.h |    5 ++++
 2 files changed, 44 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi_gpio.c b/drivers/spi/spi_gpio.c
index 26bd03e..2db2f6f 100644
--- a/drivers/spi/spi_gpio.c
+++ b/drivers/spi/spi_gpio.c
@@ -109,12 +109,16 @@ static inline void setsck(const struct spi_device *spi, int is_on)
 
 static inline void setmosi(const struct spi_device *spi, int is_on)
 {
-	gpio_set_value(SPI_MOSI_GPIO, is_on);
+	if (SPI_MOSI_GPIO != SPI_GPIO_NO_MOSI)
+		gpio_set_value(SPI_MOSI_GPIO, is_on);
 }
 
 static inline int getmiso(const struct spi_device *spi)
 {
-	return !!gpio_get_value(SPI_MISO_GPIO);
+	if (SPI_MISO_GPIO != SPI_GPIO_NO_MISO)
+		return !!gpio_get_value(SPI_MISO_GPIO);
+	else
+		return 0;
 }
 
 #undef pdata
@@ -233,19 +237,30 @@ static int __init spi_gpio_alloc(unsigned pin, const char *label, bool is_in)
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
@@ -254,9 +269,11 @@ spi_gpio_request(struct spi_gpio_platform_data *pdata, const char *label)
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
@@ -267,6 +284,7 @@ static int __init spi_gpio_probe(struct platform_device *pdev)
 	struct spi_master		*master;
 	struct spi_gpio			*spi_gpio;
 	struct spi_gpio_platform_data	*pdata;
+	u16 master_flags = 0;
 
 	pdata = pdev->dev.platform_data;
 #ifdef GENERIC_BITBANG
@@ -274,7 +292,7 @@ static int __init spi_gpio_probe(struct platform_device *pdev)
 		return -ENODEV;
 #endif
 
-	status = spi_gpio_request(pdata, dev_name(&pdev->dev));
+	status = spi_gpio_request(pdata, dev_name(&pdev->dev), &master_flags);
 	if (status < 0)
 		return status;
 
@@ -290,6 +308,7 @@ static int __init spi_gpio_probe(struct platform_device *pdev)
 	if (pdata)
 		spi_gpio->pdata = *pdata;
 
+	master->flags = master_flags;
 	master->bus_num = pdev->id;
 	master->num_chipselect = SPI_N_CHIPSEL;
 	master->setup = spi_gpio_setup;
@@ -308,8 +327,10 @@ static int __init spi_gpio_probe(struct platform_device *pdev)
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
@@ -332,8 +353,10 @@ static int __exit spi_gpio_remove(struct platform_device *pdev)
 
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
1.6.4


------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev

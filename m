From: Axel Lin <axel.lin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi: use gpio_request_one() instead of spi_gpio_alloc()
	helper function
Date: Mon, 05 Dec 2011 15:50:47 +0800
Message-ID: <1323071447.20963.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
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

Signed-off-by: Axel Lin <axel.lin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-gpio.c |   21 ++++-----------------
 1 files changed, 4 insertions(+), 17 deletions(-)

diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index e093d3e..85c2eca 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -256,20 +256,6 @@ static void spi_gpio_cleanup(struct spi_device *spi)
 	spi_bitbang_cleanup(spi);
 }
 
-static int __init spi_gpio_alloc(unsigned pin, const char *label, bool is_in)
-{
-	int value;
-
-	value = gpio_request(pin, label);
-	if (value == 0) {
-		if (is_in)
-			value = gpio_direction_input(pin);
-		else
-			value = gpio_direction_output(pin, 0);
-	}
-	return value;
-}
-
 static int __init
 spi_gpio_request(struct spi_gpio_platform_data *pdata, const char *label,
 	u16 *res_flags)
@@ -279,7 +265,8 @@ spi_gpio_request(struct spi_gpio_platform_data *pdata, const char *label,
 	/* NOTE:  SPI_*_GPIO symbols may reference "pdata" */
 
 	if (SPI_MOSI_GPIO != SPI_GPIO_NO_MOSI) {
-		value = spi_gpio_alloc(SPI_MOSI_GPIO, label, false);
+		value = gpio_request_one(SPI_MOSI_GPIO, GPIOF_OUT_INIT_LOW,
+					 label);
 		if (value)
 			goto done;
 	} else {
@@ -288,7 +275,7 @@ spi_gpio_request(struct spi_gpio_platform_data *pdata, const char *label,
 	}
 
 	if (SPI_MISO_GPIO != SPI_GPIO_NO_MISO) {
-		value = spi_gpio_alloc(SPI_MISO_GPIO, label, true);
+		value = gpio_request_one(SPI_MISO_GPIO, GPIOF_IN, label);
 		if (value)
 			goto free_mosi;
 	} else {
@@ -296,7 +283,7 @@ spi_gpio_request(struct spi_gpio_platform_data *pdata, const char *label,
 		*res_flags |= SPI_MASTER_NO_RX;
 	}
 
-	value = spi_gpio_alloc(SPI_SCK_GPIO, label, false);
+	value = gpio_request_one(SPI_SCK_GPIO, GPIOF_OUT_INIT_LOW, label);
 	if (value)
 		goto free_miso;
 
-- 
1.7.5.4




------------------------------------------------------------------------------
All the data continuously generated in your IT infrastructure 
contains a definitive record of customers, application performance, 
security threats, fraudulent activity, and more. Splunk takes this 
data and makes sense of it. IT sense. And common sense.
http://p.sf.net/sfu/splunk-novd2d

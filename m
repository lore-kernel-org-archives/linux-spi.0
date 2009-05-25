From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] [drivers] [SPI] SPI_GPIO: add support
 for controllers with missing MISO pin
Date: Mon, 25 May 2009 15:02:59 +0200
Message-ID: <E4D3F24EA6C9E54F817833EAE0D912AC0227F8F9F8@bssrvexch01.BS.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
To: LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org"
	<linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org>,
	"spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-language: en-US
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

There are some boards that do not strictly follow SPI standard and use only 3 wires
(SCLK, MOSI, SS) for connecting some simple auxiliary chips and controls them with GPIO
based 'spi controller'. In this configuration the MISO line is missing (it is not
required if the chip does not transfer any data back to host). The example of such
board is a NCP ARM S3C64XX based machine. This patch adds support for such non-standard
configuration in GPIO-based SPI controller.

Reviewed-by: Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

--- 

diff --git a/drivers/spi/spi_gpio.c b/drivers/spi/spi_gpio.c
index 26bd03e..16f74fd 100644
--- a/drivers/spi/spi_gpio.c
+++ b/drivers/spi/spi_gpio.c
@@ -114,7 +114,10 @@ static inline void setmosi(const struct spi_device *spi, int is_on)
 
 static inline int getmiso(const struct spi_device *spi)
 {
-	return !!gpio_get_value(SPI_MISO_GPIO);
+	if (gpio_is_valid(SPI_MISO_GPIO))
+		return !!gpio_get_value(SPI_MISO_GPIO);
+	else
+		return 0;
 }
 
 #undef pdata
@@ -243,9 +246,11 @@ spi_gpio_request(struct spi_gpio_platform_data *pdata, const char *label)
 	if (value)
 		goto done;
 
-	value = spi_gpio_alloc(SPI_MISO_GPIO, label, true);
-	if (value)
-		goto free_mosi;
+	if (gpio_is_valid(SPI_MISO_GPIO)) {
+		value = spi_gpio_alloc(SPI_MISO_GPIO, label, true);
+		if (value)
+			goto free_mosi;
+	}
 
 	value = spi_gpio_alloc(SPI_SCK_GPIO, label, false);
 	if (value)
@@ -254,7 +259,8 @@ spi_gpio_request(struct spi_gpio_platform_data *pdata, const char *label)
 	goto done;
 
 free_miso:
-	gpio_free(SPI_MISO_GPIO);
+	if (gpio_is_valid(SPI_MISO_GPIO))
+		gpio_free(SPI_MISO_GPIO);
 free_mosi:
 	gpio_free(SPI_MOSI_GPIO);
 done:
@@ -308,7 +314,8 @@ static int __init spi_gpio_probe(struct platform_device *pdev)
 	if (status < 0) {
 		spi_master_put(spi_gpio->bitbang.master);
 gpio_free:
-		gpio_free(SPI_MISO_GPIO);
+		if (gpio_is_valid(SPI_MISO_GPIO))
+			gpio_free(SPI_MISO_GPIO);
 		gpio_free(SPI_MOSI_GPIO);
 		gpio_free(SPI_SCK_GPIO);
 		spi_master_put(master);
@@ -332,7 +339,8 @@ static int __exit spi_gpio_remove(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, NULL);
 
-	gpio_free(SPI_MISO_GPIO);
+	if (gpio_is_valid(SPI_MISO_GPIO))
+		gpio_free(SPI_MISO_GPIO);
 	gpio_free(SPI_MOSI_GPIO);
 	gpio_free(SPI_SCK_GPIO);



------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp asthey present alongside digital heavyweights like Barbarian
Group, R/GA, & Big Spaceship. http://www.creativitycat.com 

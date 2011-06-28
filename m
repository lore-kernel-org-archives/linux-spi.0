From: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
Subject: [PATCH 2/5] mach-qt2410: convert to spi_gpio
Date: Tue, 28 Jun 2011 14:49:14 +0200
Message-ID: <1309265357-15879-3-git-send-email-jacmet@sunsite.dk>
References: <1309265357-15879-1-git-send-email-jacmet@sunsite.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
To: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1309265357-15879-1-git-send-email-jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Rather than the deprecated spi_s3c24xx_gpio driver.

Only compile tested. Notice that the board support seems quite broken
as the spi_s3c24xx_gpio platform device name was misspelled and there
is no struct spi_board_info defined, but this atleast didn't make it
any worse.

Signed-off-by: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
---
 arch/arm/mach-s3c2410/mach-qt2410.c |   34 ++++++++--------------------------
 1 files changed, 8 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-s3c2410/mach-qt2410.c b/arch/arm/mach-s3c2410/mach-qt2410.c
index e8f49fe..f44f775 100644
--- a/arch/arm/mach-s3c2410/mach-qt2410.c
+++ b/arch/arm/mach-s3c2410/mach-qt2410.c
@@ -32,7 +32,7 @@
 #include <linux/platform_device.h>
 #include <linux/serial_core.h>
 #include <linux/spi/spi.h>
-#include <linux/spi/spi_bitbang.h>
+#include <linux/spi/spi_gpio.h>
 #include <linux/io.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/nand.h>
@@ -53,8 +53,6 @@
 #include <mach/fb.h>
 #include <plat/nand.h>
 #include <plat/udc.h>
-#include <mach/spi.h>
-#include <mach/spi-gpio.h>
 #include <plat/iic.h>
 
 #include <plat/common-smdk.h>
@@ -216,32 +214,16 @@ static struct platform_device qt2410_led = {
 
 /* SPI */
 
-static void spi_gpio_cs(struct s3c2410_spigpio_info *spi, int cs)
-{
-	switch (cs) {
-	case BITBANG_CS_ACTIVE:
-		gpio_set_value(S3C2410_GPB(5), 0);
-		break;
-	case BITBANG_CS_INACTIVE:
-		gpio_set_value(S3C2410_GPB(5), 1);
-		break;
-	}
-}
-
-static struct s3c2410_spigpio_info spi_gpio_cfg = {
-	.pin_clk	= S3C2410_GPG(7),
-	.pin_mosi	= S3C2410_GPG(6),
-	.pin_miso	= S3C2410_GPG(5),
-	.chip_select	= &spi_gpio_cs,
+static struct spi_gpio_platform_data spi_gpio_cfg = {
+	.sck		= S3C2410_GPG(7),
+	.mosi		= S3C2410_GPG(6),
+	.miso		= S3C2410_GPG(5),
 };
 
-
 static struct platform_device qt2410_spi = {
-	.name		  = "s3c24xx-spi-gpio",
-	.id		  = 1,
-	.dev = {
-		.platform_data = &spi_gpio_cfg,
-	},
+	.name		= "spi-gpio",
+	.id		= 1,
+	.dev.platform_data = &spi_gpio_cfg,
 };
 
 /* Board devices */
-- 
1.7.5.4


------------------------------------------------------------------------------
All of the data generated in your IT infrastructure is seriously valuable.
Why? It contains a definitive record of application performance, security 
threats, fraudulent activity, and more. Splunk takes this data and makes 
sense of it. IT sense. And common sense.
http://p.sf.net/sfu/splunk-d2d-c2

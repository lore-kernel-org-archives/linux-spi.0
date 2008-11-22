From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch 2.6.8-rc6 3/3] spi: use generic gpio
	calls in spi_s3c24xx_gpio
Date: Sat, 22 Nov 2008 12:19:17 -0800
Message-ID: <200811221219.17491.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>

Change the spi_s3c2410 driver to use the generic gpio calls that
are now available.

Signed-off-by: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
 arch/arm/mach-s3c2410/include/mach/spi.h |    2 -
 drivers/spi/spi_s3c24xx.c                |   38 ++++++++++++++++++++++-------
 2 files changed, 30 insertions(+), 10 deletions(-)

--- a/arch/arm/mach-s3c2410/include/mach/spi.h
+++ b/arch/arm/mach-s3c2410/include/mach/spi.h
@@ -14,7 +14,7 @@
 #define __ASM_ARCH_SPI_H __FILE__
 
 struct s3c2410_spi_info {
-	unsigned long		 pin_cs;	/* simple gpio cs */
+	int			 pin_cs;	/* simple gpio cs */
 	unsigned int		 num_cs;	/* total chipselects */
 	int			 bus_num;       /* bus number to use. */
 
--- a/drivers/spi/spi_s3c24xx.c
+++ b/drivers/spi/spi_s3c24xx.c
@@ -19,6 +19,7 @@
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/platform_device.h>
+#include <linux/gpio.h>
 
 #include <linux/spi/spi.h>
 #include <linux/spi/spi_bitbang.h>
@@ -27,7 +28,6 @@
 #include <asm/dma.h>
 #include <mach/hardware.h>
 
-#include <mach/regs-gpio.h>
 #include <asm/plat-s3c24xx/regs-spi.h>
 #include <mach/spi.h>
 
@@ -66,7 +66,7 @@ static inline struct s3c24xx_spi *to_hw(
 
 static void s3c24xx_spi_gpiocs(struct s3c2410_spi_info *spi, int cs, int pol)
 {
-	s3c2410_gpio_setpin(spi->pin_cs, pol);
+	gpio_set_value(spi->pin_cs, pol);
 }
 
 static void s3c24xx_spi_chipsel(struct spi_device *spi, int value)
@@ -248,8 +248,13 @@ static void s3c24xx_spi_initialsetup(str
 	writeb(SPPIN_DEFAULT, hw->regs + S3C2410_SPPIN);
 	writeb(SPCON_DEFAULT, hw->regs + S3C2410_SPCON);
 
-	if (hw->pdata && hw->pdata->gpio_setup)
-		hw->pdata->gpio_setup(hw->pdata, 1);
+	if (hw->pdata) {
+		if (hw->set_cs == s3c24xx_spi_gpiocs)
+			gpio_direction_output(hw->pdata->pin_cs, 1);
+
+		if (hw->pdata->gpio_setup)
+			hw->pdata->gpio_setup(hw->pdata, 1);
+	}
 }
 
 static int __init s3c24xx_spi_probe(struct platform_device *pdev)
@@ -343,18 +348,27 @@ static int __init s3c24xx_spi_probe(stru
 		goto err_no_clk;
 	}
 
-	s3c24xx_spi_initialsetup(hw);
-
 	/* setup any gpio we can */
 
 	if (!pdata->set_cs) {
-		hw->set_cs = s3c24xx_spi_gpiocs;
+		if (pdata->pin_cs < 0) {
+			dev_err(&pdev->dev, "No chipselect pin\n");
+			goto err_register;
+		}
 
-		s3c2410_gpio_setpin(pdata->pin_cs, 1);
-		s3c2410_gpio_cfgpin(pdata->pin_cs, S3C2410_GPIO_OUTPUT);
+		err = gpio_request(pdata->pin_cs, dev_name(&pdev->dev));
+		if (err) {
+			dev_err(&pdev->dev, "Failed to get gpio for cs\n");
+			goto err_register;
+		}
+
+		hw->set_cs = s3c24xx_spi_gpiocs;
+		gpio_direction_output(pdata->pin_cs, 1);
 	} else
 		hw->set_cs = pdata->set_cs;
 
+	s3c24xx_spi_initialsetup(hw);
+
 	/* register our spi controller */
 
 	err = spi_bitbang_start(&hw->bitbang);
@@ -366,6 +380,9 @@ static int __init s3c24xx_spi_probe(stru
 	return 0;
 
  err_register:
+	if (hw->set_cs == s3c24xx_spi_gpiocs)
+		gpio_free(pdata->pin_cs);
+
 	clk_disable(hw->clk);
 	clk_put(hw->clk);
 
@@ -401,6 +418,9 @@ static int __exit s3c24xx_spi_remove(str
 	free_irq(hw->irq, hw);
 	iounmap(hw->regs);
 
+	if (hw->set_cs == s3c24xx_spi_gpiocs)
+		gpio_free(hw->pdata->pin_cs);
+
 	release_resource(hw->ioarea);
 	kfree(hw->ioarea);
 

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/

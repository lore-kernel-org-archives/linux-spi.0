From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: [patch 4/4] spi_s3c2410: use generic gpio calls
	instead of arch specific ones
Date: Fri, 10 Oct 2008 11:04:32 +0100
Message-ID: <20081010100455.570621709@fluff.org.uk>
References: <20081010100428.047162446@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline;
	filename=simtec/simtec-s3c24xx-spi-convert-to-generic-gpio.patch
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Change the spi_s3c2410 driver to use the generic gpio calls that
are now available.

Signed-off-by: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>

Index: linux-2.6.27-rc7-quilt2/drivers/spi/spi_s3c24xx.c
===================================================================
--- linux-2.6.27-rc7-quilt2.orig/drivers/spi/spi_s3c24xx.c	2008-09-23 15:03:10.000000000 +0100
+++ linux-2.6.27-rc7-quilt2/drivers/spi/spi_s3c24xx.c	2008-09-23 15:17:18.000000000 +0100
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
+			gpio_direction_output(hw->pdata, 1);
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
+
+		err = gpio_request(pdata->pin_cs, dev_name(&pdev->dev));
+		if (err) {
+			dev_err(&pdev->dev, "Failed to get gpio for cs\n");
+			goto err_register;
+		}
 
-		s3c2410_gpio_setpin(pdata->pin_cs, 1);
-		s3c2410_gpio_cfgpin(pdata->pin_cs, S3C2410_GPIO_OUTPUT);
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
 
Index: linux-2.6.27-rc7-quilt2/arch/arm/mach-s3c2410/include/mach/spi.h
===================================================================
--- linux-2.6.27-rc7-quilt2.orig/arch/arm/mach-s3c2410/include/mach/spi.h	2008-09-23 15:15:50.000000000 +0100
+++ linux-2.6.27-rc7-quilt2/arch/arm/mach-s3c2410/include/mach/spi.h	2008-09-23 15:16:01.000000000 +0100
@@ -14,7 +14,7 @@
 #define __ASM_ARCH_SPI_H __FILE__
 
 struct s3c2410_spi_info {
-	unsigned long		 pin_cs;	/* simple gpio cs */
+	int			 pin_cs;	/* simple gpio cs */
 	unsigned int		 num_cs;	/* total chipselects */
 	int			 bus_num;       /* bus number to use. */
 

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/

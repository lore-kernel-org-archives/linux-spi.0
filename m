From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: [patch 1/4] SPI: Add pin configuration callback
Date: Sun, 12 Oct 2008 16:36:03 +0100
Message-ID: <20081012153725.883171112@fluff.org.uk>
References: <20081012153602.964236456@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org, linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org,
	Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline;
	filename=simtec/simtec-drivers-spi-s3c24xx-gpiosetup.patch
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Add a gpio configuration callback for the s3c24xx SPI driver, as
there are several options depending on the channel and the chip
in use.

This is needed as the controller may not have been setup by the
initial bootloader and the fact that the SPI controller gets
reset over suspend/resume into slave mode but the GPIO function
registers do not.

Signed-off-by: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>

Index: linux-2.6.27-rc1-quilt1/drivers/spi/spi_s3c24xx.c
===================================================================
--- linux-2.6.27-rc1-quilt1.orig/drivers/spi/spi_s3c24xx.c	2008-08-04 11:46:12.000000000 +0100
+++ linux-2.6.27-rc1-quilt1/drivers/spi/spi_s3c24xx.c	2008-08-04 11:46:54.000000000 +0100
@@ -247,6 +247,9 @@ static void s3c24xx_spi_initialsetup(str
 	writeb(0xff, hw->regs + S3C2410_SPPRE);
 	writeb(SPPIN_DEFAULT, hw->regs + S3C2410_SPPIN);
 	writeb(SPCON_DEFAULT, hw->regs + S3C2410_SPCON);
+
+	if (hw->pdata && hw->pdata->gpio_setup)
+		hw->pdata->gpio_setup(hw->pdata, 1);
 }
 
 static int __init s3c24xx_spi_probe(struct platform_device *pdev)
@@ -412,6 +415,9 @@ static int s3c24xx_spi_suspend(struct pl
 {
 	struct s3c24xx_spi *hw = platform_get_drvdata(pdev);
 
+	if (hw->pdata && hw->pdata->gpio_setup)
+		hw->pdata->gpio_setup(hw->pdata, 0);
+
 	clk_disable(hw->clk);
 	return 0;
 }
Index: linux-2.6.27-rc1-quilt1/arch/arm/mach-s3c2410/include/mach/spi.h
===================================================================
--- linux-2.6.27-rc1-quilt1.orig/arch/arm/mach-s3c2410/include/mach/spi.h	2008-08-04 11:45:55.000000000 +0100
+++ linux-2.6.27-rc1-quilt1/arch/arm/mach-s3c2410/include/mach/spi.h	2008-08-04 11:46:13.000000000 +0100
@@ -18,6 +18,7 @@ struct s3c2410_spi_info {
 	unsigned int		 num_cs;	/* total chipselects */
 	int			 bus_num;       /* bus number to use. */
 
+	void (*gpio_setup)(struct s3c2410_spi_info *spi, int enable);
 	void (*set_cs)(struct s3c2410_spi_info *spi, int cs, int pol);
 };
 

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/

From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch 2.6.24-rc8] spi: s3c drivers shouldn't
	care about spi_board_info
Date: Mon, 21 Jan 2008 23:41:06 -0800
Message-ID: <200801212341.07086.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Ben Dooks <ben-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org>
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

The two S3C SPI master drivers got merged without much review, so
I just noticed that they're doing something that the SPI core code
is responsible for, rather than any adapter driver:  they try to
register SPI devices.

This removes that support from those drivers so they act normally.
Interestingly, none of the current boards are affected.  So it's
a net code shrink with no loss of functionality.

Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
I did a test build with the s3c defconfig.  The only problem was
with a missing #define breaking the a.out support.

 drivers/spi/spi_s3c24xx.c      |   12 ------------
 drivers/spi/spi_s3c24xx_gpio.c |   12 ------------
 include/asm/arch/spi-gpio.h    |    6 ------
 include/asm/arch/spi.h         |    6 ------
 4 files changed, 36 deletions(-)

--- at91.orig/drivers/spi/spi_s3c24xx.c	2008-01-21 23:12:01.000000000 -0800
+++ at91/drivers/spi/spi_s3c24xx.c	2008-01-21 23:13:42.000000000 -0800
@@ -237,10 +237,8 @@ static int __init s3c24xx_spi_probe(stru
 {
 	struct s3c24xx_spi *hw;
 	struct spi_master *master;
-	struct spi_board_info *bi;
 	struct resource *res;
 	int err = 0;
-	int i;
 
 	master = spi_alloc_master(&pdev->dev, sizeof(struct s3c24xx_spi));
 	if (master == NULL) {
@@ -348,16 +346,6 @@ static int __init s3c24xx_spi_probe(stru
 		goto err_register;
 	}
 
-	/* register all the devices associated */
-
-	bi = &hw->pdata->board_info[0];
-	for (i = 0; i < hw->pdata->board_size; i++, bi++) {
-		dev_info(hw->dev, "registering %s\n", bi->modalias);
-
-		bi->controller_data = hw;
-		spi_new_device(master, bi);
-	}
-
 	return 0;
 
  err_register:
--- at91.orig/drivers/spi/spi_s3c24xx_gpio.c	2008-01-21 23:12:01.000000000 -0800
+++ at91/drivers/spi/spi_s3c24xx_gpio.c	2008-01-21 23:13:26.000000000 -0800
@@ -100,7 +100,6 @@ static int s3c2410_spigpio_probe(struct 
 	struct spi_master	*master;
 	struct s3c2410_spigpio  *sp;
 	int ret;
-	int i;
 
 	master = spi_alloc_master(&dev->dev, sizeof(struct s3c2410_spigpio));
 	if (master == NULL) {
@@ -143,17 +142,6 @@ static int s3c2410_spigpio_probe(struct 
 	if (ret)
 		goto err_no_bitbang;
 
-	/* register the chips to go with the board */
-
-	for (i = 0; i < sp->info->board_size; i++) {
-		dev_info(&dev->dev, "registering %p: %s\n",
-			 &sp->info->board_info[i],
-			 sp->info->board_info[i].modalias);
-
-		sp->info->board_info[i].controller_data = sp;
-		spi_new_device(master, sp->info->board_info + i);
-	}
-
 	return 0;
 
  err_no_bitbang:
--- at91.orig/include/asm/arch/spi-gpio.h	2008-01-21 23:30:56.000000000 -0800
+++ at91/include/asm/arch/spi-gpio.h	2008-01-21 23:31:59.000000000 -0800
@@ -13,9 +13,6 @@
 #ifndef __ASM_ARCH_SPIGPIO_H
 #define __ASM_ARCH_SPIGPIO_H __FILE__
 
-struct s3c2410_spigpio_info;
-struct spi_board_info;
-
 struct s3c2410_spigpio_info {
 	unsigned long		 pin_clk;
 	unsigned long		 pin_mosi;
@@ -23,9 +20,6 @@ struct s3c2410_spigpio_info {
 
 	int			 bus_num;
 
-	unsigned long		 board_size;
-	struct spi_board_info	*board_info;
-
 	void (*chip_select)(struct s3c2410_spigpio_info *spi, int cs);
 };
 
--- at91.orig/include/asm/arch/spi.h	2008-01-21 23:30:57.000000000 -0800
+++ at91/include/asm/arch/spi.h	2008-01-21 23:31:50.000000000 -0800
@@ -13,15 +13,9 @@
 #ifndef __ASM_ARCH_SPI_H
 #define __ASM_ARCH_SPI_H __FILE__
 
-struct s3c2410_spi_info;
-struct spi_board_info;
-
 struct s3c2410_spi_info {
 	unsigned long		 pin_cs;	/* simple gpio cs */
 
-	unsigned long		 board_size;
-	struct spi_board_info	*board_info;
-
 	void (*set_cs)(struct s3c2410_spi_info *spi, int cs, int pol);
 };
 

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/

From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: [PATCH] SPI: spi_s3c24xx driver bus_num field.
Date: Fri, 11 Apr 2008 15:55:02 +0100
Message-ID: <20080411145552.044877041@fluff.org.uk>
References: <20080411145500.130608954@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: patch-out-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline;
	filename=simtec/simtec-drivers-spi-s3c24xx-busnum.patch
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

Pass the bus number we expect the S3C24XX SPI driver to attach
to via the platform data.

Signed-off-by: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>

Index: linux-2.6.25-rc8-spi/include/asm-arm/arch-s3c2410/spi.h
===================================================================
--- linux-2.6.25-rc8-spi.orig/include/asm-arm/arch-s3c2410/spi.h	2008-04-11 15:25:32.000000000 +0100
+++ linux-2.6.25-rc8-spi/include/asm-arm/arch-s3c2410/spi.h	2008-04-11 15:27:17.000000000 +0100
@@ -19,6 +19,7 @@ struct spi_board_info;
 struct s3c2410_spi_info {
 	unsigned long		 pin_cs;	/* simple gpio cs */
 	unsigned int		 num_cs;	/* total chipselects */
+	int			 bus_num;       /* bus number to use. */
 
 	unsigned long		 board_size;
 	struct spi_board_info	*board_info;
Index: linux-2.6.25-rc8-spi/drivers/spi/spi_s3c24xx.c
===================================================================
--- linux-2.6.25-rc8-spi.orig/drivers/spi/spi_s3c24xx.c	2008-04-11 15:25:32.000000000 +0100
+++ linux-2.6.25-rc8-spi/drivers/spi/spi_s3c24xx.c	2008-04-11 15:27:17.000000000 +0100
@@ -235,6 +235,7 @@ static irqreturn_t s3c24xx_spi_irq(int i
 
 static int __init s3c24xx_spi_probe(struct platform_device *pdev)
 {
+	struct s3c2410_spi_info *pdata;
 	struct s3c24xx_spi *hw;
 	struct spi_master *master;
 	struct spi_board_info *bi;
@@ -253,10 +254,10 @@ static int __init s3c24xx_spi_probe(stru
 	memset(hw, 0, sizeof(struct s3c24xx_spi));
 
 	hw->master = spi_master_get(master);
-	hw->pdata = pdev->dev.platform_data;
+	hw->pdata = pdata = pdev->dev.platform_data;
 	hw->dev = &pdev->dev;
 
-	if (hw->pdata == NULL) {
+	if (pdata == NULL) {
 		dev_err(&pdev->dev, "No platform data supplied\n");
 		err = -ENOENT;
 		goto err_no_pdata;
@@ -268,7 +269,8 @@ static int __init s3c24xx_spi_probe(stru
 	/* setup the master state. */
 
 	master->num_chipselect = hw->pdata->num_cs;
-
+	master->bus_num = pdata->bus_num;
+	
 	/* setup the state for the bitbang driver */
 
 	hw->bitbang.master         = hw->master;
@@ -336,13 +338,13 @@ static int __init s3c24xx_spi_probe(stru
 
 	/* setup any gpio we can */
 
-	if (!hw->pdata->set_cs) {
+	if (!pdata->set_cs) {
 		hw->set_cs = s3c24xx_spi_gpiocs;
 
-		s3c2410_gpio_setpin(hw->pdata->pin_cs, 1);
-		s3c2410_gpio_cfgpin(hw->pdata->pin_cs, S3C2410_GPIO_OUTPUT);
+		s3c2410_gpio_setpin(pdata->pin_cs, 1);
+		s3c2410_gpio_cfgpin(pdata->pin_cs, S3C2410_GPIO_OUTPUT);
 	} else
-		hw->set_cs = hw->pdata->set_cs;
+		hw->set_cs = pdata->set_cs;
 
 	/* register our spi controller */
 

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone

From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: [PATCH] SPI: spi_s3c24xx driver needs to pass
	num_chipselect.
Date: Fri, 11 Apr 2008 15:55:01 +0100
Message-ID: <20080411145551.834933543@fluff.org.uk>
References: <20080411145500.130608954@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: patch-out-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline;
	filename=simtec/simtec-drivers-spi-s3c24xx-fix-numcs.patch
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

The SPI core now expects num_chipselect to be set correctly as
due to added checks on the chip being selected before an
transfer is allowed. This patch adds a num_cs field to the
platform data which needs to be set correctly before adding
the SPI platform device.

Signed-off-by: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>

Index: linux-2.6.25-rc8-spi/drivers/spi/spi_s3c24xx.c
===================================================================
--- linux-2.6.25-rc8-spi.orig/drivers/spi/spi_s3c24xx.c	2008-04-11 15:25:28.000000000 +0100
+++ linux-2.6.25-rc8-spi/drivers/spi/spi_s3c24xx.c	2008-04-11 15:25:32.000000000 +0100
@@ -265,6 +265,10 @@ static int __init s3c24xx_spi_probe(stru
 	platform_set_drvdata(pdev, hw);
 	init_completion(&hw->done);
 
+	/* setup the master state. */
+
+	master->num_chipselect = hw->pdata->num_cs;
+
 	/* setup the state for the bitbang driver */
 
 	hw->bitbang.master         = hw->master;
Index: linux-2.6.25-rc8-spi/include/asm-arm/arch-s3c2410/spi.h
===================================================================
--- linux-2.6.25-rc8-spi.orig/include/asm-arm/arch-s3c2410/spi.h	2008-04-11 15:25:28.000000000 +0100
+++ linux-2.6.25-rc8-spi/include/asm-arm/arch-s3c2410/spi.h	2008-04-11 15:25:32.000000000 +0100
@@ -18,6 +18,7 @@ struct spi_board_info;
 
 struct s3c2410_spi_info {
 	unsigned long		 pin_cs;	/* simple gpio cs */
+	unsigned int		 num_cs;	/* total chipselects */
 
 	unsigned long		 board_size;
 	struct spi_board_info	*board_info;

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone

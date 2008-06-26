From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: [patch 2/2] SPI: Move MOD_ALIAS in spi_s3c24xx
	driver.
Date: Thu, 26 Jun 2008 10:59:05 +0100
Message-ID: <20080626100111.154241038@fluff.org.uk>
References: <20080626095903.388812551@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline;
	filename=simtec/simtec-drivers-spi-s3c24xx-modalias.patch
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

Unite the MODULE_ALIAS() declaration with the rest of
the MODULE_* definitions.

Signed-off-by: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>

Index: linux-2.6.25-quilt3/drivers/spi/spi_s3c24xx.c
===================================================================
--- linux-2.6.25-quilt3.orig/drivers/spi/spi_s3c24xx.c	2008-04-18 11:40:15.000000000 +0100
+++ linux-2.6.25-quilt3/drivers/spi/spi_s3c24xx.c	2008-04-18 11:41:37.000000000 +0100
@@ -424,7 +424,6 @@ static int s3c24xx_spi_resume(struct pla
 #define s3c24xx_spi_resume  NULL
 #endif
 
-MODULE_ALIAS("platform:s3c2410-spi");
 static struct platform_driver s3c24xx_spidrv = {
 	.remove		= __exit_p(s3c24xx_spi_remove),
 	.suspend	= s3c24xx_spi_suspend,
@@ -451,3 +450,4 @@ module_exit(s3c24xx_spi_exit);
 MODULE_DESCRIPTION("S3C24XX SPI Driver");
 MODULE_AUTHOR("Ben Dooks, <ben-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org>");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:s3c2410-spi");

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php

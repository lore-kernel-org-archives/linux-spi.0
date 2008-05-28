From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: SPI: spi_s3c24xx bus_num fixup due to missing
	part of previous	patch
Date: Wed, 28 May 2008 20:01:10 +0100
Message-ID: <20080528190110.GA6578@fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: patch-out-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Tom Walsh <tomw-jOXnU76SZe3OK8mupsKPhw@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
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

The original "Pass the bus number we expect the S3C24XX SPI driver to attach
to via the platform data." [1]  patch was mis-sent, and missed two important
parts of the diff, which was to actually set the bus_num field and add
the relevant field to the platform data.

[1] git commit 50f426b55d919dd017af35bb6a08753d1f262920

Signed-off-by: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>

Index: linux-2.6.25-quilt3/include/asm-arm/arch-s3c2410/spi.h
===================================================================
--- linux-2.6.25-quilt3.orig/include/asm-arm/arch-s3c2410/spi.h	2008-04-18 11:34:07.000000000 +0100
+++ linux-2.6.25-quilt3/include/asm-arm/arch-s3c2410/spi.h	2008-04-18 11:36:15.000000000 +0100
@@ -16,6 +16,7 @@
 struct s3c2410_spi_info {
 	unsigned long		 pin_cs;	/* simple gpio cs */
 	unsigned int		 num_cs;	/* total chipselects */
+	int			 bus_num;       /* bus number to use. */
 
 	void (*set_cs)(struct s3c2410_spi_info *spi, int cs, int pol);
 };
Index: linux-2.6.25-quilt3/drivers/spi/spi_s3c24xx.c
===================================================================
--- linux-2.6.25-quilt3.orig/drivers/spi/spi_s3c24xx.c	2008-04-18 11:36:30.000000000 +0100
+++ linux-2.6.25-quilt3/drivers/spi/spi_s3c24xx.c	2008-04-18 11:39:10.000000000 +0100
@@ -270,6 +270,7 @@ static int __init s3c24xx_spi_probe(stru
 	/* setup the master state. */
 
 	master->num_chipselect = hw->pdata->num_cs;
+	master->bus_num = pdata->bus_num;
 
 	/* setup the state for the bitbang driver */
 

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/

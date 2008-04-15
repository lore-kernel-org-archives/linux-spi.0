From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [patch 2.6.25-rc9 1/3] spi_s3c24xx must
	initialize num_chipselect
Date: Tue, 15 Apr 2008 12:45:40 -0700
Message-ID: <200804151245.40318.david-b@pacbell.net>
References: <200804151056.43830.david-b@pacbell.net>
	<20080415123006.b8e229d6.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20080415123006.b8e229d6.akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
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

From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>

The SPI core now expects num_chipselect to be set correctly as
due to added checks on the chip being selected before an
transfer is allowed. This patch adds a num_cs field to the
platform data which needs to be set correctly before adding
the SPI platform device.

Signed-off-by: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
Matching $TITLE this time...


 drivers/spi/spi_s3c24xx.c          |    4 ++++
 include/asm-arm/arch-s3c2410/spi.h |    1 +
 2 files changed, 5 insertions(+)

--- at91.orig/drivers/spi/spi_s3c24xx.c	2008-04-15 10:30:26.000000000 -0700
+++ at91/drivers/spi/spi_s3c24xx.c	2008-04-15 10:30:28.000000000 -0700
@@ -263,6 +263,10 @@ static int __init s3c24xx_spi_probe(stru
 	platform_set_drvdata(pdev, hw);
 	init_completion(&hw->done);
 
+	/* setup the master state. */
+
+	master->num_chipselect = hw->pdata->num_cs;
+
 	/* setup the state for the bitbang driver */
 
 	hw->bitbang.master         = hw->master;
--- at91.orig/include/asm-arm/arch-s3c2410/spi.h	2008-04-15 10:30:26.000000000 -0700
+++ at91/include/asm-arm/arch-s3c2410/spi.h	2008-04-15 10:30:28.000000000 -0700
@@ -15,6 +15,7 @@
 
 struct s3c2410_spi_info {
 	unsigned long		 pin_cs;	/* simple gpio cs */
+	unsigned int		 num_cs;	/* total chipselects */
 
 	void (*set_cs)(struct s3c2410_spi_info *spi, int cs, int pol);
 };

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone

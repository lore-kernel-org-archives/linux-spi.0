From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch 2.6.26-git] spi_s3c24xx: really assign
	busnum
Date: Sun, 27 Jul 2008 15:40:04 -0700
Message-ID: <200807271540.05120.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
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
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>

The original "Pass the bus number we expect the S3C24XX SPI driver to attach
to via the platform data." [1]  patch was mis-sent, and missed two important
parts of the diff, which was to actually set the bus_num field and add
the relevant field to the platform data.

[1] git commit 50f426b55d919dd017af35bb6a08753d1f262920

Signed-off-by: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
 drivers/spi/spi_s3c24xx.c          |    1 +
 include/asm-arm/arch-s3c2410/spi.h |    1 +
 2 files changed, 2 insertions(+)

--- a/drivers/spi/spi_s3c24xx.c	2008-05-01 12:53:37.000000000 -0700
+++ b/drivers/spi/spi_s3c24xx.c	2008-07-27 15:36:03.000000000 -0700
@@ -270,6 +270,7 @@ static int __init s3c24xx_spi_probe(stru
 	/* setup the master state. */
 
 	master->num_chipselect = hw->pdata->num_cs;
+	master->bus_num = pdata->bus_num;
 
 	/* setup the state for the bitbang driver */
 
--- a/include/asm-arm/arch-s3c2410/spi.h	2008-04-15 21:43:00.000000000 -0700
+++ b/include/asm-arm/arch-s3c2410/spi.h	2008-07-27 15:36:03.000000000 -0700
@@ -16,6 +16,7 @@
 struct s3c2410_spi_info {
 	unsigned long		 pin_cs;	/* simple gpio cs */
 	unsigned int		 num_cs;	/* total chipselects */
+	int			 bus_num;       /* bus number to use. */
 
 	void (*set_cs)(struct s3c2410_spi_info *spi, int cs, int pol);
 };

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/

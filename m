From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: [patch 3/4] spi_s3c24xx_gpio: fix setting of
	num_chipselect.
Date: Fri, 10 Oct 2008 11:04:31 +0100
Message-ID: <20081010100455.281564467@fluff.org.uk>
References: <20081010100428.047162446@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline;
	filename=simtec/simtec-s3c24xx-spi-gpio-fix-numcs.patch
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

The spi master driver must have num_chipselect set to
allow the bus to initialise. Pass this through the
platform data.

Signed-off-by: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>

Index: linux-2.6.27-rc7-quilt2/arch/arm/mach-s3c2410/include/mach/spi-gpio.h
===================================================================
--- linux-2.6.27-rc7-quilt2.orig/arch/arm/mach-s3c2410/include/mach/spi-gpio.h	2008-09-23 14:59:56.000000000 +0100
+++ linux-2.6.27-rc7-quilt2/arch/arm/mach-s3c2410/include/mach/spi-gpio.h	2008-09-23 15:58:03.000000000 +0100
@@ -18,6 +18,7 @@ struct s3c2410_spigpio_info {
 	unsigned long		 pin_mosi;
 	unsigned long		 pin_miso;
 
+	int			 num_chipselect;
 	int			 bus_num;
 
 	void (*chip_select)(struct s3c2410_spigpio_info *spi, int cs);
Index: linux-2.6.27-rc7-quilt2/drivers/spi/spi_s3c24xx_gpio.c
===================================================================
--- linux-2.6.27-rc7-quilt2.orig/drivers/spi/spi_s3c24xx_gpio.c	2008-09-23 15:01:47.000000000 +0100
+++ linux-2.6.27-rc7-quilt2/drivers/spi/spi_s3c24xx_gpio.c	2008-09-23 15:01:47.000000000 +0100
@@ -118,6 +118,7 @@ static int s3c2410_spigpio_probe(struct 
 	/* setup spi bitbang adaptor */
 	sp->bitbang.master = spi_master_get(master);
 	sp->bitbang.master->bus_num = info->bus_num;
+	sp->bitbang.master->num_chipselect = info->num_chipselect;
 	sp->bitbang.chipselect = s3c2410_spigpio_chipselect;
 
 	sp->bitbang.txrx_word[SPI_MODE_0] = s3c2410_spigpio_txrx_mode0;

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/

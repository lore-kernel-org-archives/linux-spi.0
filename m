From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch 2.6.8-rc6 2/3] spi: fix spi_s3c24xx_gpio
	num_chipselect
Date: Sat, 22 Nov 2008 12:19:12 -0800
Message-ID: <200811221219.12473.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
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
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>

The spi master driver must have num_chipselect set to
allow the bus to initialise. Pass this through the
platform data.

Signed-off-by: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
 arch/arm/mach-s3c2410/include/mach/spi-gpio.h |    1 +
 drivers/spi/spi_s3c24xx_gpio.c                |    1 +
 2 files changed, 2 insertions(+)

--- a/arch/arm/mach-s3c2410/include/mach/spi-gpio.h
+++ b/arch/arm/mach-s3c2410/include/mach/spi-gpio.h
@@ -18,6 +18,7 @@ struct s3c2410_spigpio_info {
 	unsigned long		 pin_mosi;
 	unsigned long		 pin_miso;
 
+	int			 num_chipselect;
 	int			 bus_num;
 
 	void (*chip_select)(struct s3c2410_spigpio_info *spi, int cs);
--- a/drivers/spi/spi_s3c24xx_gpio.c
+++ b/drivers/spi/spi_s3c24xx_gpio.c
@@ -118,6 +118,7 @@ static int s3c2410_spigpio_probe(struct 
 	/* setup spi bitbang adaptor */
 	sp->bitbang.master = spi_master_get(master);
 	sp->bitbang.master->bus_num = info->bus_num;
+	sp->bitbang.master->num_chipselect = info->num_chipselect;
 	sp->bitbang.chipselect = s3c2410_spigpio_chipselect;
 
 	sp->bitbang.txrx_word[SPI_MODE_0] = s3c2410_spigpio_txrx_mode0;

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/

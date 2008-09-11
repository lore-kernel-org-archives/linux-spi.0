From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch 2.6.27-rc6] spi_s3c24xx: pin
	configuration updates
Date: Thu, 11 Sep 2008 11:07:38 -0700
Message-ID: <200809111107.39002.david-b@pacbell.net>
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

Add a pin configuration callback for the s3c24xx SPI driver, as
there are several options depending on the channel and the chip
in use.

This is needed as the controller may not have been setup by the
initial bootloader and the fact that the SPI controller gets
reset over suspend/resume into slave mode but the GPIO function
registers do not.

Signed-off-by: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
AFAICT not essential for 2.6.27, but Ben may have better data.

 arch/arm/mach-s3c2410/include/mach/spi.h |    1 +
 drivers/spi/spi_s3c24xx.c                |    6 ++++++
 2 files changed, 7 insertions(+)

--- a/arch/arm/mach-s3c2410/include/mach/spi.h
+++ b/arch/arm/mach-s3c2410/include/mach/spi.h
@@ -18,6 +18,7 @@ struct s3c2410_spi_info {
 	unsigned int		 num_cs;	/* total chipselects */
 	int			 bus_num;       /* bus number to use. */
 
+	void (*gpio_setup)(struct s3c2410_spi_info *spi, int enable);
 	void (*set_cs)(struct s3c2410_spi_info *spi, int cs, int pol);
 };
 
--- a/drivers/spi/spi_s3c24xx.c
+++ b/drivers/spi/spi_s3c24xx.c
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

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/

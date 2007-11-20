From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: S3C2410: Add bus number to SPI GPIO driver
Date: Tue, 20 Nov 2007 12:26:10 +0000
Message-ID: <20071120122610.GA27539@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Vincent Sanders <vince-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org>
To: Linux SPI <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Allow passing a bus number through the platform
data for the S3C2410 SPI GPIO driver

Signed-off-by: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>

diff -urpN -X linux-2.6.24-rc3-spigpio1/Documentation/dontdiff linux-2.6.24-rc3-spigpio1/include/asm-arm/arch-s3c2410/spi-gpio.h linux-2.6.24-rc3-spigpio2/include/asm-arm/arch-s3c2410/spi-gpio.h
--- linux-2.6.24-rc3-spigpio1/include/asm-arm/arch-s3c2410/spi-gpio.h	2007-10-09 21:31:38.000000000 +0100
+++ linux-2.6.24-rc3-spigpio2/include/asm-arm/arch-s3c2410/spi-gpio.h	2007-11-20 12:11:18.000000000 +0000
@@ -21,6 +21,8 @@ struct s3c2410_spigpio_info {
 	unsigned long		 pin_mosi;
 	unsigned long		 pin_miso;
 
+	int			 bus_num;
+
 	unsigned long		 board_size;
 	struct spi_board_info	*board_info;
 
diff -urpN -X linux-2.6.24-rc3-spigpio1/Documentation/dontdiff linux-2.6.24-rc3-spigpio1/drivers/spi/spi_s3c24xx_gpio.c linux-2.6.24-rc3-spigpio2/drivers/spi/spi_s3c24xx_gpio.c
--- linux-2.6.24-rc3-spigpio1/drivers/spi/spi_s3c24xx_gpio.c	2007-11-19 23:32:27.000000000 +0000
+++ linux-2.6.24-rc3-spigpio2/drivers/spi/spi_s3c24xx_gpio.c	2007-11-20 12:12:28.000000000 +0000
@@ -118,6 +118,7 @@ static int s3c2410_spigpio_probe(struct 
 
 	/* setup spi bitbang adaptor */
 	sp->bitbang.master = spi_master_get(master);
+	sp->bitbang.master->bus_num = info->bus_num;
 	sp->bitbang.chipselect = s3c2410_spigpio_chipselect;
 
 	sp->bitbang.txrx_word[SPI_MODE_0] = s3c2410_spigpio_txrx_mode0;

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/

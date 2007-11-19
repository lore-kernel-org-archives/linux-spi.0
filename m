From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: S3C24XX: Ensure we only configure valid GPIOs
Date: Mon, 19 Nov 2007 23:36:58 +0000
Message-ID: <20071119233658.GA8371@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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

If we specify an GPIO which cannot be used for the
purpose, then assume that the GPIO is not to be used
and do not try and configure it. This can be the case
where the SPI bus is TX only.

Signed-off-by: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>

diff -urpN -X linux-2.6.24-rc3/Documentation/dontdiff linux-2.6.24-rc3/drivers/spi/spi_s3c24xx_gpio.c linux-2.6.24-rc3-spigpio1/drivers/spi/spi_s3c24xx_gpio.c
--- linux-2.6.24-rc3/drivers/spi/spi_s3c24xx_gpio.c	2007-10-09 21:31:38.000000000 +0100
+++ linux-2.6.24-rc3-spigpio1/drivers/spi/spi_s3c24xx_gpio.c	2007-11-19 23:32:27.000000000 +0000
@@ -96,6 +96,7 @@ static void s3c2410_spigpio_chipselect(s
 
 static int s3c2410_spigpio_probe(struct platform_device *dev)
 {
+	struct s3c2410_spigpio_info *info;
 	struct spi_master	*master;
 	struct s3c2410_spigpio  *sp;
 	int ret;
@@ -113,7 +114,7 @@ static int s3c2410_spigpio_probe(struct 
 	platform_set_drvdata(dev, sp);
 
 	/* copy in the plkatform data */
-	sp->info = dev->dev.platform_data;
+	info = sp->info = dev->dev.platform_data;
 
 	/* setup spi bitbang adaptor */
 	sp->bitbang.master = spi_master_get(master);
@@ -124,13 +125,18 @@ static int s3c2410_spigpio_probe(struct 
 	sp->bitbang.txrx_word[SPI_MODE_2] = s3c2410_spigpio_txrx_mode2;
 	sp->bitbang.txrx_word[SPI_MODE_3] = s3c2410_spigpio_txrx_mode3;
 
-	/* set state of spi pins */
-	s3c2410_gpio_setpin(sp->info->pin_clk, 0);
-	s3c2410_gpio_setpin(sp->info->pin_mosi, 0);
-
-	s3c2410_gpio_cfgpin(sp->info->pin_clk, S3C2410_GPIO_OUTPUT);
-	s3c2410_gpio_cfgpin(sp->info->pin_mosi, S3C2410_GPIO_OUTPUT);
-	s3c2410_gpio_cfgpin(sp->info->pin_miso, S3C2410_GPIO_INPUT);
+	/* set state of spi pins, always assume that the clock is
+	 * available, but do check the MOSI and MISO. */
+	s3c2410_gpio_setpin(info->pin_clk, 0);
+	s3c2410_gpio_cfgpin(info->pin_clk, S3C2410_GPIO_OUTPUT);
+
+	if (info->pin_mosi < S3C2410_GPH10) {
+		s3c2410_gpio_setpin(info->pin_mosi, 0);
+		s3c2410_gpio_cfgpin(info->pin_mosi, S3C2410_GPIO_OUTPUT);
+	}
+
+	if (info->pin_miso != S3C2410_GPA0 && info->pin_miso < S3C2410_GPH10)
+		s3c2410_gpio_cfgpin(info->pin_miso, S3C2410_GPIO_INPUT);
 
 	ret = spi_bitbang_start(&sp->bitbang);
 	if (ret)

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/

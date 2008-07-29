From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: S3C24XX: Ensure GPIO pins are configure
	properly on init and resume.
Date: Tue, 29 Jul 2008 18:00:53 +0100
Message-ID: <20080729170053.251716620@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline;
	filename=simtec/simtec-drivers-spi-s3c24xx-resume2.patch
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

Add initialisation for the necessary GPIO lines on driver probe and
resume. This is needed as we need to place the GPIO lines into inputs
over suspend as the controller is reset during the resume path and
the initial state is to act as a SPI slave which drivers the MISO
line. With the MISO line driven, there is the likelyhood that the
chip will be driving against the SPI slave device (not all SPI
devices tristate their MISO line when their chipselect is inactive)

Signed-off-by: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>

Index: linux-2.6.26-quilt5/drivers/spi/spi_s3c24xx.c
===================================================================
--- linux-2.6.26-quilt5.orig/drivers/spi/spi_s3c24xx.c	2008-07-29 17:46:06.000000000 +0100
+++ linux-2.6.26-quilt5/drivers/spi/spi_s3c24xx.c	2008-07-29 17:52:01.000000000 +0100
@@ -238,6 +238,8 @@ static irqreturn_t s3c24xx_spi_irq(int i
 
 static void s3c24xx_spi_initialsetup(struct s3c24xx_spi *hw)
 {
+	struct platform_device *pdev = to_platform_device(hw->dev);
+
 	/* for the moment, permanently enable the clock */
 
 	clk_enable(hw->clk);
@@ -247,6 +249,20 @@ static void s3c24xx_spi_initialsetup(str
 	writeb(0xff, hw->regs + S3C2410_SPPRE);
 	writeb(SPPIN_DEFAULT, hw->regs + S3C2410_SPPIN);
 	writeb(SPCON_DEFAULT, hw->regs + S3C2410_SPCON);
+
+	if (pdev->id == 0) {
+		s3c2410_gpio_cfgpin(S3C2410_GPE13, S3C2410_GPE13_SPICLK0);
+		s3c2410_gpio_cfgpin(S3C2410_GPE12, S3C2410_GPE12_SPIMOSI0);
+		s3c2410_gpio_cfgpin(S3C2410_GPE11, S3C2410_GPE11_SPIMISO0);
+		s3c2410_gpio_pullup(S3C2410_GPE11, 0);
+		s3c2410_gpio_pullup(S3C2410_GPE12, 0);
+	} else {
+		s3c2410_gpio_cfgpin(S3C2410_GPG7, S3C2410_GPG7_SPICLK1);
+		s3c2410_gpio_cfgpin(S3C2410_GPG6, S3C2410_GPG6_SPIMOSI1);
+		s3c2410_gpio_cfgpin(S3C2410_GPG5, S3C2410_GPG5_SPIMISO1);
+		s3c2410_gpio_pullup(S3C2410_GPG5, 0);
+		s3c2410_gpio_pullup(S3C2410_GPG6, 0);
+	}
 }
 
 static int __init s3c24xx_spi_probe(struct platform_device *pdev)
@@ -412,6 +428,26 @@ static int s3c24xx_spi_suspend(struct pl
 {
 	struct s3c24xx_spi *hw = platform_get_drvdata(pdev);
 
+	/* Place the gpio associated with the controller into input over
+	 * suspend as on resume the controller is reset and will end up
+	 * as a slave until we reconfigure it in the resume path. This
+	 * means that we cannot allow the controller to drive MISO line
+	 * during this period in case it drives against something on the
+	 * board.
+	 */
+
+	if (pdev->id == 0) {
+		s3c2410_gpio_pullup(S3C2410_GPE12, 1);
+		s3c2410_gpio_pullup(S3C2410_GPE13, 1);
+		s3c2410_gpio_cfgpin(S3C2410_GPE12, S3C2410_GPIO_INPUT);
+		s3c2410_gpio_cfgpin(S3C2410_GPE11, S3C2410_GPIO_INPUT);
+	} else {
+		s3c2410_gpio_pullup(S3C2410_GPG5, 1);
+		s3c2410_gpio_pullup(S3C2410_GPG6, 1);
+		s3c2410_gpio_cfgpin(S3C2410_GPG6, S3C2410_GPIO_INPUT);
+		s3c2410_gpio_cfgpin(S3C2410_GPG5, S3C2410_GPIO_INPUT); 
+	}
+
 	clk_disable(hw->clk);
 	return 0;
 }

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/

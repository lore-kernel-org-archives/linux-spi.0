From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: S3C24XX: Reset register status on resume.
Date: Tue, 29 Jul 2008 18:00:50 +0100
Message-ID: <20080729170050.230518000@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline;
	filename=simtec/simtec-drivers-spi-s3c24xx-resume1.patch
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

Fix the bug in the spi_s3c24xx driver where it does
not reset the registers of the hardware when resuming
from suspend (this block has been reset over suspend).

Signed-off-by: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>

Index: linux-2.6.26-quilt5/drivers/spi/spi_s3c24xx.c
===================================================================
--- linux-2.6.26-quilt5.orig/drivers/spi/spi_s3c24xx.c	2008-07-29 16:09:45.000000000 +0100
+++ linux-2.6.26-quilt5/drivers/spi/spi_s3c24xx.c	2008-07-29 17:26:55.000000000 +0100
@@ -236,6 +236,19 @@ static irqreturn_t s3c24xx_spi_irq(int i
 	return IRQ_HANDLED;
 }
 
+static void s3c24xx_spi_initialsetup(struct s3c24xx_spi *hw)
+{
+	/* for the moment, permanently enable the clock */
+
+	clk_enable(hw->clk);
+
+	/* program defaults into the registers */
+
+	writeb(0xff, hw->regs + S3C2410_SPPRE);
+	writeb(SPPIN_DEFAULT, hw->regs + S3C2410_SPPIN);
+	writeb(SPCON_DEFAULT, hw->regs + S3C2410_SPCON);
+}
+
 static int __init s3c24xx_spi_probe(struct platform_device *pdev)
 {
 	struct s3c2410_spi_info *pdata;
@@ -327,15 +340,7 @@ static int __init s3c24xx_spi_probe(stru
 		goto err_no_clk;
 	}
 
-	/* for the moment, permanently enable the clock */
-
-	clk_enable(hw->clk);
-
-	/* program defaults into the registers */
-
-	writeb(0xff, hw->regs + S3C2410_SPPRE);
-	writeb(SPPIN_DEFAULT, hw->regs + S3C2410_SPPIN);
-	writeb(SPCON_DEFAULT, hw->regs + S3C2410_SPCON);
+	s3c24xx_spi_initialsetup(hw);
 
 	/* setup any gpio we can */
 
@@ -415,7 +420,7 @@ static int s3c24xx_spi_resume(struct pla
 {
 	struct s3c24xx_spi *hw = platform_get_drvdata(pdev);
 
-	clk_enable(hw->clk);
+	s3c24xx_spi_initialsetup(hw);
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

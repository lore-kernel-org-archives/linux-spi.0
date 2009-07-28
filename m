From: Ben Dooks <ben-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org>
Subject: [patch 2/6] spi_s3c24xx: fix clock rate
	calculation
Date: Tue, 28 Jul 2009 21:51:39 +0100
Message-ID: <20090728205238.814309505@fluff.org>
References: <20090728205137.613851078@fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline; filename=spi-fix-buad-generation.patch
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Currently the clock rate calculation may round as pleased, which
means that it is possible that we will round down and end up with
a faster clock rate than intended.

Change the calculation to use DIV_ROUND_UP() to ensure that we
end up with a clock rate either the same as or lower than the
user requested one.

Signed-off-by: Ben Dooks <ben-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org>

---
 drivers/spi/spi_s3c24xx.c |   17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

Index: b/drivers/spi/spi_s3c24xx.c
===================================================================
--- a/drivers/spi/spi_s3c24xx.c	2009-07-14 13:56:07.000000000 +0100
+++ b/drivers/spi/spi_s3c24xx.c	2009-07-14 14:08:45.000000000 +0100
@@ -111,6 +111,7 @@ static int s3c24xx_spi_setupxfer(struct 
 	unsigned int bpw;
 	unsigned int hz;
 	unsigned int div;
+	unsigned long clk;
 
 	bpw = t ? t->bits_per_word : spi->bits_per_word;
 	hz  = t ? t->speed_hz : spi->max_speed_hz;
@@ -120,20 +121,16 @@ static int s3c24xx_spi_setupxfer(struct 
 		return -EINVAL;
 	}
 
-	div = clk_get_rate(hw->clk) / hz;
-
-	/* is clk = pclk / (2 * (pre+1)), or is it
-	 *    clk = (pclk * 2) / ( pre + 1) */
-
-	div /= 2;
-
-	if (div > 0)
-		div -= 1;
+	clk = clk_get_rate(hw->clk);
+	div = DIV_ROUND_UP(clk, hz * 2) - 1;
 
 	if (div > 255)
 		div = 255;
 
-	dev_dbg(&spi->dev, "setting pre-scaler to %d (hz %d)\n", div, hz);
+	dev_dbg(&spi->dev, "setting pre-scaler to %d (wanted %d, got %ld)\n",
+		div, hz, clk / (2 * (div + 1)));
+
+
 	writeb(div, hw->regs + S3C2410_SPPRE);
 
 	spin_lock(&hw->bitbang.lock);

-- 

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july

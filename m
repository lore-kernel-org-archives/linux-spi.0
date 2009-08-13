From: Ben Dooks <ben@simtec.co.uk>
Subject: [patch 2/7] spi_s3c24xx: fix clock rate calculation
Date: Thu, 13 Aug 2009 11:06:04 +0100
Message-ID: <20090813100638.423180765@fluff.org>
References: <20090813100602.545180197@fluff.org>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org
To: spi-devel-general@lists.sourceforge.net,
	dbrownell@users.sourceforge.ne
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754095AbZHMKBt@vger.kernel.org>
Content-Disposition: inline; filename=spi-fix-buad-generation.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Currently the clock rate calculation may round as pleased, which
means that it is possible that we will round down and end up with
a faster clock rate than intended.

Change the calculation to use DIV_ROUND_UP() to ensure that we
end up with a clock rate either the same as or lower than the
user requested one.

Signed-off-by: Ben Dooks <ben@simtec.co.uk>

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

From: Ben Dooks <ben-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org>
Subject: [patch 3/6] spi_s3c24xx; Fix transfer setup code
Date: Tue, 28 Jul 2009 21:51:40 +0100
Message-ID: <20090728205239.275031472@fluff.org>
References: <20090728205137.613851078@fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline; filename=spi-fix-bitperword.patch
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Since the changes to the bitbang driver, there is the possibility we
will be called with either the speed_hz or bpw values zero. We take
these to mean that the default values (8 bits per word, or maximum
bus speed).

Signed-off-by: Ben Dooks <ben-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org>

---

Index: b/drivers/spi/spi_s3c24xx.c
===================================================================
--- a/drivers/spi/spi_s3c24xx.c	2009-07-27 18:55:16.000000000 +0100
+++ b/drivers/spi/spi_s3c24xx.c	2009-07-27 18:56:08.000000000 +0100
@@ -116,6 +116,12 @@ static int s3c24xx_spi_setupxfer(struct 
 	bpw = t ? t->bits_per_word : spi->bits_per_word;
 	hz  = t ? t->speed_hz : spi->max_speed_hz;
 
+	if (!bpw)
+		bpw = 8;
+
+	if (!hz)
+		hz = spi->max_speed_hz;
+
 	if (bpw != 8) {
 		dev_err(&spi->dev, "invalid bits-per-word (%d)\n", bpw);
 		return -EINVAL;

-- 

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july

From: H Hartley Sweeten <hartleys-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
Subject: [PATCH v2 08/11] spi: spi-ep93xx: don't bother calculating the
	divisors in ep93xx_spi_setup()
Date: Tue, 2 Jul 2013 10:10:00 -0700
Message-ID: <201307021010.00977.hartleys@visionengravers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Ryan Mallon <rmallon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, mika.westerberg-X3B1VOXEql0@public.gmane.org,
	hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Linux Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
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

The divisors needed to generate the SPI clock are calculated per
transfer based on the t->speed_hz. There is no reason to calculate
them in ep93xx_spi_setup().

Signed-off-by: H Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
Acked-by: Mika Westerberg <mika.westerberg-X3B1VOXEql0@public.gmane.org>
Cc: Ryan Mallon <rmallon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-ep93xx.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
index cc2a240..6cdfc40 100644
--- a/drivers/spi/spi-ep93xx.c
+++ b/drivers/spi/spi-ep93xx.c
@@ -136,7 +136,6 @@ struct ep93xx_spi {
 /**
  * struct ep93xx_spi_chip - SPI device hardware settings
  * @spi: back pointer to the SPI device
- * @rate: max rate in hz this chip supports
  * @div_cpsr: cpsr (pre-scaler) divider
  * @div_scr: scr divider
  * @ops: private chip operations
@@ -147,7 +146,6 @@ struct ep93xx_spi {
  */
 struct ep93xx_spi_chip {
 	const struct spi_device		*spi;
-	unsigned long			rate;
 	u8				div_cpsr;
 	u8				div_scr;
 	struct ep93xx_spi_chip_ops	*ops;
@@ -315,18 +313,6 @@ static int ep93xx_spi_setup(struct spi_device *spi)
 		spi_set_ctldata(spi, chip);
 	}
 
-	if (spi->max_speed_hz != chip->rate) {
-		int err;
-
-		err = ep93xx_spi_calc_divisors(espi, chip, spi->max_speed_hz);
-		if (err != 0) {
-			spi_set_ctldata(spi, NULL);
-			kfree(chip);
-			return err;
-		}
-		chip->rate = spi->max_speed_hz;
-	}
-
 	ep93xx_spi_cs_control(spi, false);
 	return 0;
 }
-- 
1.8.1.4


------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev

From: H Hartley Sweeten <hartleys-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
Subject: [PATCH v2 07/11] spi: spi-ep93xx: remove 'dss' from per chip private
	data
Date: Tue, 2 Jul 2013 10:09:29 -0700
Message-ID: <201307021009.30230.hartleys@visionengravers.com>
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

This value is only needed to set the bits per word for each transfer
of a message. There is no reason to set the value in ep93xx_spi_enable()
because ep93xx_spi_process_transfer() sets it again for each transfer.

Just pass the t->bits_per_word directly to ep93xx_spi_chip_setup() in
ep93xx_spi_process_transfer() and remove 'dss' from the per chip private
data.

Signed-off-by: H Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
Cc: Ryan Mallon <rmallon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mika Westerberg <mika.westerberg-X3B1VOXEql0@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-ep93xx.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
index 34aade1..cc2a240 100644
--- a/drivers/spi/spi-ep93xx.c
+++ b/drivers/spi/spi-ep93xx.c
@@ -139,7 +139,6 @@ struct ep93xx_spi {
  * @rate: max rate in hz this chip supports
  * @div_cpsr: cpsr (pre-scaler) divider
  * @div_scr: scr divider
- * @dss: bits per word (4 - 16 bits)
  * @ops: private chip operations
  *
  * This structure is used to store hardware register specific settings for each
@@ -151,7 +150,6 @@ struct ep93xx_spi_chip {
 	unsigned long			rate;
 	u8				div_cpsr;
 	u8				div_scr;
-	u8				dss;
 	struct ep93xx_spi_chip_ops	*ops;
 };
 
@@ -329,8 +327,6 @@ static int ep93xx_spi_setup(struct spi_device *spi)
 		chip->rate = spi->max_speed_hz;
 	}
 
-	chip->dss = bits_per_word_to_dss(spi->bits_per_word);
-
 	ep93xx_spi_cs_control(spi, false);
 	return 0;
 }
@@ -407,22 +403,25 @@ static void ep93xx_spi_cleanup(struct spi_device *spi)
  * ep93xx_spi_chip_setup() - configures hardware according to given @chip
  * @espi: ep93xx SPI controller struct
  * @chip: chip specific settings
+ * @bits_per_word: transfer bits_per_word
  *
  * This function sets up the actual hardware registers with settings given in
  * @chip. Note that no validation is done so make sure that callers validate
  * settings before calling this.
  */
 static void ep93xx_spi_chip_setup(const struct ep93xx_spi *espi,
-				  const struct ep93xx_spi_chip *chip)
+				  const struct ep93xx_spi_chip *chip,
+				  u8 bits_per_word)
 {
+	u8 dss = bits_per_word_to_dss(bits_per_word);
 	u16 cr0;
 
 	cr0 = chip->div_scr << SSPCR0_SCR_SHIFT;
 	cr0 |= (chip->spi->mode & (SPI_CPHA|SPI_CPOL)) << SSPCR0_MODE_SHIFT;
-	cr0 |= chip->dss;
+	cr0 |= dss;
 
 	dev_dbg(&espi->pdev->dev, "setup: mode %d, cpsr %d, scr %d, dss %d\n",
-		chip->spi->mode, chip->div_cpsr, chip->div_scr, chip->dss);
+		chip->spi->mode, chip->div_cpsr, chip->div_scr, dss);
 	dev_dbg(&espi->pdev->dev, "setup: cr0 %#x", cr0);
 
 	ep93xx_spi_write_u8(espi, SSPCPSR, chip->div_cpsr);
@@ -709,9 +708,7 @@ static void ep93xx_spi_process_transfer(struct ep93xx_spi *espi,
 		return;
 	}
 
-	chip->dss = bits_per_word_to_dss(t->bits_per_word);
-
-	ep93xx_spi_chip_setup(espi, chip);
+	ep93xx_spi_chip_setup(espi, chip, t->bits_per_word);
 
 	espi->rx = 0;
 	espi->tx = 0;
-- 
1.8.1.4


------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev

From: H Hartley Sweeten <hartleys-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
Subject: [PATCH 5/8] spi: spi-ep93xx: remove 'dss' from per chip private data
Date: Fri, 28 Jun 2013 11:44:33 -0700
Message-ID: <201306281144.34074.hartleys@visionengravers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	mika.westerberg-X3B1VOXEql0@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Ryan Mallon <rmallon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
 drivers/spi/spi-ep93xx.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
index 4fab3bb..cb22c89 100644
--- a/drivers/spi/spi-ep93xx.c
+++ b/drivers/spi/spi-ep93xx.c
@@ -140,7 +140,6 @@ struct ep93xx_spi {
  * @rate: max rate in hz this chip supports
  * @div_cpsr: cpsr (pre-scaler) divider
  * @div_scr: scr divider
- * @dss: bits per word (4 - 16 bits)
  * @ops: private chip operations
  *
  * This structure is used to store hardware register specific settings for each
@@ -152,13 +151,9 @@ struct ep93xx_spi_chip {
 	unsigned long			rate;
 	u8				div_cpsr;
 	u8				div_scr;
-	u8				dss;
 	struct ep93xx_spi_chip_ops	*ops;
 };
 
-/* converts bits per word to CR0.DSS value */
-#define bits_per_word_to_dss(bpw)	((bpw) - 1)
-
 static int ep93xx_spi_enable(const struct ep93xx_spi *espi)
 {
 	u8 regval;
@@ -308,8 +303,6 @@ static int ep93xx_spi_setup(struct spi_device *spi)
 		chip->rate = spi->max_speed_hz;
 	}
 
-	chip->dss = bits_per_word_to_dss(spi->bits_per_word);
-
 	ep93xx_spi_cs_control(spi, false);
 	return 0;
 }
@@ -386,22 +379,25 @@ static void ep93xx_spi_cleanup(struct spi_device *spi)
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
 	u16 cr0;
 
 	cr0 = chip->div_scr << SSPCR0_SCR_SHIFT;
 	cr0 |= (chip->spi->mode & (SPI_CPHA|SPI_CPOL)) << SSPCR0_MODE_SHIFT;
-	cr0 |= chip->dss;
+	cr0 |= (bits_per_word - 1);
 
 	dev_dbg(&espi->pdev->dev, "setup: mode %d, cpsr %d, scr %d, dss %d\n",
-		chip->spi->mode, chip->div_cpsr, chip->div_scr, chip->dss);
+		chip->spi->mode, chip->div_cpsr, chip->div_scr,
+		bits_per_word - 1);
 	dev_dbg(&espi->pdev->dev, "setup: cr0 %#x", cr0);
 
 	writeb(chip->div_cpsr, espi->regs_base + SSPCPSR);
@@ -688,9 +684,7 @@ static void ep93xx_spi_process_transfer(struct ep93xx_spi *espi,
 		return;
 	}
 
-	chip->dss = bits_per_word_to_dss(t->bits_per_word);
-
-	ep93xx_spi_chip_setup(espi, chip);
+	ep93xx_spi_chip_setup(espi, chip, t->bits_per_word);
 
 	espi->word_xfer = (t->bits_per_word > 8) ? true : false;
 	espi->rx = 0;
-- 
1.8.1.4


------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev

From: H Hartley Sweeten <hartleys-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
Subject: [PATCH v2 09/11] spi: spi-ep93xx: move the clock divider calcs into
	ep93xx_spi_chip_setup()
Date: Tue, 2 Jul 2013 10:10:29 -0700
Message-ID: <201307021010.30326.hartleys@visionengravers.com>
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

The divider values stored in the per chip data are only used to set the
registers in the hardware to generate the desired SPI clock. Since these
are calculated per transfer based on the t->speed_hz there is no reason
keep them in the per chip data.

Move the ep93xx_spi_calc_divisors() call into ep93xx_spi_chip_setup()
and return the dividers thru pointers. Remove the divider values from
the per chip data structure.

Signed-off-by: H Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
Acked-by: Mika Westerberg <mika.westerberg-X3B1VOXEql0@public.gmane.org>
Cc: Ryan Mallon <rmallon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-ep93xx.c | 57 +++++++++++++++++++++---------------------------
 1 file changed, 25 insertions(+), 32 deletions(-)

diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
index 6cdfc40..2e64806 100644
--- a/drivers/spi/spi-ep93xx.c
+++ b/drivers/spi/spi-ep93xx.c
@@ -136,18 +136,10 @@ struct ep93xx_spi {
 /**
  * struct ep93xx_spi_chip - SPI device hardware settings
  * @spi: back pointer to the SPI device
- * @div_cpsr: cpsr (pre-scaler) divider
- * @div_scr: scr divider
  * @ops: private chip operations
- *
- * This structure is used to store hardware register specific settings for each
- * SPI device. Settings are written to hardware by function
- * ep93xx_spi_chip_setup().
  */
 struct ep93xx_spi_chip {
 	const struct spi_device		*spi;
-	u8				div_cpsr;
-	u8				div_scr;
 	struct ep93xx_spi_chip_ops	*ops;
 };
 
@@ -224,17 +216,13 @@ static void ep93xx_spi_disable_interrupts(const struct ep93xx_spi *espi)
 /**
  * ep93xx_spi_calc_divisors() - calculates SPI clock divisors
  * @espi: ep93xx SPI controller struct
- * @chip: divisors are calculated for this chip
  * @rate: desired SPI output clock rate
- *
- * Function calculates cpsr (clock pre-scaler) and scr divisors based on
- * given @rate and places them to @chip->div_cpsr and @chip->div_scr. If,
- * for some reason, divisors cannot be calculated nothing is stored and
- * %-EINVAL is returned.
+ * @div_cpsr: pointer to return the cpsr (pre-scaler) divider
+ * @div_scr: pointer to return the scr divider
  */
 static int ep93xx_spi_calc_divisors(const struct ep93xx_spi *espi,
-				    struct ep93xx_spi_chip *chip,
-				    unsigned long rate)
+				    unsigned long rate,
+				    u8 *div_cpsr, u8 *div_scr)
 {
 	unsigned long spi_clk_rate = clk_get_rate(espi->clk);
 	int cpsr, scr;
@@ -257,8 +245,8 @@ static int ep93xx_spi_calc_divisors(const struct ep93xx_spi *espi,
 	for (cpsr = 2; cpsr <= 254; cpsr += 2) {
 		for (scr = 0; scr <= 255; scr++) {
 			if ((spi_clk_rate / (cpsr * (scr + 1))) <= rate) {
-				chip->div_scr = (u8)scr;
-				chip->div_cpsr = (u8)cpsr;
+				*div_scr = (u8)scr;
+				*div_cpsr = (u8)cpsr;
 				return 0;
 			}
 		}
@@ -389,29 +377,35 @@ static void ep93xx_spi_cleanup(struct spi_device *spi)
  * ep93xx_spi_chip_setup() - configures hardware according to given @chip
  * @espi: ep93xx SPI controller struct
  * @chip: chip specific settings
+ * @speed_hz: transfer speed
  * @bits_per_word: transfer bits_per_word
- *
- * This function sets up the actual hardware registers with settings given in
- * @chip. Note that no validation is done so make sure that callers validate
- * settings before calling this.
  */
-static void ep93xx_spi_chip_setup(const struct ep93xx_spi *espi,
-				  const struct ep93xx_spi_chip *chip,
-				  u8 bits_per_word)
+static int ep93xx_spi_chip_setup(const struct ep93xx_spi *espi,
+				 const struct ep93xx_spi_chip *chip,
+				 u32 speed_hz, u8 bits_per_word)
 {
 	u8 dss = bits_per_word_to_dss(bits_per_word);
+	u8 div_cpsr = 0;
+	u8 div_scr = 0;
 	u16 cr0;
+	int err;
+
+	err = ep93xx_spi_calc_divisors(espi, speed_hz, &div_cpsr, &div_scr);
+	if (err)
+		return err;
 
-	cr0 = chip->div_scr << SSPCR0_SCR_SHIFT;
+	cr0 = div_scr << SSPCR0_SCR_SHIFT;
 	cr0 |= (chip->spi->mode & (SPI_CPHA|SPI_CPOL)) << SSPCR0_MODE_SHIFT;
 	cr0 |= dss;
 
 	dev_dbg(&espi->pdev->dev, "setup: mode %d, cpsr %d, scr %d, dss %d\n",
-		chip->spi->mode, chip->div_cpsr, chip->div_scr, dss);
+		chip->spi->mode, div_cpsr, div_scr, dss);
 	dev_dbg(&espi->pdev->dev, "setup: cr0 %#x", cr0);
 
-	ep93xx_spi_write_u8(espi, SSPCPSR, chip->div_cpsr);
+	ep93xx_spi_write_u8(espi, SSPCPSR, div_cpsr);
 	ep93xx_spi_write_u16(espi, SSPCR0, cr0);
+
+	return 0;
 }
 
 static void ep93xx_do_write(struct ep93xx_spi *espi, struct spi_transfer *t)
@@ -687,15 +681,14 @@ static void ep93xx_spi_process_transfer(struct ep93xx_spi *espi,
 
 	msg->state = t;
 
-	err = ep93xx_spi_calc_divisors(espi, chip, t->speed_hz);
+	err = ep93xx_spi_chip_setup(espi, chip, t->speed_hz, t->bits_per_word);
 	if (err) {
-		dev_err(&espi->pdev->dev, "failed to adjust speed\n");
+		dev_err(&espi->pdev->dev,
+			"failed to setup chip for transfer\n");
 		msg->status = err;
 		return;
 	}
 
-	ep93xx_spi_chip_setup(espi, chip, t->bits_per_word);
-
 	espi->rx = 0;
 	espi->tx = 0;
 
-- 
1.8.1.4


------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev

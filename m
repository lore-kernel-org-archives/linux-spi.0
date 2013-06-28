From: H Hartley Sweeten <hartleys@visionengravers.com>
Subject: [PATCH 6/8] spi: spi-ep93xx: don't bother calculating the divisors in ep93xx_spi_setup()
Date: Fri, 28 Jun 2013 11:45:02 -0700
Message-ID: <201306281145.02815.hartleys@visionengravers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: <spi-devel-general@lists.sourceforge.net>,
	Ryan Mallon <rmallon@gmail.com>, <mika.westerberg@iki.fi>,
	<broonie@kernel.org>, <grant.likely@linaro.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The divisors needed to generate the SPI clock are calculated per
transfer based on the t->speed_hz. There is no reason to calculate
them in ep93xx_spi_setup().

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Ryan Mallon <rmallon@gmail.com>
Cc: Mika Westerberg <mika.westerberg@iki.fi>
Cc: Mark Brown <broonie@kernel.org>
Cc: Grant Likely <grant.likely@linaro.org>
---
 drivers/spi/spi-ep93xx.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
index cb22c89..2f2d51a 100644
--- a/drivers/spi/spi-ep93xx.c
+++ b/drivers/spi/spi-ep93xx.c
@@ -137,7 +137,6 @@ struct ep93xx_spi {
 /**
  * struct ep93xx_spi_chip - SPI device hardware settings
  * @spi: back pointer to the SPI device
- * @rate: max rate in hz this chip supports
  * @div_cpsr: cpsr (pre-scaler) divider
  * @div_scr: scr divider
  * @ops: private chip operations
@@ -148,7 +147,6 @@ struct ep93xx_spi {
  */
 struct ep93xx_spi_chip {
 	const struct spi_device		*spi;
-	unsigned long			rate;
 	u8				div_cpsr;
 	u8				div_scr;
 	struct ep93xx_spi_chip_ops	*ops;
@@ -291,18 +289,6 @@ static int ep93xx_spi_setup(struct spi_device *spi)
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

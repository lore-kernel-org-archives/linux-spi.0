From: H Hartley Sweeten <hartleys@visionengravers.com>
Subject: [PATCH v2 01/11] spi: spi-ep93xx: always handle transfer specific settings
Date: Tue, 2 Jul 2013 10:05:34 -0700
Message-ID: <201307021005.34628.hartleys@visionengravers.com>
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

__spi_async(), which starts every SPI message transfer, initializes
the bits_per_word and max speed for every transfer in the message.
Since the conditional test in ep93xx_spi_process_transfer() will
always succeed just remove it and always call ep93xx_spi_chip_setup()
to configure the hardware for each transfer in the message.

Remove the redundant ep93xx_spi_chp_setup() in ep93xx_spi_process_transfer()
which just initializes the hardware to the "default" based on the SPI
device.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Ryan Mallon <rmallon@gmail.com>
Cc: Mika Westerberg <mika.westerberg@iki.fi>
Cc: Mark Brown <broonie@kernel.org>
Cc: Grant Likely <grant.likely@linaro.org>
---
 drivers/spi/spi-ep93xx.c | 43 ++++++++++---------------------------------
 1 file changed, 10 insertions(+), 33 deletions(-)

diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
index cad30b8..11e2b99 100644
--- a/drivers/spi/spi-ep93xx.c
+++ b/drivers/spi/spi-ep93xx.c
@@ -708,38 +708,20 @@ static void ep93xx_spi_process_transfer(struct ep93xx_spi *espi,
 					struct spi_transfer *t)
 {
 	struct ep93xx_spi_chip *chip = spi_get_ctldata(msg->spi);
+	int err;
 
 	msg->state = t;
 
-	/*
-	 * Handle any transfer specific settings if needed. We use
-	 * temporary chip settings here and restore original later when
-	 * the transfer is finished.
-	 */
-	if (t->speed_hz || t->bits_per_word) {
-		struct ep93xx_spi_chip tmp_chip = *chip;
-
-		if (t->speed_hz) {
-			int err;
-
-			err = ep93xx_spi_calc_divisors(espi, &tmp_chip,
-						       t->speed_hz);
-			if (err) {
-				dev_err(&espi->pdev->dev,
-					"failed to adjust speed\n");
-				msg->status = err;
-				return;
-			}
-		}
+	err = ep93xx_spi_calc_divisors(espi, chip, t->speed_hz);
+	if (err) {
+		dev_err(&espi->pdev->dev, "failed to adjust speed\n");
+		msg->status = err;
+		return;
+	}
 
-		if (t->bits_per_word)
-			tmp_chip.dss = bits_per_word_to_dss(t->bits_per_word);
+	chip->dss = bits_per_word_to_dss(t->bits_per_word);
 
-		/*
-		 * Set up temporary new hw settings for this transfer.
-		 */
-		ep93xx_spi_chip_setup(espi, &tmp_chip);
-	}
+	ep93xx_spi_chip_setup(espi, chip);
 
 	espi->rx = 0;
 	espi->tx = 0;
@@ -783,9 +765,6 @@ static void ep93xx_spi_process_transfer(struct ep93xx_spi *espi,
 			ep93xx_spi_cs_control(msg->spi, true);
 		}
 	}
-
-	if (t->speed_hz || t->bits_per_word)
-		ep93xx_spi_chip_setup(espi, chip);
 }
 
 /*
@@ -838,10 +817,8 @@ static void ep93xx_spi_process_message(struct ep93xx_spi *espi,
 	espi->fifo_level = 0;
 
 	/*
-	 * Update SPI controller registers according to spi device and assert
-	 * the chipselect.
+	 * Assert the chipselect.
 	 */
-	ep93xx_spi_chip_setup(espi, spi_get_ctldata(msg->spi));
 	ep93xx_spi_cs_control(msg->spi, true);
 
 	list_for_each_entry(t, &msg->transfers, transfer_list) {
-- 
1.8.1.4

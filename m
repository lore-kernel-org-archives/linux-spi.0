From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: atmel: Remove and fix erroneous comments" to the spi tree
Date: Fri, 18 Oct 2019 19:07:09 +0100 (BST)
Message-ID: <20191018180709.17FD42743259@ypsilon.sirena.org.uk>
References: <20191017141846.7523-2-gregory.clement@bootlin.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: Gregory CLEMENT <gregory.clement@bootlin.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191017141846.7523-2-gregory.clement@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: atmel: Remove and fix erroneous comments

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.5

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 4d8672d17450b457c0dbbcfe9868438036b4647c Mon Sep 17 00:00:00 2001
From: Gregory CLEMENT <gregory.clement@bootlin.com>
Date: Thu, 17 Oct 2019 16:18:40 +0200
Subject: [PATCH] spi: atmel: Remove and fix erroneous comments

Since CSAAT functionality support has been added. Some comments become
wrong. Fix them to match the current driver behavior.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Link: https://lore.kernel.org/r/20191017141846.7523-2-gregory.clement@bootlin.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-atmel.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index e34ab587b980..7a17c3e2a8ee 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -312,11 +312,9 @@ static bool atmel_spi_is_v2(struct atmel_spi *as)
  * transmitted")  Not so!  Workaround uses nCSx pins as GPIOs; or newer
  * controllers have CSAAT and friends.
  *
- * Since the CSAAT functionality is a bit weird on newer controllers as
- * well, we use GPIO to control nCSx pins on all controllers, updating
- * MR.PCS to avoid confusing the controller.  Using GPIOs also lets us
- * support active-high chipselects despite the controller's belief that
- * only active-low devices/systems exists.
+ * Even controller newer than ar91rm9200, using GPIOs can make sens as
+ * it lets us support active-high chipselects despite the controller's
+ * belief that only active-low devices/systems exists.
  *
  * However, at91rm9200 has a second erratum whereby nCS0 doesn't work
  * right when driven with GPIO.  ("Mode Fault does not allow more than one
@@ -1193,8 +1191,6 @@ static int atmel_spi_setup(struct spi_device *spi)
 	if (!as->use_cs_gpios)
 		csr |= SPI_BIT(CSAAT);
 
-	/* DLYBS is mostly irrelevant since we manage chipselect using GPIOs.
-	 */
 	csr |= SPI_BF(DLYBS, 0);
 
 	word_delay_csr = atmel_word_delay_csr(spi, as);
-- 
2.20.1

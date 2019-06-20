From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: fix ctrl->num_chipselect constraint" to the spi tree
Date: Thu, 20 Jun 2019 14:32:36 +0100 (BST)
Message-ID: <20190620133236.B1610440046@finisterre.sirena.org.uk>
References: <20190619143820.4045-1-tudor.ambarus@microchip.com>
Cc: broonie@kernel.org, linus.walleij@linaro.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, Nicolas.Ferre@microchip.com,
        Tudor.Ambarus@microchip.com
To: Tudor Ambarus <tudor.ambarus@microchip.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190619143820.4045-1-tudor.ambarus@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: fix ctrl->num_chipselect constraint

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.3

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

>From f9481b08220d7dc1ff21e296a330ee8b721b44e4 Mon Sep 17 00:00:00 2001
From: Tudor Ambarus <tudor.ambarus@microchip.com>
Date: Wed, 19 Jun 2019 14:38:28 +0000
Subject: [PATCH] spi: fix ctrl->num_chipselect constraint

at91sam9g25ek showed the following error at probe:
atmel_spi f0000000.spi: Using dma0chan2 (tx) and dma0chan3 (rx)
for DMA transfers
atmel_spi: probe of f0000000.spi failed with error -22

Commit 0a919ae49223 ("spi: Don't call spi_get_gpio_descs() before device name is set")
moved the calling of spi_get_gpio_descs() after ctrl->dev is set,
but didn't move the !ctrl->num_chipselect check. When there are
chip selects in the device tree, the spi-atmel driver lets the
SPI core discover them when registering the SPI master.
The ctrl->num_chipselect is thus expected to be set by
spi_get_gpio_descs().

Move the !ctlr->num_chipselect after spi_get_gpio_descs() as it was
before the aforementioned commit. While touching this block, get rid
of the explicit comparison with 0 and update the commenting style.

Fixes: 0a919ae49223 ("spi: Don't call spi_get_gpio_descs() before device name is set")
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index a31e1e291335..80d2d14f6294 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2375,11 +2375,6 @@ int spi_register_controller(struct spi_controller *ctlr)
 	if (status)
 		return status;
 
-	/* even if it's just one always-selected device, there must
-	 * be at least one chipselect
-	 */
-	if (ctlr->num_chipselect == 0)
-		return -EINVAL;
 	if (ctlr->bus_num >= 0) {
 		/* devices with a fixed bus num must check-in with the num */
 		mutex_lock(&board_lock);
@@ -2450,6 +2445,13 @@ int spi_register_controller(struct spi_controller *ctlr)
 		}
 	}
 
+	/*
+	 * Even if it's just one always-selected device, there must
+	 * be at least one chipselect.
+	 */
+	if (!ctlr->num_chipselect)
+		return -EINVAL;
+
 	status = device_add(&ctlr->dev);
 	if (status < 0) {
 		/* free bus id */
-- 
2.20.1

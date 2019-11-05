From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: bcm2835: fix typo in comment" to the spi tree
Date: Tue,  5 Nov 2019 23:51:29 +0000 (GMT)
Message-ID: <20191105235129.9DAE12741915@ypsilon.sirena.org.uk>
References: <20191105214134.25142-1-chris.packham@alliedtelesis.co.nz>
Cc: broonie@kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        trivial@kernel.org
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191105214134.25142-1-chris.packham@alliedtelesis.co.nz>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: bcm2835: fix typo in comment

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.4

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

>From c2f102f1e884fe1a6a54c36f232e560675657f12 Mon Sep 17 00:00:00 2001
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
Date: Wed, 6 Nov 2019 10:41:34 +1300
Subject: [PATCH] spi: bcm2835: fix typo in comment

GPIOS_OUT_LOW should be GPIOD_OUT_LOW.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Link: https://lore.kernel.org/r/20191105214134.25142-1-chris.packham@alliedtelesis.co.nz
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-bcm2835.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index b4070c0de3df..fb61a620effc 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -1248,7 +1248,7 @@ static int bcm2835_spi_setup(struct spi_device *spi)
 	/*
 	 * Retrieve the corresponding GPIO line used for CS.
 	 * The inversion semantics will be handled by the GPIO core
-	 * code, so we pass GPIOS_OUT_LOW for "unasserted" and
+	 * code, so we pass GPIOD_OUT_LOW for "unasserted" and
 	 * the correct flag for inversion semantics. The SPI_CS_HIGH
 	 * on spi->mode cannot be checked for polarity in this case
 	 * as the flag use_gpio_descriptors enforces SPI_CS_HIGH.
-- 
2.20.1

From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: spidev: Add dhcom-board to compatibility list" to the spi tree
Date: Tue, 21 May 2019 21:33:09 +0100 (BST)
Message-ID: <20190521203309.A48CA1126D18@debutante.sirena.org.uk>
References: <20190516110149.6165-1-cniedermaier@dh-electronics.com>
Cc: broonie@kernel.org, cniedermaier@dh-electronics.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
To: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190516110149.6165-1-cniedermaier@dh-electronics.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: spidev: Add dhcom-board to compatibility list

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

>From 9783da2384c5623d376e4641bbce9339be1001eb Mon Sep 17 00:00:00 2001
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Date: Thu, 16 May 2019 13:01:49 +0200
Subject: [PATCH] spi: spidev: Add dhcom-board to compatibility list

Prepare to use devices on the external SPI interface
on a DH electronics Development Board.

Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spidev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index ce9142d87f41..df4c0a9b34dd 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -672,6 +672,7 @@ static const struct of_device_id spidev_dt_ids[] = {
 	{ .compatible = "ge,achc" },
 	{ .compatible = "semtech,sx1301" },
 	{ .compatible = "lwn,bk4" },
+	{ .compatible = "dh,dhcom-board" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, spidev_dt_ids);
-- 
2.20.1

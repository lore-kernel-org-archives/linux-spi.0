From: Mark Brown <broonie@kernel.org>
Subject: Applied "spidev: Enable the Liebherr's BK4 board to work with spidev driver" to the spi tree
Date: Mon,  8 Oct 2018 14:57:21 +0100 (BST)
Message-ID: <20181008135721.21E431122339@debutante.sirena.org.uk>
References: <20180927223152.24990-1-lukma@denx.de>
Cc: Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
To: Lukasz Majewski <lukma@denx.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180927223152.24990-1-lukma@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spidev: Enable the Liebherr's BK4 board to work with spidev driver

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From 5e9feb3544a72321553d17fcfa0c7e88435ea7ad Mon Sep 17 00:00:00 2001
From: Lukasz Majewski <lukma@denx.de>
Date: Fri, 28 Sep 2018 00:31:52 +0200
Subject: [PATCH] spidev: Enable the Liebherr's BK4 board to work with spidev
 driver

With this commit the DSPI driver on the BK4 board can be used for SPI
transmission managed from user space (via /dev/spidev0.0).

Example usage/testing:
insmod ./spi-fsl-dspi.ko
./spidev_test -D /dev/spidev0.0 -s 3000000 -v -H -b 8 -p "\xCC\x11\x22\x74"

Signed-off-by: Lukasz Majewski <lukma@denx.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spidev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index cda10719d1d1..07f4d05563ea 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -669,6 +669,7 @@ static const struct of_device_id spidev_dt_ids[] = {
 	{ .compatible = "lineartechnology,ltc2488" },
 	{ .compatible = "ge,achc" },
 	{ .compatible = "semtech,sx1301" },
+	{ .compatible = "lwn,bk4" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, spidev_dt_ids);
-- 
2.19.0.rc2

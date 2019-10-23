From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: document CS setup, hold & inactive times in header" to the spi tree
Date: Wed, 23 Oct 2019 19:56:17 +0100 (BST)
Message-ID: <20191023185617.DD3E5274326E@ypsilon.sirena.org.uk>
References: <20191023070046.12478-1-alexandru.ardelean@analog.com>
Cc: broonie@kernel.org, kbuild test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
To: Alexandru Ardelean <alexandru.ardelean@analog.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191023070046.12478-1-alexandru.ardelean@analog.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: document CS setup, hold & inactive times in header

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

>From a3470c1829c0c856a19c10af58f8e7792ae27d7a Mon Sep 17 00:00:00 2001
From: Alexandru Ardelean <alexandru.ardelean@analog.com>
Date: Wed, 23 Oct 2019 10:00:46 +0300
Subject: [PATCH] spi: document CS setup, hold & inactive times in header

This change documents the CS setup, host & inactive times. They were
omitted when the fields were added, and were caught by one of the build
bots.

Fixes: 25093bdeb6bc ("spi: implement SW control for CS times")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Link: https://lore.kernel.org/r/20191023070046.12478-1-alexandru.ardelean@analog.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/linux/spi/spi.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index c40d6af2bf07..98fe8663033a 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -407,6 +407,11 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
  *	     controller has native support for memory like operations.
  * @unprepare_message: undo any work done by prepare_message().
  * @slave_abort: abort the ongoing transfer request on an SPI slave controller
+ * @cs_setup: delay to be introduced by the controller after CS is asserted
+ * @cs_hold: delay to be introduced by the controller before CS is deasserted
+ * @cs_inactive: delay to be introduced by the controller after CS is
+ *	deasserted. If @cs_change_delay is used from @spi_transfer, then the
+ *	two delays will be added up.
  * @cs_gpios: LEGACY: array of GPIO descs to use as chip select lines; one per
  *	CS number. Any individual value may be -ENOENT for CS lines that
  *	are not GPIOs (driven by the SPI controller itself). Use the cs_gpiods
-- 
2.20.1

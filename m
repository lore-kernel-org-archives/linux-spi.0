From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: nxp-fspi: Ensure width is respected in spi-mem operations" to the spi tree
Date: Mon, 16 Dec 2019 12:06:24 +0000
Message-ID: <applied-20191211195730.26794-1-michael@walle.cc>
References: <20191211195730.26794-1-michael@walle.cc>
Cc: Ashish Kumar <ashish.kumar@nxp.com>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>
To: Michael Walle <michael@walle.cc>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191211195730.26794-1-michael@walle.cc>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: nxp-fspi: Ensure width is respected in spi-mem operations

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

>From 007773e16a6f3f49d1439554078c3ba8af131998 Mon Sep 17 00:00:00 2001
From: Michael Walle <michael@walle.cc>
Date: Wed, 11 Dec 2019 20:57:30 +0100
Subject: [PATCH] spi: nxp-fspi: Ensure width is respected in spi-mem
 operations

Make use of a core helper to ensure the desired width is respected
when calling spi-mem operators.

Otherwise only the SPI controller will be matched with the flash chip,
which might lead to wrong widths. Also consider the width specified by
the user in the device tree.

Fixes: a5356aef6a90 ("spi: spi-mem: Add driver for NXP FlexSPI controller")
Signed-off-by: Michael Walle <michael@walle.cc>
Link: https://lore.kernel.org/r/20191211195730.26794-1-michael@walle.cc
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-nxp-fspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index c36bb1bb464e..8c5084a3a617 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -439,7 +439,7 @@ static bool nxp_fspi_supports_op(struct spi_mem *mem,
 	    op->data.nbytes > f->devtype_data->txfifo)
 		return false;
 
-	return true;
+	return spi_mem_default_supports_op(mem, op);
 }
 
 /* Instead of busy looping invoke readl_poll_timeout functionality. */
-- 
2.20.1

From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: spi-fsl-qspi: Ensure width is respected in spi-mem operations" to the spi tree
Date: Tue, 21 Jan 2020 17:29:17 +0000
Message-ID: <applied-20200114154613.8195-1-michael@walle.cc>
References: <20200114154613.8195-1-michael@walle.cc>
Cc: Boris Brezillon <bbrezillon@kernel.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Han Xu <han.xu@nxp.com>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
To: Michael Walle <michael@walle.cc>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200114154613.8195-1-michael@walle.cc>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: spi-fsl-qspi: Ensure width is respected in spi-mem operations

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

>From b0177aca7aea7e8917d4e463334b51facb293d02 Mon Sep 17 00:00:00 2001
From: Michael Walle <michael@walle.cc>
Date: Tue, 14 Jan 2020 16:46:13 +0100
Subject: [PATCH] spi: spi-fsl-qspi: Ensure width is respected in spi-mem
 operations

Make use of a core helper to ensure the desired width is respected
when calling spi-mem operators.

Otherwise only the SPI controller will be matched with the flash chip,
which might lead to wrong widths. Also consider the width specified by
the user in the device tree.

Fixes: 84d043185dbe ("spi: Add a driver for the Freescale/NXP QuadSPI controller")
Signed-off-by: Michael Walle <michael@walle.cc>
Link: https://lore.kernel.org/r/20200114154613.8195-1-michael@walle.cc
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-fsl-qspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
index 79b1558b74b8..e8a499cd1f13 100644
--- a/drivers/spi/spi-fsl-qspi.c
+++ b/drivers/spi/spi-fsl-qspi.c
@@ -410,7 +410,7 @@ static bool fsl_qspi_supports_op(struct spi_mem *mem,
 	    op->data.nbytes > q->devtype_data->txfifo)
 		return false;
 
-	return true;
+	return spi_mem_default_supports_op(mem, op);
 }
 
 static void fsl_qspi_prepare_lut(struct fsl_qspi *q,
-- 
2.20.1

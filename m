From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: lpspi: add missing complete in abort func at dma mode" to the spi tree
Date: Wed,  3 Apr 2019 05:42:21 +0100 (BST)
Message-ID: <20190403044221.E7247440083@finisterre.ee.mobilebroadband>
References: <20190402124609.22157-1-xiaoning.wang@nxp.com>
Cc: Mark Brown <broonie@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-spi@vger.kernel.org
To: Clark Wang <xiaoning.wang@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190402124609.22157-1-xiaoning.wang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: lpspi: add missing complete in abort func at dma mode

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

>From 8863eca8c46affaa91ae35390b00358b925483eb Mon Sep 17 00:00:00 2001
From: Clark Wang <xiaoning.wang@nxp.com>
Date: Tue, 2 Apr 2019 12:45:53 +0000
Subject: [PATCH] spi: lpspi: add missing complete in abort func at dma mode

Add the missing complete operations for dma_completion to fix the
problem of blocking at the wait_for_completion_interruptible()
function when use spi_slave_abort().

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-fsl-lpspi.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 4de8eb378752..2ad9d6262c2b 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -482,7 +482,13 @@ static int fsl_lpspi_slave_abort(struct spi_controller *controller)
 				spi_controller_get_devdata(controller);
 
 	fsl_lpspi->slave_aborted = true;
-	complete(&fsl_lpspi->xfer_done);
+	if (!fsl_lpspi->usedma)
+		complete(&fsl_lpspi->xfer_done);
+	else {
+		complete(&fsl_lpspi->dma_tx_completion);
+		complete(&fsl_lpspi->dma_rx_completion);
+	}
+
 	return 0;
 }
 
-- 
2.20.1

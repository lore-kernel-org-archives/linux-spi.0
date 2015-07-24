From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: imx: Fix small DMA transfers" to the spi tree
Date: Fri, 24 Jul 2015 16:09:12 +0100
Message-ID: <E1ZIeb2-0004vh-Iz@debutante>
References: <1437742868-23430-1-git-send-email-s.hauer@pengutronix.de>
Cc: linux-spi@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>, stable@vger.kernel.org,
	Mark Brown <broonie@kernel.org>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1437742868-23430-1-git-send-email-s.hauer@pengutronix.de>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: imx: Fix small DMA transfers

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From f6ee9b582d2db652497b73c1f117591dfb6d3a90 Mon Sep 17 00:00:00 2001
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Fri, 24 Jul 2015 15:01:08 +0200
Subject: [PATCH] spi: imx: Fix small DMA transfers

DMA transfers must be greater than the watermark level size. spi_imx->rx_wml
and spi_imx->tx_wml contain the watermark level in 32bit words whereas struct
spi_transfer contains the transfer len in bytes. Fix the check if DMA is
possible for a transfer accordingly. This fixes transfers with sizes between
33 and 128 bytes for which previously was claimed that DMA is possible.

Fixes: f62caccd12c17e4 (spi: spi-imx: add DMA support)
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Cc: stable@vger.kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-imx.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index eb7d3a6fb14c..f9deb84e4e55 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -201,8 +201,9 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
 {
 	struct spi_imx_data *spi_imx = spi_master_get_devdata(master);
 
-	if (spi_imx->dma_is_inited && (transfer->len > spi_imx->rx_wml)
-	    && (transfer->len > spi_imx->tx_wml))
+	if (spi_imx->dma_is_inited
+	    && transfer->len > spi_imx->rx_wml * sizeof(u32)
+	    && transfer->len > spi_imx->tx_wml * sizeof(u32))
 		return true;
 	return false;
 }
-- 
2.1.4

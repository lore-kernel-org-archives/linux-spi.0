From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: imx: use PIO mode if size is small" to the spi tree
Date: Fri, 12 Oct 2018 19:01:22 +0200 (CEST)
Message-ID: <20181012170122.C66EC440078@finisterre.ee.mobilebroadband>
References: <1539196453-8704-4-git-send-email-yibin.gong@nxp.com>
Cc: Mark Brown <broonie@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>, linux-spi@vger.kernel.org
To: Robin Gong <yibin.gong@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539196453-8704-4-git-send-email-yibin.gong@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: imx: use PIO mode if size is small

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

>From 133eb8e38b02c6c63a039523fca12737009a6686 Mon Sep 17 00:00:00 2001
From: Robin Gong <yibin.gong@nxp.com>
Date: Wed, 10 Oct 2018 10:32:48 +0000
Subject: [PATCH] spi: imx: use PIO mode if size is small

Use PIO mode instead if size is smaller than fifo size, since
dma may be less efficient.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-imx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 037abbb852a4..dd1ce12aa386 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -224,6 +224,9 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
 	if (spi_imx->slave_mode)
 		return false;
 
+	if (transfer->len < spi_imx->devtype_data->fifo_size)
+		return false;
+
 	spi_imx->dynamic_burst = 0;
 
 	return true;
-- 
2.19.0

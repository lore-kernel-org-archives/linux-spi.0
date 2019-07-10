From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: spi-fsl-qspi: change i.MX7D RX FIFO size" to the spi tree
Date: Wed, 10 Jul 2019 16:34:53 +0100 (BST)
Message-ID: <20190710153453.DF598D02D7C@fitzroy.sirena.org.uk>
References: <20190710023128.13115-3-han.xu@nxp.com>
Cc: ashish.kumar@nxp.com, broonie@kernel.org, han.xu@nxp.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
To: Han Xu <han.xu@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190710023128.13115-3-han.xu@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: spi-fsl-qspi: change i.MX7D RX FIFO size

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

>From d6b197a14863818a7ed7890e91f043fab49e8c60 Mon Sep 17 00:00:00 2001
From: Han Xu <han.xu@nxp.com>
Date: Wed, 10 Jul 2019 10:31:27 +0800
Subject: [PATCH] spi: spi-fsl-qspi: change i.MX7D RX FIFO size

The RX FIFO should be 128 byte rather than 512 byte. It's a typo on
reference manual.

Signed-off-by: Han Xu <han.xu@nxp.com>
Link: https://lore.kernel.org/r/20190710023128.13115-3-han.xu@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-fsl-qspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
index 41a49b93ca60..448c00e4065b 100644
--- a/drivers/spi/spi-fsl-qspi.c
+++ b/drivers/spi/spi-fsl-qspi.c
@@ -206,7 +206,7 @@ static const struct fsl_qspi_devtype_data imx6sx_data = {
 };
 
 static const struct fsl_qspi_devtype_data imx7d_data = {
-	.rxfifo = SZ_512,
+	.rxfifo = SZ_128,
 	.txfifo = SZ_512,
 	.ahb_buf_size = SZ_1K,
 	.quirks = QUADSPI_QUIRK_TKT253890 | QUADSPI_QUIRK_4X_INT_CLK,
-- 
2.20.1

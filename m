From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: imx: Drop unnecessary check" to the spi tree
Date: Tue, 06 Jun 2017 20:07:40 +0100
Message-ID: <E1dIJpM-0007fn-Jx@debutante>
References: <20170602053804.3238-3-s.hauer@pengutronix.de>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, festevam@gmail.com,
        Jiada Wang <jiada_wang@mentor.com>, linux-spi@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170602053804.3238-3-s.hauer@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: imx: Drop unnecessary check

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

>From 494f3193bd8ca6a15a813bf0f8b5552ec0d173f3 Mon Sep 17 00:00:00 2001
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Fri, 2 Jun 2017 07:38:00 +0200
Subject: [PATCH] spi: imx: Drop unnecessary check

__spi_validate makes sure that every transfer has a valid bits_per_word
and speed_hz setting. We do not need to fallback to values from the
spi_device.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-imx.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 4b5cd0c84450..e3bc3d51a2d6 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -218,8 +218,6 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
 		return false;
 
 	bpw = transfer->bits_per_word;
-	if (!bpw)
-		bpw = spi->bits_per_word;
 
 	bpw = spi_imx_bytes_per_word(bpw);
 
@@ -898,11 +896,6 @@ static int spi_imx_setupxfer(struct spi_device *spi,
 	config.bpw = t->bits_per_word;
 	config.speed_hz  = t->speed_hz;
 
-	if (!config.speed_hz)
-		config.speed_hz = spi->max_speed_hz;
-	if (!config.bpw)
-		config.bpw = spi->bits_per_word;
-
 	/* Initialize the functions for transfer */
 	if (config.bpw <= 8) {
 		spi_imx->rx = spi_imx_buf_rx_u8;
-- 
2.11.0

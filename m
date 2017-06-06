From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: imx: drop bogus unnecessary dma config" to the spi tree
Date: Tue, 06 Jun 2017 20:07:24 +0100
Message-ID: <E1dIJp6-0007dI-N3@debutante>
References: <20170602053804.3238-5-s.hauer@pengutronix.de>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, festevam@gmail.com,
        Jiada Wang <jiada_wang@mentor.com>, linux-spi@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170602053804.3238-5-s.hauer@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: imx: drop bogus unnecessary dma config

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

>From d6be7d1db51799fb510458b8ede6e5bef96ab1f0 Mon Sep 17 00:00:00 2001
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Fri, 2 Jun 2017 07:38:02 +0200
Subject: [PATCH] spi: imx: drop bogus unnecessary dma config

It's unnecessary to call spi_imx_dma_configure() from probe(). It will
be called later anyway again when an actual DMA transfer is prepared.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-imx.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 3fa5ccfb45a1..0ec8d816e033 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -965,8 +965,6 @@ static int spi_imx_sdma_init(struct device *dev, struct spi_imx_data *spi_imx,
 		goto err;
 	}
 
-	spi_imx_dma_configure(master, 1);
-
 	init_completion(&spi_imx->dma_rx_completion);
 	init_completion(&spi_imx->dma_tx_completion);
 	master->can_dma = spi_imx_can_dma;
-- 
2.11.0

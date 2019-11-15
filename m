From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: qup: Use dma_request_chan() directly for channel request" to the spi tree
Date: Fri, 15 Nov 2019 12:25:15 +0000 (GMT)
Message-ID: <20191115122515.3521B27415A7@ypsilon.sirena.org.uk>
References: <20191113094256.1108-7-peter.ujfalusi@ti.com>
Cc: agross@kernel.org, alexandre.belloni@bootlin.com, andi@etezian.org,
        bjorn.andersson@linaro.org, broonie@kernel.org,
        jonathanh@nvidia.com, kgene@kernel.org, krzk@kernel.org,
        ldewangan@nvidia.com, linus.walleij@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, radu_nicolae.pirea@upb.ro,
        s.hauer@pengutronix.de, shawnguo@kernel.org,
        thierry.reding@gmail.com, vkoul@kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191113094256.1108-7-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: qup: Use dma_request_chan() directly for channel request

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

>From 194e1d4bc262c2d23ba9a8a5c03855c372ea1b5c Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Wed, 13 Nov 2019 11:42:53 +0200
Subject: [PATCH] spi: qup: Use dma_request_chan() directly for channel request

dma_request_slave_channel_reason() is:
#define dma_request_slave_channel_reason(dev, name) \
	dma_request_chan(dev, name)

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Link: https://lore.kernel.org/r/20191113094256.1108-7-peter.ujfalusi@ti.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-qup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index 2f559e531100..dd3434a407ea 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -932,11 +932,11 @@ static int spi_qup_init_dma(struct spi_master *master, resource_size_t base)
 	int ret;
 
 	/* allocate dma resources, if available */
-	master->dma_rx = dma_request_slave_channel_reason(dev, "rx");
+	master->dma_rx = dma_request_chan(dev, "rx");
 	if (IS_ERR(master->dma_rx))
 		return PTR_ERR(master->dma_rx);
 
-	master->dma_tx = dma_request_slave_channel_reason(dev, "tx");
+	master->dma_tx = dma_request_chan(dev, "tx");
 	if (IS_ERR(master->dma_tx)) {
 		ret = PTR_ERR(master->dma_tx);
 		goto err_tx;
-- 
2.20.1

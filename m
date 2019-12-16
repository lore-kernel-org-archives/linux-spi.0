From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: mxs: Use dma_request_chan() instead dma_request_slave_channel()" to the spi tree
Date: Mon, 16 Dec 2019 12:06:09 +0000
Message-ID: <applied-20191212135550.4634-6-peter.ujfalusi@ti.com>
References: <20191212135550.4634-6-peter.ujfalusi@ti.com>
Cc: alexandre.torgue@st.com, baohua@kernel.org, broonie@kernel.org,
        f.fainelli@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Mark Brown <broonie@kernel.org>, mcoquelin.stm32@gmail.com,
        nsaenzjulienne@suse.de, rjui@broadcom.com, sbranden@broadcom.com,
        s.hauer@pengutronix.de, shawnguo@kernel.org, vkoul@kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191212135550.4634-6-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: mxs: Use dma_request_chan() instead dma_request_slave_channel()

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.6

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

>From 7ccffd41b2d4d180dcdcc03c54c446621e34bca5 Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Thu, 12 Dec 2019 15:55:46 +0200
Subject: [PATCH] spi: mxs: Use dma_request_chan() instead
 dma_request_slave_channel()

dma_request_slave_channel() is a wrapper on top of dma_request_chan()
eating up the error code.

By using dma_request_chan() directly the driver can support deferred
probing against DMA.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Link: https://lore.kernel.org/r/20191212135550.4634-6-peter.ujfalusi@ti.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-mxs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
index 996c1c8a9c71..dce85ee07cd0 100644
--- a/drivers/spi/spi-mxs.c
+++ b/drivers/spi/spi-mxs.c
@@ -590,10 +590,10 @@ static int mxs_spi_probe(struct platform_device *pdev)
 	if (ret)
 		goto out_master_free;
 
-	ssp->dmach = dma_request_slave_channel(&pdev->dev, "rx-tx");
-	if (!ssp->dmach) {
+	ssp->dmach = dma_request_chan(&pdev->dev, "rx-tx");
+	if (IS_ERR(ssp->dmach)) {
 		dev_err(ssp->dev, "Failed to request DMA\n");
-		ret = -ENODEV;
+		ret = PTR_ERR(ssp->dmach);
 		goto out_master_free;
 	}
 
-- 
2.20.1

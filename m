From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: s3c64xx: potential oops on probe error" to the spi tree
Date: Tue, 17 Jan 2017 18:46:25 +0000
Message-ID: <E1cTYm1-0000XD-FR@debutante>
References: <20170113074253.GA30524@mwanda>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
        Andi Shyti <andi.shyti@samsung.com>,
        Mark Brown <broonie@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        Andi Shyti <andi.shyti@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-spi@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-spi@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20170113074253.GA30524@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: s3c64xx: potential oops on probe error

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

>From 72bc7ae0633e2b580217d254114ac6650380b7f6 Mon Sep 17 00:00:00 2001
From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 13 Jan 2017 10:42:53 +0300
Subject: [PATCH] spi: s3c64xx: potential oops on probe error

We accidentally mixed up freeing the rx and tx channels which would a
leak and an oops.

Fixes: 3d63a47a380a ("spi: s3c64xx: Don't request/release DMA channels for each SPI transfer")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
Acked-by: Andi Shyti <andi.shyti@samsung.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-s3c64xx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 849ee82483e4..b8cd356d8d10 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1147,7 +1147,7 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 		if (IS_ERR(sdd->tx_dma.ch)) {
 			dev_err(&pdev->dev, "Failed to get TX DMA channel\n");
 			ret = PTR_ERR(sdd->tx_dma.ch);
-			goto err_release_tx_dma;
+			goto err_release_rx_dma;
 		}
 	}
 
@@ -1197,10 +1197,10 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 	pm_runtime_set_suspended(&pdev->dev);
 
 	if (!is_polling(sdd))
-		dma_release_channel(sdd->rx_dma.ch);
-err_release_tx_dma:
-	if (!is_polling(sdd))
 		dma_release_channel(sdd->tx_dma.ch);
+err_release_rx_dma:
+	if (!is_polling(sdd))
+		dma_release_channel(sdd->rx_dma.ch);
 err_disable_io_clk:
 	clk_disable_unprepare(sdd->ioclk);
 err_disable_src_clk:
-- 
2.11.0


From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] spi: s3c64xx: potential oops on probe error
Date: Fri, 13 Jan 2017 10:42:53 +0300
Message-ID: <20170113074253.GA30524@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        Andi Shyti <andi.shyti@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-spi@vger.kernel.org,
        kernel-janitors@vger.kernel.org
To: Kukjin Kim <kgene@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

We accidentally mixed up freeing the rx and tx channels which would a
leak and an oops.

Fixes: 3d63a47a380a ("spi: s3c64xx: Don't request/release DMA channels for each SPI transfer")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 849ee82..b8cd356 100644
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

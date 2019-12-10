From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 105/177] spi: img-spfi: fix potential double release
Date: Tue, 10 Dec 2019 16:31:09 -0500
Message-ID: <20191210213221.11921-105-sashal@kernel.org>
References: <20191210213221.11921-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Pan Bian <bianpan2016@163.com>, Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-spi@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191210213221.11921-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Pan Bian <bianpan2016@163.com>

[ Upstream commit e9a8ba9769a0e354341bc6cc01b98aadcea1dfe9 ]

The channels spfi->tx_ch and spfi->rx_ch are not set to NULL after they
are released. As a result, they will be released again, either on the
error handling branch in the same function or in the corresponding
remove function, i.e. img_spfi_remove(). This patch fixes the bug by
setting the two members to NULL.

Signed-off-by: Pan Bian <bianpan2016@163.com>
Link: https://lore.kernel.org/r/1573007769-20131-1-git-send-email-bianpan2016@163.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-img-spfi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-img-spfi.c b/drivers/spi/spi-img-spfi.c
index e6eb979f1b8a0..e4b31d6e6e33e 100644
--- a/drivers/spi/spi-img-spfi.c
+++ b/drivers/spi/spi-img-spfi.c
@@ -676,6 +676,8 @@ static int img_spfi_probe(struct platform_device *pdev)
 			dma_release_channel(spfi->tx_ch);
 		if (spfi->rx_ch)
 			dma_release_channel(spfi->rx_ch);
+		spfi->tx_ch = NULL;
+		spfi->rx_ch = NULL;
 		dev_warn(spfi->dev, "Failed to get DMA channels, falling back to PIO mode\n");
 	} else {
 		master->dma_tx = spfi->tx_ch;
-- 
2.20.1

From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 1/2] spi: core: Fix check for dma_map_sg() failures
Date: Thu, 10 Jul 2014 15:29:32 +0200
Message-ID: <1404998973-19425-1-git-send-email-geert@linux-m68k.org>
Cc: linux-spi@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

According to Documentation/DMA-API.txt, dma_map_sg() returns 0 on failure.
As spi_map_buf() returns an error code, convert zero into -ENOMEM.
Keep the existing check for negative numbers just in case.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/spi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 3a3245dd64ed..3aac0e885cd9 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -617,6 +617,8 @@ static int spi_map_buf(struct spi_master *master, struct device *dev,
 	}
 
 	ret = dma_map_sg(dev, sgt->sgl, sgt->nents, dir);
+	if (!ret)
+		ret = -ENOMEM;
 	if (ret < 0) {
 		sg_free_table(sgt);
 		return ret;
-- 
1.9.1

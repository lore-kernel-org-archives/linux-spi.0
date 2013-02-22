From: Boojin Kim <boojin.kim@samsung.com>
Subject: [PATCH v2 2/4] ARM: EXYNOS: support burst mode for for dev-to-mem and
 mem-to-dev transmit
Date: Fri, 22 Feb 2013 17:05:35 +0900
Message-ID: <001a01ce10d3$64b4afb0$2e1e0f10$%kim@samsung.com>
Cc: 'Vinod Koul' <vinod.koul@intel.com>, 'Dan Williams' <djbw@fb.com>,
	'Russell King' <linux@arm.linux.org.uk>,
	'Kukjin Kim' <kgene.kim@samsung.com>,
	'Grant Likely' <grant.likely@secretlab.ca>,
	'Mark Brown' <broonie@opensource.wolfsonmicro.com>,
	'Rob Herring' <rob.herring@calxeda.com>,
	'Sangbeom Kim' <sbkim73@samsung.com>
To: 'Boojin Kim' <boojin.kim@samsung.com>,
	linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	spi-devel-general@lists.sourceforge.net,
	alsa-devel@alsa-project.org
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
References: 
In-reply-to: 
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This patch adds to support burst mode for for dev-to-mem and dev-to-mem transmit

Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
---
 arch/arm/plat-samsung/dma-ops.c              |    4 ++--
 arch/arm/plat-samsung/include/plat/dma-ops.h |    1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-samsung/dma-ops.c b/arch/arm/plat-samsung/dma-ops.c
index 71d58dd..6c90c16 100644
--- a/arch/arm/plat-samsung/dma-ops.c
+++ b/arch/arm/plat-samsung/dma-ops.c
@@ -60,14 +60,14 @@ static int samsung_dmadev_config(unsigned ch,
 		slave_config.direction = param->direction;
 		slave_config.src_addr = param->fifo;
 		slave_config.src_addr_width = param->width;
-		slave_config.src_maxburst = 1;
+		slave_config.src_maxburst = param->maxburst;
 		dmaengine_slave_config(chan, &slave_config);
 	} else if (param->direction == DMA_MEM_TO_DEV) {
 		memset(&slave_config, 0, sizeof(struct dma_slave_config));
 		slave_config.direction = param->direction;
 		slave_config.dst_addr = param->fifo;
 		slave_config.dst_addr_width = param->width;
-		slave_config.dst_maxburst = 1;
+		slave_config.dst_maxburst = param->maxburst;
 		dmaengine_slave_config(chan, &slave_config);
 	} else {
 		pr_warn("unsupported direction\n");
diff --git a/arch/arm/plat-samsung/include/plat/dma-ops.h b/arch/arm/plat-samsung/include/plat/dma-ops.h
index 1141782..383bd6d 100644
--- a/arch/arm/plat-samsung/include/plat/dma-ops.h
+++ b/arch/arm/plat-samsung/include/plat/dma-ops.h
@@ -35,6 +35,7 @@ struct samsung_dma_prep {
 struct samsung_dma_config {
 	enum dma_transfer_direction direction;
 	enum dma_slave_buswidth width;
+	u32 maxburst;
 	dma_addr_t fifo;
 };

--
1.7.5.4

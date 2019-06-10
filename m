From: yibin.gong@nxp.com
Subject: [PATCH v5 04/15] dmaengine: imx-sdma: remove dupilicated sdma_load_context
Date: Mon, 10 Jun 2019 16:17:42 +0800
Message-ID: <20190610081753.11422-5-yibin.gong@nxp.com>
References: <20190610081753.11422-1-yibin.gong@nxp.com>
Cc: linux-spi@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, broonie@kernel.org,
        festevam@gmail.com, vkoul@kernel.org, dan.j.williams@intel.com,
        u.kleine-koenig@pengutronix.de, catalin.marinas@arm.com,
        l.stach@pengutronix.de, will.deacon@arm.com
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190610081753.11422-1-yibin.gong@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Robin Gong <yibin.gong@nxp.com>

Since sdma_transfer_init() will do sdma_load_context before any
sdma transfer, no need once more in sdma_config_channel().

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Acked-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/imx-sdma.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 21db6b69..dbd1dcd 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1134,7 +1134,6 @@ static void sdma_set_watermarklevel_for_p2p(struct sdma_channel *sdmac)
 static int sdma_config_channel(struct dma_chan *chan)
 {
 	struct sdma_channel *sdmac = to_sdma_chan(chan);
-	int ret;
 
 	sdma_disable_channel(chan);
 
@@ -1174,9 +1173,7 @@ static int sdma_config_channel(struct dma_chan *chan)
 		sdmac->watermark_level = 0; /* FIXME: M3_BASE_ADDRESS */
 	}
 
-	ret = sdma_load_context(sdmac);
-
-	return ret;
+	return 0;
 }
 
 static int sdma_set_channel_priority(struct sdma_channel *sdmac,
-- 
2.7.4

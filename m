From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 07/12] spi: sh-msiof: Configure DMA slave bus width
Date: Wed,  6 Aug 2014 14:59:04 +0200
Message-ID: <1407329949-5695-8-git-send-email-geert+renesas@glider.be>
References: <1407329949-5695-1-git-send-email-geert+renesas@glider.be>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	linux-spi@vger.kernel.org, linux-sh@vger.kernel.org,
	dmaengine@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
To: Mark Brown <broonie@kernel.org>, Simon Horman <horms@verge.net.au>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1407329949-5695-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The new Renesas R-Car Gen2 DMA Controller driver (rcar-dmac) requires
explicit configuration of the DMA slave bus width.
Hardcode the DMA transfer size to 4 bytes, as MSIOF DMA is limited to
32-bit words.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/spi-sh-msiof.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 887c2084130f..b19cbb4cb4a0 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -987,10 +987,13 @@ static struct dma_chan *sh_msiof_request_dma_chan(struct device *dev,
 	memset(&cfg, 0, sizeof(cfg));
 	cfg.slave_id = id;
 	cfg.direction = dir;
-	if (dir == DMA_MEM_TO_DEV)
+	if (dir == DMA_MEM_TO_DEV) {
 		cfg.dst_addr = port_addr;
-	else
+		cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	} else {
 		cfg.src_addr = port_addr;
+		cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	}
 
 	ret = dmaengine_slave_config(chan, &cfg);
 	if (ret) {
-- 
1.9.1


From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH 04/12] spi: rspi: Configure DMA slave bus width to 8 bit
Date: Wed,  6 Aug 2014 14:59:01 +0200
Message-ID: <1407329949-5695-5-git-send-email-geert+renesas@glider.be>
References: <1407329949-5695-1-git-send-email-geert+renesas@glider.be>
Cc: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1407329949-5695-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The new Renesas R-Car Gen2 DMA Controller driver (rcar-dmac) requires
explicit configuration of the DMA slave bus width.
Hardcode the DMA transfer size to 1 byte for both directions, as that's
the only supported configuration (16-bit DMA support was removed in
commit 9c5de2c1754c2bb3c69c4d7bf0d0edc0a61d8232 ("spi: rspi: Remove
unused 16-bit DMA support")).

Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
---
 drivers/spi/spi-rspi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index aa1c6a893570..6a4eb2d7f644 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -919,10 +919,13 @@ static struct dma_chan *rspi_request_dma_chan(struct device *dev,
 	memset(&cfg, 0, sizeof(cfg));
 	cfg.slave_id = id;
 	cfg.direction = dir;
-	if (dir == DMA_MEM_TO_DEV)
+	if (dir == DMA_MEM_TO_DEV) {
 		cfg.dst_addr = port_addr;
-	else
+		cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+	} else {
 		cfg.src_addr = port_addr;
+		cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+	}
 
 	ret = dmaengine_slave_config(chan, &cfg);
 	if (ret) {
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

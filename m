From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH 1/2] spi: sh-msiof: Return early in sh_msiof_dma_once() where possible
Date: Thu,  7 Aug 2014 14:07:42 +0200
Message-ID: <1407413263-20177-1-git-send-email-geert+renesas@glider.be>
References: <CAMuHMdUd3OKqDwhLSCMW-rEQSnWky+saN5TgC005rkmNPfEL+g@mail.gmail.com>
Cc: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMuHMdUd3OKqDwhLSCMW-rEQSnWky+saN5TgC005rkmNPfEL+g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Reported-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
---
Feel free to fold into commit 4240305f7cbdc7782aa8bc40cc702775d9ac0839
("spi: sh-msiof: Fix leaking of unused DMA descriptors")
---
 drivers/spi/spi-sh-msiof.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 887c2084130f..0d9ccd0953de 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -642,18 +642,14 @@ static int sh_msiof_dma_once(struct sh_msiof_spi_priv *p, const void *tx,
 		desc_rx = dmaengine_prep_slave_single(p->master->dma_rx,
 					p->rx_dma_addr, len, DMA_FROM_DEVICE,
 					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
-		if (!desc_rx) {
-			ret = -EAGAIN;
-			goto no_dma_rx;
-		}
+		if (!desc_rx)
+			return -EAGAIN;
 
 		desc_rx->callback = sh_msiof_dma_complete;
 		desc_rx->callback_param = p;
 		cookie = dmaengine_submit(desc_rx);
-		if (dma_submit_error(cookie)) {
-			ret = cookie;
-			goto no_dma_rx;
-		}
+		if (dma_submit_error(cookie))
+			return cookie;
 	}
 
 	if (tx) {
@@ -738,7 +734,6 @@ no_dma_tx:
 	if (rx)
 		dmaengine_terminate_all(p->master->dma_rx);
 	sh_msiof_write(p, IER, 0);
-no_dma_rx:
 	return ret;
 }
 
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

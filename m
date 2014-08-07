From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH 2/2] spi: sh-msiof: Fix transmit-only DMA transfers
Date: Thu,  7 Aug 2014 14:07:43 +0200
Message-ID: <1407413263-20177-2-git-send-email-geert+renesas@glider.be>
References: <CAMuHMdUd3OKqDwhLSCMW-rEQSnWky+saN5TgC005rkmNPfEL+g@mail.gmail.com>
 <1407413263-20177-1-git-send-email-geert+renesas@glider.be>
Cc: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1407413263-20177-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Fix tx/rx mixup, which broke transmit-only transfers.

Introduced by commit 4240305f7cbdc7782aa8bc40cc702775d9ac0839
("spi: sh-msiof: Fix leaking of unused DMA descriptors").

Reported-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
---
Feel free to fold into commit 4240305f7cbdc7782aa8bc40cc702775d9ac0839
("spi: sh-msiof: Fix leaking of unused DMA descriptors")
---
 drivers/spi/spi-sh-msiof.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 0d9ccd0953de..5ee13a2d93df 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -689,9 +689,9 @@ static int sh_msiof_dma_once(struct sh_msiof_spi_priv *p, const void *tx,
 	reinit_completion(&p->done);
 
 	/* Now start DMA */
-	if (tx)
-		dma_async_issue_pending(p->master->dma_rx);
 	if (rx)
+		dma_async_issue_pending(p->master->dma_rx);
+	if (tx)
 		dma_async_issue_pending(p->master->dma_tx);
 
 	ret = sh_msiof_spi_start(p, rx);
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

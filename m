From: Dirk Behme <dirk.behme-V5te9oGctAVWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 3/8] spi: sh-msiof: Fix MSIOF address for DMAC
Date: Wed, 6 Sep 2017 09:05:02 +0200
Message-ID: <20170906070507.26223-4-dirk.behme@de.bosch.com>
References: <20170906070507.26223-1-dirk.behme@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ryo Kataoka <ryo.kataoka.wt-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
        Hiromitsu Yamasaki <hiromitsu.yamasaki.ym-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
        Dirk Behme <dirk.behme-V5te9oGctAVWk0Htik3J/w@public.gmane.org>
To: <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170906070507.26223-1-dirk.behme-V5te9oGctAVWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Ryo Kataoka <ryo.kataoka.wt-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>

MSIOF Base Address H'E6xx can be accessed by CPU and DMAC.
MSIOF Base Address H'E7xx for DMAC was removed from H/W manual.

Signed-off-by: Ryo Kataoka <ryo.kataoka.wt-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Hiromitsu Yamasaki <hiromitsu.yamasaki.ym-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Dirk Behme <dirk.behme-V5te9oGctAVWk0Htik3J/w@public.gmane.org>
---
 drivers/spi/spi-sh-msiof.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index f9300fdf41e5..24b49d3ca9a8 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -1145,10 +1145,7 @@ static int sh_msiof_request_dma(struct sh_msiof_spi_priv *p)
 		return 0;
 	}
 
-	/* The DMA engine uses the second register set, if present */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	if (!res)
-		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 
 	master = p->master;
 	master->dma_tx = sh_msiof_request_dma_chan(dev, DMA_MEM_TO_DEV,
-- 
2.14.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

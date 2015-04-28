From: Cao Minh Hiep <cm-hiep-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
Subject: [PATCH 1/3] spi: Re-do the returning value of rspi_dma_check_then_transfer
Date: Tue, 28 Apr 2015 14:55:49 +0900
Message-ID: <1430200551-20708-2-git-send-email-cm-hiep@jinso.co.jp>
References: <1430200551-20708-1-git-send-email-cm-hiep@jinso.co.jp>
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org,
	ryusuke.sakato.bx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1430200551-20708-1-git-send-email-cm-hiep-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Hiep Cao Minh <cm-hiep-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>

To reduce indentation and complex of code, insteeds of returning zero,
the function rspi_dma_check_then_transfer should be returned
rspi_dma_transfer directly after checking error.

Signed-off-by: Hiep Cao Minh <cm-hiep-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
---
 drivers/spi/spi-rspi.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 186924a..a17564a 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -665,15 +665,12 @@ static bool rspi_can_dma(struct spi_master *master, struct spi_device *spi,
 static int rspi_dma_check_then_transfer(struct rspi_data *rspi,
 					 struct spi_transfer *xfer)
 {
-	if (rspi->master->can_dma && __rspi_can_dma(rspi, xfer)) {
-		/* rx_buf can be NULL on RSPI on SH in TX-only Mode */
-		int ret = rspi_dma_transfer(rspi, &xfer->tx_sg,
-					xfer->rx_buf ? &xfer->rx_sg : NULL);
-		if (ret != -EAGAIN)
-			return 0;
-	}
+	if (!rspi->master->can_dma || !__rspi_can_dma(rspi, xfer)) {
+		return -EAGAIN;
 
-	return -EAGAIN;
+	/* rx_buf can be NULL on RSPI on SH in TX-only Mode */
+	return rspi_dma_transfer(rspi, &xfer->tx_sg,
+					xfer->rx_buf ? &xfer->rx_sg : NULL);
 }
 
 static int rspi_common_transfer(struct rspi_data *rspi,
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Cao Minh Hiep <cm-hiep-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
Subject: [PATCH 1/1] spi: Re-do correctly function name and 'ret' return value
Date: Fri, 24 Apr 2015 15:40:56 +0900
Message-ID: <1429857656-8348-2-git-send-email-cm-hiep@jinso.co.jp>
References: <1429857656-8348-1-git-send-email-cm-hiep@jinso.co.jp>
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org,
	ryusuke.sakato.bx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1429857656-8348-1-git-send-email-cm-hiep-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Hiep Cao Minh <cm-hiep-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>

qspi_trigger_transfer_out_int function should be qspi_trigger_transfer_out_in
without "t". "ret" value in rspi_dma_check_then_transfer should be returned
insteeds of returning zero. It just returns qspi_trigger_transfer_out_in() value
in qspi_transfer_out_in().

Signed-off-by: Hiep Cao Minh <cm-hiep-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
---
 drivers/spi/spi-rspi.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 186924a..9304a6d 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -670,7 +670,7 @@ static int rspi_dma_check_then_transfer(struct rspi_data *rspi,
 		int ret = rspi_dma_transfer(rspi, &xfer->tx_sg,
 					xfer->rx_buf ? &xfer->rx_sg : NULL);
 		if (ret != -EAGAIN)
-			return 0;
+			return ret;
 	}
 
 	return -EAGAIN;
@@ -724,7 +724,7 @@ static int rspi_rz_transfer_one(struct spi_master *master,
 	return rspi_common_transfer(rspi, xfer);
 }
 
-static int qspi_trigger_transfer_out_int(struct rspi_data *rspi, const u8 *tx,
+static int qspi_trigger_transfer_out_in(struct rspi_data *rspi, const u8 *tx,
 					u8 *rx, unsigned int len)
 {
 	int i, n, ret;
@@ -771,12 +771,8 @@ static int qspi_transfer_out_in(struct rspi_data *rspi,
 	if (ret != -EAGAIN)
 		return ret;
 
-	ret = qspi_trigger_transfer_out_int(rspi, xfer->tx_buf,
+	return qspi_trigger_transfer_out_in(rspi, xfer->tx_buf,
 					    xfer->rx_buf, xfer->len);
-	if (ret < 0)
-		return ret;
-
-	return 0;
 }
 
 static int qspi_transfer_out(struct rspi_data *rspi, struct spi_transfer *xfer)
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

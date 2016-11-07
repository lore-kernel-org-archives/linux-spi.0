From: Cao Minh Hiep <cm-hiep-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
Subject: [PATCH] ARM: spi: rewrites the name of the function.
Date: Mon,  7 Nov 2016 10:00:10 +0900
Message-ID: <1478480410-6320-1-git-send-email-cm-hiep@jinso.co.jp>
Cc: kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org,
        ryusuke.sakato.bx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        nv-dung-HEF513clHfp3+QwDJ9on6Q@public.gmane.org, h-inayoshi-HEF513clHfp3+QwDJ9on6Q@public.gmane.org, cm-hiep-HEF513clHfp3+QwDJ9on6Q@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Hiep Cao Minh <cm-hiep-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>

This patch rewrites the name of rspi_pio_transfer_in_or_out
function.

Signed-off-by: Hiep Cao Minh <cm-hiep-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
---
 drivers/spi/spi-rspi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index fb12bc5..7d3a825 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -515,7 +515,7 @@ static int rspi_pio_transfer(struct rspi_data *rspi, const u8 *tx, u8 *rx,
 	return 0;
 }
 
-static int rspi_pio_transfer_in_or_our(struct rspi_data *rspi, const u8 *tx, 
+static int rspi_pio_transfer_in_or_out(struct rspi_data *rspi, const u8 *tx, 
 				       u8 *rx, unsigned int n)
 {
 	unsigned int i, len;
@@ -839,7 +839,7 @@ static int qspi_transfer_out(struct rspi_data *rspi, struct spi_transfer *xfer)
 			return ret;
 	}
 
-	ret = rspi_pio_transfer_in_or_our(rspi, xfer->tx_buf, NULL, xfer->len);
+	ret = rspi_pio_transfer_in_or_out(rspi, xfer->tx_buf, NULL, xfer->len);
 	if (ret < 0)
 		return ret;
 
@@ -857,7 +857,7 @@ static int qspi_transfer_in(struct rspi_data *rspi, struct spi_transfer *xfer)
 			return ret;
 	}
 
-	return rspi_pio_transfer_in_or_our(rspi, NULL, xfer->rx_buf, xfer->len);
+	return rspi_pio_transfer_in_or_out(rspi, NULL, xfer->rx_buf, xfer->len);
 }
 
 static int qspi_transfer_one(struct spi_master *master, struct spi_device *spi,
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

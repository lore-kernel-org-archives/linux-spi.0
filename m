From: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi: core: Staticize __spi_split_transfer_maxsize()
Date: Sun, 14 Feb 2016 13:33:50 -0200
Message-ID: <1455464030-24398-1-git-send-email-festevam@gmail.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>

__spi_split_transfer_maxsize() can be made static as it is only
used in this file.

This fixes the following sparse warning:

drivers/spi/spi.c:2266:5: warning: symbol '__spi_split_transfer_maxsize' was not declared. Should it be static?

Signed-off-by: Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>
---
 drivers/spi/spi.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 1413a6b..ced6c88 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2263,11 +2263,11 @@ struct spi_replaced_transfers *spi_replace_transfers(
 }
 EXPORT_SYMBOL_GPL(spi_replace_transfers);
 
-int __spi_split_transfer_maxsize(struct spi_master *master,
-				 struct spi_message *msg,
-				 struct spi_transfer **xferp,
-				 size_t maxsize,
-				 gfp_t gfp)
+static int __spi_split_transfer_maxsize(struct spi_master *master,
+					struct spi_message *msg,
+					struct spi_transfer **xferp,
+					size_t maxsize,
+					gfp_t gfp)
 {
 	struct spi_transfer *xfer = *xferp, *xfers;
 	struct spi_replaced_transfers *srt;
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

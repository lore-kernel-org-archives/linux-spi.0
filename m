From: Moritz Fischer <moritz.fischer-+aYTwkv1SeIAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi: Fix simple typo s/impelment/implement
Date: Tue,  3 May 2016 11:59:30 -0700
Message-ID: <1462301970-27235-1-git-send-email-moritz.fischer@ettus.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	moritz.fischer.private-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	Moritz Fischer <moritz.fischer-+aYTwkv1SeIAvxtiuMwx3w@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This fixes a simple typo in one of the comments.

Signed-off-by: Moritz Fischer <moritz.fischer-+aYTwkv1SeIAvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 0239b45..af7c48d 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -933,7 +933,7 @@ static int spi_map_msg(struct spi_master *master, struct spi_message *msg)
  * spi_transfer_one_message - Default implementation of transfer_one_message()
  *
  * This is a standard implementation of transfer_one_message() for
- * drivers which impelment a transfer_one() operation.  It provides
+ * drivers which implement a transfer_one() operation.  It provides
  * standard handling of delays and chip select management.
  */
 static int spi_transfer_one_message(struct spi_master *master,
-- 
2.5.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

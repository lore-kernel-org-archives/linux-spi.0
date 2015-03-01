From: Marcin Bis <marcin-hTNZmJK687nVItvQsEIGlw@public.gmane.org>
Subject: [PATCH] spi - fix a typo in comment.
Date: Sun,  1 Mar 2015 13:49:32 +0100
Message-ID: <1425214172-23269-1-git-send-email-marcin@bis.org.pl>
Cc: trivial-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcin Bis <marcin-hTNZmJK687nVItvQsEIGlw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

alway -> always

Signed-off-by: Marcin Bis <marcin-hTNZmJK687nVItvQsEIGlw@public.gmane.org>
---
 include/linux/spi/spi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index ed9489d..856d34d 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -649,7 +649,7 @@ struct spi_transfer {
  * sequence completes.  On some systems, many such sequences can execute as
  * as single programmed DMA transfer.  On all systems, these messages are
  * queued, and might complete after transactions to other devices.  Messages
- * sent to a given spi_device are alway executed in FIFO order.
+ * sent to a given spi_device are always executed in FIFO order.
  *
  * The code that submits an spi_message (and its spi_transfers)
  * to the lower layers is responsible for managing its memory.
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

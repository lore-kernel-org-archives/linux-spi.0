From: Geliang Tang <geliangtang-9Onoh4P/yGk@public.gmane.org>
Subject: [PATCH] spi: fix kernel-doc warnings in spi.h
Date: Tue, 15 Sep 2015 04:59:21 -0700
Message-ID: <2ecb1dfb30cbac1fdd4e1884de40af896bf5975b.1442346538.git.geliangtang@163.com>
Cc: Geliang Tang <geliangtang-9Onoh4P/yGk@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Fix the following 'make htmldocs' warnings:

  .//include/linux/spi/spi.h:71: warning: No description found for parameter 'lock'
  .//include/linux/spi/spi.h:71: warning: Excess struct/union/enum/typedef member 'clock' description in 'spi_statistics'

Signed-off-by: Geliang Tang <geliangtang-9Onoh4P/yGk@public.gmane.org>
---
 include/linux/spi/spi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 269e8af..6b00f18 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -34,7 +34,7 @@ extern struct bus_type spi_bus_type;
 
 /**
  * struct spi_statistics - statistics for spi transfers
- * @clock:         lock protecting this structure
+ * @lock:          lock protecting this structure
  *
  * @messages:      number of spi-messages handled
  * @transfers:     number of spi_transfers handled
-- 
1.9.1


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

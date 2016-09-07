From: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH] tools: spi: enable CROSS_COMPILE in Makefile
Date: Wed,  7 Sep 2016 16:28:16 +0200
Message-ID: <1473258496-14565-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
To: jorge.ramirez-ortiz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 tools/spi/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/spi/Makefile b/tools/spi/Makefile
index cd0db62..d1845b0 100644
--- a/tools/spi/Makefile
+++ b/tools/spi/Makefile
@@ -1,4 +1,8 @@
+CC = $(CROSS_COMPILE)gcc
+
 all: spidev_test spidev_fdx
 
+%: %.c
+	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $<
 clean:
 	$(RM) spidev_test spidev_fdx
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

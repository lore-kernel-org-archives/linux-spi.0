From: Tiezhu Yang <yangtiezhu-cXZgJK919ebM1kAEIRd3EQ@public.gmane.org>
Subject: [PATCH 4/4] spi: spidev_test: Remove the whole "include" directory when make clean
Date: Thu, 13 Feb 2020 12:16:08 +0800
Message-ID: <1581567368-8055-4-git-send-email-yangtiezhu@loongson.cn>
References: <1581567368-8055-1-git-send-email-yangtiezhu@loongson.cn>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1581567368-8055-1-git-send-email-yangtiezhu-cXZgJK919ebM1kAEIRd3EQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

In the current code, it only removes "include/linux/spi/spidev.h" file
when make clean and there still exists useless "include/linux/spi/"
directory, just remove it.

Signed-off-by: Tiezhu Yang <yangtiezhu-cXZgJK919ebM1kAEIRd3EQ@public.gmane.org>
---
 tools/spi/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/spi/Makefile b/tools/spi/Makefile
index 5c342e6..2249a15 100644
--- a/tools/spi/Makefile
+++ b/tools/spi/Makefile
@@ -51,7 +51,7 @@ $(OUTPUT)spidev_fdx: $(SPIDEV_FDX_IN)
 
 clean:
 	rm -f $(ALL_PROGRAMS)
-	rm -f $(OUTPUT)include/linux/spi/spidev.h
+	rm -rf $(OUTPUT)include/
 	find $(if $(OUTPUT),$(OUTPUT),.) -name '*.o' -delete -o -name '\.*.d' -delete
 
 install: $(ALL_PROGRAMS)
-- 
1.8.3.1

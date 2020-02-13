From: Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: [PATCH 3/4] spi: spidev_test: Use perror() only if errno is not 0
Date: Thu, 13 Feb 2020 12:16:07 +0800
Message-ID: <1581567368-8055-3-git-send-email-yangtiezhu@loongson.cn>
References: <1581567368-8055-1-git-send-email-yangtiezhu@loongson.cn>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1581567368-8055-1-git-send-email-yangtiezhu@loongson.cn>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

It is better to use perror() only if errno is not 0, it should use printf()
when errno is 0, otherwise there exists redudant ": Success".

E.g. without this patch:

$ ./spidev_test -p 1234 --input test.bin
only one of -p and --input may be selected: Success
Aborted (core dumped)

With this patch:

$ ./spidev_test -p 1234 --input test.bin
only one of -p and --input may be selected
Aborted (core dumped)

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/spi/spidev_test.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/spi/spidev_test.c b/tools/spi/spidev_test.c
index 5866178..27967dd 100644
--- a/tools/spi/spidev_test.c
+++ b/tools/spi/spidev_test.c
@@ -13,6 +13,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include <errno.h>
 #include <getopt.h>
 #include <fcntl.h>
 #include <time.h>
@@ -26,7 +27,11 @@
 
 static void pabort(const char *s)
 {
-	perror(s);
+	if (errno != 0)
+		perror(s);
+	else
+		printf("%s\n", s);
+
 	abort();
 }
 
-- 
1.8.3.1

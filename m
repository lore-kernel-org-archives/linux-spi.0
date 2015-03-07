From: Adrian Remonda <adrianremonda@gmail.com>
Subject: [PATCH 1/4] Cleaned hexadecimal dump
Date: Sat,  7 Mar 2015 12:56:32 -0500
Message-ID: <1425750995-18176-2-git-send-email-adrianremonda@gmail.com>
References: <1425750995-18176-1-git-send-email-adrianremonda@gmail.com>
Cc: adrianremonda@gmail.com, broonie@kernel.org, corbet@lwn.net,
	linux-spi@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425750995-18176-1-git-send-email-adrianremonda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


Signed-off-by: Adrian Remonda <adrianremonda@gmail.com>
---
 Documentation/spi/spidev_test.c |   35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/Documentation/spi/spidev_test.c b/Documentation/spi/spidev_test.c
index 3a2f9d59edab..533050ced9f1 100644
--- a/Documentation/spi/spidev_test.c
+++ b/Documentation/spi/spidev_test.c
@@ -15,6 +15,7 @@
 #include <unistd.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <getopt.h>
 #include <fcntl.h>
 #include <sys/ioctl.h>
@@ -35,6 +36,33 @@ static uint8_t bits = 8;
 static uint32_t speed = 500000;
 static uint16_t delay;
 
+static void hexDump(const void *src, size_t length, size_t bLine, char *prefix)
+{
+	int i = 0;
+	char *address = (char *)src;
+	char *line = (char *)address;
+	unsigned char c;
+
+	printf("%s | ", prefix);
+	while (length-- > 0) {
+		printf("%02X ", (unsigned char)*address++);
+		if (!(++i % bLine) || (length == 0 && i % bLine)) {
+			if (length == 0) {
+				while (i++ % bLine)
+					printf("__ ");
+			}
+			printf(" | ");  /* right close */
+			while (line < address) {
+				c = *line++;
+				printf("%c", (c < 33 || c == 255) ? 0x2E : c);
+			}
+			printf("\n");
+			if (length > 0)
+				printf("%s | ", prefix);
+		}
+	}
+}
+
 static void transfer(int fd)
 {
 	int ret;
@@ -76,12 +104,7 @@ static void transfer(int fd)
 	if (ret < 1)
 		pabort("can't send spi message");
 
-	for (ret = 0; ret < ARRAY_SIZE(tx); ret++) {
-		if (!(ret % 6))
-			puts("");
-		printf("%.2X ", rx[ret]);
-	}
-	puts("");
+	hexDump(rx, ARRAY_SIZE(tx), 32, "RX");
 }
 
 static void print_usage(const char *prog)
-- 
1.7.10.4

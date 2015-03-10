From: Adrian Remonda <adrianremonda@gmail.com>
Subject: [PATCHv2 1/4] Cleaned hexadecimal dump
Date: Tue, 10 Mar 2015 16:12:30 -0400
Message-ID: <1426018353-13442-2-git-send-email-adrianremonda@gmail.com>
References: <1426018353-13442-1-git-send-email-adrianremonda@gmail.com>
Cc: adrianremonda@gmail.com, broonie@kernel.org, corbet@lwn.net,
	linux-spi@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1426018353-13442-1-git-send-email-adrianremonda@gmail.com>
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

	v2: Fixed coding style and removed unnecessary castings
	As noted by Geert Uytterhoeven and Mark Brown

	modified:   Documentation/spi/spidev_test.c

Signed-off-by: Adrian Remonda <adrianremonda@gmail.com>
---
 Documentation/spi/spidev_test.c |   35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/Documentation/spi/spidev_test.c b/Documentation/spi/spidev_test.c
index 3a2f9d59edab..9cb09184a3d6 100644
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
 
+static void hex_dump(const void *src, size_t length, size_t line_size, char *prefix)
+{
+	int i = 0;
+	const unsigned char *address = src;
+	const unsigned char *line = address;
+	unsigned char c;
+
+	printf("%s | ", prefix);
+	while (length-- > 0) {
+		printf("%02X ", *address++);
+		if (!(++i % line_size) || (length == 0 && i % line_size)) {
+			if (length == 0) {
+				while (i++ % line_size)
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
+	hex_dump(rx, ARRAY_SIZE(rx), 32, "RX");
 }
 
 static void print_usage(const char *prog)
-- 
1.7.10.4


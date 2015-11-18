From: Joshua Clayton <stillcompiling@gmail.com>
Subject: [PATCH v2 5/6] spi: spidev_test: check error
Date: Wed, 18 Nov 2015 14:30:41 -0800
Message-ID: <2bbb0374d7fd390a04ceb8d7b552f1a8d946c0f0.1447880230.git.stillcompiling@gmail.com>
References: <cover.1447880230.git.stillcompiling@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Anton Bondarenko <anton.bondarenko.sama@gmail.com>,
	Joshua Clayton <stillcompiling@gmail.com>
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1447880230.git.stillcompiling@gmail.com>
In-Reply-To: <cover.1447880230.git.stillcompiling@gmail.com>
References: <cover.1447880230.git.stillcompiling@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Check the result of sscanf to verify a result was found.
report and error and abort if pattern was not found.

Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
---
 tools/spi/spidev_test.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/spi/spidev_test.c b/tools/spi/spidev_test.c
index 02fc3a4..322370d 100644
--- a/tools/spi/spidev_test.c
+++ b/tools/spi/spidev_test.c
@@ -86,13 +86,17 @@ static void hex_dump(const void *src, size_t length, size_t line_size, char *pre
 static int unescape(char *_dst, char *_src, size_t len)
 {
 	int ret = 0;
+	int match;
 	char *src = _src;
 	char *dst = _dst;
 	unsigned int ch;
 
 	while (*src) {
 		if (*src == '\\' && *(src+1) == 'x') {
-			sscanf(src + 2, "%2x", &ch);
+			match = sscanf(src + 2, "%2x", &ch);
+			if (!match)
+				pabort("malformed input string");
+
 			src += 4;
 			*dst++ = (unsigned char)ch;
 		} else {
-- 
2.5.0

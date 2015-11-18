From: Joshua Clayton <stillcompiling@gmail.com>
Subject: [PATCH v2 6/6] spi: spidev_test: fix whitespace
Date: Wed, 18 Nov 2015 14:30:42 -0800
Message-ID: <0365b51d6bfd3002287a1ebe382e58a2766aa2d2.1447880230.git.stillcompiling@gmail.com>
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

Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
---
 tools/spi/spidev_test.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/spi/spidev_test.c b/tools/spi/spidev_test.c
index 322370d..eddfc33 100644
--- a/tools/spi/spidev_test.c
+++ b/tools/spi/spidev_test.c
@@ -52,7 +52,8 @@ uint8_t default_tx[] = {
 uint8_t default_rx[ARRAY_SIZE(default_tx)] = {0, };
 char *input_tx;
 
-static void hex_dump(const void *src, size_t length, size_t line_size, char *prefix)
+static void hex_dump(const void *src, size_t length, size_t line_size,
+		     char *prefix)
 {
 	int i = 0;
 	const unsigned char *address = src;
@@ -164,7 +165,7 @@ static void print_usage(const char *prog)
 	puts("  -D --device   device to use (default /dev/spidev1.1)\n"
 	     "  -s --speed    max speed (Hz)\n"
 	     "  -d --delay    delay (usec)\n"
-	     "  -b --bpw      bits per word \n"
+	     "  -b --bpw      bits per word\n"
 	     "  -i --input    input data from a file (e.g. \"test.bin\")\n"
 	     "  -o --output   output data to a file (e.g. \"results.bin\")\n"
 	     "  -l --loop     loopback\n"
-- 
2.5.0

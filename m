From: Joshua Clayton <stillcompiling@gmail.com>
Subject: [PATCH 6/8] Documentation/spi/spidev_test.c: fix whitespace
Date: Tue, 17 Nov 2015 07:24:26 -0800
Message-ID: <27567ecdb418006e2a0a5b60d291ab00e47adc45.1447773299.git.stillcompiling@gmail.com>
References: <cover.1447773299.git.stillcompiling@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Adrian Remonda <adrianremonda@gmail.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org,
	Joshua Clayton <stillcompiling@gmail.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1447773299.git.stillcompiling@gmail.com>
In-Reply-To: <cover.1447773299.git.stillcompiling@gmail.com>
References: <cover.1447773299.git.stillcompiling@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
---
 Documentation/spi/spidev_test.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/spi/spidev_test.c b/Documentation/spi/spidev_test.c
index 2ff5fe8..bf6070c 100644
--- a/Documentation/spi/spidev_test.c
+++ b/Documentation/spi/spidev_test.c
@@ -51,7 +51,8 @@ uint8_t default_tx[] = {
 
 char *input_tx;
 
-static void hex_dump(const void *src, size_t length, size_t line_size, char *prefix)
+static void hex_dump(const void *src, size_t length, size_t line_size,
+		     char *prefix)
 {
 	int i = 0;
 	const unsigned char *address = src;
@@ -166,7 +167,7 @@ static void print_usage(const char *prog)
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

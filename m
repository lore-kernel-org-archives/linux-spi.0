From: Adrian Remonda <adrianremonda@gmail.com>
Subject: [PATCH 2/4] Added verbose output
Date: Sat,  7 Mar 2015 12:56:33 -0500
Message-ID: <1425750995-18176-3-git-send-email-adrianremonda@gmail.com>
References: <1425750995-18176-1-git-send-email-adrianremonda@gmail.com>
 <1425750995-18176-2-git-send-email-adrianremonda@gmail.com>
Cc: adrianremonda@gmail.com, broonie@kernel.org, corbet@lwn.net,
	linux-spi@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425750995-18176-2-git-send-email-adrianremonda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


Signed-off-by: Adrian Remonda <adrianremonda@gmail.com>
---
 Documentation/spi/spidev_test.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/spi/spidev_test.c b/Documentation/spi/spidev_test.c
index 533050ced9f1..a247b3dbf65a 100644
--- a/Documentation/spi/spidev_test.c
+++ b/Documentation/spi/spidev_test.c
@@ -35,6 +35,7 @@ static uint32_t mode;
 static uint8_t bits = 8;
 static uint32_t speed = 500000;
 static uint16_t delay;
+static int verbose;
 
 static void hexDump(const void *src, size_t length, size_t bLine, char *prefix)
 {
@@ -104,7 +105,9 @@ static void transfer(int fd)
 	if (ret < 1)
 		pabort("can't send spi message");
 
-	hexDump(rx, ARRAY_SIZE(tx), 32, "RX");
+	if (verbose)
+		hexDump(tx, ARRAY_SIZE(tx), 32, "TX");
+	hexDump(rx, ARRAY_SIZE(rx), 32, "RX");
 }
 
 static void print_usage(const char *prog)
@@ -120,6 +123,7 @@ static void print_usage(const char *prog)
 	     "  -L --lsb      least significant bit first\n"
 	     "  -C --cs-high  chip select active high\n"
 	     "  -3 --3wire    SI/SO signals shared\n"
+	     "  -v --verbose  Verbose (show tx buffer)\n"
 	     "  -N --no-cs    no chip select\n"
 	     "  -R --ready    slave pulls low to pause\n"
 	     "  -2 --dual     dual transfer\n"
@@ -144,12 +148,13 @@ static void parse_opts(int argc, char *argv[])
 			{ "no-cs",   0, 0, 'N' },
 			{ "ready",   0, 0, 'R' },
 			{ "dual",    0, 0, '2' },
+			{ "verbose", 0, 0, 'v' },
 			{ "quad",    0, 0, '4' },
 			{ NULL, 0, 0, 0 },
 		};
 		int c;
 
-		c = getopt_long(argc, argv, "D:s:d:b:lHOLC3NR24", lopts, NULL);
+		c = getopt_long(argc, argv, "D:s:d:b:lHOLC3NR24:v", lopts, NULL);
 
 		if (c == -1)
 			break;
@@ -188,6 +193,9 @@ static void parse_opts(int argc, char *argv[])
 		case 'N':
 			mode |= SPI_NO_CS;
 			break;
+		case 'v':
+			verbose = 1;
+			break;
 		case 'R':
 			mode |= SPI_READY;
 			break;
-- 
1.7.10.4

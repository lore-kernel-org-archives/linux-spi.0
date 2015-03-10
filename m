From: Adrian Remonda <adrianremonda@gmail.com>
Subject: [PATCHv2 3/4] Added input buffer from the terminal
Date: Tue, 10 Mar 2015 16:12:32 -0400
Message-ID: <1426018353-13442-4-git-send-email-adrianremonda@gmail.com>
References: <1426018353-13442-1-git-send-email-adrianremonda@gmail.com>
 <1426018353-13442-2-git-send-email-adrianremonda@gmail.com>
 <1426018353-13442-3-git-send-email-adrianremonda@gmail.com>
Cc: adrianremonda@gmail.com, broonie@kernel.org, corbet@lwn.net,
	linux-spi@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426018353-13442-3-git-send-email-adrianremonda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

	Now it is possible to send string and hexadecimal data as an input parameter
	
	v2: Fixed coding style and removed unnecessary castings from malloc
	Noted by Mark Brown

	modified:   Documentation/spi/spidev_test.c

Signed-off-by: Adrian Remonda <adrianremonda@gmail.com>
---
 Documentation/spi/spidev_test.c |   76 ++++++++++++++++++++++++++++++---------
 1 file changed, 60 insertions(+), 16 deletions(-)

diff --git a/Documentation/spi/spidev_test.c b/Documentation/spi/spidev_test.c
index 4b6a3803638b..94f574b0fdb2 100644
--- a/Documentation/spi/spidev_test.c
+++ b/Documentation/spi/spidev_test.c
@@ -37,6 +37,18 @@ static uint32_t speed = 500000;
 static uint16_t delay;
 static int verbose;
 
+uint8_t default_tx[] = {
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
+	0x40, 0x00, 0x00, 0x00, 0x00, 0x95,
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
+	0xF0, 0x0D,
+};
+
+uint8_t default_rx[ARRAY_SIZE(default_tx)] = {0, };
+char *input_tx;
+
 static void hex_dump(const void *src, size_t length, size_t line_size, char *prefix)
 {
 	int i = 0;
@@ -64,23 +76,38 @@ static void hex_dump(const void *src, size_t length, size_t line_size, char *pre
 	}
 }
 
-static void transfer(int fd)
+/*
+ *  Unescape - process hexadecimal escape character
+ *      converts shell input "\x23" -> 0x23
+ */
+int unespcape(char *_dst, char *_src, size_t len)
+{
+	int ret = 0;
+	char *src = _src;
+	char *dst = _dst;
+	unsigned int ch;
+
+	while (*src) {
+		if (*src == '\\' && *(src+1) == 'x') {
+			sscanf(src + 2, "%2x", &ch);
+			src += 4;
+			*dst++ = (unsigned char)ch;
+		} else {
+			*dst++ = *src++;
+		}
+		ret++;
+	}
+	return ret;
+}
+
+static void transfer(int fd, uint8_t const *tx, uint8_t const *rx, size_t len)
 {
 	int ret;
-	uint8_t tx[] = {
-		0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
-		0x40, 0x00, 0x00, 0x00, 0x00, 0x95,
-		0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
-		0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
-		0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
-		0xDE, 0xAD, 0xBE, 0xEF, 0xBA, 0xAD,
-		0xF0, 0x0D,
-	};
-	uint8_t rx[ARRAY_SIZE(tx)] = {0, };
+
 	struct spi_ioc_transfer tr = {
 		.tx_buf = (unsigned long)tx,
 		.rx_buf = (unsigned long)rx,
-		.len = ARRAY_SIZE(tx),
+		.len = len,
 		.delay_usecs = delay,
 		.speed_hz = speed,
 		.bits_per_word = bits,
@@ -106,8 +133,8 @@ static void transfer(int fd)
 		pabort("can't send spi message");
 
 	if (verbose)
-		hex_dump(tx, ARRAY_SIZE(tx), 32, "TX");
-	hex_dump(rx, ARRAY_SIZE(rx), 32, "RX");
+		hex_dump(tx, len, 32, "TX");
+	hex_dump(rx, len, 32, "RX");
 }
 
 static void print_usage(const char *prog)
@@ -124,6 +151,7 @@ static void print_usage(const char *prog)
 	     "  -C --cs-high  chip select active high\n"
 	     "  -3 --3wire    SI/SO signals shared\n"
 	     "  -v --verbose  Verbose (show tx buffer)\n"
+	     "  -p            Send data (e.g. \"1234\\xde\\xad\")\n"
 	     "  -N --no-cs    no chip select\n"
 	     "  -R --ready    slave pulls low to pause\n"
 	     "  -2 --dual     dual transfer\n"
@@ -154,7 +182,7 @@ static void parse_opts(int argc, char *argv[])
 		};
 		int c;
 
-		c = getopt_long(argc, argv, "D:s:d:b:lHOLC3NR24:v", lopts, NULL);
+		c = getopt_long(argc, argv, "D:s:d:b:lHOLC3NR24p:v", lopts, NULL);
 
 		if (c == -1)
 			break;
@@ -199,6 +227,9 @@ static void parse_opts(int argc, char *argv[])
 		case 'R':
 			mode |= SPI_READY;
 			break;
+		case 'p':
+			input_tx = optarg;
+			break;
 		case '2':
 			mode |= SPI_TX_DUAL;
 			break;
@@ -222,6 +253,9 @@ int main(int argc, char *argv[])
 {
 	int ret = 0;
 	int fd;
+	uint8_t *tx;
+	uint8_t *rx;
+	int size;
 
 	parse_opts(argc, argv);
 
@@ -266,7 +300,17 @@ int main(int argc, char *argv[])
 	printf("bits per word: %d\n", bits);
 	printf("max speed: %d Hz (%d KHz)\n", speed, speed/1000);
 
-	transfer(fd);
+	if (input_tx) {
+		size = strlen(input_tx+1);
+		tx = malloc(size);
+		rx = malloc(size);
+		size = unespcape((char *)tx, input_tx, size);
+		transfer(fd, tx, rx, size);
+		free(rx);
+		free(tx);
+	} else {
+		transfer(fd, default_tx, default_rx, sizeof(default_tx));
+	}
 
 	close(fd);
 
-- 
1.7.10.4

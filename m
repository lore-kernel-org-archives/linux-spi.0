From: Adrian Remonda <adrianremonda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi: spidev_test: Added functionalities
Date: Wed, 25 Feb 2015 20:08:44 +0100
Message-ID: <1424891324-24784-1-git-send-email-adrianremonda@gmail.com>
Cc: Adrian Remonda <adrianremonda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org (open list:SPI SUBSYSTEM),
	linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org (open list:DOCUMENTATION),
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org (open list)
To: unlisted-recipients:; (no To-header on input)
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This is a patch that add functionalities to the spidev_test tool found
in Documentation/spi/spidev_test.c.

- Cleaned hexadecimal dump
- Added verbose mode to see the transmitting sequence
- Added input buffer from the terminal. Now it is possible to send
  string and hexadecimal data as an input parameter:

  Example that shows verbose mode and a sending sequence:

  root@microZed:~# ./a.out -D /dev/spidev32766.1 -p "\x23ab1" -v
  spi mode: 0x0
  bits per word: 8
  max speed: 500000 Hz (500 KHz)
  TX | 23 61 62 31 __ __ __ __  | #ab1
  RX | FF FF FF FF __ __ __ __  | ....

	modified:   Documentation/spi/spidev_test.c

Signed-off-by: Adrian Remonda <adrianremonda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 Documentation/spi/spidev_test.c | 118 +++++++++++++++++++++++++++++++++-------
 1 file changed, 98 insertions(+), 20 deletions(-)

diff --git a/Documentation/spi/spidev_test.c b/Documentation/spi/spidev_test.c
index 3a2f9d59edab..7fe5ba4b9072 100644
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
@@ -34,24 +35,55 @@ static uint32_t mode;
 static uint8_t bits = 8;
 static uint32_t speed = 500000;
 static uint16_t delay;
+static int verbose;
 
-static void transfer(int fd)
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
@@ -76,27 +108,54 @@ static void transfer(int fd)
 	if (ret < 1)
 		pabort("can't send spi message");
 
-	for (ret = 0; ret < ARRAY_SIZE(tx); ret++) {
-		if (!(ret % 6))
-			puts("");
-		printf("%.2X ", rx[ret]);
+	if (verbose)
+		hexDump(tx, len, 32, "TX");
+	hexDump(rx, len, 32, "RX");
+}
+
+/*
+ *  Unescape - process hexadecimal escape character
+ *      converts shell input "\x23" -> 0x23
+ */
+int unespcape(char *dst, char *src, size_t len)
+{
+	int ret = 0;
+	char *pSrc = src;
+	char *pDst = dst;
+	unsigned int ch;
+
+	while (*pSrc) {
+		if (*pSrc == '\\' && *(pSrc+1) == 'x') {
+			sscanf(pSrc + 2, "%2x", &ch);
+			pSrc += 4;
+			*pDst++ = (unsigned char)ch;
+		} else {
+			*pDst++ = *pSrc++;
+		}
+
+
+		ret++;
 	}
-	puts("");
+	return ret;
+
 }
 
 static void print_usage(const char *prog)
 {
+
 	printf("Usage: %s [-DsbdlHOLC3]\n", prog);
 	puts("  -D --device   device to use (default /dev/spidev1.1)\n"
 	     "  -s --speed    max speed (Hz)\n"
 	     "  -d --delay    delay (usec)\n"
-	     "  -b --bpw      bits per word \n"
+	     "  -b --bpw      bits per word\n"
 	     "  -l --loop     loopback\n"
 	     "  -H --cpha     clock phase\n"
 	     "  -O --cpol     clock polarity\n"
 	     "  -L --lsb      least significant bit first\n"
 	     "  -C --cs-high  chip select active high\n"
 	     "  -3 --3wire    SI/SO signals shared\n"
+	     "  -v --verbose  Verbose (show tx buffer)\n"
+	     "  -p            Send data (e.g. \"1234\\xde\\xad\")\n"
 	     "  -N --no-cs    no chip select\n"
 	     "  -R --ready    slave pulls low to pause\n"
 	     "  -2 --dual     dual transfer\n"
@@ -120,13 +179,14 @@ static void parse_opts(int argc, char *argv[])
 			{ "3wire",   0, 0, '3' },
 			{ "no-cs",   0, 0, 'N' },
 			{ "ready",   0, 0, 'R' },
+			{ "verbose", 0, 0, 'v' },
 			{ "dual",    0, 0, '2' },
 			{ "quad",    0, 0, '4' },
 			{ NULL, 0, 0, 0 },
 		};
 		int c;
 
-		c = getopt_long(argc, argv, "D:s:d:b:lHOLC3NR24", lopts, NULL);
+		c = getopt_long(argc, argv, "D:s:d:b:lHOLC3NR24p:v", lopts, NULL);
 
 		if (c == -1)
 			break;
@@ -168,6 +228,11 @@ static void parse_opts(int argc, char *argv[])
 		case 'R':
 			mode |= SPI_READY;
 			break;
+		case 'p':
+			input_tx = optarg;
+			break;
+		case 'v':
+			verbose = 1;
 		case '2':
 			mode |= SPI_TX_DUAL;
 			break;
@@ -191,6 +256,9 @@ int main(int argc, char *argv[])
 {
 	int ret = 0;
 	int fd;
+	int size;
+	uint8_t *tx;
+	uint8_t *rx;
 
 	parse_opts(argc, argv);
 
@@ -235,7 +303,17 @@ int main(int argc, char *argv[])
 	printf("bits per word: %d\n", bits);
 	printf("max speed: %d Hz (%d KHz)\n", speed, speed/1000);
 
-	transfer(fd);
+	if (input_tx) {
+		size = strlen(input_tx+1);
+		tx = (uint8_t *)malloc(size);
+		rx = (uint8_t *)malloc(size);
+		size = unespcape((char *)tx, input_tx, size);
+		transfer(fd, tx, rx, size);
+		free(rx);
+		free(tx);
+	} else {
+		transfer(fd, default_tx, default_rx, sizeof(default_tx));
+	}
 
 	close(fd);
 
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

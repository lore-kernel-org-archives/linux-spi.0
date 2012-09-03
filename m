From: Jan Luebbe <jlu@pengutronix.de>
Subject: [PATCH] spidev_test.c: extend the spidev_test tool to read a command file
Date: Mon,  3 Sep 2012 15:01:47 +0200
Message-ID: <1346677307-17141-1-git-send-email-jlu@pengutronix.de>
Cc: spi-devel-general@lists.sourceforge.net, linux-doc@vger.kernel.org,
	Jan Luebbe <jlu@pengutronix.de>
To: Grant Likely <grant.likely@secretlab.ca>,
	Rob Landley <rob@landley.net>
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Currently, spidev_test.c always sends hardcoded data to the device.
By fetching this data from a file given as a parameter, one can test
real devices.

Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
---
 Documentation/spi/spidev_test.c |   73 +++++++++++++++++++++++++++++++--------
 1 file changed, 58 insertions(+), 15 deletions(-)

diff --git a/Documentation/spi/spidev_test.c b/Documentation/spi/spidev_test.c
index 16feda9..bbb0090 100644
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
@@ -30,38 +31,73 @@ static void pabort(const char *s)
 }
 
 static const char *device = "/dev/spidev1.1";
+static const char *command = NULL;
 static uint8_t mode;
 static uint8_t bits = 8;
 static uint32_t speed = 500000;
 static uint16_t delay;
 
+uint8_t dummy[] = {
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
+	0x40, 0x00, 0x00, 0x00, 0x00, 0x95,
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
+	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
+	0xDE, 0xAD, 0xBE, 0xEF, 0xBA, 0xAD,
+	0xF0, 0x0D,
+};
+uint8_t *tx, *rx;
+int len = ARRAY_SIZE(dummy);
+
+static void prepare()
+{
+	int fd;
+	tx = malloc(len);
+	if (!tx)
+		pabort("can't allocate tx buffer");
+	rx = malloc(len);
+	if (!rx)
+		pabort("can't allocate rx buffer");
+	memset(tx, 0xff, len);
+	memset(rx, 0xff, len);
+	if (!command) {
+		memcpy(tx, dummy, len);
+		return;
+	}
+	fd = open(command, O_RDONLY);
+	if (fd < 0)
+		pabort("can't open command file");
+	len = read(fd, tx, len);
+	if (len < 0)
+		pabort("can't read command file");
+}
+
 static void transfer(int fd)
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
 	struct spi_ioc_transfer tr = {
 		.tx_buf = (unsigned long)tx,
 		.rx_buf = (unsigned long)rx,
-		.len = ARRAY_SIZE(tx),
+		.len = len,
 		.delay_usecs = delay,
 		.speed_hz = speed,
 		.bits_per_word = bits,
 	};
 
+	printf("sending:\n");
+	for (ret = 0; ret < len; ret++) {
+		if (!(ret % 6))
+			puts("");
+		printf("%.2X ", tx[ret]);
+	}
+	puts("");
+
 	ret = ioctl(fd, SPI_IOC_MESSAGE(1), &tr);
 	if (ret < 1)
 		pabort("can't send spi message");
 
-	for (ret = 0; ret < ARRAY_SIZE(tx); ret++) {
+	printf("received:\n");
+	for (ret = 0; ret < len; ret++) {
 		if (!(ret % 6))
 			puts("");
 		printf("%.2X ", rx[ret]);
@@ -71,11 +107,12 @@ static void transfer(int fd)
 
 static void print_usage(const char *prog)
 {
-	printf("Usage: %s [-DsbdlHOLC3]\n", prog);
+	printf("Usage: %s [-DcsbdlHOLC3]\n", prog);
 	puts("  -D --device   device to use (default /dev/spidev1.1)\n"
+	     "  -c --command  command file\n"
 	     "  -s --speed    max speed (Hz)\n"
 	     "  -d --delay    delay (usec)\n"
-	     "  -b --bpw      bits per word \n"
+	     "  -b --bpw      bits per word\n"
 	     "  -l --loop     loopback\n"
 	     "  -H --cpha     clock phase\n"
 	     "  -O --cpol     clock polarity\n"
@@ -90,6 +127,7 @@ static void parse_opts(int argc, char *argv[])
 	while (1) {
 		static const struct option lopts[] = {
 			{ "device",  1, 0, 'D' },
+			{ "command", 1, 0, 'c' },
 			{ "speed",   1, 0, 's' },
 			{ "delay",   1, 0, 'd' },
 			{ "bpw",     1, 0, 'b' },
@@ -105,7 +143,7 @@ static void parse_opts(int argc, char *argv[])
 		};
 		int c;
 
-		c = getopt_long(argc, argv, "D:s:d:b:lHOLC3NR", lopts, NULL);
+		c = getopt_long(argc, argv, "D:c:s:d:b:lHOLC3NR", lopts, NULL);
 
 		if (c == -1)
 			break;
@@ -114,6 +152,9 @@ static void parse_opts(int argc, char *argv[])
 		case 'D':
 			device = optarg;
 			break;
+		case 'c':
+			command = optarg;
+			break;
 		case 's':
 			speed = atoi(optarg);
 			break;
@@ -161,6 +202,8 @@ int main(int argc, char *argv[])
 
 	parse_opts(argc, argv);
 
+	prepare();
+
 	fd = open(device, O_RDWR);
 	if (fd < 0)
 		pabort("can't open device");
-- 
1.7.10.4


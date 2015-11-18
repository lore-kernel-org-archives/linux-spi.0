From: Joshua Clayton <stillcompiling@gmail.com>
Subject: [PATCH v2 3/6] spi: spidev_test: accept input from a file
Date: Wed, 18 Nov 2015 14:30:39 -0800
Message-ID: <783ea7346741b23f17c73a13f03f64ac17de8c2e.1447880230.git.stillcompiling@gmail.com>
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

Add input file support to facilitate testing larger data.

Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
---
 tools/spi/spidev_test.c | 48 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/tools/spi/spidev_test.c b/tools/spi/spidev_test.c
index f9d2957..71a45a4 100644
--- a/tools/spi/spidev_test.c
+++ b/tools/spi/spidev_test.c
@@ -19,6 +19,7 @@
 #include <getopt.h>
 #include <fcntl.h>
 #include <sys/ioctl.h>
+#include <sys/stat.h>
 #include <linux/types.h>
 #include <linux/spi/spidev.h>
 
@@ -33,6 +34,7 @@ static void pabort(const char *s)
 static const char *device = "/dev/spidev1.1";
 static uint32_t mode;
 static uint8_t bits = 8;
+static char *input_file;
 static uint32_t speed = 500000;
 static uint16_t delay;
 static int verbose;
@@ -144,6 +146,7 @@ static void print_usage(const char *prog)
 	     "  -s --speed    max speed (Hz)\n"
 	     "  -d --delay    delay (usec)\n"
 	     "  -b --bpw      bits per word \n"
+	     "  -i --input    input data from a file (e.g. \"test.bin\")\n"
 	     "  -l --loop     loopback\n"
 	     "  -H --cpha     clock phase\n"
 	     "  -O --cpol     clock polarity\n"
@@ -167,6 +170,7 @@ static void parse_opts(int argc, char *argv[])
 			{ "speed",   1, 0, 's' },
 			{ "delay",   1, 0, 'd' },
 			{ "bpw",     1, 0, 'b' },
+			{ "input",   1, 0, 'i' },
 			{ "loop",    0, 0, 'l' },
 			{ "cpha",    0, 0, 'H' },
 			{ "cpol",    0, 0, 'O' },
@@ -182,7 +186,8 @@ static void parse_opts(int argc, char *argv[])
 		};
 		int c;
 
-		c = getopt_long(argc, argv, "D:s:d:b:lHOLC3NR24p:v", lopts, NULL);
+		c = getopt_long(argc, argv, "D:s:d:b:i:lHOLC3NR24p:v",
+				lopts, NULL);
 
 		if (c == -1)
 			break;
@@ -200,6 +205,9 @@ static void parse_opts(int argc, char *argv[])
 		case 'b':
 			bits = atoi(optarg);
 			break;
+		case 'i':
+			input_file = optarg;
+			break;
 		case 'l':
 			mode |= SPI_LOOP;
 			break;
@@ -269,6 +277,39 @@ static void transfer_escaped_string(int fd, char *str)
 	free(tx);
 }
 
+static void transfer_file(int fd, char *filename)
+{
+	ssize_t bytes;
+	struct stat sb;
+	int tx_fd;
+	uint8_t *tx;
+	uint8_t *rx;
+
+	if (stat(filename, &sb) == -1)
+		pabort("can't stat input file");
+
+	tx_fd = open(filename, O_RDONLY);
+	if (fd < 0)
+		pabort("can't open input file");
+
+	tx = malloc(sb.st_size);
+	if (!tx)
+		pabort("can't allocate tx buffer");
+
+	rx = malloc(sb.st_size);
+	if (!rx)
+		pabort("can't allocate rx buffer");
+
+	bytes = read(tx_fd, tx, sb.st_size);
+	if (bytes != sb.st_size)
+		pabort("failed to read input file");
+
+	transfer(fd, tx, rx, sb.st_size);
+	free(rx);
+	free(tx);
+	close(tx_fd);
+}
+
 int main(int argc, char *argv[])
 {
 	int ret = 0;
@@ -317,8 +358,13 @@ int main(int argc, char *argv[])
 	printf("bits per word: %d\n", bits);
 	printf("max speed: %d Hz (%d KHz)\n", speed, speed/1000);
 
+	if (input_tx && input_file)
+		pabort("only one of -p and --input may be selected");
+
 	if (input_tx)
 		transfer_escaped_string(fd, input_tx);
+	else if (input_file)
+		transfer_file(fd, input_file);
 	else
 		transfer(fd, default_tx, default_rx, sizeof(default_tx));
 
-- 
2.5.0

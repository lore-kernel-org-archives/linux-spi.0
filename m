From: Joshua Clayton <stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 4/6] spi: spidev_test: output to a file
Date: Wed, 18 Nov 2015 14:30:40 -0800
Message-ID: <9ef02d085de706dfbf7eb57370ce33f076dfd9ce.1447880230.git.stillcompiling@gmail.com>
References: <cover.1447880230.git.stillcompiling@gmail.com>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Anton Bondarenko <anton.bondarenko.sama-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Joshua Clayton <stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1447880230.git.stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
In-Reply-To: <cover.1447880230.git.stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
References: <cover.1447880230.git.stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

For testing of larger data transfers, output unmodified data
directly to a file.

Signed-off-by: Joshua Clayton <stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 tools/spi/spidev_test.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/tools/spi/spidev_test.c b/tools/spi/spidev_test.c
index 71a45a4..02fc3a4 100644
--- a/tools/spi/spidev_test.c
+++ b/tools/spi/spidev_test.c
@@ -35,6 +35,7 @@ static const char *device = "/dev/spidev1.1";
 static uint32_t mode;
 static uint8_t bits = 8;
 static char *input_file;
+static char *output_file;
 static uint32_t speed = 500000;
 static uint16_t delay;
 static int verbose;
@@ -105,7 +106,7 @@ static int unescape(char *_dst, char *_src, size_t len)
 static void transfer(int fd, uint8_t const *tx, uint8_t const *rx, size_t len)
 {
 	int ret;
-
+	int out_fd;
 	struct spi_ioc_transfer tr = {
 		.tx_buf = (unsigned long)tx,
 		.rx_buf = (unsigned long)rx,
@@ -136,7 +137,21 @@ static void transfer(int fd, uint8_t const *tx, uint8_t const *rx, size_t len)
 
 	if (verbose)
 		hex_dump(tx, len, 32, "TX");
-	hex_dump(rx, len, 32, "RX");
+
+	if (output_file) {
+		out_fd = open(output_file, O_WRONLY | O_CREAT | O_TRUNC, 0666);
+		if (out_fd < 0)
+			pabort("could not open output file");
+
+		ret = write(out_fd, rx, len);
+		if (ret != len)
+			pabort("not all bytes written to utput file");
+
+		close(out_fd);
+	}
+
+	if (verbose || !output_file)
+		hex_dump(rx, len, 32, "RX");
 }
 
 static void print_usage(const char *prog)
@@ -147,6 +162,7 @@ static void print_usage(const char *prog)
 	     "  -d --delay    delay (usec)\n"
 	     "  -b --bpw      bits per word \n"
 	     "  -i --input    input data from a file (e.g. \"test.bin\")\n"
+	     "  -o --output   output data to a file (e.g. \"results.bin\")\n"
 	     "  -l --loop     loopback\n"
 	     "  -H --cpha     clock phase\n"
 	     "  -O --cpol     clock polarity\n"
@@ -171,6 +187,7 @@ static void parse_opts(int argc, char *argv[])
 			{ "delay",   1, 0, 'd' },
 			{ "bpw",     1, 0, 'b' },
 			{ "input",   1, 0, 'i' },
+			{ "output",  1, 0, 'o' },
 			{ "loop",    0, 0, 'l' },
 			{ "cpha",    0, 0, 'H' },
 			{ "cpol",    0, 0, 'O' },
@@ -186,7 +203,7 @@ static void parse_opts(int argc, char *argv[])
 		};
 		int c;
 
-		c = getopt_long(argc, argv, "D:s:d:b:i:lHOLC3NR24p:v",
+		c = getopt_long(argc, argv, "D:s:d:b:i:o:lHOLC3NR24p:v",
 				lopts, NULL);
 
 		if (c == -1)
@@ -208,6 +225,9 @@ static void parse_opts(int argc, char *argv[])
 		case 'i':
 			input_file = optarg;
 			break;
+		case 'o':
+			output_file = optarg;
+			break;
 		case 'l':
 			mode |= SPI_LOOP;
 			break;
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

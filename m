From: Joshua Clayton <stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 4/8] Documentation/spi/spidev_test.c: output to a file
Date: Tue, 17 Nov 2015 07:24:24 -0800
Message-ID: <a28708ec4d050be02e5f8c50095efd1c577f9e66.1447773299.git.stillcompiling@gmail.com>
References: <cover.1447773299.git.stillcompiling@gmail.com>
Cc: Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>,
	Adrian Remonda <adrianremonda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Joshua Clayton <stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1447773299.git.stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
In-Reply-To: <cover.1447773299.git.stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
References: <cover.1447773299.git.stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

For testing of larger data transfers, output unmodified data
directly to a file.

Signed-off-by: Joshua Clayton <stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 Documentation/spi/spidev_test.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/Documentation/spi/spidev_test.c b/Documentation/spi/spidev_test.c
index ef812ad..273f667 100644
--- a/Documentation/spi/spidev_test.c
+++ b/Documentation/spi/spidev_test.c
@@ -35,6 +35,7 @@ static const char *device = "/dev/spidev1.1";
 static uint32_t mode;
 static uint8_t bits = 8;
 static char *input_file;
+static char *output_file;
 static uint32_t speed = 500000;
 static uint16_t delay;
 static int verbose;
@@ -104,6 +105,7 @@ static int unescape(char *_dst, char *_src, size_t len)
 static void transfer(int fd, uint8_t const *tx, size_t len)
 {
 	int ret;
+	int out_fd;
 	uint8_t *rx = malloc(len);
 	struct spi_ioc_transfer tr = {
 		.tx_buf = (unsigned long)tx,
@@ -135,7 +137,22 @@ static void transfer(int fd, uint8_t const *tx, size_t len)
 
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
+
 	free(rx);
 }
 
@@ -147,6 +164,7 @@ static void print_usage(const char *prog)
 	     "  -d --delay    delay (usec)\n"
 	     "  -b --bpw      bits per word \n"
 	     "  -i --input    input data from a file (e.g. \"test.bin\")\n"
+	     "  -o --output   output data to a file (e.g. \"results.bin\")\n"
 	     "  -l --loop     loopback\n"
 	     "  -H --cpha     clock phase\n"
 	     "  -O --cpol     clock polarity\n"
@@ -171,6 +189,7 @@ static void parse_opts(int argc, char *argv[])
 			{ "delay",   1, 0, 'd' },
 			{ "bpw",     1, 0, 'b' },
 			{ "input",   1, 0, 'i' },
+			{ "output",  1, 0, 'o' },
 			{ "loop",    0, 0, 'l' },
 			{ "cpha",    0, 0, 'H' },
 			{ "cpol",    0, 0, 'O' },
@@ -186,7 +205,7 @@ static void parse_opts(int argc, char *argv[])
 		};
 		int c;
 
-		c = getopt_long(argc, argv, "D:s:d:b:i:lHOLC3NR24p:v",
+		c = getopt_long(argc, argv, "D:s:d:b:i:o:lHOLC3NR24p:v",
 				lopts, NULL);
 
 		if (c == -1)
@@ -208,6 +227,9 @@ static void parse_opts(int argc, char *argv[])
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

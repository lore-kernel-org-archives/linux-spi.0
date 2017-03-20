From: Frode Isaksen <fisaksen-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: [PATCH] spi: spidev_test: add option to continously transfer data
Date: Mon, 20 Mar 2017 14:45:35 +0100
Message-ID: <1490017535-31546-1-git-send-email-fisaksen@baylibre.com>
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Frode Isaksen <fisaksen-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
To: nsekhar-l0cyMroinI0@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Add option to send+recv <size> bytes with <iter> iterations
and show the transfer rate every 5 seconds.

Signed-off-by: Frode Isaksen <fisaksen-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
---
 tools/spi/spidev_test.c | 95 ++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 91 insertions(+), 4 deletions(-)

diff --git a/tools/spi/spidev_test.c b/tools/spi/spidev_test.c
index 816f119..4375f58 100644
--- a/tools/spi/spidev_test.c
+++ b/tools/spi/spidev_test.c
@@ -18,6 +18,7 @@
 #include <string.h>
 #include <getopt.h>
 #include <fcntl.h>
+#include <time.h>
 #include <sys/ioctl.h>
 #include <linux/ioctl.h>
 #include <sys/stat.h>
@@ -40,6 +41,9 @@ static char *output_file;
 static uint32_t speed = 500000;
 static uint16_t delay;
 static int verbose;
+static int transfer_size;
+static int iterations;
+static int interval = 5; /* interval in seconds for showing transfer rate */
 
 uint8_t default_tx[] = {
 	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
@@ -156,7 +160,7 @@ static void transfer(int fd, uint8_t const *tx, uint8_t const *rx, size_t len)
 		close(out_fd);
 	}
 
-	if (verbose || !output_file)
+	if (verbose)
 		hex_dump(rx, len, 32, "RX");
 }
 
@@ -180,7 +184,9 @@ static void print_usage(const char *prog)
 	     "  -N --no-cs    no chip select\n"
 	     "  -R --ready    slave pulls low to pause\n"
 	     "  -2 --dual     dual transfer\n"
-	     "  -4 --quad     quad transfer\n");
+	     "  -4 --quad     quad transfer\n"
+	     "  -S --size     transfer size\n"
+	     "  -I --iter     iterations\n");
 	exit(1);
 }
 
@@ -205,11 +211,13 @@ static void parse_opts(int argc, char *argv[])
 			{ "dual",    0, 0, '2' },
 			{ "verbose", 0, 0, 'v' },
 			{ "quad",    0, 0, '4' },
+			{ "size",    1, 0, 'S' },
+			{ "iter",    1, 0, 'I' },
 			{ NULL, 0, 0, 0 },
 		};
 		int c;
 
-		c = getopt_long(argc, argv, "D:s:d:b:i:o:lHOLC3NR24p:v",
+		c = getopt_long(argc, argv, "D:s:d:b:i:o:lHOLC3NR24p:vS:I:",
 				lopts, NULL);
 
 		if (c == -1)
@@ -270,6 +278,12 @@ static void parse_opts(int argc, char *argv[])
 		case '4':
 			mode |= SPI_TX_QUAD;
 			break;
+		case 'S':
+			transfer_size = atoi(optarg);
+			break;
+		case 'I':
+			iterations = atoi(optarg);
+			break;
 		default:
 			print_usage(argv[0]);
 			break;
@@ -336,6 +350,61 @@ static void transfer_file(int fd, char *filename)
 	close(tx_fd);
 }
 
+static uint64_t _read_count;
+static uint64_t _write_count;
+
+static void show_transfer_rate(void)
+{
+	static int first = 1;
+	static uint64_t prev_read_count, prev_write_count;
+	double rx_rate, tx_rate;
+
+	if (first) {
+		first = 0;
+	} else {
+		rx_rate = ((_read_count - prev_read_count) * 8) / (interval*1000.0);
+		tx_rate = ((_write_count - prev_write_count) * 8) / (interval*1000.0);
+
+		printf("rate: tx %.1fkbps, rx %.1fkbps\n", rx_rate, tx_rate);
+	}
+	prev_read_count = _read_count;
+	prev_write_count = _write_count;
+}
+
+static void transfer_buf(int fd, int len)
+{
+	uint8_t *tx;
+	uint8_t *rx;
+	int i;
+
+	tx = malloc(len);
+	if (!tx)
+		pabort("can't allocate tx buffer");
+	for (i=0; i < len; i++)
+		tx[i] = random();
+
+	rx = malloc(len);
+	if (!rx)
+		pabort("can't allocate rx buffer");
+
+	transfer(fd, tx, rx, len);
+
+	_write_count += len;
+	_read_count += 	len;
+
+	if (mode & SPI_LOOP) {
+		if (memcmp(tx, rx, len)) {
+			fprintf(stderr, "transfer error !\n");
+			hex_dump(tx, len, 32, "TX");
+			hex_dump(tx, len, 32, "RX");
+			exit(-1);
+		}
+	}
+
+	free(rx);
+	free(tx);
+}
+
 int main(int argc, char *argv[])
 {
 	int ret = 0;
@@ -391,7 +460,25 @@ int main(int argc, char *argv[])
 		transfer_escaped_string(fd, input_tx);
 	else if (input_file)
 		transfer_file(fd, input_file);
-	else
+	else if (transfer_size) {
+		struct timespec last_stat;
+
+		clock_gettime(CLOCK_MONOTONIC, &last_stat);
+		show_transfer_rate(); /* initialize */
+
+		while (iterations-- > 0) {
+			struct timespec current;
+
+			transfer_buf(fd, transfer_size);
+
+			clock_gettime(CLOCK_MONOTONIC, &current);
+			if (current.tv_sec - last_stat.tv_sec > interval) {
+				show_transfer_rate();
+				last_stat = current;
+			}
+		}
+		printf("total: tx %.1fKB, rx %.1fKB\n",  _write_count/1024.0, _read_count/1024.0);
+	} else
 		transfer(fd, default_tx, default_rx, sizeof(default_tx));
 
 	close(fd);
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

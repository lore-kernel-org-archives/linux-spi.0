From: Adrian Remonda <adrianremonda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCHv2 2/4] Added verbose output
Date: Tue, 10 Mar 2015 16:12:31 -0400
Message-ID: <1426018353-13442-3-git-send-email-adrianremonda@gmail.com>
References: <1426018353-13442-1-git-send-email-adrianremonda@gmail.com>
 <1426018353-13442-2-git-send-email-adrianremonda@gmail.com>
Cc: adrianremonda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, corbet-T1hC0tSOHrs@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: unlisted-recipients:; (no To-header on input)
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1426018353-13442-2-git-send-email-adrianremonda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


Signed-off-by: Adrian Remonda <adrianremonda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 Documentation/spi/spidev_test.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/spi/spidev_test.c b/Documentation/spi/spidev_test.c
index 9cb09184a3d6..4b6a3803638b 100644
--- a/Documentation/spi/spidev_test.c
+++ b/Documentation/spi/spidev_test.c
@@ -35,6 +35,7 @@ static uint32_t mode;
 static uint8_t bits = 8;
 static uint32_t speed = 500000;
 static uint16_t delay;
+static int verbose;
 
 static void hex_dump(const void *src, size_t length, size_t line_size, char *prefix)
 {
@@ -104,6 +105,8 @@ static void transfer(int fd)
 	if (ret < 1)
 		pabort("can't send spi message");
 
+	if (verbose)
+		hex_dump(tx, ARRAY_SIZE(tx), 32, "TX");
 	hex_dump(rx, ARRAY_SIZE(rx), 32, "RX");
 }
 
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

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

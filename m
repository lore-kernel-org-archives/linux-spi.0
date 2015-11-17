From: Joshua Clayton <stillcompiling@gmail.com>
Subject: [PATCH 1/8] Documentation/spi/spidev_test.c: use one rx buffer
Date: Tue, 17 Nov 2015 07:24:21 -0800
Message-ID: <2f17ae29e75967b4522b080c275b907622e1d353.1447773299.git.stillcompiling@gmail.com>
References: <cover.1447773299.git.stillcompiling@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Adrian Remonda <adrianremonda@gmail.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org,
	Joshua Clayton <stillcompiling@gmail.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <cover.1447773299.git.stillcompiling@gmail.com>
In-Reply-To: <cover.1447773299.git.stillcompiling@gmail.com>
References: <cover.1447773299.git.stillcompiling@gmail.com>
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

default_rx and rx are needlessly different.
Use one buffer, local to transmit()

Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
---
 Documentation/spi/spidev_test.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/Documentation/spi/spidev_test.c b/Documentation/spi/spidev_test.c
index 135b3f5..dfe8f47 100644
--- a/Documentation/spi/spidev_test.c
+++ b/Documentation/spi/spidev_test.c
@@ -46,7 +46,6 @@ uint8_t default_tx[] = {
 	0xF0, 0x0D,
 };
 
-uint8_t default_rx[ARRAY_SIZE(default_tx)] = {0, };
 char *input_tx;
 
 static void hex_dump(const void *src, size_t length, size_t line_size, char *prefix)
@@ -100,10 +99,10 @@ static int unescape(char *_dst, char *_src, size_t len)
 	return ret;
 }
 
-static void transfer(int fd, uint8_t const *tx, uint8_t const *rx, size_t len)
+static void transfer(int fd, uint8_t const *tx, size_t len)
 {
 	int ret;
-
+	uint8_t *rx = malloc(len);
 	struct spi_ioc_transfer tr = {
 		.tx_buf = (unsigned long)tx,
 		.rx_buf = (unsigned long)rx,
@@ -135,6 +134,7 @@ static void transfer(int fd, uint8_t const *tx, uint8_t const *rx, size_t len)
 	if (verbose)
 		hex_dump(tx, len, 32, "TX");
 	hex_dump(rx, len, 32, "RX");
+	free(rx);
 }
 
 static void print_usage(const char *prog)
@@ -254,7 +254,6 @@ int main(int argc, char *argv[])
 	int ret = 0;
 	int fd;
 	uint8_t *tx;
-	uint8_t *rx;
 	int size;
 
 	parse_opts(argc, argv);
@@ -303,13 +302,11 @@ int main(int argc, char *argv[])
 	if (input_tx) {
 		size = strlen(input_tx+1);
 		tx = malloc(size);
-		rx = malloc(size);
 		size = unescape((char *)tx, input_tx, size);
-		transfer(fd, tx, rx, size);
-		free(rx);
+		transfer(fd, tx, size);
 		free(tx);
 	} else {
-		transfer(fd, default_tx, default_rx, sizeof(default_tx));
+		transfer(fd, default_tx, sizeof(default_tx));
 	}
 
 	close(fd);
-- 
2.5.0


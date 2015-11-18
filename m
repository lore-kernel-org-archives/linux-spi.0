From: Joshua Clayton <stillcompiling@gmail.com>
Subject: [PATCH v2 2/6] spi: spidev_test: transfer_escaped_string function
Date: Wed, 18 Nov 2015 14:30:38 -0800
Message-ID: <b0719c2739aabcd9894e85d82cbae21fcf83df3a.1447880230.git.stillcompiling@gmail.com>
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

Move the input_tx code into its own small function.
This cleans up some variables from main() that are used only here.
While we are at it, check malloc calls instead of assuming they succeed.

Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
---
 tools/spi/spidev_test.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/tools/spi/spidev_test.c b/tools/spi/spidev_test.c
index 135b3f5..f9d2957 100644
--- a/tools/spi/spidev_test.c
+++ b/tools/spi/spidev_test.c
@@ -249,13 +249,30 @@ static void parse_opts(int argc, char *argv[])
 	}
 }
 
+static void transfer_escaped_string(int fd, char *str)
+{
+	size_t size = strlen(str + 1);
+	uint8_t *tx;
+	uint8_t *rx;
+
+	tx = malloc(size);
+	if (!tx)
+		pabort("can't allocate tx buffer");
+
+	rx = malloc(size);
+	if (!rx)
+		pabort("can't allocate rx buffer");
+
+	size = unescape((char *)tx, str, size);
+	transfer(fd, tx, rx, size);
+	free(rx);
+	free(tx);
+}
+
 int main(int argc, char *argv[])
 {
 	int ret = 0;
 	int fd;
-	uint8_t *tx;
-	uint8_t *rx;
-	int size;
 
 	parse_opts(argc, argv);
 
@@ -300,17 +317,10 @@ int main(int argc, char *argv[])
 	printf("bits per word: %d\n", bits);
 	printf("max speed: %d Hz (%d KHz)\n", speed, speed/1000);
 
-	if (input_tx) {
-		size = strlen(input_tx+1);
-		tx = malloc(size);
-		rx = malloc(size);
-		size = unescape((char *)tx, input_tx, size);
-		transfer(fd, tx, rx, size);
-		free(rx);
-		free(tx);
-	} else {
+	if (input_tx)
+		transfer_escaped_string(fd, input_tx);
+	else
 		transfer(fd, default_tx, default_rx, sizeof(default_tx));
-	}
 
 	close(fd);
 
-- 
2.5.0

From: Joshua Clayton <stillcompiling@gmail.com>
Subject: [PATCH 2/8] Documentation/spi/spidev_test.c: clean up input_tx
Date: Tue, 17 Nov 2015 07:24:22 -0800
Message-ID: <7f2139b27013d77993c6bc2b0a6c94fab01add98.1447773299.git.stillcompiling@gmail.com>
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

Put input from string into its own function.

Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
---
 Documentation/spi/spidev_test.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/Documentation/spi/spidev_test.c b/Documentation/spi/spidev_test.c
index dfe8f47..1ed9110 100644
--- a/Documentation/spi/spidev_test.c
+++ b/Documentation/spi/spidev_test.c
@@ -249,12 +249,20 @@ static void parse_opts(int argc, char *argv[])
 	}
 }
 
+static void transfer_escaped_string(int fd, char *str)
+{
+	size_t size = strlen(str + 1);
+	uint8_t *tx = malloc(size);
+
+	size = unescape((char *)tx, str, size);
+	transfer(fd, tx, size);
+	free(tx);
+}
+
 int main(int argc, char *argv[])
 {
 	int ret = 0;
 	int fd;
-	uint8_t *tx;
-	int size;
 
 	parse_opts(argc, argv);
 
@@ -299,15 +307,10 @@ int main(int argc, char *argv[])
 	printf("bits per word: %d\n", bits);
 	printf("max speed: %d Hz (%d KHz)\n", speed, speed/1000);
 
-	if (input_tx) {
-		size = strlen(input_tx+1);
-		tx = malloc(size);
-		size = unescape((char *)tx, input_tx, size);
-		transfer(fd, tx, size);
-		free(tx);
-	} else {
+	if (input_tx)
+		transfer_escaped_string(fd, input_tx);
+	else
 		transfer(fd, default_tx, sizeof(default_tx));
-	}
 
 	close(fd);
 
-- 
2.5.0


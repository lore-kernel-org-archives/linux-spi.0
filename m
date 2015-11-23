From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: spidev_test: transfer_escaped_string function" to the spi tree
Date: Mon, 23 Nov 2015 14:54:24 +0000
Message-ID: <E1a0sVc-0000Mq-2J@debutante>
References: <b0719c2739aabcd9894e85d82cbae21fcf83df3a.1447880230.git.stillcompiling@gmail.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joshua Clayton <stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <b0719c2739aabcd9894e85d82cbae21fcf83df3a.1447880230.git.stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: spidev_test: transfer_escaped_string function

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 5c437a401b824399b6fa7342c66b675ebb7af43e Mon Sep 17 00:00:00 2001
From: Joshua Clayton <stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Wed, 18 Nov 2015 14:30:38 -0800
Subject: [PATCH] spi: spidev_test: transfer_escaped_string function

Move the input_tx code into its own small function.
This cleans up some variables from main() that are used only here.
While we are at it, check malloc calls instead of assuming they succeed.

Signed-off-by: Joshua Clayton <stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 tools/spi/spidev_test.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/tools/spi/spidev_test.c b/tools/spi/spidev_test.c
index 135b3f592b83..f9d2957e538b 100644
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
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

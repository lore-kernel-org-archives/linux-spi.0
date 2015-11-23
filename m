From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: spidev_test: fix whitespace" to the spi tree
Date: Mon, 23 Nov 2015 14:54:20 +0000
Message-ID: <E1a0sVY-0000Ja-EC@debutante>
References: <0365b51d6bfd3002287a1ebe382e58a2766aa2d2.1447880230.git.stillcompiling@gmail.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joshua Clayton <stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <0365b51d6bfd3002287a1ebe382e58a2766aa2d2.1447880230.git.stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: spidev_test: fix whitespace

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

>From b2cfc90428f1c24ce4920f06b584bd05c62741e6 Mon Sep 17 00:00:00 2001
From: Joshua Clayton <stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Wed, 18 Nov 2015 14:30:42 -0800
Subject: [PATCH] spi: spidev_test: fix whitespace

Signed-off-by: Joshua Clayton <stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 tools/spi/spidev_test.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/spi/spidev_test.c b/tools/spi/spidev_test.c
index 322370dbc770..eddfc336a960 100644
--- a/tools/spi/spidev_test.c
+++ b/tools/spi/spidev_test.c
@@ -52,7 +52,8 @@ uint8_t default_tx[] = {
 uint8_t default_rx[ARRAY_SIZE(default_tx)] = {0, };
 char *input_tx;
 
-static void hex_dump(const void *src, size_t length, size_t line_size, char *prefix)
+static void hex_dump(const void *src, size_t length, size_t line_size,
+		     char *prefix)
 {
 	int i = 0;
 	const unsigned char *address = src;
@@ -164,7 +165,7 @@ static void print_usage(const char *prog)
 	puts("  -D --device   device to use (default /dev/spidev1.1)\n"
 	     "  -s --speed    max speed (Hz)\n"
 	     "  -d --delay    delay (usec)\n"
-	     "  -b --bpw      bits per word \n"
+	     "  -b --bpw      bits per word\n"
 	     "  -i --input    input data from a file (e.g. \"test.bin\")\n"
 	     "  -o --output   output data to a file (e.g. \"results.bin\")\n"
 	     "  -l --loop     loopback\n"
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: spidev_test: check error" to the spi tree
Date: Mon, 23 Nov 2015 14:54:21 +0000
Message-ID: <E1a0sVZ-0000KC-B0@debutante>
References: <2bbb0374d7fd390a04ceb8d7b552f1a8d946c0f0.1447880230.git.stillcompiling@gmail.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joshua Clayton <stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2bbb0374d7fd390a04ceb8d7b552f1a8d946c0f0.1447880230.git.stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: spidev_test: check error

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

>From a20874f78be633b9e3a505d5f191735188b110a5 Mon Sep 17 00:00:00 2001
From: Joshua Clayton <stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Wed, 18 Nov 2015 14:30:41 -0800
Subject: [PATCH] spi: spidev_test: check error

Check the result of sscanf to verify a result was found.
report and error and abort if pattern was not found.

Signed-off-by: Joshua Clayton <stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 tools/spi/spidev_test.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/spi/spidev_test.c b/tools/spi/spidev_test.c
index 02fc3a44901b..322370dbc770 100644
--- a/tools/spi/spidev_test.c
+++ b/tools/spi/spidev_test.c
@@ -86,13 +86,17 @@ static void hex_dump(const void *src, size_t length, size_t line_size, char *pre
 static int unescape(char *_dst, char *_src, size_t len)
 {
 	int ret = 0;
+	int match;
 	char *src = _src;
 	char *dst = _dst;
 	unsigned int ch;
 
 	while (*src) {
 		if (*src == '\\' && *(src+1) == 'x') {
-			sscanf(src + 2, "%2x", &ch);
+			match = sscanf(src + 2, "%2x", &ch);
+			if (!match)
+				pabort("malformed input string");
+
 			src += 4;
 			*dst++ = (unsigned char)ch;
 		} else {
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

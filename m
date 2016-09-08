From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH] spi: spidev_test: Fix buffer overflow in unescape()
Date: Thu,  8 Sep 2016 20:05:58 +0200
Message-ID: <1473357958-5576-1-git-send-email-geert+renesas@glider.be>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Adrian Remonda <adrianremonda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>,
        <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Sometimes spidev_test crashes with:

    *** Error in `spidev_test': munmap_chunk(): invalid pointer: 0x00022020 ***
    Aborted

or just

    Segmentation fault

This is due to transfer_escaped_string() miscalculating the required
size of the buffer by two bytes, causing a buffer overflow in unescape().

Move the misplaced closing parenthesis to fix this.

Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Fixes: 30061915be6e3a2c ("spi: spidev_test: Added input buffer from the terminal")
Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org> # v4.5+
---
The bug is present in all kernels since v4.1, but in v4.5 the code was
changed, and the source file was moved.

The fix for older kernels is straight-forward, there's only a single
strlen() call in Documentation/spi/spidev_test.c:

	-	size = strlen(input_tx+1);
	+	size = strlen(input_tx)+1;

If you want, I can send a patch against v4.4 (for v4.1..v4.4) later.
---
 tools/spi/spidev_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/spi/spidev_test.c b/tools/spi/spidev_test.c
index 1eaa4de6605bd935..ffa9908f7eb6670e 100644
--- a/tools/spi/spidev_test.c
+++ b/tools/spi/spidev_test.c
@@ -285,7 +285,7 @@ static void parse_opts(int argc, char *argv[])
 
 static void transfer_escaped_string(int fd, char *str)
 {
-	size_t size = strlen(str + 1);
+	size_t size = strlen(str) + 1;
 	uint8_t *tx;
 	uint8_t *rx;
 
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

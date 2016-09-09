From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH v2] spi: spidev_test: Fix buffer overflow in unescape()
Date: Fri,  9 Sep 2016 09:02:51 +0200
Message-ID: <1473404571-27302-1-git-send-email-geert+renesas@glider.be>
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
size of the buffer by one byte, causing a buffer overflow in unescape().

Drop the bogus "+ 1" in the strlen() parameter to fix this.

Note that unescape() never copies the zero-terminator of the source
string, so it writes at most as many bytes as the length of the source
string.

Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Fixes: 30061915be6e3a2c ("spi: spidev_test: Added input buffer from the terminal")
Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org> # v4.5+
---
v2:
  - As unescape() doesn't copy the zero-terminator, it's an off-by-one
    not off-by-two bug, and the "+ 1" should just be dropped.

The bug is present in all kernel sources since v4.1, but in v4.5 the
code was changed, and the source file was moved.

The fix for older kernels is straight-forward, there's only a single
strlen() call in Documentation/spi/spidev_test.c:

	-	size = strlen(input_tx+1);
	+	size = strlen(input_tx);

If you want, I can send a patch against v4.4 (for v4.1..v4.4) later.
---
 tools/spi/spidev_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/spi/spidev_test.c b/tools/spi/spidev_test.c
index 1eaa4de6605bd935..f046b77cfefe3056 100644
--- a/tools/spi/spidev_test.c
+++ b/tools/spi/spidev_test.c
@@ -285,7 +285,7 @@ static void parse_opts(int argc, char *argv[])
 
 static void transfer_escaped_string(int fd, char *str)
 {
-	size_t size = strlen(str + 1);
+	size_t size = strlen(str);
 	uint8_t *tx;
 	uint8_t *rx;
 
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

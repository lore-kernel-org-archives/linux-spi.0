From: Joshua Clayton <stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 5/8] Documentation/spi/spidev_test.c: check error
Date: Tue, 17 Nov 2015 07:24:25 -0800
Message-ID: <cc91f6bbe4e8536a1749268683265854dd19deed.1447773299.git.stillcompiling@gmail.com>
References: <cover.1447773299.git.stillcompiling@gmail.com>
Cc: Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>,
	Adrian Remonda <adrianremonda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Joshua Clayton <stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1447773299.git.stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
In-Reply-To: <cover.1447773299.git.stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
References: <cover.1447773299.git.stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Check the result of sscanf to verify a result was found.
report and error and abort if pattern was not found.

Signed-off-by: Joshua Clayton <stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 Documentation/spi/spidev_test.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/spi/spidev_test.c b/Documentation/spi/spidev_test.c
index 273f667..2ff5fe8 100644
--- a/Documentation/spi/spidev_test.c
+++ b/Documentation/spi/spidev_test.c
@@ -85,13 +85,17 @@ static void hex_dump(const void *src, size_t length, size_t line_size, char *pre
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
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

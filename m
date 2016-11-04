From: =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <vokac.m-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi: spidev_test: Fix input file check when transferring file
Date: Fri,  4 Nov 2016 11:30:03 +0100
Message-ID: <1478255403-11149-1-git-send-email-vokac.m@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
        =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <vokac.m-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Check the input file fd instead of spidev fd.
The spidev fd is supposed to be OK otherwise the transfer_file() function
would not be called at all.

Signed-off-by: Michal Vokáč <vokac.m-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 tools/spi/spidev_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/spi/spidev_test.c b/tools/spi/spidev_test.c
index f046b77..816f119 100644
--- a/tools/spi/spidev_test.c
+++ b/tools/spi/spidev_test.c
@@ -315,7 +315,7 @@ static void transfer_file(int fd, char *filename)
 		pabort("can't stat input file");
 
 	tx_fd = open(filename, O_RDONLY);
-	if (fd < 0)
+	if (tx_fd < 0)
 		pabort("can't open input file");
 
 	tx = malloc(sb.st_size);
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 4/6] spi: loopback-test: test zero-length transfer
Date: Sat, 18 Mar 2017 03:17:29 +0900
Message-ID: <1489774651-30170-5-git-send-email-akinobu.mita@gmail.com>
References: <1489774651-30170-1-git-send-email-akinobu.mita@gmail.com>
Cc: Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1489774651-30170-1-git-send-email-akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

In order to test various spi_messages including zero-length transfer,
this adds zero length into the iterate_len list.

Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-test.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-test.h b/drivers/spi/spi-test.h
index 2dd5691..82fff4a 100644
--- a/drivers/spi/spi-test.h
+++ b/drivers/spi/spi-test.h
@@ -124,7 +124,7 @@ int spi_test_execute_msg(struct spi_device *spi,
 int spi_test_run_tests(struct spi_device *spi,
 		       struct spi_test *tests);
 
-#define ITERATE_LEN_LIST 1, 2, 3, 7, 11, 16, 31, 32, 64, 97, 128, 251, 256, \
+#define ITERATE_LEN_LIST 0, 1, 2, 3, 7, 11, 16, 31, 32, 64, 97, 128, 251, 256, \
 		1021, 1024, 1031, 4093, PAGE_SIZE, 4099, 65536, 65537
 /* some of the default @spi_transfer.len to test, terminated by a -1 */
 #define ITERATE_LEN ITERATE_LEN_LIST, -1
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

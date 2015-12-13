From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH] spi: loopback: added additional non-power of 2 transfer lengthes
Date: Sun, 13 Dec 2015 09:46:25 +0000
Message-ID: <1449999986-2335-1-git-send-email-kernel@martin.sperl.org>
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

Added additional transfer length to test that are not a power of 2.

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
---
 drivers/spi/spi-test.h |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-test.h b/drivers/spi/spi-test.h
index 7bfdbe2..922c528 100644
--- a/drivers/spi/spi-test.h
+++ b/drivers/spi/spi-test.h
@@ -20,7 +20,7 @@
 
 #define SPI_TEST_MAX_TRANSFERS 4
 #define SPI_TEST_MAX_SIZE (32 * PAGE_SIZE)
-#define SPI_TEST_MAX_ITERATE 16
+#define SPI_TEST_MAX_ITERATE 32
 
 /* the "dummy" start addresses used in spi_test
  * these addresses get translated at a later stage
@@ -127,9 +127,10 @@ int spi_test_run_tests(struct spi_device *spi,
 		       struct spi_test *tests);
 
 /* some of the default @spi_transfer.len to test */
-#define ITERATE_LEN 16, 32, 64, 128, 256, 1024, PAGE_SIZE, 65536
+#define ITERATE_LEN 2, 3, 7, 11, 16, 31, 32, 64, 97, 128, 251, 256, \
+		1021, 1024, 1031, 4093, PAGE_SIZE, 4099, 65536, 65537
 
-#define ITERATE_MAX_LEN ITERATE_LEN, SPI_TEST_MAX_SIZE
+#define ITERATE_MAX_LEN ITERATE_LEN, SPI_TEST_MAX_SIZE - 1, SPI_TEST_MAX_SIZE
 
 /* the default alignment to test */
 #define ITERATE_ALIGN sizeof(int)
-- 
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

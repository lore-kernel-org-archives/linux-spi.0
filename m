From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH] spi: loopback: fix printk format issues with size_t
Date: Sun, 13 Dec 2015 09:42:55 +0000
Message-ID: <1449999775-2245-1-git-send-email-kernel@martin.sperl.org>
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

Fixes the reported printk format issues reported by kbuild-test-robot.

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
---
 drivers/spi/spi-loopback-test.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

I hope I got them right (no warnings on my system).
Is there a way to apply the same warning checks as kbuild-test-robot for
printk?

diff --git a/drivers/spi/spi-loopback-test.c b/drivers/spi/spi-loopback-test.c
index facef7a..7f497ac 100644
--- a/drivers/spi/spi-loopback-test.c
+++ b/drivers/spi/spi-loopback-test.c
@@ -345,7 +345,7 @@ static void spi_test_print_hex_dump(char *pre, const void *ptr, size_t len)
 		       DUMP_PREFIX_OFFSET, 16, 1,
 		       ptr, 512, 0);
 	/* print tail */
-	pr_info("%s truncated - continuing at offset %04x\n",
+	pr_info("%s truncated - continuing at offset %04zx\n",
 		pre, len - 512);
 	print_hex_dump(KERN_INFO, pre,
 		       DUMP_PREFIX_OFFSET, 16, 1,
@@ -525,7 +525,7 @@ static int spi_test_check_loopback_result(struct spi_device *spi,
 
 mismatch_error:
 	dev_err(&spi->dev,
-		"loopback strangeness - transfer missmatch on byte %04x - expected 0x%02x, but got 0x%02x\n",
+		"loopback strangeness - transfer missmatch on byte %04zx - expected 0x%02x, but got 0x%02x\n",
 		i, txb, rxb);
 
 	return -EINVAL;
@@ -777,7 +777,7 @@ static int spi_test_run_iter(struct spi_device *spi,
 		dev_info(&spi->dev, "Running test %s\n", test.description);
 	} else {
 		dev_info(&spi->dev,
-			 "  with iteration values: len = %i, tx_off = %i, rx_off = %i\n",
+			 "  with iteration values: len = %zu, tx_off = %zu, rx_off = %zu\n",
 			 len, tx_off, rx_off);
 	}
 
-- 
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

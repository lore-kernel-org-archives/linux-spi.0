From: Frode Isaksen <fisaksen-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v3 6/6] spi: loopback-test: add option to use vmalloc'ed buffers
Date: Thu, 23 Feb 2017 19:02:01 +0100
Message-ID: <1487872921-26628-7-git-send-email-fisaksen@baylibre.com>
References: <1487872921-26628-1-git-send-email-fisaksen@baylibre.com>
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Frode Isaksen <fisaksen-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
To: nsekhar-l0cyMroinI0@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1487872921-26628-1-git-send-email-fisaksen-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Using vmalloc'ed buffers will use one SG entry for each page,
that may provoke DMA errors for large transfers.
Also vmalloc'ed buffers may cause errors on CPU's with VIVT cache.
Add this option to catch these errors when testing.
Note that to catch VIVT cache errors, checking the rx range
has to be disabled, so this option has been added as well.

Signed-off-by: Frode Isaksen <fisaksen-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
---
 drivers/spi/spi-loopback-test.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-loopback-test.c b/drivers/spi/spi-loopback-test.c
index 50e620f..3596051 100644
--- a/drivers/spi/spi-loopback-test.c
+++ b/drivers/spi/spi-loopback-test.c
@@ -55,6 +55,18 @@ module_param(run_only_test, int, 0);
 MODULE_PARM_DESC(run_only_test,
 		 "only run the test with this number (0-based !)");
 
+/* use vmalloc'ed buffers */
+int use_vmalloc;
+module_param(use_vmalloc, int, 0644);
+MODULE_PARM_DESC(use_vmalloc,
+		 "use vmalloc'ed buffers instead of kmalloc'ed");
+
+/* check rx ranges */
+int check_ranges = 1;
+module_param(check_ranges, int, 0644);
+MODULE_PARM_DESC(check_ranges,
+		 "checks rx_buffer pattern are valid");
+
 /* the actual tests to execute */
 static struct spi_test spi_tests[] = {
 	{
@@ -492,9 +504,11 @@ static int spi_test_check_loopback_result(struct spi_device *spi,
 	int ret;
 
 	/* checks rx_buffer pattern are valid with loopback or without */
-	ret = spi_check_rx_ranges(spi, msg, rx);
-	if (ret)
-		return ret;
+	if (check_ranges) {
+		ret = spi_check_rx_ranges(spi, msg, rx);
+		if (ret)
+			return ret;
+	}
 
 	/* if we run without loopback, then return now */
 	if (!loopback)
@@ -965,13 +979,19 @@ int spi_test_run_tests(struct spi_device *spi,
 	/* allocate rx/tx buffers of 128kB size without devm
 	 * in the hope that is on a page boundary
 	 */
-	rx = kzalloc(SPI_TEST_MAX_SIZE_PLUS, GFP_KERNEL);
+	if (use_vmalloc)
+		rx = vmalloc(SPI_TEST_MAX_SIZE_PLUS);
+	else
+		rx = kzalloc(SPI_TEST_MAX_SIZE_PLUS, GFP_KERNEL);
 	if (!rx) {
 		ret = -ENOMEM;
 		goto out;
 	}
 
-	tx = kzalloc(SPI_TEST_MAX_SIZE_PLUS, GFP_KERNEL);
+	if (use_vmalloc)
+		tx = vmalloc(SPI_TEST_MAX_SIZE_PLUS);
+	else
+		tx = kzalloc(SPI_TEST_MAX_SIZE_PLUS, GFP_KERNEL);
 	if (!tx) {
 		ret = -ENOMEM;
 		goto out;
@@ -999,8 +1019,8 @@ int spi_test_run_tests(struct spi_device *spi,
 	}
 
 out:
-	kfree(rx);
-	kfree(tx);
+	kvfree(rx);
+	kvfree(tx);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(spi_test_run_tests);
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 5/6] spi: loopback-test: add elapsed time check
Date: Sat, 18 Mar 2017 03:17:30 +0900
Message-ID: <1489774651-30170-6-git-send-email-akinobu.mita@gmail.com>
References: <1489774651-30170-1-git-send-email-akinobu.mita@gmail.com>
Cc: Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1489774651-30170-1-git-send-email-akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This adds checks whether the elapsed time is longer than the minimam
estimated time.  The estimated time is calculated with the total
transfer length per clock rate and optional spi_transfer.delay_usecs.

Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-loopback-test.c | 38 ++++++++++++++++++++++++++++++++++++++
 drivers/spi/spi-test.h          |  2 ++
 2 files changed, 40 insertions(+)

diff --git a/drivers/spi/spi-loopback-test.c b/drivers/spi/spi-loopback-test.c
index 6df6ddd..66e8cfd0 100644
--- a/drivers/spi/spi-loopback-test.c
+++ b/drivers/spi/spi-loopback-test.c
@@ -20,6 +20,7 @@
 
 #include <linux/delay.h>
 #include <linux/kernel.h>
+#include <linux/ktime.h>
 #include <linux/list.h>
 #include <linux/list_sort.h>
 #include <linux/module.h>
@@ -479,6 +480,35 @@ static int spi_check_rx_ranges(struct spi_device *spi,
 	return ret;
 }
 
+static int spi_test_check_elapsed_time(struct spi_device *spi,
+				       struct spi_test *test)
+{
+	int i;
+	unsigned long long estimated_time = 0;
+	unsigned long long delay_usecs = 0;
+
+	for (i = 0; i < test->transfer_count; i++) {
+		struct spi_transfer *xfer = test->transfers + i;
+		unsigned long long nbits = BITS_PER_BYTE * xfer->len;
+
+		delay_usecs += xfer->delay_usecs;
+		if (!xfer->speed_hz)
+			continue;
+		estimated_time += div_u64(nbits * NSEC_PER_SEC, xfer->speed_hz);
+	}
+
+	estimated_time += delay_usecs * NSEC_PER_USEC;
+	if (test->elapsed_time < estimated_time) {
+		dev_err(&spi->dev,
+			"elapsed time %lld ns is shorter than minimam estimated time %lld ns\n",
+			test->elapsed_time, estimated_time);
+
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int spi_test_check_loopback_result(struct spi_device *spi,
 					  struct spi_message *msg,
 					  void *tx, void *rx)
@@ -817,12 +847,16 @@ int spi_test_execute_msg(struct spi_device *spi, struct spi_test *test,
 
 	/* only if we do not simulate */
 	if (!simulate_only) {
+		ktime_t start;
+
 		/* dump the complete message before and after the transfer */
 		if (dump_messages == 3)
 			spi_test_dump_message(spi, msg, true);
 
+		start = ktime_get();
 		/* run spi message */
 		ret = spi_sync(spi, msg);
+		test->elapsed_time = ktime_to_ns(ktime_sub(ktime_get(), start));
 		if (ret == -ETIMEDOUT) {
 			dev_info(&spi->dev,
 				 "spi-message timed out - reruning...\n");
@@ -848,6 +882,10 @@ int spi_test_execute_msg(struct spi_device *spi, struct spi_test *test,
 
 		/* run rx-buffer tests */
 		ret = spi_test_check_loopback_result(spi, msg, tx, rx);
+		if (ret)
+			goto exit;
+
+		ret = spi_test_check_elapsed_time(spi, test);
 	}
 
 	/* if requested or on error dump message (including data) */
diff --git a/drivers/spi/spi-test.h b/drivers/spi/spi-test.h
index 82fff4a..6ed7b89 100644
--- a/drivers/spi/spi-test.h
+++ b/drivers/spi/spi-test.h
@@ -75,6 +75,7 @@
  * @fill_option:      define the way how tx_buf is filled
  * @fill_pattern:     fill pattern to apply to the tx_buf
  *                    (used in some of the @fill_options)
+ * @elapsed_time:     elapsed time in nanoseconds
  */
 
 struct spi_test {
@@ -108,6 +109,7 @@ struct spi_test {
 #define FILL_TRANSFER_BYTE_32 11 /* fill with the transfer byte - 32 bit */
 #define FILL_TRANSFER_NUM     16 /* fill with the transfer number */
 	u32 fill_pattern;
+	unsigned long long elapsed_time;
 };
 
 /* default implementation for @spi_test.run_test */
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

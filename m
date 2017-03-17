From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: loopback-test: add elapsed time check" to the spi tree
Date: Fri, 17 Mar 2017 21:54:50 +0000
Message-ID: <E1cozpi-00025i-Uf@debutante>
References: <1489774651-30170-6-git-send-email-akinobu.mita@gmail.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1489774651-30170-6-git-send-email-akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: loopback-test: add elapsed time check

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

>From ea9936f32435699907807aaac87f993482208578 Mon Sep 17 00:00:00 2001
From: Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Sat, 18 Mar 2017 03:17:30 +0900
Subject: [PATCH] spi: loopback-test: add elapsed time check

This adds checks whether the elapsed time is longer than the minimam
estimated time.  The estimated time is calculated with the total
transfer length per clock rate and optional spi_transfer.delay_usecs.

Signed-off-by: Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-loopback-test.c | 38 ++++++++++++++++++++++++++++++++++++++
 drivers/spi/spi-test.h          |  2 ++
 2 files changed, 40 insertions(+)

diff --git a/drivers/spi/spi-loopback-test.c b/drivers/spi/spi-loopback-test.c
index 6df6dddc2890..66e8cfd04395 100644
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
index 82fff4a0fd94..6ed7b899da8a 100644
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
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

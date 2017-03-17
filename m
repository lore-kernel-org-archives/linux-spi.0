From: Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 3/6] spi: loopback-test: add ability to test zero-length transfer
Date: Sat, 18 Mar 2017 03:17:28 +0900
Message-ID: <1489774651-30170-4-git-send-email-akinobu.mita@gmail.com>
References: <1489774651-30170-1-git-send-email-akinobu.mita@gmail.com>
Cc: Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1489774651-30170-1-git-send-email-akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The spi-loopback-test module currently cannot test the spi_message
including a zero-length transfer.  Because the zero-length transfer is
treated as a special value in several meanings.

1. The number of spi_transfer to execute in one test case is described
by spi_test.transfer_count.  It is normally computed by counting number
of transfers with len > 0 in spi_test.transfers array.

This change stops the detection for the number of spi_transfer.  Each
spi_test.transfer_count needs to be filled by hand now.

2. The spi_test.iterate_len is a list of transfer length to iterate on.
This list is terminated by zero, so zero-length transfer cannot be
included.

This changes the terminal value from 0 to -1.

3. The length for the spi_transfer masked by spi_test.iterate_transfer_mask
is iterated.  Before starting the iteration, the default value which
is statically initialized is applied.  In order to specify the default
value, zero-length is reserved.

Currently, the default values are always '1'.  So this removes this
trick and add '1' to iterate_len list.

By applying all these changes, the spi-loopback-test can execute spi
messages with zero-length transfer.

Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-loopback-test.c | 55 +++++++++++++----------------------------
 drivers/spi/spi-test.h          | 19 +++++++-------
 2 files changed, 26 insertions(+), 48 deletions(-)

diff --git a/drivers/spi/spi-loopback-test.c b/drivers/spi/spi-loopback-test.c
index 85c0c4e..6df6ddd 100644
--- a/drivers/spi/spi-loopback-test.c
+++ b/drivers/spi/spi-loopback-test.c
@@ -63,9 +63,9 @@ static struct spi_test spi_tests[] = {
 		.iterate_len    = { ITERATE_MAX_LEN },
 		.iterate_tx_align = ITERATE_ALIGN,
 		.iterate_rx_align = ITERATE_ALIGN,
+		.transfer_count = 1,
 		.transfers		= {
 			{
-				.len = 1,
 				.tx_buf = TX(0),
 				.rx_buf = RX(0),
 			},
@@ -77,9 +77,9 @@ static struct spi_test spi_tests[] = {
 		.iterate_len    = { ITERATE_MAX_LEN },
 		.iterate_tx_align = ITERATE_ALIGN,
 		.iterate_rx_align = ITERATE_ALIGN,
+		.transfer_count = 1,
 		.transfers		= {
 			{
-				.len = 1,
 				.tx_buf = TX(PAGE_SIZE - 4),
 				.rx_buf = RX(PAGE_SIZE - 4),
 			},
@@ -90,9 +90,9 @@ static struct spi_test spi_tests[] = {
 		.fill_option	= FILL_COUNT_8,
 		.iterate_len    = { ITERATE_MAX_LEN },
 		.iterate_tx_align = ITERATE_ALIGN,
+		.transfer_count = 1,
 		.transfers		= {
 			{
-				.len = 1,
 				.tx_buf = TX(0),
 			},
 		},
@@ -102,9 +102,9 @@ static struct spi_test spi_tests[] = {
 		.fill_option	= FILL_COUNT_8,
 		.iterate_len    = { ITERATE_MAX_LEN },
 		.iterate_rx_align = ITERATE_ALIGN,
+		.transfer_count = 1,
 		.transfers		= {
 			{
-				.len = 1,
 				.rx_buf = RX(0),
 			},
 		},
@@ -115,13 +115,12 @@ static struct spi_test spi_tests[] = {
 		.iterate_len    = { ITERATE_LEN },
 		.iterate_tx_align = ITERATE_ALIGN,
 		.iterate_transfer_mask = BIT(0) | BIT(1),
+		.transfer_count = 2,
 		.transfers		= {
 			{
-				.len = 1,
 				.tx_buf = TX(0),
 			},
 			{
-				.len = 1,
 				/* this is why we cant use ITERATE_MAX_LEN */
 				.tx_buf = TX(SPI_TEST_MAX_SIZE_HALF),
 			},
@@ -133,9 +132,9 @@ static struct spi_test spi_tests[] = {
 		.iterate_len    = { ITERATE_MAX_LEN },
 		.iterate_tx_align = ITERATE_ALIGN,
 		.iterate_transfer_mask = BIT(0),
+		.transfer_count = 2,
 		.transfers		= {
 			{
-				.len = 1,
 				.tx_buf = TX(64),
 			},
 			{
@@ -150,13 +149,13 @@ static struct spi_test spi_tests[] = {
 		.iterate_len    = { ITERATE_MAX_LEN },
 		.iterate_tx_align = ITERATE_ALIGN,
 		.iterate_transfer_mask = BIT(1),
+		.transfer_count = 2,
 		.transfers		= {
 			{
 				.len = 16,
 				.tx_buf = TX(0),
 			},
 			{
-				.len = 1,
 				.tx_buf = TX(64),
 			},
 		},
@@ -167,13 +166,12 @@ static struct spi_test spi_tests[] = {
 		.iterate_len    = { ITERATE_MAX_LEN },
 		.iterate_tx_align = ITERATE_ALIGN,
 		.iterate_transfer_mask = BIT(0) | BIT(1),
+		.transfer_count = 2,
 		.transfers		= {
 			{
-				.len = 1,
 				.tx_buf = TX(0),
 			},
 			{
-				.len = 1,
 				.rx_buf = RX(0),
 			},
 		},
@@ -184,9 +182,9 @@ static struct spi_test spi_tests[] = {
 		.iterate_len    = { ITERATE_MAX_LEN },
 		.iterate_tx_align = ITERATE_ALIGN,
 		.iterate_transfer_mask = BIT(0),
+		.transfer_count = 2,
 		.transfers		= {
 			{
-				.len = 1,
 				.tx_buf = TX(0),
 			},
 			{
@@ -201,13 +199,13 @@ static struct spi_test spi_tests[] = {
 		.iterate_len    = { ITERATE_MAX_LEN },
 		.iterate_tx_align = ITERATE_ALIGN,
 		.iterate_transfer_mask = BIT(1),
+		.transfer_count = 2,
 		.transfers		= {
 			{
 				.len = 1,
 				.tx_buf = TX(0),
 			},
 			{
-				.len = 1,
 				.rx_buf = RX(0),
 			},
 		},
@@ -218,14 +216,13 @@ static struct spi_test spi_tests[] = {
 		.iterate_len    = { ITERATE_LEN },
 		.iterate_tx_align = ITERATE_ALIGN,
 		.iterate_transfer_mask = BIT(0) | BIT(1),
+		.transfer_count = 2,
 		.transfers		= {
 			{
-				.len = 1,
 				.tx_buf = TX(0),
 				.rx_buf = RX(0),
 			},
 			{
-				.len = 1,
 				/* making sure we align without overwrite
 				 * the reason we can not use ITERATE_MAX_LEN
 				 */
@@ -240,9 +237,9 @@ static struct spi_test spi_tests[] = {
 		.iterate_len    = { ITERATE_MAX_LEN },
 		.iterate_tx_align = ITERATE_ALIGN,
 		.iterate_transfer_mask = BIT(0),
+		.transfer_count = 2,
 		.transfers		= {
 			{
-				.len = 1,
 				/* making sure we align without overwrite */
 				.tx_buf = TX(1024),
 				.rx_buf = RX(1024),
@@ -261,6 +258,7 @@ static struct spi_test spi_tests[] = {
 		.iterate_len    = { ITERATE_MAX_LEN },
 		.iterate_tx_align = ITERATE_ALIGN,
 		.iterate_transfer_mask = BIT(1),
+		.transfer_count = 2,
 		.transfers		= {
 			{
 				.len = 1,
@@ -268,7 +266,6 @@ static struct spi_test spi_tests[] = {
 				.rx_buf = RX(0),
 			},
 			{
-				.len = 1,
 				/* making sure we align without overwrite */
 				.tx_buf = TX(1024),
 				.rx_buf = RX(1024),
@@ -503,7 +500,7 @@ static int spi_test_check_loopback_result(struct spi_device *spi,
 	/* if applicable to transfer check that rx_buf is equal to tx_buf */
 	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
 		/* if there is no rx, then no check is needed */
-		if (!xfer->rx_buf)
+		if (!xfer->len || !xfer->rx_buf)
 			continue;
 		/* so depending on tx_buf we need to handle things */
 		if (xfer->tx_buf) {
@@ -745,15 +742,6 @@ static int spi_test_run_iter(struct spi_device *spi,
 	/* copy the test template to test */
 	memcpy(&test, testtemplate, sizeof(test));
 
-	/* set up test->transfers to the correct count */
-	if (!test.transfer_count) {
-		for (i = 0;
-		    (i < SPI_TEST_MAX_TRANSFERS) && test.transfers[i].len;
-		    i++) {
-			test.transfer_count++;
-		}
-	}
-
 	/* if iterate_transfer_mask is not set,
 	 * then set it to first transfer only
 	 */
@@ -799,8 +787,7 @@ static int spi_test_run_iter(struct spi_device *spi,
 		/* only when bit in transfer mask is set */
 		if (!(test.iterate_transfer_mask & BIT(i)))
 			continue;
-		if (len)
-			test.transfers[i].len = len;
+		test.transfers[i].len = len;
 		if (test.transfers[i].tx_buf)
 			test.transfers[i].tx_buf += tx_off;
 		if (test.transfers[i].tx_buf)
@@ -910,15 +897,6 @@ int spi_test_run_test(struct spi_device *spi, const struct spi_test *test,
 	/* iterate over all the iterable values using macros
 	 * (to make it a bit more readable...
 	 */
-#define FOR_EACH_ITERATE(var, defaultvalue)				\
-	for (idx_##var = -1, var = defaultvalue;			\
-	     ((idx_##var < 0) ||					\
-		     (							\
-			     (idx_##var < SPI_TEST_MAX_ITERATE) &&	\
-			     (var = test->iterate_##var[idx_##var])	\
-		     )							\
-	     );								\
-	     idx_##var++)
 #define FOR_EACH_ALIGNMENT(var)						\
 	for (var = 0;							\
 	    var < (test->iterate_##var ?				\
@@ -928,7 +906,8 @@ int spi_test_run_test(struct spi_device *spi, const struct spi_test *test,
 			1);						\
 	    var++)
 
-	FOR_EACH_ITERATE(len, 0) {
+	for (idx_len = 0; idx_len < SPI_TEST_MAX_ITERATE &&
+	     (len = test->iterate_len[idx_len]) != -1; idx_len++) {
 		FOR_EACH_ALIGNMENT(tx_align) {
 			FOR_EACH_ALIGNMENT(rx_align) {
 				/* and run the iteration */
diff --git a/drivers/spi/spi-test.h b/drivers/spi/spi-test.h
index 922c528..2dd5691 100644
--- a/drivers/spi/spi-test.h
+++ b/drivers/spi/spi-test.h
@@ -48,9 +48,8 @@
  *
  * @msg:              a template @spi_message usedfor the default settings
  * @transfers:        array of @spi_transfers that are part of the
- *                    resulting spi_message. The first transfer with len == 0
- *                    signifies the end of the list
- * @transfer_count:   normally computed number of transfers with len > 0
+ *                    resulting spi_message.
+ * @transfer_count:   number of transfers
  *
  * @run_test:         run a specific spi_test - this allows to override
  *                    the default implementation of @spi_test_run_transfer
@@ -62,8 +61,7 @@
  * @expected_return:  the expected return code - in some cases we want to
  *                    test also for error conditions
  *
- * @iterate_len:      list of length to iterate on (in addition to the
- *                    explicitly set @spi_transfer.len)
+ * @iterate_len:      list of length to iterate on
  * @iterate_tx_align: change the alignment of @spi_transfer.tx_buf
  *                    for all values in the below range if set.
  *                    the ranges are:
@@ -89,7 +87,7 @@ struct spi_test {
 	int (*execute_msg)(struct spi_device *spi, struct spi_test *test,
 			   void *tx, void *rx);
 	int expected_return;
-	/* iterate over all the non-zero values */
+	/* iterate over all values, terminated by a -1 */
 	int iterate_len[SPI_TEST_MAX_ITERATE];
 	int iterate_tx_align;
 	int iterate_rx_align;
@@ -126,11 +124,12 @@ int spi_test_execute_msg(struct spi_device *spi,
 int spi_test_run_tests(struct spi_device *spi,
 		       struct spi_test *tests);
 
-/* some of the default @spi_transfer.len to test */
-#define ITERATE_LEN 2, 3, 7, 11, 16, 31, 32, 64, 97, 128, 251, 256, \
+#define ITERATE_LEN_LIST 1, 2, 3, 7, 11, 16, 31, 32, 64, 97, 128, 251, 256, \
 		1021, 1024, 1031, 4093, PAGE_SIZE, 4099, 65536, 65537
-
-#define ITERATE_MAX_LEN ITERATE_LEN, SPI_TEST_MAX_SIZE - 1, SPI_TEST_MAX_SIZE
+/* some of the default @spi_transfer.len to test, terminated by a -1 */
+#define ITERATE_LEN ITERATE_LEN_LIST, -1
+#define ITERATE_MAX_LEN ITERATE_LEN_LIST, (SPI_TEST_MAX_SIZE - 1), \
+		SPI_TEST_MAX_SIZE, -1
 
 /* the default alignment to test */
 #define ITERATE_ALIGN sizeof(int)
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH v2 4/8] spi: loopback-test: move to use spi_message_dump_data
Date: Mon, 21 Dec 2015 11:52:47 +0000
Message-ID: <1450698772-2379-5-git-send-email-kernel@martin.sperl.org>
References: <1450698772-2379-1-git-send-email-kernel@martin.sperl.org>
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1450698772-2379-1-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

Move loopback-test to use the core spi_message_dump_data method.

A piece of functionality (testing for UNWRITTEN guard pattern)
that was inside spi_test_dump_transfer had to get moved out
to keep the functionality working.

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
---
 drivers/spi/spi-loopback-test.c |  116 +++++++++++++--------------------------
 1 file changed, 39 insertions(+), 77 deletions(-)

diff --git a/drivers/spi/spi-loopback-test.c b/drivers/spi/spi-loopback-test.c
index 81fa906..75cea07 100644
--- a/drivers/spi/spi-loopback-test.c
+++ b/drivers/spi/spi-loopback-test.c
@@ -331,74 +331,6 @@ MODULE_LICENSE("GPL");
 /* we allocate one page more, to allow for offsets */
 #define SPI_TEST_MAX_SIZE_PLUS (SPI_TEST_MAX_SIZE + PAGE_SIZE)
 
-static void spi_test_print_hex_dump(char *pre, const void *ptr, size_t len)
-{
-	/* limit the hex_dump */
-	if (len < 1024) {
-		print_hex_dump(KERN_INFO, pre,
-			       DUMP_PREFIX_OFFSET, 16, 1,
-			       ptr, len, 0);
-		return;
-	}
-	/* print head */
-	print_hex_dump(KERN_INFO, pre,
-		       DUMP_PREFIX_OFFSET, 16, 1,
-		       ptr, 512, 0);
-	/* print tail */
-	pr_info("%s truncated - continuing at offset %04zx\n",
-		pre, len - 512);
-	print_hex_dump(KERN_INFO, pre,
-		       DUMP_PREFIX_OFFSET, 16, 1,
-		       ptr + (len - 512), 512, 0);
-}
-
-static void spi_test_dump_message(struct spi_device *spi,
-				  struct spi_message *msg,
-				  bool dump_data)
-{
-	struct spi_transfer *xfer;
-	int i;
-	u8 b;
-
-	dev_info(&spi->dev, "  spi_msg@%pK\n", msg);
-	if (msg->status)
-		dev_info(&spi->dev, "    status:        %i\n",
-			 msg->status);
-	dev_info(&spi->dev, "    frame_length:  %i\n",
-		 msg->frame_length);
-	dev_info(&spi->dev, "    actual_length: %i\n",
-		 msg->actual_length);
-
-	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
-		dev_info(&spi->dev, "    spi_transfer@%pK\n", xfer);
-		dev_info(&spi->dev, "      len:    %i\n", xfer->len);
-		dev_info(&spi->dev, "      tx_buf: %pK\n", xfer->tx_buf);
-		if (dump_data && xfer->tx_buf)
-			spi_test_print_hex_dump("          TX: ",
-						xfer->tx_buf,
-						xfer->len);
-
-		dev_info(&spi->dev, "      rx_buf: %pK\n", xfer->rx_buf);
-		if (dump_data && xfer->rx_buf)
-			spi_test_print_hex_dump("          RX: ",
-						xfer->rx_buf,
-						xfer->len);
-		/* check for unwritten test pattern on rx_buf */
-		if (xfer->rx_buf) {
-			for (i = 0 ; i < xfer->len ; i++) {
-				b = ((u8 *)xfer->rx_buf)[xfer->len - 1 - i];
-				if (b != SPI_TEST_PATTERN_UNWRITTEN)
-					break;
-			}
-			if (i)
-				dev_info(&spi->dev,
-					 "      rx_buf filled with %02x starts at offset: %i\n",
-					 SPI_TEST_PATTERN_UNWRITTEN,
-					 xfer->len - i);
-		}
-	}
-}
-
 struct rx_ranges {
 	struct list_head list;
 	u8 *start;
@@ -423,17 +355,37 @@ static int spi_check_rx_ranges(struct spi_device *spi,
 {
 	struct spi_transfer *xfer;
 	struct rx_ranges ranges[SPI_TEST_MAX_TRANSFERS], *r;
-	int i = 0;
+	size_t i = 0;
 	LIST_HEAD(ranges_list);
-	u8 *addr;
+	u8 *addr, b;
 	int ret = 0;
 
-	/* loop over all transfers to fill in the rx_ranges */
+	/* if there is no rx, then no check is needed */
 	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
-		/* if there is no rx, then no check is needed */
 		if (!xfer->rx_buf)
 			continue;
-		/* fill in the rx_range */
+		/* check the unwritten pattern inside the transfer*/
+		for (i = 0; i < xfer->len ; i++) {
+			b = ((u8 *)xfer->rx_buf)[xfer->len - 1 - i];
+			if (b != SPI_TEST_PATTERN_UNWRITTEN)
+				break;
+		}
+		/* if there is a match then return with an error
+		 * note that the fill pattern makes sure that the last
+		 * TX byte per transfer is never the UNWRITTEN test pattern
+		 */
+		if (i) {
+			dev_err(&spi->dev,
+				"      rx_buf filled with %02x starts at offset: %i\n",
+				SPI_TEST_PATTERN_UNWRITTEN,
+				xfer->len - i);
+			return -EINVAL;
+		}
+	}
+
+	/* loop over all transfers to fill in the rx_ranges */
+	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
+		/* fill in the rx_range for the check below*/
 		if (RANGE_CHECK(xfer->rx_buf, xfer->len,
 				rx, SPI_TEST_MAX_SIZE_PLUS)) {
 			ranges[i].start = xfer->rx_buf;
@@ -653,6 +605,12 @@ static int spi_test_fill_pattern(struct spi_device *spi,
 				return -EINVAL;
 			}
 		}
+		/* make sure that the last byte in TX is
+		 * not the UNWRITTEN pattern
+		 */
+		tx_buf--;
+		if (*tx_buf == SPI_TEST_PATTERN_UNWRITTEN)
+			*tx_buf = 0;
 	}
 
 	return 0;
@@ -812,6 +770,7 @@ static int spi_test_run_iter(struct spi_device *spi,
 int spi_test_execute_msg(struct spi_device *spi, struct spi_test *test,
 			 void *tx, void *rx)
 {
+	const size_t dump_size = 512;
 	struct spi_message *msg = &test->msg;
 	int ret = 0;
 	int i;
@@ -820,7 +779,7 @@ int spi_test_execute_msg(struct spi_device *spi, struct spi_test *test,
 	if (!simulate_only) {
 		/* dump the complete message before and after the transfer */
 		if (dump_messages == 3)
-			spi_test_dump_message(spi, msg, true);
+			spi_message_dump(spi, msg, dump_size, dump_size);
 
 		/* run spi message */
 		ret = spi_sync(spi, msg);
@@ -855,9 +814,12 @@ int spi_test_execute_msg(struct spi_device *spi, struct spi_test *test,
 
 	/* if requested or on error dump message (including data) */
 exit:
-	if (dump_messages || ret)
-		spi_test_dump_message(spi, msg,
-				      (dump_messages >= 2) || (ret));
+	if (dump_messages || ret) {
+		if ((dump_messages >= 2) || (ret))
+			spi_message_dump(spi, msg, dump_size, dump_size);
+		else
+			spi_message_dump(spi, msg, 0, 0);
+	}
 
 	return ret;
 }
-- 
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

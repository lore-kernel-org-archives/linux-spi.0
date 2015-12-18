From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH 2/4] spi: loopback-test: move to use spi_message_dump_data
Date: Fri, 18 Dec 2015 12:44:25 +0000
Message-ID: <1450442668-2391-3-git-send-email-kernel@martin.sperl.org>
References: <1450442668-2391-1-git-send-email-kernel@martin.sperl.org>
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1450442668-2391-1-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

Move loopback-test to use the core spi_message_dump_data method.

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
---
 drivers/spi/spi-loopback-test.c |   75 +++------------------------------------
 1 file changed, 4 insertions(+), 71 deletions(-)

diff --git a/drivers/spi/spi-loopback-test.c b/drivers/spi/spi-loopback-test.c
index 7f497ac..8dac6a4 100644
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
@@ -819,7 +751,7 @@ int spi_test_execute_msg(struct spi_device *spi, struct spi_test *test,
 	if (!simulate_only) {
 		/* dump the complete message before and after the transfer */
 		if (dump_messages == 3)
-			spi_test_dump_message(spi, msg, true);
+			spi_message_dump_data(spi, msg, 1024);
 
 		/* run spi message */
 		ret = spi_sync(spi, msg);
@@ -855,8 +787,9 @@ int spi_test_execute_msg(struct spi_device *spi, struct spi_test *test,
 	/* if requested or on error dump message (including data) */
 exit:
 	if (dump_messages || ret)
-		spi_test_dump_message(spi, msg,
-				      (dump_messages >= 2) || (ret));
+		spi_message_dump_data(spi, msg,
+				      ((dump_messages >= 2) || (ret)) ?
+				      1024 : 0);
 
 	return ret;
 }
-- 
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

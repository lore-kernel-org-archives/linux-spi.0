From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH v3 6/8] spi: loopback-test: improve granularity of dump_messages module parameter
Date: Tue, 22 Dec 2015 18:03:26 +0000
Message-ID: <1450807408-2422-7-git-send-email-kernel@martin.sperl.org>
References: <1450807408-2422-1-git-send-email-kernel@martin.sperl.org>
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1450807408-2422-1-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

Make dump_messages module parameter a bitmask to allow for better
granularity when dumping messages.

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
---
 drivers/spi/spi-loopback-test.c |   39 ++++++++++++++++++++++++++++-----------
 1 file changed, 28 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-loopback-test.c b/drivers/spi/spi-loopback-test.c
index c26ffa1..312754f 100644
--- a/drivers/spi/spi-loopback-test.c
+++ b/drivers/spi/spi-loopback-test.c
@@ -36,11 +36,17 @@ MODULE_PARM_DESC(simulate_only, "if not 0 do not execute the spi message");
 
 /* dump spi messages */
 int dump_messages;
+#define SPI_DUMP_MESSAGE_AFTER		BIT(0)
+#define SPI_DUMP_MESSAGE_BEFORE		BIT(1)
+#define SPI_DUMP_MESSAGE_DATA_AFTER	BIT(2)
+#define SPI_DUMP_MESSAGE_DATA_BEFORE	BIT(3)
 module_param(dump_messages, int, 0);
-MODULE_PARM_DESC(dump_message,
-		 "=1 dump the basic spi_message_structure, " \
-		 "=2 dump the spi_message_structure including data, " \
-		 "=3 dump the spi_message structure before and after execution");
+MODULE_PARM_DESC(dump_messages,
+		 "BIT(0) - dump the basic spi_message_structure after processing, "
+		 "BIT(1) - dump the basic spi_message_structure before processing, "
+		 "BIT(2) - also dump the spi_message data after processing, "
+		 "BIT(3) - also dump the spi_message data before processing");
+
 /* the device is jumpered for loopback - enabling some rx_buf tests */
 int loopback;
 module_param(loopback, int, 0);
@@ -789,8 +795,14 @@ int spi_test_execute_msg(struct spi_device *spi, struct spi_test *test,
 	/* only if we do not simulate */
 	if (!simulate_only) {
 		/* dump the complete message before and after the transfer */
-		if (dump_messages == 3)
-			spi_message_dump(spi, msg, dump_size, dump_size);
+		if (dump_messages & SPI_DUMP_MESSAGE_BEFORE) {
+			if (dump_messages & SPI_DUMP_MESSAGE_DATA_BEFORE)
+				spi_message_dump(spi, msg,
+						 dump_size, dump_size);
+			else
+				spi_message_dump(spi, msg, 0, 0);
+		}
+
 
 		/* run spi message */
 		ret = spi_sync(spi, msg);
@@ -823,11 +835,16 @@ int spi_test_execute_msg(struct spi_device *spi, struct spi_test *test,
 
 	/* if requested or on error dump message (including data) */
 exit:
-	if (dump_messages || ret) {
-		if ((dump_messages >= 2) || (ret))
-			spi_message_dump(spi, msg, dump_size, dump_size);
-		else
-			spi_message_dump(spi, msg, 0, 0);
+	if (ret) {
+		spi_message_dump(spi, msg, dump_size, dump_size);
+	} else {
+		if (dump_messages & SPI_DUMP_MESSAGE_AFTER) {
+			if (dump_messages & SPI_DUMP_MESSAGE_DATA_AFTER)
+				spi_message_dump(spi, msg,
+						 dump_size, dump_size);
+			else
+				spi_message_dump(spi, msg, 0, 0);
+		}
 	}
 
 	return ret;
-- 
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

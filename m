From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH v3 3/8] spi: core: add spi_message_dump and spi_transfer_dump
Date: Tue, 22 Dec 2015 18:03:23 +0000
Message-ID: <1450807408-2422-4-git-send-email-kernel@martin.sperl.org>
References: <1450807408-2422-1-git-send-email-kernel@martin.sperl.org>
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1450807408-2422-1-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

This implements a means to dump a spi_message or spi_transfer.

spi_loop_back_test requires a means to report on failed transfers
(including payload data), so it makes use of this.

Such a functionality can also be helpful during development of
other drivers, so it has been exposed as a general facility.

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
---
 drivers/spi/spi.c       |  171 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/spi/spi.h |   24 +++++++
 2 files changed, 195 insertions(+)

Changelog:
V1->V2: changes recommended by Andy Shevchenko
V2->V3: changes recommended by Andy Shevchenko
	specifically:
	* formating of hex dump using %*ph
	* added some kerneldoc


diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 9964835..63f31f8 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -31,6 +31,7 @@
 #include <linux/of_gpio.h>
 #include <linux/pm_runtime.h>
 #include <linux/pm_domain.h>
+#include <linux/printk.h>
 #include <linux/export.h>
 #include <linux/sched/rt.h>
 #include <linux/delay.h>
@@ -718,6 +719,176 @@ int spi_register_board_info(struct spi_board_info const *info, unsigned n)
 	return 0;
 }

+const unsigned spi_dump_bytes_per_line = 16;
+static void __spi_transfer_dump_chunk(struct spi_device *spi, char *prefix,
+				      const void *ptr, size_t start,
+				      size_t len)
+{
+	for (; start < len; start += spi_dump_bytes_per_line) {
+		/* print data including address and offset */
+		dev_info(&spi->dev, "%soff=0x%.5zx ptr=0x%pK: %*ph\n",
+			 prefix, start, ptr + start,
+			 min_t(size_t, len - start, spi_dump_bytes_per_line),
+			 ptr + start);
+	}
+}
+
+/**
+ * spi_transfer_dump_buffer - dump head/tail portions of a buffer
+ * @spi:      the spi device to use for printing using dev_info
+ * @prefix:   the prefix to put in front of each line for alignment
+ * @ptr:      the buffer to dump
+ * @len:      the total length of the buffer
+ * @head_len: dump this many bytes from the start of the buffer
+ *            (rounded up to a multiple of 16)
+ * @tail_len: dump this many bytes from the end of the buffer
+ *            (rounded up so that a the start offset is a multiple of 16)
+ */
+static void spi_transfer_dump_buffer(struct spi_device *spi, char *prefix,
+				     const void *ptr, size_t len,
+				     size_t head_len, size_t tail_len)
+{
+	size_t tail_start;
+
+	/* dump head if requested */
+	if (head_len) {
+		/* calculate effective head_len - aligning if necessary */
+		head_len = (len <= head_len) ?
+			   len :
+			   roundup(head_len, spi_dump_bytes_per_line);
+
+		/* dump the head */
+		__spi_transfer_dump_chunk(spi, prefix, ptr, 0, head_len);
+
+		/* if we dumped everything return immediately */
+		if (len == head_len)
+			return;
+	}
+
+	/* return if no tail_len is requested */
+	if (!tail_len)
+		return;
+
+	/* calculate real tail start offset aligning it */
+	tail_start = (tail_len >= len) ?
+		     head_len :
+		     rounddown(len - tail_len, spi_dump_bytes_per_line);
+
+	/* special handling needed if we have been dumping head */
+	if (head_len) {
+		if (tail_start > head_len)
+			/* we are not overlapping */
+			dev_info(&spi->dev,
+				 "%struncated - continuing at offset %04x\n",
+				 prefix, tail_start);
+		else
+			/* we are overlapping, so continue at head_len */
+			tail_start = head_len;
+	}
+
+	/* dump the tail */
+	__spi_transfer_dump_chunk(spi, prefix, ptr, tail_start, len);
+}
+
+/**
+ * spi_transfer_dump - dump all the essential information
+ *                     of a @spi_transfer, when dump_size is set,
+ *                     then hex-dump that many bytes of data
+ * @spi:       @spi_device for which to dump this (dev_info)
+ * @msg:       @spi_message to which xfer belongs
+ * @xfer:      @spi_transfer to dump
+ * @head_len: bytes to dump from the start of the buffers
+ *            (rounded up to multiple of 16)
+ * @tail_len: bytes to dump from the end of the buffers
+ *            (rounded up so that tail dump starts 16 byte aligned)
+ */
+void spi_transfer_dump(struct spi_device *spi,
+		       struct spi_message *msg,
+		       struct spi_transfer *xfer,
+		       size_t head_len, size_t tail_len)
+{
+	struct device *dev = &spi->dev;
+
+	dev_info(dev, "  spi_transfer@%pK\n", xfer);
+	dev_info(dev, "    speed_hz:    %u\n", xfer->speed_hz);
+	dev_info(dev, "    len:         %u\n", xfer->len);
+	dev_info(dev, "    tx_nbits:    %u\n", xfer->tx_nbits);
+	dev_info(dev, "    rx_nbits:    %u\n", xfer->rx_nbits);
+	dev_info(dev, "    bits/word:   %u\n", xfer->bits_per_word);
+	if (xfer->delay_usecs)
+		dev_info(dev, "    delay_usecs: %u\n",
+			 xfer->delay_usecs);
+	if (xfer->cs_change)
+		dev_info(dev, "    cs_change\n");
+	if (xfer->tx_buf) {
+		dev_info(dev, "    tx_buf:      %pK\n", xfer->tx_buf);
+		if (xfer->tx_dma)
+			dev_info(dev, "    tx_dma:      %pad\n",
+				 &xfer->tx_dma);
+		if (head_len || tail_len)
+			spi_transfer_dump_buffer(spi, "\t",
+						 xfer->tx_buf, xfer->len,
+						 head_len, tail_len);
+	}
+	if (xfer->rx_buf) {
+		dev_info(dev, "    rx_buf:      %pK\n", xfer->rx_buf);
+		if (xfer->rx_dma)
+			dev_info(dev, "    rx_dma:      %pad\n",
+				 &xfer->rx_dma);
+		if (head_len || tail_len)
+			spi_transfer_dump_buffer(spi, "\t",
+						 xfer->rx_buf, xfer->len,
+						 head_len, tail_len);
+	}
+}
+EXPORT_SYMBOL_GPL(spi_transfer_dump);
+
+/**
+ * spi_message_dump_custom - dump a spi message with ability to have
+ *                           a custom dump method per transfer
+ * @spi:       @spi_device for which to dump this (dev_info)
+ * @msg:       @spi_message to dump
+ * @head_len: bytes to dump from the start of the buffers
+ *            (rounded up to multiple of 16)
+ * @tail_len: bytes to dump from the end of the buffers
+ *            (rounded up so that tail dump starts 16 byte aligned)
+ * @custom:    custom dump code to execute per transfer
+ * @context:   context to pass to the custom dump code
+ *
+ * Uses dev_info() to dump the lines.
+ */
+void spi_message_dump_custom(struct spi_device *spi,
+			     struct spi_message *msg,
+			     size_t head_len, size_t tail_len,
+			     spi_transfer_dump_custom_t custom,
+			     void *context)
+{
+	struct device *dev = &spi->dev;
+	struct spi_transfer *xfer;
+
+	/* dump the message */
+	dev_info(dev, "spi_msg@%pK\n", msg);
+	if (msg->status)
+		dev_info(dev, "  status:         %d\n", msg->status);
+	dev_info(dev, "  frame_length:   %zu\n", msg->frame_length);
+	dev_info(dev, "  actual_length:  %zu\n", msg->actual_length);
+	if (msg->complete)
+		dev_info(dev, "  complete:       %pF\n", msg->complete);
+	if (msg->context)
+		dev_info(dev, "  context:        %pF\n", msg->context);
+	if (msg->is_dma_mapped)
+		dev_info(dev, "  is_dma_mapped\n");
+	dev_info(dev, "  transfers-head: %pK\n", &msg->transfers);
+
+	/* dump transfers themselves */
+	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
+		spi_transfer_dump(spi, msg, xfer, head_len, tail_len);
+		if (custom)
+			custom(spi, msg, xfer, context);
+	}
+}
+EXPORT_SYMBOL_GPL(spi_message_dump_custom);
+
 /*-------------------------------------------------------------------------*/

 static void spi_set_cs(struct spi_device *spi, bool enable)
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index f055a47..13f8f06 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -897,6 +897,30 @@ extern int spi_setup(struct spi_device *spi);
 extern int spi_async(struct spi_device *spi, struct spi_message *message);
 extern int spi_async_locked(struct spi_device *spi,
 			    struct spi_message *message);
+/*---------------------------------------------------------------------------*/
+
+extern void spi_transfer_dump(struct spi_device *spi,
+			      struct spi_message *msg,
+			      struct spi_transfer *xfer,
+			      size_t dump_head, size_t dump_tail);
+
+typedef void (*spi_transfer_dump_custom_t)(struct spi_device *spi,
+					   struct spi_message *msg,
+					   struct spi_transfer *xfer,
+					   void *context);
+
+extern void spi_message_dump_custom(struct spi_device *spi,
+				    struct spi_message *msg,
+				    size_t dump_head, size_t dump_tail,
+				    spi_transfer_dump_custom_t custom,
+				    void *context);
+
+static inline void spi_message_dump(struct spi_device *spi,
+				    struct spi_message *msg,
+				    size_t dump_head, size_t dump_tail)
+{
+	spi_message_dump_custom(spi, msg, dump_head, dump_tail, NULL, NULL);
+}

 /*---------------------------------------------------------------------------*/

--
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

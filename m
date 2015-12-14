From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH v3 7/8] spi: core: add spi_master.min_dma_len and supporting methods
Date: Mon, 14 Dec 2015 15:20:24 +0000
Message-ID: <1450106426-2277-8-git-send-email-kernel@martin.sperl.org>
References: <1450106426-2277-1-git-send-email-kernel@martin.sperl.org>
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1450106426-2277-1-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

Added spi_master.min_dma_len plus methods requireing this information:
* spi_translate_message_size_align_merge
* spi_can_dma_min_dma_len

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
---
 drivers/spi/spi.c       |   66 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/spi/spi.h |   14 +++++++++-
 2 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 020e34d..883bfa8 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -277,6 +277,27 @@ void spi_statistics_add_transfer_stats(struct spi_statistics *stats,
 }
 EXPORT_SYMBOL_GPL(spi_statistics_add_transfer_stats);

+/**
+ * spi_can_dma_min_dma_len - default implementation for spi_can_dma
+ *                           that only checks spi_transfer.len is bigger
+ *                           spi_master.min_dma_len
+ * @master: the spi_master device
+ * @spi:    the spi_device
+ * @tfr:    the spi_transfer
+ */
+bool spi_can_dma_min_dma_len(struct spi_master *master,
+			     struct spi_device *spi,
+			     struct spi_transfer *tfr)
+{
+	/* we start DMA efforts only on bigger transfers */
+	if (tfr->len < master->min_dma_len)
+		return false;
+
+	/* return OK */
+	return true;
+}
+EXPORT_SYMBOL_GPL(spi_can_dma_min_dma_len);
+
 /* modalias support makes "modprobe $MODALIAS" new-style hotplug work,
  * and the sysfs version makes coldplug work too.
  */
@@ -2793,6 +2814,51 @@ int spi_merge_transfers(struct spi_master *master,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(spi_merge_transfers);
+/*-------------------------------------------------------------------------*/
+
+/**
+ * spi_translate_message_size_align_merge - default spi_message translation
+ *                                          code that takes its parameters
+ *                                          from @spi_master
+ *
+ * @master:  the spi_master for which we run this translation
+ * @message: the spi_message which we need to translate
+ *
+ * Returns: status of tranformation
+ */
+int spi_translate_message_size_align_merge(
+	struct spi_master *master, struct spi_message *message)
+{
+	int ret;
+
+	/* translate the message */
+
+	/* fix alignment of transfers by splitting rx_buf/tx_buf
+	 * (and worsted case copying tx_buf)
+	 */
+	ret = spi_split_transfers_unaligned(master, message,
+					    master->min_dma_len,
+					    master->dma_alignment,
+					    GFP_KERNEL);
+	if (ret)
+		return ret;
+
+	/* limit transfer length */
+	if (master->max_dma_len) {
+		ret = spi_split_transfers_maxsize(master, message,
+						  master->max_dma_len,
+						  GFP_KERNEL);
+		if (ret)
+			return ret;
+	}
+
+	/* merge spi_transfers up to a full page */
+	ret = spi_merge_transfers(master, message, 2, PAGE_SIZE,
+				  GFP_KERNEL);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(spi_translate_message_size_align_merge);

 /*-------------------------------------------------------------------------*/

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 4b4c1e9..f055a47 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -351,6 +351,9 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
  *                   while the hardware is prepared, using the parent
  *                   device for the spidev
  * @max_dma_len: Maximum length of a DMA transfer for the device.
+ * @min_dma_len: Minimum length of a DMA transfer for the device.
+ *               (mostly to avoid dma_mapping a buffer when dma is not used,
+ *                should be multiple of dma_alignment)
  * @prepare_transfer_hardware: a message will soon arrive from the queue
  *	so the subsystem requests the driver to prepare the transfer hardware
  *	by issuing this call
@@ -423,7 +426,6 @@ struct spi_master {
 	 * buffers; let protocol drivers know about these requirements.
 	 */
 	u16			dma_alignment;
-
 	/* spi_device.mode flags understood by this controller driver */
 	u16			mode_bits;

@@ -517,6 +519,7 @@ struct spi_master {
 	bool                            cur_msg_prepared;
 	bool				cur_msg_mapped;
 	struct completion               xfer_completion;
+	size_t				min_dma_len;
 	size_t				max_dma_len;

 	int (*prepare_transfer_hardware)(struct spi_master *master);
@@ -940,6 +943,15 @@ extern struct spi_replaced_transfers *spi_replace_transfers(
 	size_t extradatasize,
 	gfp_t gfp);

+/* some default implementations that drivers may use */
+extern int spi_translate_message_size_align_merge(
+	struct spi_master *master, struct spi_message *message);
+
+/* a default implementation of can_dma */
+extern bool spi_can_dma_min_dma_len(struct spi_master *master,
+				    struct spi_device *spi,
+				    struct spi_transfer *tfr);
+
 /*---------------------------------------------------------------------------*/

 /* SPI transfer transformation methods */
--
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

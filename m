From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH v3 6/8] spi: core: add spi_master.translate_message
Date: Mon, 14 Dec 2015 15:20:23 +0000
Message-ID: <1450106426-2277-7-git-send-email-kernel@martin.sperl.org>
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

Add translate_message to spi_master structure to allow
translations of spi_messages to happen independently of
prepare messages.

This "translations" are supposed to be using spi_res to handle the
reverse transformation (see spi_replace_transfers), so no explicit
code is necessary to revert any changes.

dma_mapping of spi_messages could also become part of this processing.

The long-term view is that this translation as well as the
dma_mapping of the messages may happen in a separate thread
when we are queueing those spi_messages - this would allows
for better use of cpu resources as well as reduction of latency
in the case of queuing.

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
---
 drivers/spi/spi.c       |   15 +++++++++++++++
 include/linux/spi/spi.h |    4 ++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index fe3b18e..020e34d 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1170,6 +1170,21 @@ static void __spi_pump_messages(struct spi_master *master, bool in_kthread)

 	trace_spi_message_start(master->cur_msg);

+	/* under some circumstances (i.e: when queuing a message) this
+	 * could get moved to a separate thread to reduce latencies
+	 * this could also handle the mapping of spi_transfers
+	 */
+	if (master->translate_message) {
+		ret = master->translate_message(master, master->cur_msg);
+		if (ret) {
+			dev_err(&master->dev,
+				"failed to translate message: %d\n", ret);
+			master->cur_msg->status = ret;
+			spi_finalize_current_message(master);
+			return;
+		}
+	}
+
 	if (master->prepare_message) {
 		ret = master->prepare_message(master, master->cur_msg);
 		if (ret) {
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 7172e73..4b4c1e9 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -379,6 +379,8 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
  * @handle_err: the subsystem calls the driver to handle an error that occurs
  *		in the generic implementation of transfer_one_message().
  * @unprepare_message: undo any work done by prepare_message().
+ * @translate_message: apply some message translations to optimize for the
+ *                     spi_master
  * @cs_gpios: Array of GPIOs to use as chip select lines; one per CS
  *	number. Any individual value may be -ENOENT for CS lines that
  *	are not GPIOs (driven by the SPI controller itself).
@@ -525,6 +527,8 @@ struct spi_master {
 			       struct spi_message *message);
 	int (*unprepare_message)(struct spi_master *master,
 				 struct spi_message *message);
+	int (*translate_message)(struct spi_master *master,
+				 struct spi_message *message);

 	/*
 	 * These hooks are for drivers that use a generic implementation
--
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

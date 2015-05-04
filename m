From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH 2/2] spi: add statistics gathering and reporting methods
Date: Mon,  4 May 2015 12:12:43 +0000
Message-ID: <1430741564-2849-2-git-send-email-kernel@martin.sperl.org>
References: <1430741564-2849-1-git-send-email-kernel@martin.sperl.org>
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1430741564-2849-1-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

the statistics are available:
for each master via:
  /sys/class/spi_master/spi*/stat
for each device via:
  /sys/class/spi_master/spi32766/spi32766.4/stat
  /sys/bus/spi/devices/spi32766.*/stat

Example output:
messages: 78
transfers: 78
errors: 0
timeout: 0
bytes: 122990
bytes-tx: 122990
bytes-rx: 122990
transfer-len-log2-histogram: 0 33 3 9 1 2 0 0 0 0 0 0 0 30 0 0 0

Note that log2-histogram is defined for bin n as:
spi_transfer.len in the range: [ 2^n : 2^(n+1) [
with n=0 for spi_transfer.len = 0

bus-master drivers can include additional information via
spi_master.show_stats

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
---
 drivers/spi/spi.c |  145 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 144 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 50910d8..615f60d 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -41,6 +41,114 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/spi.h>
 
+/* helper macros to help updating statistics (locked and unlocked) */
+#define SPI_STATS_FIELD_ADD_NOLOCK(master, spi, key, value) \
+	do {						    \
+		master->stats.key += value;		    \
+		spi->stats.key += value;		    \
+	} while (0)
+
+#define SPI_STATS_FIELD_ADD(master, spi, key, value)			\
+	do {								\
+		unsigned long flags;					\
+									\
+		spin_lock_irqsave(&master->stats_spinlock, flags);	\
+		SPI_STATS_FIELD_ADD_NOLOCK(master, spi, key, value);	\
+		spin_unlock_irqrestore(&master->stats_spinlock, flags);	\
+	} while (0)
+
+static ssize_t
+spi_show_statistics(struct spi_statistics *stat,
+		    char *buf, ssize_t buf_size)
+{
+	ssize_t len;
+	int i;
+
+	len = snprintf(buf,
+		       buf_size,
+		       "messages: %ld\n"
+		       "transfers: %ld\n"
+		       "errors: %ld\n"
+		       "timeout: %ld\n"
+		       "bytes: %lld\n"
+		       "bytes-tx: %lld\n"
+		       "bytes-rx: %lld\n"
+		       "transfer-len-log2-histogram:",
+		       stat->messages,
+		       stat->transfers,
+		       stat->errors,
+		       stat->timedout,
+		       stat->bytes,
+		       stat->bytes_tx,
+		       stat->bytes_rx
+		);
+
+	for (i = 0; i < SPI_STATISTICS_L2HISTO_SIZE; i++) {
+		len += snprintf(buf + len, buf_size - len,
+				" %ld", stat->bytes_l2histo[i]);
+	}
+
+	len += snprintf(buf + len, buf_size - len, "\n");
+
+	return len;
+}
+
+static ssize_t
+stat_show(struct device *dev, struct device_attribute *a, char *buf)
+{
+	struct spi_device *spi = to_spi_device(dev);
+	ssize_t len;
+	unsigned long flags;
+
+	spin_lock_irqsave(&spi->master->stats_spinlock, flags);
+
+	len = spi_show_statistics(&spi->stats, buf, PAGE_SIZE);
+
+	/* call show_stats */
+	if (spi->master->show_stats)
+		len += spi->master->show_stats(spi->master, spi,
+					       buf + len,
+					       PAGE_SIZE - len);
+
+	spin_unlock_irqrestore(&spi->master->stats_spinlock, flags);
+
+	return len;
+}
+static DEVICE_ATTR_RO(stat);
+
+static ssize_t
+master_stat_show(struct device *dev, struct device_attribute *a, char *buf)
+{
+	struct spi_master *master = to_spi_master(dev);
+	ssize_t len;
+	unsigned long flags;
+
+	spin_lock_irqsave(&master->stats_spinlock, flags);
+
+	len = spi_show_statistics(&master->stats, buf, PAGE_SIZE);
+
+	if (master->show_stats)
+		len += master->show_stats(master, NULL,
+					  buf + len,
+					  PAGE_SIZE - len);
+
+	spin_unlock_irqrestore(&master->stats_spinlock, flags);
+
+	return len;
+}
+
+struct device_attribute dev_attr_master_stat = {
+	.attr  = { .name = "stat", .mode = S_IRUGO },
+	.show  = master_stat_show,
+	.store = NULL
+};
+
+static struct attribute *spi_master_attrs[] = {
+	&dev_attr_master_stat.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(spi_master);
+
 static void spidev_release(struct device *dev)
 {
 	struct spi_device	*spi = to_spi_device(dev);
@@ -69,6 +177,7 @@ static DEVICE_ATTR_RO(modalias);
 
 static struct attribute *spi_dev_attrs[] = {
 	&dev_attr_modalias.attr,
+	&dev_attr_stat.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(spi_dev);
@@ -679,12 +788,34 @@ static int spi_transfer_one_message(struct spi_master *master,
 	bool keep_cs = false;
 	int ret = 0;
 	unsigned long ms = 1;
+	int l2size;
+	unsigned long flags;
 
 	spi_set_cs(msg->spi, true);
 
+	SPI_STATS_FIELD_ADD(master, msg->spi, messages, 1);
+
 	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
 		trace_spi_transfer_start(msg, xfer);
 
+		/* update statistics */
+		l2size = (xfer->len) ? fls(xfer->len - 1) + 1 : 0;
+		l2size = min(l2size, SPI_STATISTICS_L2HISTO_SIZE - 1);
+
+		spin_lock_irqsave(&master->stats_spinlock, flags);
+		SPI_STATS_FIELD_ADD_NOLOCK(master, msg->spi, transfers, 1);
+		SPI_STATS_FIELD_ADD_NOLOCK(master, msg->spi,
+					   bytes, xfer->len);
+		if (xfer->tx_buf)
+			SPI_STATS_FIELD_ADD_NOLOCK(master, msg->spi,
+						   bytes_tx, xfer->len);
+		if (xfer->rx_buf)
+			SPI_STATS_FIELD_ADD_NOLOCK(master, msg->spi,
+					           bytes_rx, xfer->len);
+		SPI_STATS_FIELD_ADD_NOLOCK(master, msg->spi,
+					   bytes_l2histo[l2size], 1);
+		spin_unlock_irqrestore(&master->stats_spinlock, flags);
+
 		if (xfer->tx_buf || xfer->rx_buf) {
 			reinit_completion(&master->xfer_completion);
 
@@ -692,6 +823,8 @@ static int spi_transfer_one_message(struct spi_master *master,
 			if (ret < 0) {
 				dev_err(&msg->spi->dev,
 					"SPI transfer failed: %d\n", ret);
+				SPI_STATS_FIELD_ADD(master, msg->spi,
+						    errors, 1);
 				goto out;
 			}
 
@@ -707,6 +840,8 @@ static int spi_transfer_one_message(struct spi_master *master,
 			if (ms == 0) {
 				dev_err(&msg->spi->dev,
 					"SPI transfer timed out\n");
+				SPI_STATS_FIELD_ADD(master, msg->spi,
+						    timedout, 1);
 				msg->status = -ETIMEDOUT;
 			}
 		} else {
@@ -1405,6 +1540,7 @@ static struct class spi_master_class = {
 	.name		= "spi_master",
 	.owner		= THIS_MODULE,
 	.dev_release	= spi_master_release,
+	.dev_groups     = spi_master_groups,
 };
 
 
@@ -1928,6 +2064,8 @@ static int __spi_async(struct spi_device *spi, struct spi_message *message)
 
 	message->spi = spi;
 
+	SPI_STATS_FIELD_ADD(master, spi, spi_async, 1);
+
 	trace_spi_message_submit(message);
 
 	return master->transfer(spi, message);
@@ -2064,6 +2202,8 @@ static int __spi_sync(struct spi_device *spi, struct spi_message *message,
 	message->context = &done;
 	message->spi = spi;
 
+	SPI_STATS_FIELD_ADD(master, spi, spi_sync, 1);
+
 	if (!bus_locked)
 		mutex_lock(&master->bus_lock_mutex);
 
@@ -2091,8 +2231,11 @@ static int __spi_sync(struct spi_device *spi, struct spi_message *message,
 		/* Push out the messages in the calling context if we
 		 * can.
 		 */
-		if (master->transfer == spi_queued_transfer)
+		if (master->transfer == spi_queued_transfer) {
+			SPI_STATS_FIELD_ADD(master, spi,
+					    spi_sync_immediate, 1);
 			__spi_pump_messages(master, false);
+		}
 
 		wait_for_completion(&done);
 		status = message->status;
-- 
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

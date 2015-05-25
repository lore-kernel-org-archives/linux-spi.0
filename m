From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH] spi: expose spi_master and spi_device statistics via sysfs
Date: Mon, 25 May 2015 17:28:28 +0000
Message-ID: <1432574909-2326-1-git-send-email-kernel@martin.sperl.org>
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

per spi-master statistics accessible as:
  /sys/class/spi_master/spi*/statistics/

per spi-device statistics accessible via:
  /sys/class/spi_master/spi*/spi*.*/statistics/

The following statistics are exposed as separate "files" inside
these directories:
  * messages		number of spi_messages
  * transfers		number of spi_transfers
  * bytes		number of bytes transferred
  * bytes_rx		number of bytes transmitted
  * bytes_tx		number of bytes received
  * bytes_histo		transferred bytes/spi_transfer histogram
  * errors		number of errors encounterd
  * timedout		number of messages that have timed out
  * spi_async		number of spi_messages submitted using spi_async
  * spi_sync		number of spi_messages submitted using spi_sync
  * spi_sync_immediate	number of spi_messages submitted using spi_sync,
			that are handled immediately without a context switch
			to the spi_pump worker-thread

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
---
 drivers/spi/spi.c       |  190 ++++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/spi/spi.h |   68 +++++++++++++++++
 2 files changed, 255 insertions(+), 3 deletions(-)

Todo: api to expose extra data per spi-master that is specific to the
driver.

Applies against: for-next

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index d35c1a1..f50cee3 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -67,11 +67,163 @@ modalias_show(struct device *dev, struct device_attribute *a, char *buf)
 }
 static DEVICE_ATTR_RO(modalias);
 
+#define SPI_STATISTICS_ATTRS(field)					\
+static ssize_t spi_master_##field##_show(struct device *dev,		\
+					 struct device_attribute *attr,	\
+					 char *buf)			\
+{									\
+	struct spi_master *master = container_of(dev,			\
+						 struct spi_master, dev); \
+	return spi_statistics_##field##_show(&master->statistics, buf);	\
+}									\
+static struct device_attribute dev_attr_spi_master_##field = {		\
+	.attr = { .name = __stringify(field), .mode = S_IRUGO },	\
+	.show = spi_master_##field##_show,				\
+};									\
+static ssize_t spi_device_##field##_show(struct device *dev,		\
+					 struct device_attribute *attr,	\
+					 char *buf)			\
+{									\
+	struct spi_device *spi = container_of(dev,			\
+					      struct spi_device, dev);	\
+	return spi_statistics_##field##_show(&spi->statistics, buf);	\
+}									\
+static struct device_attribute dev_attr_spi_device_##field = {		\
+	.attr = { .name = __stringify(field), .mode = S_IRUGO },	\
+	.show = spi_device_##field##_show,				\
+}
+
+#define SPI_STATISTICS_SHOW(field, format_string)			\
+static ssize_t spi_statistics_##field##_show(struct spi_statistics *stat, \
+					     char *buf)			\
+{									\
+	unsigned long flags;						\
+	ssize_t len;							\
+	spin_lock_irqsave(&stat->lock, flags);				\
+	len = sprintf(buf, format_string, stat->field);			\
+	spin_unlock_irqrestore(&stat->lock, flags);			\
+	return len;							\
+	}								\
+SPI_STATISTICS_ATTRS(field)
+
+SPI_STATISTICS_SHOW(messages, "%lu");
+SPI_STATISTICS_SHOW(transfers, "%lu");
+SPI_STATISTICS_SHOW(errors, "%lu");
+SPI_STATISTICS_SHOW(timedout, "%lu");
+
+SPI_STATISTICS_SHOW(spi_sync, "%lu");
+SPI_STATISTICS_SHOW(spi_sync_immediate, "%lu");
+SPI_STATISTICS_SHOW(spi_async, "%lu");
+
+SPI_STATISTICS_SHOW(bytes, "%llu");
+SPI_STATISTICS_SHOW(bytes_rx, "%llu");
+SPI_STATISTICS_SHOW(bytes_tx, "%llu");
+
+static ssize_t spi_statistics_bytes_histo_show(struct spi_statistics *stats,
+					       char *buf)
+{
+	int i;
+	ssize_t len;
+	unsigned long flags;
+
+	spin_lock_irqsave(&stats->lock, flags);
+	len = sprintf(buf, "%lu", stats->bytes_l2histo[0]);
+	for (i = 1; i < SPI_STATISTICS_L2HISTO_SIZE; i++)
+		len += sprintf(buf + len, " %lu",
+			       stats->bytes_l2histo[i]);
+	spin_unlock_irqrestore(&stats->lock, flags);
+
+	return len;
+}
+SPI_STATISTICS_ATTRS(bytes_histo);
+
 static struct attribute *spi_dev_attrs[] = {
 	&dev_attr_modalias.attr,
 	NULL,
 };
-ATTRIBUTE_GROUPS(spi_dev);
+
+static const struct attribute_group spi_dev_group = {
+	.attrs  = spi_dev_attrs,
+};
+
+static struct attribute *spi_device_statistics_attrs[] = {
+	&dev_attr_spi_device_messages.attr,
+	&dev_attr_spi_device_transfers.attr,
+	&dev_attr_spi_device_errors.attr,
+	&dev_attr_spi_device_timedout.attr,
+	&dev_attr_spi_device_spi_sync.attr,
+	&dev_attr_spi_device_spi_sync_immediate.attr,
+	&dev_attr_spi_device_spi_async.attr,
+	&dev_attr_spi_device_bytes.attr,
+	&dev_attr_spi_device_bytes_rx.attr,
+	&dev_attr_spi_device_bytes_tx.attr,
+	&dev_attr_spi_device_bytes_histo.attr,
+	NULL,
+};
+
+static const struct attribute_group spi_device_statistics_group = {
+	.name  = "statistics",
+	.attrs  = spi_device_statistics_attrs,
+};
+
+static const struct attribute_group *spi_dev_groups[] = {
+	&spi_dev_group,
+	&spi_device_statistics_group,
+	NULL,
+};
+
+static struct attribute *spi_master_statistics_attrs[] = {
+	&dev_attr_spi_master_messages.attr,
+	&dev_attr_spi_master_transfers.attr,
+	&dev_attr_spi_master_errors.attr,
+	&dev_attr_spi_master_timedout.attr,
+	&dev_attr_spi_master_spi_sync.attr,
+	&dev_attr_spi_master_spi_sync_immediate.attr,
+	&dev_attr_spi_master_spi_async.attr,
+	&dev_attr_spi_master_bytes.attr,
+	&dev_attr_spi_master_bytes_rx.attr,
+	&dev_attr_spi_master_bytes_tx.attr,
+	&dev_attr_spi_master_bytes_histo.attr,
+	NULL,
+};
+
+static const struct attribute_group spi_master_statistics_group = {
+	.name  = "statistics",
+	.attrs  = spi_master_statistics_attrs,
+};
+
+static const struct attribute_group *spi_master_groups[] = {
+	&spi_master_statistics_group,
+	NULL,
+};
+
+void spi_statistics_add_transfer_stats(struct spi_statistics *stats,
+				       struct spi_transfer *xfer,
+				       struct spi_master *master)
+{
+	unsigned long flags;
+	int l2len = min(fls(xfer->len), SPI_STATISTICS_L2HISTO_SIZE) - 1;
+
+	if (l2len < 0)
+		l2len = 0;
+
+	spin_lock_irqsave(&stats->lock, flags);
+
+	stats->transfers++;
+
+	stats->bytes_l2histo[l2len]++;
+
+	stats->bytes += xfer->len;
+	if ((xfer->tx_buf) &&
+	    (xfer->tx_buf != master->dummy_tx))
+		stats->bytes_tx += xfer->len;
+	if ((xfer->rx_buf) &&
+	    (xfer->rx_buf != master->dummy_rx))
+		stats->bytes_rx += xfer->len;
+
+	spin_unlock_irqrestore(&stats->lock, flags);
+}
+EXPORT_SYMBOL_GPL(spi_statistics_add_transfer_stats);
 
 /* modalias support makes "modprobe $MODALIAS" new-style hotplug work,
  * and the sysfs version makes coldplug work too.
@@ -249,6 +401,9 @@ struct spi_device *spi_alloc_device(struct spi_master *master)
 	spi->dev.bus = &spi_bus_type;
 	spi->dev.release = spidev_release;
 	spi->cs_gpio = -ENOENT;
+
+	spin_lock_init(&spi->statistics.lock);
+
 	device_initialize(&spi->dev);
 	return spi;
 }
@@ -679,17 +834,29 @@ static int spi_transfer_one_message(struct spi_master *master,
 	bool keep_cs = false;
 	int ret = 0;
 	unsigned long ms = 1;
+	struct spi_statistics *statm = &master->statistics;
+	struct spi_statistics *stats = &msg->spi->statistics;
 
 	spi_set_cs(msg->spi, true);
 
+	SPI_STATISTICS_INCREMENT_FIELD(statm, messages);
+	SPI_STATISTICS_INCREMENT_FIELD(stats, messages);
+
 	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
 		trace_spi_transfer_start(msg, xfer);
 
+		spi_statistics_add_transfer_stats(statm, xfer, master);
+		spi_statistics_add_transfer_stats(stats, xfer, master);
+
 		if (xfer->tx_buf || xfer->rx_buf) {
 			reinit_completion(&master->xfer_completion);
 
 			ret = master->transfer_one(master, msg->spi, xfer);
 			if (ret < 0) {
+				SPI_STATISTICS_INCREMENT_FIELD(statm,
+							       errors);
+				SPI_STATISTICS_INCREMENT_FIELD(stats,
+							       errors);
 				dev_err(&msg->spi->dev,
 					"SPI transfer failed: %d\n", ret);
 				goto out;
@@ -705,6 +872,10 @@ static int spi_transfer_one_message(struct spi_master *master,
 			}
 
 			if (ms == 0) {
+				SPI_STATISTICS_INCREMENT_FIELD(statm,
+							       timedout);
+				SPI_STATISTICS_INCREMENT_FIELD(stats,
+							       timedout);
 				dev_err(&msg->spi->dev,
 					"SPI transfer timed out\n");
 				msg->status = -ETIMEDOUT;
@@ -1406,10 +1577,10 @@ static struct class spi_master_class = {
 	.name		= "spi_master",
 	.owner		= THIS_MODULE,
 	.dev_release	= spi_master_release,
+	.dev_groups	= spi_master_groups,
 };
 
 
-
 /**
  * spi_alloc_master - allocate SPI master controller
  * @dev: the controller, possibly using the platform_bus
@@ -1575,6 +1746,8 @@ int spi_register_master(struct spi_master *master)
 			goto done;
 		}
 	}
+	/* add statistics */
+	spin_lock_init(&master->statistics.lock);
 
 	mutex_lock(&board_lock);
 	list_add_tail(&master->list, &spi_master_list);
@@ -1929,6 +2102,9 @@ static int __spi_async(struct spi_device *spi, struct spi_message *message)
 
 	message->spi = spi;
 
+	SPI_STATISTICS_INCREMENT_FIELD(&master->statistics, spi_async);
+	SPI_STATISTICS_INCREMENT_FIELD(&spi->statistics, spi_async);
+
 	trace_spi_message_submit(message);
 
 	return master->transfer(spi, message);
@@ -2065,6 +2241,9 @@ static int __spi_sync(struct spi_device *spi, struct spi_message *message,
 	message->context = &done;
 	message->spi = spi;
 
+	SPI_STATISTICS_INCREMENT_FIELD(&master->statistics, spi_sync);
+	SPI_STATISTICS_INCREMENT_FIELD(&spi->statistics, spi_sync);
+
 	if (!bus_locked)
 		mutex_lock(&master->bus_lock_mutex);
 
@@ -2092,8 +2271,13 @@ static int __spi_sync(struct spi_device *spi, struct spi_message *message,
 		/* Push out the messages in the calling context if we
 		 * can.
 		 */
-		if (master->transfer == spi_queued_transfer)
+		if (master->transfer == spi_queued_transfer) {
+			SPI_STATISTICS_INCREMENT_FIELD(&master->statistics,
+						       spi_sync_immediate);
+			SPI_STATISTICS_INCREMENT_FIELD(&spi->statistics,
+						       spi_sync_immediate);
 			__spi_pump_messages(master, false);
+		}
 
 		wait_for_completion(&done);
 		status = message->status;
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index d673072..606212a 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -23,6 +23,8 @@
 #include <linux/scatterlist.h>
 
 struct dma_chan;
+struct spi_master;
+struct spi_transfer;
 
 /*
  * INTERFACES between SPI master-side drivers and SPI infrastructure.
@@ -31,6 +33,63 @@ struct dma_chan;
 extern struct bus_type spi_bus_type;
 
 /**
+ * struct spi_statistics - statistics for spi transfers
+ * @clock:         lock protecting this structure
+ *
+ * @messages:      number of spi-messages handled
+ * @transfers:     number of spi_transfers handled
+ * @errors:        number of errors during spi_transfer
+ * @timedout:      number of timeouts during spi_transfer
+ *
+ * @spi_sync:      number of times spi_sync is used
+ * @spi_sync_immediate:
+ *                 number of times spi_sync is executed immediately
+ *                 in calling context without queuing and scheduling
+ * @spi_async:     number of times spi_async is used
+ *
+ * @bytes:         number of bytes transferred to/from device
+ * @bytes_tx:      number of bytes sent to device
+ * @bytes_rx:      number of bytes received from device
+ *
+ * @bytes_l2histo: histogram of bytes per spi_transfer (log2 with saturation)
+ */
+struct spi_statistics {
+	spinlock_t		lock; /* lock for the whole structure */
+
+	unsigned long		messages;
+	unsigned long		transfers;
+	unsigned long		errors;
+	unsigned long		timedout;
+
+	unsigned long		spi_sync;
+	unsigned long		spi_sync_immediate;
+	unsigned long		spi_async;
+
+	unsigned long long	bytes;
+	unsigned long long	bytes_rx;
+	unsigned long long	bytes_tx;
+
+	/* histogram of log2(size) between 0 and 65536 with saturation */
+#define SPI_STATISTICS_L2HISTO_SIZE 17
+	unsigned long bytes_l2histo[SPI_STATISTICS_L2HISTO_SIZE];
+};
+
+void spi_statistics_add_transfer_stats(struct spi_statistics *stats,
+				       struct spi_transfer *xfer,
+				       struct spi_master *master);
+
+#define SPI_STATISTICS_ADD_TO_FIELD(stats, field, count)	\
+	do {							\
+		unsigned long flags;				\
+		spin_lock_irqsave(&(stats)->lock, flags);	\
+		(stats)->field += count;			\
+		spin_unlock_irqrestore(&(stats)->lock, flags);	\
+	} while (0)
+
+#define SPI_STATISTICS_INCREMENT_FIELD(stats, field)	\
+	SPI_STATISTICS_ADD_TO_FIELD(stats, field, 1)
+
+/**
  * struct spi_device - Master side proxy for an SPI slave device
  * @dev: Driver model representation of the device.
  * @master: SPI controller used with the device.
@@ -60,6 +119,8 @@ extern struct bus_type spi_bus_type;
  * @cs_gpio: gpio number of the chipselect line (optional, -ENOENT when
  *	when not using a GPIO line)
  *
+ * @statistics: statistics for the spi_device
+ *
  * A @spi_device is used to interchange data between an SPI slave
  * (usually a discrete chip) and CPU memory.
  *
@@ -98,6 +159,9 @@ struct spi_device {
 	char			modalias[SPI_NAME_SIZE];
 	int			cs_gpio;	/* chip select gpio */
 
+	/* the statistics */
+	struct spi_statistics	statistics;
+
 	/*
 	 * likely need more hooks for more protocol options affecting how
 	 * the controller talks to each chip, like:
@@ -296,6 +360,7 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
  * @cs_gpios: Array of GPIOs to use as chip select lines; one per CS
  *	number. Any individual value may be -ENOENT for CS lines that
  *	are not GPIOs (driven by the SPI controller itself).
+ * @statistics: statistics for the spi_master
  * @dma_tx: DMA transmit channel
  * @dma_rx: DMA receive channel
  * @dummy_rx: dummy receive buffer for full-duplex devices
@@ -452,6 +517,9 @@ struct spi_master {
 	/* gpio chip select */
 	int			*cs_gpios;
 
+	/* statistics */
+	struct spi_statistics	statistics;
+
 	/* DMA channels for use with core dmaengine helpers */
 	struct dma_chan		*dma_tx;
 	struct dma_chan		*dma_rx;
-- 
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

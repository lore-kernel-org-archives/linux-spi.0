From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH 1/2] spi: add spi_statistics framework
Date: Mon,  4 May 2015 12:12:42 +0000
Message-ID: <1430741564-2849-1-git-send-email-kernel@martin.sperl.org>
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

add spi_statistics to spi_master and spi_device
also add a missing "to_spi_master" method

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
---
 include/linux/spi/spi.h |   65 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index d673072..6898574d 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -31,6 +31,45 @@ struct dma_chan;
 extern struct bus_type spi_bus_type;
 
 /**
+ * struct spi_statistics - statistics for spi transfers
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
+	unsigned long messages;
+	unsigned long transfers;
+	unsigned long errors;
+	unsigned long timedout;
+
+	unsigned long spi_sync;
+	unsigned long spi_sync_immediate;
+	unsigned long spi_async;
+
+	unsigned long long bytes;
+	unsigned long long bytes_rx;
+	unsigned long long bytes_tx;
+
+	/* histogram of log2(size) between 0 and 65536 with saturation */
+#define SPI_STATISTICS_L2HISTO_SIZE 17
+	unsigned long bytes_l2histo[SPI_STATISTICS_L2HISTO_SIZE];
+
+};
+
+/**
  * struct spi_device - Master side proxy for an SPI slave device
  * @dev: Driver model representation of the device.
  * @master: SPI controller used with the device.
@@ -59,6 +98,7 @@ extern struct bus_type spi_bus_type;
  *	for driver coldplugging, and in uevents used for hotplugging
  * @cs_gpio: gpio number of the chipselect line (optional, -ENOENT when
  *	when not using a GPIO line)
+ * @stats: the statistics for this device
  *
  * A @spi_device is used to interchange data between an SPI slave
  * (usually a discrete chip) and CPU memory.
@@ -98,6 +138,8 @@ struct spi_device {
 	char			modalias[SPI_NAME_SIZE];
 	int			cs_gpio;	/* chip select gpio */
 
+	struct spi_statistics	stats;
+
 	/*
 	 * likely need more hooks for more protocol options affecting how
 	 * the controller talks to each chip, like:
@@ -301,6 +343,16 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
  * @dummy_rx: dummy receive buffer for full-duplex devices
  * @dummy_tx: dummy transmit buffer for full-duplex devices
  *
+ * @stats: the statistics for this master
+ * @stats_spinlock: spinlock for stats locking
+ *                  (common lock for access to spi_master
+ *                  and spi_device stats structures)
+ * @show_stats: report extra data specific to this master/device
+ *                - spi can be null indicating statistics for the master
+ *                  should get reported
+ *                - returns number of bytes added to buffer
+ *                - spinlock is held while in this operation
+ *
  * Each SPI master controller can communicate with one or more @spi_device
  * children.  These make a small bus, sharing MOSI, MISO and SCK signals
  * but not chip select signals.  Each device may be configured to use a
@@ -452,6 +504,14 @@ struct spi_master {
 	/* gpio chip select */
 	int			*cs_gpios;
 
+	/* statistics reporting */
+	struct spi_statistics	stats;
+	spinlock_t		stats_spinlock;
+	ssize_t (*show_stats)(struct spi_master *master,
+			      struct spi_device *spi,
+			      char *buf,
+			      ssize_t buffer_size);
+
 	/* DMA channels for use with core dmaengine helpers */
 	struct dma_chan		*dma_tx;
 	struct dma_chan		*dma_rx;
@@ -461,6 +521,11 @@ struct spi_master {
 	void			*dummy_tx;
 };
 
+static inline struct spi_master *to_spi_master(struct device *dev)
+{
+	return dev ? container_of(dev, struct spi_master, dev) : NULL;
+}
+
 static inline void *spi_master_get_devdata(struct spi_master *master)
 {
 	return dev_get_drvdata(&master->dev);
-- 
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

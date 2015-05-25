From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH 1/4] spi: dma map a single page multiple times in sg_list for rx/tx_buf == NULL
Date: Mon, 25 May 2015 12:44:23 +0000
Message-ID: <1432557867-2427-2-git-send-email-kernel@martin.sperl.org>
References: <2B971A09-33E3-42BC-B13D-49B6DD3D2E7A@martin.sperl.org>
 <1432557867-2427-1-git-send-email-kernel@martin.sperl.org>
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1432557867-2427-1-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

This does not require SPI_MASTER_MUST_RX/TX to be set any longer
in a spi_master and by this avoids unnecessary memory allocations.

This impacts all spi_master with can_dma support when tx/rx_buf == NULL.

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
---
 drivers/spi/spi.c       |   70 ++++++++++++++++++++++++++++++++---------------
 include/linux/spi/spi.h |    4 +++
 2 files changed, 52 insertions(+), 22 deletions(-)

Applies against for-next, but note that there will be a conflict
if the patch "spi: add missing cleanup in spi_map_msg on error" is
applied already.

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index d35c1a1..7e1a12c 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -471,12 +471,28 @@ static void spi_set_cs(struct spi_device *spi, bool enable)
 }
 
 #ifdef CONFIG_HAS_DMA
+static void *__spi_map_alloc_page(struct spi_master *master,
+				  enum dma_data_direction dir)
+{
+	void **buf = (dir == DMA_TO_DEVICE) ?
+		&master->dummy_page_tx : &master->dummy_page_rx;
+
+	if (!*buf) {
+		*buf = devm_kzalloc(&master->dev,
+				    PAGE_SIZE,
+				    GFP_ATOMIC);
+	}
+
+	return *buf;
+}
+
 static int spi_map_buf(struct spi_master *master, struct device *dev,
 		       struct sg_table *sgt, void *buf, size_t len,
 		       enum dma_data_direction dir)
 {
 	const bool vmalloced_buf = is_vmalloc_addr(buf);
-	const int desc_len = vmalloced_buf ? PAGE_SIZE : master->max_dma_len;
+	const int desc_len = (vmalloced_buf || (!buf)) ?
+		PAGE_SIZE : master->max_dma_len;
 	const int sgs = DIV_ROUND_UP(len, desc_len);
 	struct page *vm_page;
 	void *sg_buf;
@@ -490,7 +506,7 @@ static int spi_map_buf(struct spi_master *master, struct device *dev,
 	for (i = 0; i < sgs; i++) {
 		min = min_t(size_t, len, desc_len);
 
-		if (vmalloced_buf) {
+		if (buf && vmalloced_buf) {
 			vm_page = vmalloc_to_page(buf);
 			if (!vm_page) {
 				sg_free_table(sgt);
@@ -499,12 +515,20 @@ static int spi_map_buf(struct spi_master *master, struct device *dev,
 			sg_set_page(&sgt->sgl[i], vm_page,
 				    min, offset_in_page(buf));
 		} else {
-			sg_buf = buf;
+			if (!buf) {
+				sg_buf = __spi_map_alloc_page(master, dir);
+				if (!sg_buf) {
+					sg_free_table(sgt);
+					return -ENOMEM;
+				}
+			} else {
+				sg_buf = buf;
+			}
 			sg_set_buf(&sgt->sgl[i], sg_buf, min);
 		}
 
-
-		buf += min;
+		if (buf)
+			buf += min;
 		len -= min;
 	}
 
@@ -546,23 +570,25 @@ static int __spi_map_msg(struct spi_master *master, struct spi_message *msg)
 		if (!master->can_dma(master, msg->spi, xfer))
 			continue;
 
-		if (xfer->tx_buf != NULL) {
-			ret = spi_map_buf(master, tx_dev, &xfer->tx_sg,
-					  (void *)xfer->tx_buf, xfer->len,
-					  DMA_TO_DEVICE);
-			if (ret != 0)
-				return ret;
-		}
-
-		if (xfer->rx_buf != NULL) {
-			ret = spi_map_buf(master, rx_dev, &xfer->rx_sg,
-					  xfer->rx_buf, xfer->len,
-					  DMA_FROM_DEVICE);
-			if (ret != 0) {
-				spi_unmap_buf(master, tx_dev, &xfer->tx_sg,
-					      DMA_TO_DEVICE);
-				return ret;
-			}
+		/* potentially add a flag to spi_master
+		 * (SPI_MASTER_MUST_TX_SG) to avoid unnecessary mapping
+		 */
+		ret = spi_map_buf(master, tx_dev, &xfer->tx_sg,
+				  (void *)xfer->tx_buf, xfer->len,
+				  DMA_TO_DEVICE);
+		if (ret != 0)
+			return ret;
+
+		/* potentially add a flag to spi_master
+		 * (SPI_MASTER_MUST_RX_SG) to avoid unnecessary mapping
+		 */
+		ret = spi_map_buf(master, rx_dev, &xfer->rx_sg,
+				  xfer->rx_buf, xfer->len,
+				  DMA_FROM_DEVICE);
+		if (ret != 0) {
+			spi_unmap_buf(master, tx_dev, &xfer->tx_sg,
+				      DMA_TO_DEVICE);
+			return ret;
 		}
 	}
 
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index d673072..9ffa506 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -300,6 +300,8 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
  * @dma_rx: DMA receive channel
  * @dummy_rx: dummy receive buffer for full-duplex devices
  * @dummy_tx: dummy transmit buffer for full-duplex devices
+ * @dummy_page_rx: dummy page for full-duplex devices
+ * @dummy_page_tx: dummy page for full-duplex devices
  *
  * Each SPI master controller can communicate with one or more @spi_device
  * children.  These make a small bus, sharing MOSI, MISO and SCK signals
@@ -459,6 +461,8 @@ struct spi_master {
 	/* dummy data for full duplex devices */
 	void			*dummy_rx;
 	void			*dummy_tx;
+	void			*dummy_page_tx;
+	void			*dummy_page_rx;
 };
 
 static inline void *spi_master_get_devdata(struct spi_master *master)
-- 
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

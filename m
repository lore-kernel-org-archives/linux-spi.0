From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH] spi: SPI_MASTER_MUST_* with scatter-gather only option and avoiding realloc
Date: Thu, 14 May 2015 09:58:44 +0000
Message-ID: <1431597524-7907-1-git-send-email-kernel@martin.sperl.org>
References: <20150512165053.GE3066@sirena.org.uk>
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150512165053.GE3066-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

Rewrite of spi_map_msg and spi_map_buf so that for SPI_MASTER_MUST_*:
* short transfers are handled by a page-sized buffer instead of
  reallocating and freeing memory (if smaller than PAGE_SIZE)
* with an extra set of flags allows to ONLY create a scatter/gather list
  that reuses the same page for all the transfers
  The scatter list produced is a match of the corresponding template
  scatter list (so tx-sg is the template for the rx-sg and vice versa)

It also fixes the insufficient cleanup in case __spi_map_msg returns
an error.

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
---
 drivers/spi/spi-bcm2835.c |    2 +-
 drivers/spi/spi.c         |  174 ++++++++++++++++++++++++++++++++++++++++-----
 include/linux/spi/spi.h   |   10 ++-
 3 files changed, 165 insertions(+), 21 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index ac1760e..ac74456 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -463,7 +463,7 @@ void bcm2835_dma_init(struct spi_master *master, struct device *dev)
 	master->can_dma = bcm2835_spi_can_dma;
 	master->max_dma_len = 65535; /* limitation by BCM2835_SPI_DLEN */
 	/* need to do TX AND RX DMA, so we need dummy buffers */
-	master->flags = SPI_MASTER_MUST_RX | SPI_MASTER_MUST_TX;
+	master->flags = SPI_MASTER_MUST_RX_SG | SPI_MASTER_MUST_TX_SG;
 
 	return;
 
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index d35c1a1..c85cf58 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -471,6 +471,73 @@ static void spi_set_cs(struct spi_device *spi, bool enable)
 }
 
 #ifdef CONFIG_HAS_DMA
+static int spi_map_null(struct spi_master *master, struct device *dev,
+			struct sg_table *sgt,
+			struct sg_table *sgt_template,
+			void *buf,
+			enum dma_data_direction dir)
+{
+	struct page *vm_page;
+	unsigned long page_offset;
+	int sgs = 0;
+	int i, j, ret;
+	ssize_t len, l;
+
+	if (is_vmalloc_addr(buf)) {
+		vm_page = vmalloc_to_page(buf);
+		if (!vm_page) {
+			sg_free_table(sgt);
+			return -ENOMEM;
+		}
+		page_offset = offset_in_page(buf);
+	} else {
+		vm_page = NULL;
+		page_offset = 0;
+	}
+
+	/* count the number of sgs we will need walking the template */
+	for (i = 0; i < sgt_template->nents; i++) {
+		len = sg_dma_len(&sgt_template->sgl[i]);
+		while (len) {
+			len -= min_t(size_t, len, PAGE_SIZE);
+			sgs++;
+		}
+	}
+
+	/* now allocate it */
+	ret = sg_alloc_table(sgt, sgs, GFP_KERNEL);
+	if (ret)
+		return ret;
+
+	/* and iterate over the template to fill our own table */
+	for (i = 0, j = 0; i < sgt_template->nents; i++) {
+		len = sg_dma_len(&sgt_template->sgl[i]);
+		/* split into multiple transfers if needed */
+		while (len) {
+			l = min_t(size_t, len, PAGE_SIZE);
+			if (vm_page)
+				sg_set_page(&sgt->sgl[i], vm_page,
+					    l, page_offset);
+			else
+				sg_set_buf(&sgt->sgl[j], buf, l);
+			len -= l;
+			j++;
+		}
+	}
+
+	ret = dma_map_sg(dev, sgt->sgl, sgt->nents, dir);
+	if (!ret)
+		ret = -ENOMEM;
+	if (ret < 0) {
+		sg_free_table(sgt);
+		return ret;
+	}
+
+	sgt->nents = ret;
+
+	return 0;
+}
+
 static int spi_map_buf(struct spi_master *master, struct device *dev,
 		       struct sg_table *sgt, void *buf, size_t len,
 		       enum dma_data_direction dir)
@@ -564,6 +631,37 @@ static int __spi_map_msg(struct spi_master *master, struct spi_message *msg)
 				return ret;
 			}
 		}
+
+		/*
+		 * handle the SPI_MASTER_MUST_*_SG
+		 * note that the situation with tx_buf and rx_buf both NULL
+		 * is checked and handled inside spi_transfer_one_message
+		 */
+		if ((!xfer->tx_buf) && (xfer->rx_buf) &&
+		    (master->flags & SPI_MASTER_MUST_TX_SG)) {
+			ret = spi_map_null(master, tx_dev,
+					   &xfer->tx_sg, &xfer->rx_sg,
+					   master->page_tx,
+					   DMA_TO_DEVICE);
+			if (ret != 0) {
+				spi_unmap_buf(master, rx_dev, &xfer->rx_sg,
+					      DMA_FROM_DEVICE);
+				return ret;
+			}
+		}
+
+		if ((!xfer->rx_buf) && (xfer->tx_buf) &&
+		    (master->flags & SPI_MASTER_MUST_RX_SG)) {
+			ret = spi_map_null(master, rx_dev,
+					   &xfer->rx_sg, &xfer->tx_sg,
+					   master->page_rx,
+					   DMA_FROM_DEVICE);
+			if (ret != 0) {
+				spi_unmap_buf(master, tx_dev, &xfer->tx_sg,
+					      DMA_TO_DEVICE);
+				return ret;
+			}
+		}
 	}
 
 	master->cur_msg_mapped = true;
@@ -587,9 +685,11 @@ static int spi_unmap_msg(struct spi_master *master, struct spi_message *msg)
 		 * Restore the original value of tx_buf or rx_buf if they are
 		 * NULL.
 		 */
-		if (xfer->tx_buf == master->dummy_tx)
+		if ((xfer->tx_buf == master->dummy_tx) ||
+		    (xfer->tx_buf == master->page_tx))
 			xfer->tx_buf = NULL;
-		if (xfer->rx_buf == master->dummy_rx)
+		if ((xfer->rx_buf == master->dummy_rx) ||
+		    (xfer->rx_buf == master->page_rx))
 			xfer->rx_buf = NULL;
 
 		if (!master->can_dma(master, msg->spi, xfer))
@@ -618,8 +718,9 @@ static inline int spi_unmap_msg(struct spi_master *master,
 static int spi_map_msg(struct spi_master *master, struct spi_message *msg)
 {
 	struct spi_transfer *xfer;
-	void *tmp;
+	void *tmp_tx, *tmp_rx;
 	unsigned int max_tx, max_rx;
+	int ret;
 
 	if (master->flags & (SPI_MASTER_MUST_RX | SPI_MASTER_MUST_TX)) {
 		max_tx = 0;
@@ -635,34 +736,53 @@ static int spi_map_msg(struct spi_master *master, struct spi_message *msg)
 		}
 
 		if (max_tx) {
-			tmp = krealloc(master->dummy_tx, max_tx,
-				       GFP_KERNEL | GFP_DMA);
-			if (!tmp)
-				return -ENOMEM;
-			master->dummy_tx = tmp;
-			memset(tmp, 0, max_tx);
+			if (max_tx > PAGE_SIZE) {
+				tmp_tx = krealloc(master->dummy_tx, max_tx,
+						  GFP_KERNEL | GFP_DMA);
+				if (!tmp_tx)
+					return -ENOMEM;
+				master->dummy_tx = tmp_tx;
+				memset(tmp_tx, 0, max_tx);
+			} else {
+				tmp_tx = master->page_tx;
+			}
+		} else {
+			tmp_tx = NULL;
 		}
 
-		if (max_rx) {
-			tmp = krealloc(master->dummy_rx, max_rx,
-				       GFP_KERNEL | GFP_DMA);
-			if (!tmp)
-				return -ENOMEM;
-			master->dummy_rx = tmp;
+		if (max_rx)  {
+			if (max_rx > PAGE_SIZE) {
+				tmp_rx = krealloc(master->dummy_rx, max_rx,
+						  GFP_KERNEL | GFP_DMA);
+				if (!tmp_rx)
+					return -ENOMEM;
+				master->dummy_rx = tmp_rx;
+			} else {
+				tmp_rx = master->page_rx;
+			}
+		} else {
+			tmp_tx = NULL;
 		}
 
 		if (max_tx || max_rx) {
 			list_for_each_entry(xfer, &msg->transfers,
 					    transfer_list) {
 				if (!xfer->tx_buf)
-					xfer->tx_buf = master->dummy_tx;
+					xfer->tx_buf = tmp_tx;
 				if (!xfer->rx_buf)
-					xfer->rx_buf = master->dummy_rx;
+					xfer->rx_buf = tmp_rx;
 			}
 		}
 	}
 
-	return __spi_map_msg(master, msg);
+	/* if we fail we need to undo the parial mappings
+	 * and fix up the modified rx_buf/tx_buf
+	 */
+	ret = __spi_map_msg(master, msg);
+	if (ret)
+		spi_unmap_msg(master, msg);
+
+	return ret;
 }
 
 /*
@@ -1555,6 +1675,24 @@ int spi_register_master(struct spi_master *master)
 	if (!master->max_dma_len)
 		master->max_dma_len = INT_MAX;
 
+	/* we need to set max_dma_len to PAGESIZE for MUST_XX_SG */
+	if (master->flags & (SPI_MASTER_MUST_RX_SG | SPI_MASTER_MUST_TX_SG))
+		master->max_dma_len = min_t(size_t,
+					    master->max_dma_len, PAGE_SIZE);
+	/* and allocate some buffers for dma */
+	if (master->flags & (SPI_MASTER_MUST_RX | SPI_MASTER_MUST_RX_SG)) {
+		master->page_rx = devm_kmalloc(&master->dev,
+					       PAGE_SIZE, GFP_DMA);
+		if (!master->page_rx)
+			return -ENOMEM;
+	}
+	if (master->flags & (SPI_MASTER_MUST_TX | SPI_MASTER_MUST_TX_SG)) {
+		master->page_tx = devm_kzalloc(&master->dev,
+					       PAGE_SIZE, GFP_DMA);
+		if (!master->page_tx)
+			return -ENOMEM;
+	}
+
 	/* register the device, then userspace will see it.
 	 * registration fails if the bus ID is in use.
 	 */
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index d673072..1f440ff 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -353,8 +353,10 @@ struct spi_master {
 #define SPI_MASTER_HALF_DUPLEX	BIT(0)		/* can't do full duplex */
 #define SPI_MASTER_NO_RX	BIT(1)		/* can't do buffer read */
 #define SPI_MASTER_NO_TX	BIT(2)		/* can't do buffer write */
-#define SPI_MASTER_MUST_RX      BIT(3)		/* requires rx */
-#define SPI_MASTER_MUST_TX      BIT(4)		/* requires tx */
+#define SPI_MASTER_MUST_RX      BIT(3)		/* requires rx_buf allocated */
+#define SPI_MASTER_MUST_TX      BIT(4)		/* requires tx_buf allocated */
+#define SPI_MASTER_MUST_RX_SG   BIT(5)		/* requires rx sg list */
+#define SPI_MASTER_MUST_TX_SG   BIT(6)		/* requires tx sg list */
 
 	/* lock and mutex for SPI bus locking */
 	spinlock_t		bus_lock_spinlock;
@@ -459,6 +461,10 @@ struct spi_master {
 	/* dummy data for full duplex devices */
 	void			*dummy_rx;
 	void			*dummy_tx;
+
+	/* pages for dma-transfers */
+	void			*page_rx;
+	void			*page_tx;
 };
 
 static inline void *spi_master_get_devdata(struct spi_master *master)
-- 
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

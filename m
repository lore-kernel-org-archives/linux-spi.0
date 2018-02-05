From: Boris Brezillon <boris.brezillon-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Subject: [RFC PATCH 6/6] spi: Get rid of the spi_flash_read() API
Date: Tue,  6 Feb 2018 00:21:20 +0100
Message-ID: <20180205232120.5851-7-boris.brezillon@bootlin.com>
References: <20180205232120.5851-1-boris.brezillon@bootlin.com>
Cc: Peter Pan <peterpansjtu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Frieder Schrempf <frieder.schrempf-wPoT/lNZgHizQB+pC5nmwQ@public.gmane.org>,
        Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>,
        Yogesh Gaur <yogeshnarayan.gaur-3arQi8VN3Tc@public.gmane.org>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal-g1n6cQUeyibVItvQsEIGlw@public.gmane.org>,
        Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
To: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
        Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
        Marek Vasut <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Richard Weinberger <richard-/L3Ra7n9ekc@public.gmane.org>,
        Cyrille Pitchen <cyrille.pitchen-yU5RGvR974pGWvitb5QawA@public.gmane.org>,
        linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180205232120.5851-1-boris.brezillon-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

This API has been replaced by the spi_mem_xx() one, its only user
(spi-nor) has been converted to spi_mem_xx() and all SPI controller
drivers that were implementing the ->spi_flash_xxx() hooks are also
implementing the spi_mem ones. So we can safely get rid of this API.

Signed-off-by: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 drivers/spi/spi-bcm-qspi.c | 38 +++----------------------------
 drivers/spi/spi-bcm53xx.c  | 20 +---------------
 drivers/spi/spi-ti-qspi.c  | 41 ---------------------------------
 drivers/spi/spi.c          | 57 ----------------------------------------------
 include/linux/spi/spi.h    | 53 ------------------------------------------
 5 files changed, 4 insertions(+), 205 deletions(-)

diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index f47a13453ef6..4670fe5d83f8 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -946,9 +946,10 @@ static int bcm_qspi_mspi_exec_mem_op(struct spi_device *spi,
 	return ret;
 }
 
-static int bcm_qspi_exec_mem_op(struct spi_device *spi,
+static int bcm_qspi_exec_mem_op(struct spi_mem *mem,
 				const struct spi_mem_op *op)
 {
+	struct spi_device *spi = mem->spi;
 	struct bcm_qspi *qspi = spi_master_get_devdata(spi->master);
 	int ret = 0, i;
 	bool mspi_read = false;
@@ -998,38 +999,6 @@ static int bcm_qspi_exec_mem_op(struct spi_device *spi,
 	return ret;
 }
 
-static int bcm_qspi_exec_mem_op_wrapper(struct spi_mem *mem,
-					const struct spi_mem_op *op)
-{
-	return bcm_qspi_exec_mem_op(mem->spi, op);
-}
-
-static int bcm_qspi_flash_read_wrapper(struct spi_device *spi,
-				       struct spi_flash_read_message *msg)
-{
-	int i, ret;
-	u8 addrs[4];
-	struct spi_mem_op op = SPI_MEM_OP(SPI_MEM_OP_CMD(msg->read_opcode, 1),
-					  SPI_MEM_OP_ADDRS(msg->addr_width,
-							   addrs,
-							   msg->addr_nbits),
-					  SPI_MEM_OP_DUMMY(msg->dummy_bytes,
-							   msg->addr_nbits),
-					  SPI_MEM_OP_DATA_IN(msg->len,
-							     msg->buf,
-							     msg->data_nbits));
-
-	for (i = msg->addr_width - 1; i >= 0; i--)
-		addrs[i] = msg->from >> (i * 8);
-
-	msg->retlen = 0;
-	ret = bcm_qspi_exec_mem_op(spi, &op);
-	if (!ret)
-		msg->retlen = msg->len;
-
-	return ret;
-}
-
 static void bcm_qspi_cleanup(struct spi_device *spi)
 {
 	struct bcm_qspi_parms *xp = spi_get_ctldata(spi);
@@ -1225,7 +1194,7 @@ static void bcm_qspi_hw_uninit(struct bcm_qspi *qspi)
 }
 
 static const struct spi_controller_mem_ops bcm_qspi_mem_ops = {
-	.exec_op = bcm_qspi_exec_mem_op_wrapper,
+	.exec_op = bcm_qspi_exec_mem_op,
 };
 
 static const struct of_device_id bcm_qspi_of_match[] = {
@@ -1270,7 +1239,6 @@ int bcm_qspi_probe(struct platform_device *pdev,
 	master->mode_bits = SPI_CPHA | SPI_CPOL | SPI_RX_DUAL | SPI_RX_QUAD;
 	master->setup = bcm_qspi_setup;
 	master->transfer_one = bcm_qspi_transfer_one;
-	master->spi_flash_read = bcm_qspi_flash_read_wrapper;
 	master->mem_ops = &bcm_qspi_mem_ops;
 	master->cleanup = bcm_qspi_cleanup;
 	master->dev.of_node = dev->of_node;
diff --git a/drivers/spi/spi-bcm53xx.c b/drivers/spi/spi-bcm53xx.c
index c681d432e26c..707213418bb3 100644
--- a/drivers/spi/spi-bcm53xx.c
+++ b/drivers/spi/spi-bcm53xx.c
@@ -297,22 +297,6 @@ static const struct spi_controller_mem_ops bcm53xxspi_mem_ops = {
 	.exec_op = bcm53xxspi_exec_mem_op,
 };
 
-static int bcm53xxspi_flash_read(struct spi_device *spi,
-				 struct spi_flash_read_message *msg)
-{
-	struct bcm53xxspi *b53spi = spi_master_get_devdata(spi->master);
-	int ret = 0;
-
-	if (msg->from + msg->len > BCM53XXSPI_FLASH_WINDOW)
-		return -EINVAL;
-
-	bcm53xxspi_enable_bspi(b53spi);
-	memcpy_fromio(msg->buf, b53spi->mmio_base + msg->from, msg->len);
-	msg->retlen = msg->len;
-
-	return ret;
-}
-
 /**************************************************
  * BCMA
  **************************************************/
@@ -351,10 +335,8 @@ static int bcm53xxspi_bcma_probe(struct bcma_device *core)
 
 	master->dev.of_node = dev->of_node;
 	master->transfer_one = bcm53xxspi_transfer_one;
-	if (b53spi->mmio_base) {
+	if (b53spi->mmio_base)
 		master->mem_ops = &bcm53xxspi_mem_ops;
-		master->spi_flash_read = bcm53xxspi_flash_read;
-	}
 
 	bcma_set_drvdata(core, b53spi);
 
diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 40cac3ef6cc9..50237e2753b2 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -529,44 +529,6 @@ static void ti_qspi_setup_mmap_read(struct spi_device *spi, u8 opcode,
 		      QSPI_SPI_SETUP_REG(spi->chip_select));
 }
 
-static bool ti_qspi_spi_flash_can_dma(struct spi_device *spi,
-				      struct spi_flash_read_message *msg)
-{
-	return virt_addr_valid(msg->buf);
-}
-
-static int ti_qspi_spi_flash_read(struct spi_device *spi,
-				  struct spi_flash_read_message *msg)
-{
-	struct ti_qspi *qspi = spi_master_get_devdata(spi->master);
-	int ret = 0;
-
-	mutex_lock(&qspi->list_lock);
-
-	if (!qspi->mmap_enabled)
-		ti_qspi_enable_memory_map(spi);
-	ti_qspi_setup_mmap_read(spi, msg->read_opcode, msg->data_nbits,
-				msg->addr_width, msg->dummy_bytes);
-
-	if (qspi->rx_chan) {
-		if (msg->cur_msg_mapped)
-			ret = ti_qspi_dma_xfer_sg(qspi, msg->rx_sg, msg->from);
-		else
-			ret = ti_qspi_dma_bounce_buffer(qspi, msg->from,
-							msg->buf, msg->len);
-		if (ret)
-			goto err_unlock;
-	} else {
-		memcpy_fromio(msg->buf, qspi->mmap_base + msg->from, msg->len);
-	}
-	msg->retlen = msg->len;
-
-err_unlock:
-	mutex_unlock(&qspi->list_lock);
-
-	return ret;
-}
-
 static int ti_qspi_exec_mem_op(struct spi_mem *mem,
 			       const struct spi_mem_op *op)
 {
@@ -729,7 +691,6 @@ static int ti_qspi_probe(struct platform_device *pdev)
 	master->dev.of_node = pdev->dev.of_node;
 	master->bits_per_word_mask = SPI_BPW_MASK(32) | SPI_BPW_MASK(16) |
 				     SPI_BPW_MASK(8);
-	master->spi_flash_read = ti_qspi_spi_flash_read;
 	master->mem_ops = &ti_qspi_mem_ops;
 
 	if (!of_property_read_u32(np, "num-cs", &num_cs))
@@ -828,7 +789,6 @@ static int ti_qspi_probe(struct platform_device *pdev)
 		dma_release_channel(qspi->rx_chan);
 		goto no_dma;
 	}
-	master->spi_flash_can_dma = ti_qspi_spi_flash_can_dma;
 	master->dma_rx = qspi->rx_chan;
 	init_completion(&qspi->transfer_complete);
 	if (res_mmap)
@@ -842,7 +802,6 @@ static int ti_qspi_probe(struct platform_device *pdev)
 				 "mmap failed with error %ld using PIO mode\n",
 				 PTR_ERR(qspi->mmap_base));
 			qspi->mmap_base = NULL;
-			master->spi_flash_read = NULL;
 			master->mem_ops = NULL;
 		}
 	}
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 57bc540a0521..0491ef8c321f 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3046,63 +3046,6 @@ int spi_async_locked(struct spi_device *spi, struct spi_message *message)
 }
 EXPORT_SYMBOL_GPL(spi_async_locked);
 
-
-int spi_flash_read(struct spi_device *spi,
-		   struct spi_flash_read_message *msg)
-
-{
-	struct spi_controller *master = spi->controller;
-	struct device *rx_dev = NULL;
-	int ret;
-
-	if ((msg->opcode_nbits == SPI_NBITS_DUAL ||
-	     msg->addr_nbits == SPI_NBITS_DUAL) &&
-	    !(spi->mode & (SPI_TX_DUAL | SPI_TX_QUAD)))
-		return -EINVAL;
-	if ((msg->opcode_nbits == SPI_NBITS_QUAD ||
-	     msg->addr_nbits == SPI_NBITS_QUAD) &&
-	    !(spi->mode & SPI_TX_QUAD))
-		return -EINVAL;
-	if (msg->data_nbits == SPI_NBITS_DUAL &&
-	    !(spi->mode & (SPI_RX_DUAL | SPI_RX_QUAD)))
-		return -EINVAL;
-	if (msg->data_nbits == SPI_NBITS_QUAD &&
-	    !(spi->mode &  SPI_RX_QUAD))
-		return -EINVAL;
-
-	if (master->auto_runtime_pm) {
-		ret = pm_runtime_get_sync(master->dev.parent);
-		if (ret < 0) {
-			dev_err(&master->dev, "Failed to power device: %d\n",
-				ret);
-			return ret;
-		}
-	}
-
-	mutex_lock(&master->bus_lock_mutex);
-	mutex_lock(&master->io_mutex);
-	if (master->dma_rx && master->spi_flash_can_dma(spi, msg)) {
-		rx_dev = master->dma_rx->device->dev;
-		ret = spi_map_buf(master, rx_dev, &msg->rx_sg,
-				  msg->buf, msg->len,
-				  DMA_FROM_DEVICE);
-		if (!ret)
-			msg->cur_msg_mapped = true;
-	}
-	ret = master->spi_flash_read(spi, msg);
-	if (msg->cur_msg_mapped)
-		spi_unmap_buf(master, rx_dev, &msg->rx_sg,
-			      DMA_FROM_DEVICE);
-	mutex_unlock(&master->io_mutex);
-	mutex_unlock(&master->bus_lock_mutex);
-
-	if (master->auto_runtime_pm)
-		pm_runtime_put(master->dev.parent);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(spi_flash_read);
-
 /*-------------------------------------------------------------------------*/
 
 /* Utility methods for SPI protocol drivers, layered on
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index af3c4ac62b55..0921d2c82b35 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -26,7 +26,6 @@ struct dma_chan;
 struct property_entry;
 struct spi_controller;
 struct spi_transfer;
-struct spi_flash_read_message;
 struct spi_controller_mem_ops;
 
 /*
@@ -382,11 +381,6 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
  *	     controller has native support for memory like operations.
  * @unprepare_message: undo any work done by prepare_message().
  * @slave_abort: abort the ongoing transfer request on an SPI slave controller
- * @spi_flash_read: to support spi-controller hardwares that provide
- *                  accelerated interface to read from flash devices.
- * @spi_flash_can_dma: analogous to can_dma() interface, but for
- *		       controllers implementing spi_flash_read.
- * @flash_read_supported: spi device supports flash read
  * @cs_gpios: Array of GPIOs to use as chip select lines; one per CS
  *	number. Any individual value may be -ENOENT for CS lines that
  *	are not GPIOs (driven by the SPI controller itself).
@@ -552,11 +546,6 @@ struct spi_controller {
 	int (*unprepare_message)(struct spi_controller *ctlr,
 				 struct spi_message *message);
 	int (*slave_abort)(struct spi_controller *ctlr);
-	int (*spi_flash_read)(struct  spi_device *spi,
-			      struct spi_flash_read_message *msg);
-	bool (*spi_flash_can_dma)(struct spi_device *spi,
-				  struct spi_flash_read_message *msg);
-	bool (*flash_read_supported)(struct spi_device *spi);
 
 	/*
 	 * These hooks are for drivers that use a generic implementation
@@ -1190,48 +1179,6 @@ static inline ssize_t spi_w8r16be(struct spi_device *spi, u8 cmd)
 	return be16_to_cpu(result);
 }
 
-/**
- * struct spi_flash_read_message - flash specific information for
- * spi-masters that provide accelerated flash read interfaces
- * @buf: buffer to read data
- * @from: offset within the flash from where data is to be read
- * @len: length of data to be read
- * @retlen: actual length of data read
- * @read_opcode: read_opcode to be used to communicate with flash
- * @addr_width: number of address bytes
- * @dummy_bytes: number of dummy bytes
- * @opcode_nbits: number of lines to send opcode
- * @addr_nbits: number of lines to send address
- * @data_nbits: number of lines for data
- * @rx_sg: Scatterlist for receive data read from flash
- * @cur_msg_mapped: message has been mapped for DMA
- */
-struct spi_flash_read_message {
-	void *buf;
-	loff_t from;
-	size_t len;
-	size_t retlen;
-	u8 read_opcode;
-	u8 addr_width;
-	u8 dummy_bytes;
-	u8 opcode_nbits;
-	u8 addr_nbits;
-	u8 data_nbits;
-	struct sg_table rx_sg;
-	bool cur_msg_mapped;
-};
-
-/* SPI core interface for flash read support */
-static inline bool spi_flash_read_supported(struct spi_device *spi)
-{
-	return spi->controller->spi_flash_read &&
-	       (!spi->controller->flash_read_supported ||
-	       spi->controller->flash_read_supported(spi));
-}
-
-int spi_flash_read(struct spi_device *spi,
-		   struct spi_flash_read_message *msg);
-
 /*---------------------------------------------------------------------------*/
 
 /* SPI memory related definitions. */
-- 
2.14.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

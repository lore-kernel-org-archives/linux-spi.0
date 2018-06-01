From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [RFC PATCH 1/2] spi: spi-mem: Add a new API to support direct mapping
Date: Fri,  1 Jun 2018 16:36:02 +0200
Message-ID: <20180601143603.4047-2-boris.brezillon@bootlin.com>
References: <20180601143603.4047-1-boris.brezillon@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Cyrille Pitchen <cyrille.pitchen@microchip.com>,
 Vignesh R <vigneshr@ti.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Boris Brezillon <boris.brezillon@bootlin.com>,
 Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>,
 linux-mtd@lists.infradead.org, Mark Brown <broonie@kernel.org>,
 linux-spi@vger.kernel.org
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20180601143603.4047-1-boris.brezillon@bootlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

Most modern QSPI controllers support can directly map a SPI memory (or
a portion of the SPI memory) in the CPU address space. Most of the time
this brings significant performance improvements as it automates the
whole process of sending SPI memory operations every time a new region
is accessed.

This new API allow SPI memory driver to create direct mappings and then
use them to access the memory instead of using spi_mem_exec_op().

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 drivers/spi/spi-mem.c       | 267 ++++++++++++++++++++++++++++++++++++++++----
 include/linux/spi/spi-mem.h |  72 ++++++++++++
 2 files changed, 318 insertions(+), 21 deletions(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 990770dfa5cf..90ea0c5263a7 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -175,6 +175,44 @@ bool spi_mem_supports_op(struct spi_mem *mem, const struct spi_mem_op *op)
 }
 EXPORT_SYMBOL_GPL(spi_mem_supports_op);
 
+static int spi_mem_access_start(struct spi_mem *mem)
+{
+	struct spi_controller *ctlr = mem->spi->controller;
+
+	/*
+	 * Flush the message queue before executing our SPI memory
+	 * operation to prevent preemption of regular SPI transfers.
+	 */
+	spi_flush_queue(ctlr);
+
+	if (ctlr->auto_runtime_pm) {
+		int ret;
+
+		ret = pm_runtime_get_sync(ctlr->dev.parent);
+		if (ret < 0) {
+			dev_err(&ctlr->dev, "Failed to power device: %d\n",
+				ret);
+			return ret;
+		}
+	}
+
+	mutex_lock(&ctlr->bus_lock_mutex);
+	mutex_lock(&ctlr->io_mutex);
+
+	return 0;
+}
+
+static void spi_mem_access_end(struct spi_mem *mem)
+{
+	struct spi_controller *ctlr = mem->spi->controller;
+
+	mutex_unlock(&ctlr->io_mutex);
+	mutex_unlock(&ctlr->bus_lock_mutex);
+
+	if (ctlr->auto_runtime_pm)
+		pm_runtime_put(ctlr->dev.parent);
+}
+
 /**
  * spi_mem_exec_op() - Execute a memory operation
  * @mem: the SPI memory
@@ -200,30 +238,13 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 		return -ENOTSUPP;
 
 	if (ctlr->mem_ops) {
-		/*
-		 * Flush the message queue before executing our SPI memory
-		 * operation to prevent preemption of regular SPI transfers.
-		 */
-		spi_flush_queue(ctlr);
-
-		if (ctlr->auto_runtime_pm) {
-			ret = pm_runtime_get_sync(ctlr->dev.parent);
-			if (ret < 0) {
-				dev_err(&ctlr->dev,
-					"Failed to power device: %d\n",
-					ret);
-				return ret;
-			}
-		}
+		ret = spi_mem_access_start(mem);
+		if (ret)
+			return ret;
 
-		mutex_lock(&ctlr->bus_lock_mutex);
-		mutex_lock(&ctlr->io_mutex);
 		ret = ctlr->mem_ops->exec_op(mem, op);
-		mutex_unlock(&ctlr->io_mutex);
-		mutex_unlock(&ctlr->bus_lock_mutex);
 
-		if (ctlr->auto_runtime_pm)
-			pm_runtime_put(ctlr->dev.parent);
+		spi_mem_access_end(mem);
 
 		/*
 		 * Some controllers only optimize specific paths (typically the
@@ -336,6 +357,210 @@ int spi_mem_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
 }
 EXPORT_SYMBOL_GPL(spi_mem_adjust_op_size);
 
+static ssize_t spi_mem_no_dirmap_read(struct spi_mem_dirmap_desc *desc,
+				      u64 offs, size_t len, void *buf)
+{
+	struct spi_mem_op op = desc->info.op_tmpl;
+	size_t read = 0;
+	int ret;
+
+	while (read < len) {
+		op.addr.val = desc->info.offset + offs + read;
+		op.data.buf.in = buf + read;
+		op.data.nbytes = len - read;
+		ret = spi_mem_adjust_op_size(desc->mem, &op);
+		if (ret)
+			return ret;
+
+		ret = spi_mem_exec_op(desc->mem, &op);
+		if (ret)
+			return ret;
+
+		read += op.data.nbytes;
+	}
+
+	return read;
+}
+
+static ssize_t spi_mem_no_dirmap_write(struct spi_mem_dirmap_desc *desc,
+				       u64 offs, size_t len, const void *buf)
+{
+	struct spi_mem_op op = desc->info.op_tmpl;
+	size_t written = 0;
+	int ret;
+
+	while (written < len) {
+		op.addr.val = desc->info.offset + offs + written;
+		op.data.buf.out = buf + written;
+		op.data.nbytes = len - written;
+		ret = spi_mem_adjust_op_size(desc->mem, &op);
+		if (ret)
+			return ret;
+
+		ret = spi_mem_exec_op(desc->mem, &op);
+		if (ret)
+			return ret;
+
+		written += op.data.nbytes;
+	}
+
+	return written;
+}
+
+/**
+ * spi_mem_dirmap_create() - Create a direct mapping descriptor
+ * @mem: SPI mem device this direct mapping should be created for
+ * @info: direct mapping information
+ *
+ * This function is creating a direct mapping descriptor which can then be used
+ * to access the memory using spi_mem_dirmap_read() or spi_mem_dirmap_write().
+ * If the SPI controller driver does not support direct mapping, this function
+ * fallback to an implementation using spi_mem_exec_op(), so that the caller
+ * doesn't have to bother implementing a fallback on his own.
+ *
+ * Return: a valid pointer in case of success, and ERR_PTR() otherwise.
+ */
+struct spi_mem_dirmap_desc *
+spi_mem_dirmap_create(struct spi_mem *mem,
+		      const struct spi_mem_dirmap_info *info)
+{
+	struct spi_controller *ctlr = mem->spi->controller;
+	struct spi_mem_dirmap_desc *desc;
+	int ret = -ENOTSUPP;
+
+	desc = kzalloc(sizeof(*desc), GFP_KERNEL);
+	if (!desc)
+		return ERR_PTR(-ENOMEM);
+
+	desc->mem = mem;
+	desc->info = *info;
+	if (ctlr->mem_ops && ctlr->mem_ops->dirmap_create)
+		ret = ctlr->mem_ops->dirmap_create(desc);
+
+	if (ret) {
+		desc->nodirmap = true;
+		if (!spi_mem_supports_op(desc->mem, &desc->info.op_tmpl))
+			ret = -ENOTSUPP;
+		else
+			ret = 0;
+	}
+
+	if (ret) {
+		kfree(desc);
+		return ERR_PTR(ret);
+	}
+
+	return desc;
+}
+EXPORT_SYMBOL_GPL(spi_mem_dirmap_create);
+
+/**
+ * spi_mem_dirmap_destroy() - Destroy a direct mapping descriptor
+ * @desc: the direct mapping descriptor to destroy
+ * @info: direct mapping information
+ *
+ * This function destroys a direct mapping descriptor previously created by
+ * spi_mem_dirmap_create().
+ */
+void spi_mem_dirmap_destroy(struct spi_mem_dirmap_desc *desc)
+{
+	struct spi_controller *ctlr = desc->mem->spi->controller;
+
+	if (!desc->nodirmap && ctlr->mem_ops && ctlr->mem_ops->dirmap_destroy)
+		ctlr->mem_ops->dirmap_destroy(desc);
+}
+EXPORT_SYMBOL_GPL(spi_mem_dirmap_destroy);
+
+/**
+ * spi_mem_dirmap_dirmap_read() - Read data through a direct mapping
+ * @desc: direct mapping descriptor
+ * @offs: offset to start reading from. Note that this is not an absolute
+ *	  offset, but the offset within the direct mapping which already has
+ *	  its own offset
+ * @len: length in bytes
+ * @buf: destination buffer. This buffer must be DMA-able
+ *
+ * This function reads data from a memory device using a direct mapping
+ * previously instantiated with spi_mem_dirmap_create().
+ *
+ * Return: the amount of data read from the memory device or a negative error
+ * code.
+ */
+ssize_t spi_mem_dirmap_read(struct spi_mem_dirmap_desc *desc,
+			    u64 offs, size_t len, void *buf)
+{
+	struct spi_controller *ctlr = desc->mem->spi->controller;
+	ssize_t ret;
+
+	if (desc->info.op_tmpl.data.dir != SPI_MEM_DATA_IN)
+		return -EINVAL;
+
+	if (!len)
+		return 0;
+
+	if (desc->nodirmap) {
+		ret = spi_mem_no_dirmap_read(desc, offs, len, buf);
+	} else if (ctlr->mem_ops && ctlr->mem_ops->dirmap_read) {
+		ret = spi_mem_access_start(desc->mem);
+		if (ret)
+			return ret;
+
+		ret = ctlr->mem_ops->dirmap_read(desc, offs, len, buf);
+
+		spi_mem_access_end(desc->mem);
+	} else {
+		ret = -ENOTSUPP;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(spi_mem_dirmap_read);
+
+/**
+ * spi_mem_dirmap_dirmap_write() - Write data through a direct mapping
+ * @desc: direct mapping descriptor
+ * @offs: offset to start writing from. Note that this is not an absolute
+ *	  offset, but the offset within the direct mapping which already has
+ *	  its own offset
+ * @len: length in bytes
+ * @buf: source buffer. This buffer must be DMA-able
+ *
+ * This function writes data to a memory device using a direct mapping
+ * previously instantiated with spi_mem_dirmap_create().
+ *
+ * Return: the amount of data written to the memory device or a negative error
+ * code.
+ */
+ssize_t spi_mem_dirmap_write(struct spi_mem_dirmap_desc *desc,
+			     u64 offs, size_t len, const void *buf)
+{
+	struct spi_controller *ctlr = desc->mem->spi->controller;
+	ssize_t ret;
+
+	if (desc->info.op_tmpl.data.dir != SPI_MEM_DATA_OUT)
+		return -EINVAL;
+
+	if (!len)
+		return 0;
+
+	if (desc->nodirmap) {
+		ret = spi_mem_no_dirmap_write(desc, offs, len, buf);
+	} else if (ctlr->mem_ops && ctlr->mem_ops->dirmap_write) {
+		ret = spi_mem_access_start(desc->mem);
+		if (ret)
+			return ret;
+
+		ret = ctlr->mem_ops->dirmap_write(desc, offs, len, buf);
+
+		spi_mem_access_end(desc->mem);
+	} else {
+		ret = -ENOTSUPP;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(spi_mem_dirmap_write);
+
 static inline struct spi_mem_driver *to_spi_mem_drv(struct device_driver *drv)
 {
 	return container_of(drv, struct spi_mem_driver, spidrv.driver);
diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index 4fa34a227a0f..da67b75a19f1 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -121,6 +121,49 @@ struct spi_mem_op {
 		.data = __data,					\
 	}
 
+/**
+ * struct spi_mem_dirmap_info - Direct mapping information
+ * @op_tmpl: operation template that should be used by the direct mapping when
+ *	     the memory device is accessed
+ * @offset: absolute offset this direct mapping is pointing to
+ * @length: length in byte of this direct mapping
+ *
+ * These information are used by the controller specific implementation to know
+ * the portion of memory that is directly mapped and the spi_mem_op that should
+ * be used to access the device.
+ * A direct mapping is only valid for one direction (read or write) and this
+ * direction is directly encoded in the ->op_tmpl.data.dir field.
+ */
+struct spi_mem_dirmap_info {
+	struct spi_mem_op op_tmpl;
+	u64 offset;
+	u64 length;
+};
+
+/**
+ * struct spi_mem_dirmap_desc - Direct mapping descriptor
+ * @mem: the SPI memory device this direct mapping is attached to
+ * @info: information passed at direct mapping creation time
+ * @nodirmap: set to true if the SPI controller does not implement
+ *	      ->mem_ops->dirmap_create() or when this function returned an
+ *	      error. If dirmap is true, all spi_mem_dirmap_{read,write}()
+ *	      calls will use spi_mem_exec_op() to access the memory. This is a
+ *	      degraded mode that allows higher spi_mem drivers to use the same
+ *	      code no matter if the controller supports direct mapping or not
+ * @priv: field pointing to controller specific data
+ *
+ * Common part of a direct mapping descriptor. This object is created by
+ * spi_mem_dirmap_create() and controller implementation of ->create_dirmap()
+ * can create/attach direct mapping resources to the descriptor in the ->priv
+ * field.
+ */
+struct spi_mem_dirmap_desc {
+	struct spi_mem *mem;
+	struct spi_mem_dirmap_info info;
+	bool nodirmap;
+	void *priv;
+};
+
 /**
  * struct spi_mem - describes a SPI memory device
  * @spi: the underlying SPI device
@@ -167,10 +210,24 @@ static inline void *spi_mem_get_drvdata(struct spi_mem *mem)
  *		    limitations)
  * @supports_op: check if an operation is supported by the controller
  * @exec_op: execute a SPI memory operation
+ * @dirmap_create: create a direct mapping descriptor that can later be used to
+ *		   access the memory device. This method is optional
+ * @dirmap_destroy: destroy a memory descriptor previous created by
+ *		    ->dirmap_create()
+ * @dirmap_read: read data from the memory device using the direct mapping
+ *		 created by ->dirmap_create().
+ * @dirmap_write: write data to the memory device using the direct mapping
+ *		  created by ->dirmap_create().
  *
  * This interface should be implemented by SPI controllers providing an
  * high-level interface to execute SPI memory operation, which is usually the
  * case for QSPI controllers.
+ *
+ * Note on ->dirmap_{read,write}(): drivers should avoid accessing the direct
+ * mapping from the CPU because doing that can stall the CPU waiting for the
+ * SPI mem transaction to finish, and this will make real-time maintainers
+ * unhappy and might make your system less reactive. Instead, drivers should
+ * use DMA to access this direct mapping.
  */
 struct spi_controller_mem_ops {
 	int (*adjust_op_size)(struct spi_mem *mem, struct spi_mem_op *op);
@@ -178,6 +235,12 @@ struct spi_controller_mem_ops {
 			    const struct spi_mem_op *op);
 	int (*exec_op)(struct spi_mem *mem,
 		       const struct spi_mem_op *op);
+	int (*dirmap_create)(struct spi_mem_dirmap_desc *desc);
+	void (*dirmap_destroy)(struct spi_mem_dirmap_desc *desc);
+	ssize_t (*dirmap_read)(struct spi_mem_dirmap_desc *desc,
+			       u64 offs, size_t len, void *buf);
+	ssize_t (*dirmap_write)(struct spi_mem_dirmap_desc *desc,
+				u64 offs, size_t len, const void *buf);
 };
 
 /**
@@ -236,6 +299,15 @@ bool spi_mem_supports_op(struct spi_mem *mem,
 int spi_mem_exec_op(struct spi_mem *mem,
 		    const struct spi_mem_op *op);
 
+struct spi_mem_dirmap_desc *
+spi_mem_dirmap_create(struct spi_mem *mem,
+		      const struct spi_mem_dirmap_info *info);
+void spi_mem_dirmap_destroy(struct spi_mem_dirmap_desc *desc);
+ssize_t spi_mem_dirmap_read(struct spi_mem_dirmap_desc *desc,
+			    u64 offs, size_t len, void *buf);
+ssize_t spi_mem_dirmap_write(struct spi_mem_dirmap_desc *desc,
+			     u64 offs, size_t len, const void *buf);
+
 int spi_mem_driver_register_with_owner(struct spi_mem_driver *drv,
 				       struct module *owner);
 
-- 
2.14.1


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

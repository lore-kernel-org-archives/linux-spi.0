From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH v4 5/7] spi: ti-qspi: Implement the spi_mem interface
Date: Thu, 26 Apr 2018 18:18:18 +0200
Message-ID: <20180426161820.2852-6-boris.brezillon@bootlin.com>
References: <20180426161820.2852-1-boris.brezillon@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>, Vignesh R <vigneshr@ti.com>,
 Kamal Dasu <kdasu.kdev@gmail.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Peter Pan <peterpansjtu@gmail.com>,
 Frieder Schrempf <frieder.schrempf@exceet.de>,
 =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
To: David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Boris Brezillon <boris.brezillon@bootlin.com>,
 Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>,
 Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
 linux-mtd@lists.infradead.org, Miquel Raynal <miquel.raynal@bootlin.com>,
 Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20180426161820.2852-1-boris.brezillon@bootlin.com>
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

The spi_mem interface is meant to replace the spi_flash_read() one.
Implement the ->exec_op() method so that we can smoothly get rid of the
old interface.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
Changes in v4:
- fix ->mmap_size assignment

Changes in v3:
- none

Changes in v2:
- include spi-mem.h
- treat op->addr.val differently since it's now an u64
- Fix 'buf is DMA-able' check
- Extract max mmap size from resource_size()
---
 drivers/spi/spi-ti-qspi.c | 84 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 71 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index c24d9b45a27c..1b12c2ff8be3 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -36,6 +36,7 @@
 #include <linux/sizes.h>
 
 #include <linux/spi/spi.h>
+#include <linux/spi/spi-mem.h>
 
 struct ti_qspi_regs {
 	u32 clkctrl;
@@ -50,6 +51,7 @@ struct ti_qspi {
 	struct spi_master	*master;
 	void __iomem            *base;
 	void __iomem            *mmap_base;
+	size_t			mmap_size;
 	struct regmap		*ctrl_base;
 	unsigned int		ctrl_reg;
 	struct clk		*fclk;
@@ -434,12 +436,10 @@ static int ti_qspi_dma_xfer(struct ti_qspi *qspi, dma_addr_t dma_dst,
 	return 0;
 }
 
-static int ti_qspi_dma_bounce_buffer(struct ti_qspi *qspi,
-				     struct spi_flash_read_message *msg)
+static int ti_qspi_dma_bounce_buffer(struct ti_qspi *qspi, loff_t offs,
+				     void *to, size_t readsize)
 {
-	size_t readsize = msg->len;
-	void *to = msg->buf;
-	dma_addr_t dma_src = qspi->mmap_phys_base + msg->from;
+	dma_addr_t dma_src = qspi->mmap_phys_base + offs;
 	int ret = 0;
 
 	/*
@@ -507,13 +507,14 @@ static void ti_qspi_disable_memory_map(struct spi_device *spi)
 	qspi->mmap_enabled = false;
 }
 
-static void ti_qspi_setup_mmap_read(struct spi_device *spi,
-				    struct spi_flash_read_message *msg)
+static void ti_qspi_setup_mmap_read(struct spi_device *spi, u8 opcode,
+				    u8 data_nbits, u8 addr_width,
+				    u8 dummy_bytes)
 {
 	struct ti_qspi  *qspi = spi_master_get_devdata(spi->master);
-	u32 memval = msg->read_opcode;
+	u32 memval = opcode;
 
-	switch (msg->data_nbits) {
+	switch (data_nbits) {
 	case SPI_NBITS_QUAD:
 		memval |= QSPI_SETUP_RD_QUAD;
 		break;
@@ -524,8 +525,8 @@ static void ti_qspi_setup_mmap_read(struct spi_device *spi,
 		memval |= QSPI_SETUP_RD_NORMAL;
 		break;
 	}
-	memval |= ((msg->addr_width - 1) << QSPI_SETUP_ADDR_SHIFT |
-		   msg->dummy_bytes << QSPI_SETUP_DUMMY_SHIFT);
+	memval |= ((addr_width - 1) << QSPI_SETUP_ADDR_SHIFT |
+		   dummy_bytes << QSPI_SETUP_DUMMY_SHIFT);
 	ti_qspi_write(qspi, memval,
 		      QSPI_SPI_SETUP_REG(spi->chip_select));
 }
@@ -546,13 +547,15 @@ static int ti_qspi_spi_flash_read(struct spi_device *spi,
 
 	if (!qspi->mmap_enabled)
 		ti_qspi_enable_memory_map(spi);
-	ti_qspi_setup_mmap_read(spi, msg);
+	ti_qspi_setup_mmap_read(spi, msg->read_opcode, msg->data_nbits,
+				msg->addr_width, msg->dummy_bytes);
 
 	if (qspi->rx_chan) {
 		if (msg->cur_msg_mapped)
 			ret = ti_qspi_dma_xfer_sg(qspi, msg->rx_sg, msg->from);
 		else
-			ret = ti_qspi_dma_bounce_buffer(qspi, msg);
+			ret = ti_qspi_dma_bounce_buffer(qspi, msg->from,
+							msg->buf, msg->len);
 		if (ret)
 			goto err_unlock;
 	} else {
@@ -566,6 +569,58 @@ static int ti_qspi_spi_flash_read(struct spi_device *spi,
 	return ret;
 }
 
+static int ti_qspi_exec_mem_op(struct spi_mem *mem,
+			       const struct spi_mem_op *op)
+{
+	struct ti_qspi *qspi = spi_master_get_devdata(mem->spi->master);
+	u32 from = 0;
+	int ret = 0;
+
+	/* Only optimize read path. */
+	if (!op->data.nbytes || op->data.dir != SPI_MEM_DATA_IN ||
+	    !op->addr.nbytes || op->addr.nbytes > 4)
+		return -ENOTSUPP;
+
+	/* Address exceeds MMIO window size, fall back to regular mode. */
+	from = op->addr.val;
+	if (from + op->data.nbytes > qspi->mmap_size)
+		return -ENOTSUPP;
+
+	mutex_lock(&qspi->list_lock);
+
+	if (!qspi->mmap_enabled)
+		ti_qspi_enable_memory_map(mem->spi);
+	ti_qspi_setup_mmap_read(mem->spi, op->cmd.opcode, op->data.buswidth,
+				op->addr.nbytes, op->dummy.nbytes);
+
+	if (qspi->rx_chan) {
+		struct sg_table sgt;
+
+		if (virt_addr_valid(op->data.buf.in) &&
+		    !spi_controller_dma_map_mem_op_data(mem->spi->master, op,
+							&sgt)) {
+			ret = ti_qspi_dma_xfer_sg(qspi, sgt, from);
+			spi_controller_dma_unmap_mem_op_data(mem->spi->master,
+							     op, &sgt);
+		} else {
+			ret = ti_qspi_dma_bounce_buffer(qspi, from,
+							op->data.buf.in,
+							op->data.nbytes);
+		}
+	} else {
+		memcpy_fromio(op->data.buf.in, qspi->mmap_base + from,
+			      op->data.nbytes);
+	}
+
+	mutex_unlock(&qspi->list_lock);
+
+	return ret;
+}
+
+static const struct spi_controller_mem_ops ti_qspi_mem_ops = {
+	.exec_op = ti_qspi_exec_mem_op,
+};
+
 static int ti_qspi_start_transfer_one(struct spi_master *master,
 		struct spi_message *m)
 {
@@ -673,6 +728,7 @@ static int ti_qspi_probe(struct platform_device *pdev)
 	master->bits_per_word_mask = SPI_BPW_MASK(32) | SPI_BPW_MASK(16) |
 				     SPI_BPW_MASK(8);
 	master->spi_flash_read = ti_qspi_spi_flash_read;
+	master->mem_ops = &ti_qspi_mem_ops;
 
 	if (!of_property_read_u32(np, "num-cs", &num_cs))
 		master->num_chipselect = num_cs;
@@ -701,6 +757,7 @@ static int ti_qspi_probe(struct platform_device *pdev)
 				"memory mapped resource not required\n");
 		}
 	}
+	qspi->mmap_size = resource_size(res_mmap);
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
@@ -785,6 +842,7 @@ static int ti_qspi_probe(struct platform_device *pdev)
 				 PTR_ERR(qspi->mmap_base));
 			qspi->mmap_base = NULL;
 			master->spi_flash_read = NULL;
+			master->mem_ops = NULL;
 		}
 	}
 	qspi->mmap_enabled = false;
-- 
2.14.1


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

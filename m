From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH 3/3] spi: spi-mem: Add extra sanity checks on the op param
Date: Thu, 20 Sep 2018 09:31:12 +0200
Message-ID: <20180920073112.7897-4-boris.brezillon@bootlin.com>
References: <20180920073112.7897-1-boris.brezillon@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>,
 Boris Brezillon <boris.brezillon@bootlin.com>, linux-mtd@lists.infradead.org,
 Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>
To: Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20180920073112.7897-1-boris.brezillon@bootlin.com>
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

Some combinations are simply not valid and should be rejected before
the op is passed to the SPI controller driver.

Add an spi_mem_check_op() helper and use it in spi_mem_exec_op() and
spi_mem_supports_op() to make sure the spi-mem operation is valid.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 drivers/spi/spi-mem.c | 54 +++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 48 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index eb72dba71d83..cc3d425aae56 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -12,6 +12,8 @@
 
 #include "internals.h"
 
+#define SPI_MEM_MAX_BUSWIDTH		4
+
 /**
  * spi_controller_dma_map_mem_op_data() - DMA-map the buffer attached to a
  *					  memory operation
@@ -149,6 +151,44 @@ static bool spi_mem_default_supports_op(struct spi_mem *mem,
 }
 EXPORT_SYMBOL_GPL(spi_mem_default_supports_op);
 
+static bool spi_mem_buswidth_is_valid(u8 buswidth)
+{
+	if (hweight8(buswidth) > 1 || buswidth > SPI_MEM_MAX_BUSWIDTH)
+		return false;
+
+	return true;
+}
+
+static int spi_mem_check_op(const struct spi_mem_op *op)
+{
+	if (!op->cmd.buswidth)
+		return -EINVAL;
+
+	if ((op->addr.nbytes && !op->addr.buswidth) ||
+	    (op->dummy.nbytes && !op->dummy.buswidth) ||
+	    (op->data.nbytes && !op->data.buswidth))
+		return -EINVAL;
+
+	if (spi_mem_buswidth_is_valid(op->cmd.buswidth) ||
+	    spi_mem_buswidth_is_valid(op->addr.buswidth) ||
+	    spi_mem_buswidth_is_valid(op->dummy.buswidth) ||
+	    spi_mem_buswidth_is_valid(op->data.buswidth))
+		return -EINVAL;
+
+	return 0;
+}
+
+static bool spi_mem_internal_supports_op(struct spi_mem *mem,
+					 const struct spi_mem_op *op)
+{
+	struct spi_controller *ctlr = mem->spi->controller;
+
+	if (ctlr->mem_ops && ctlr->mem_ops->supports_op)
+		return ctlr->mem_ops->supports_op(mem, op);
+
+	return spi_mem_default_supports_op(mem, op);
+}
+
 /**
  * spi_mem_supports_op() - Check if a memory device and the controller it is
  *			   connected to support a specific memory operation
@@ -166,12 +206,10 @@ EXPORT_SYMBOL_GPL(spi_mem_default_supports_op);
  */
 bool spi_mem_supports_op(struct spi_mem *mem, const struct spi_mem_op *op)
 {
-	struct spi_controller *ctlr = mem->spi->controller;
-
-	if (ctlr->mem_ops && ctlr->mem_ops->supports_op)
-		return ctlr->mem_ops->supports_op(mem, op);
+	if (spi_mem_check_op(op))
+		return false;
 
-	return spi_mem_default_supports_op(mem, op);
+	return spi_mem_internal_supports_op(mem, op);
 }
 EXPORT_SYMBOL_GPL(spi_mem_supports_op);
 
@@ -196,7 +234,11 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	u8 *tmpbuf;
 	int ret;
 
-	if (!spi_mem_supports_op(mem, op))
+	ret = spi_mem_check_op(op);
+	if (ret)
+		return ret;
+
+	if (!spi_mem_internal_supports_op(mem, op))
 		return -ENOTSUPP;
 
 	if (ctlr->mem_ops) {
-- 
2.14.1


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

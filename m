From: Chuanhua Han <chuanhua.han@nxp.com>
Subject: [PATCH v4] mtd: spi-mem: Add the default transfer length adjustments
Date: Tue, 21 Aug 2018 15:15:50 +0800
Message-ID: <1534835750-2251-1-git-send-email-chuanhua.han@nxp.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuanhua Han <chuanhua.han@nxp.com>, stable@vger.kernel.org
To: boris.brezillon@bootlin.com, broonie@kernel.org
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

    We need that to adjust the len of the 2nd transfer (called data in spi-mem)
if it's too long to fit in a SPI message or SPI transfer.

Fixes: c36ff266dc82 ("spi: Extend the core to ease integration of SPI memory controllers")
Cc: <stable@vger.kernel.org>

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Chuanhua Han <chuanhua.han@nxp.com>
---
Changes in v4:
  -Rename variable name "opcode_addr_dummy_sum" to "len".
  -The comparison of "spi_max_message_size(mem->spi)" and "len" was removed.
  -Adjust their order when comparing the sizes of "spi_max_message_size(mem->spi)" and "len".
  -Changing the "unsigned long" type in the code to "size_t".
Changes in v3:
  -Rename variable name "val" to "opcode_addr_dummy_sum".
  -Place the legitimacy of the transfer size(i.e., "spi_max_message_size(mem->spi)" and
  -"opcode_addr_dummy_sum") into "if (! ctlr - > mem_ops | |! ctlr-> mem_ops->exec_op) {"
structure and add "spi_max_transfer_size(mem->spi) and opcode_addr_dummy_sum".
  -Adjust the formatting alignment of the code.
  -"(unsigned long)op->data.nbytes" was modified to "(unsigned long)(op->data.nbytes)".
Changes in v2:
  -Place the adjusted transfer bytes code in spi_mem_adjust_op_size() and  check 
spi_max_message_size(mem->spi) value before subtracting opcode, addr and dummy bytes.
  -Change the code from fsl-espi controller to generic code(The adjustment of spi transmission
length was originally modified in the "drivers/spi/spi-fsl-espi.c" file, and now the adjustment
of transfer length is made in the "drivers/spi/spi-mem.c" file).

 drivers/spi/spi-mem.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 990770d..5374606 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -328,10 +328,23 @@ EXPORT_SYMBOL_GPL(spi_mem_exec_op);
 int spi_mem_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
 {
 	struct spi_controller *ctlr = mem->spi->controller;
+	size_t len = sizeof(op->cmd.opcode) +
+			    op->addr.nbytes +
+			    op->dummy.nbytes;
 
 	if (ctlr->mem_ops && ctlr->mem_ops->adjust_op_size)
 		return ctlr->mem_ops->adjust_op_size(mem, op);
 
+	if (!ctlr->mem_ops || !ctlr->mem_ops->exec_op) {
+		if (len > spi_max_transfer_size(mem->spi))
+			return -EINVAL;
+
+		op->data.nbytes = min3((size_t)(op->data.nbytes),
+				       spi_max_transfer_size(mem->spi),
+				       spi_max_message_size(mem->spi) -
+				       len);
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(spi_mem_adjust_op_size);
-- 
2.7.4

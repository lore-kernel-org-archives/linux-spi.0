From: Chuanhua Han <chuanhua.han@nxp.com>
Subject: [PATCH v5] spi: spi-mem: Adjust op len based on message/transfer size limitations
Date: Thu, 30 Aug 2018 16:43:24 +0800
Message-ID: <1535618604-21706-1-git-send-email-chuanhua.han@nxp.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        boris.brezillon@bootlin.com, Chuanhua Han <chuanhua.han@nxp.com>,
        stable@vger.kernel.org
To: broonie@kernel.org
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

We need that to adjust the len of the 2nd transfer (called data in
spi-mem) if it's too long to fit in a SPI message or SPI transfer.

Fixes: c36ff266dc82 ("spi: Extend the core to ease integration of SPI memory controllers")
Cc: <stable@vger.kernel.org>
Signed-off-by: Chuanhua Han <chuanhua.han@nxp.com>
Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
Changes in v5:
  -Add the validation check after the op->data.nbytes assignment
  -Assign the "len" variable after defining it
  -Remove the brackets on both sides of "opt-> data.nbytes"
Changes in v4:
  -Rename variable name "opcode_addr_dummy_sum" to "len"
  -The comparison of "spi_max_message_size(mem->spi)" and "len" was removed
  -Adjust their order when comparing the sizes of "spi_max_message_size(mem->spi)" and "len"
  -Changing the "unsigned long" type in the code to "size_t"
Changes in v3:
  -Rename variable name "val" to "opcode_addr_dummy_sum"
  -Place the legitimacy of the transfer size(i.e., "spi_max_message_size(mem->spi)" and
"opcode_addr_dummy_sum") into "if (! ctlr - > mem_ops | |! ctlr-> mem_ops->exec_op) {"
structure and add "spi_max_transfer_size(mem->spi) and opcode_addr_dummy_sum"
  -Adjust the formatting alignment of the code
  -"(unsigned long)op->data.nbytes" was modified to "(unsigned long)(op->data.nbytes)"
Changes in v2:
  -Place the adjusted transfer bytes code in spi_mem_adjust_op_size() and  check
spi_max_message_size(mem->spi) value before subtracting opcode, addr and dummy bytes
  -Change the code from fsl-espi controller to generic code(The adjustment of spi transmission
length was originally modified in the "drivers/spi/spi-fsl-espi.c" file, and now the adjustment
of transfer length is made in the "drivers/spi/spi-mem.c" file)

 drivers/spi/spi-mem.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index e43842c..eb72dba 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -346,10 +346,25 @@ EXPORT_SYMBOL_GPL(spi_mem_get_name);
 int spi_mem_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
 {
 	struct spi_controller *ctlr = mem->spi->controller;
+	size_t len;
+
+	len = sizeof(op->cmd.opcode) + op->addr.nbytes + op->dummy.nbytes;
 
 	if (ctlr->mem_ops && ctlr->mem_ops->adjust_op_size)
 		return ctlr->mem_ops->adjust_op_size(mem, op);
 
+	if (!ctlr->mem_ops || !ctlr->mem_ops->exec_op) {
+		if (len > spi_max_transfer_size(mem->spi))
+			return -EINVAL;
+
+		op->data.nbytes = min3((size_t)op->data.nbytes,
+				       spi_max_transfer_size(mem->spi),
+				       spi_max_message_size(mem->spi) -
+				       len);
+		if (!op->data.nbytes)
+			return -EINVAL;
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(spi_mem_adjust_op_size);
-- 
2.7.4

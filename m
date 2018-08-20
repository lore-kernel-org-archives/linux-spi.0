From: Chuanhua Han <chuanhua.han@nxp.com>
Subject: [PATCH] mtd: m25p80: consider max message size when use the spi_mem_xx() API
Date: Mon, 20 Aug 2018 20:43:33 +0800
Message-ID: <1534769013-43449-1-git-send-email-chuanhua.han@nxp.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, jiafei.pan@nxp.com, zhiqiang.hou@nxp.com,
        Chuanhua Han <chuanhua.han@nxp.com>
To: broonie@kernel.org, boris.brezillon@bootlin.com
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Signed-off-by: Chuanhua Han <chuanhua.han@nxp.com>
---
Changes in v3:
    Rename variable name "val" to "opcode_addr_dummy_sum".
    Place the legitimacy of the transfer size(i.e., "pi_max_message_size(mem->spi)" and
"opcode_addr_dummy_sum") into "if (! ctlr - > mem_ops | |! ctlr-> mem_ops->exec_op) {"
structure and add "spi_max_transfer_size(mem->spi) and opcode_addr_dummy_sum".
    Adjust the formatting alignment of your code.
    "(unsigned long)op->data.nbytes" was modified to "(unsigned long)(op->data.nbytes)".

Fixes: c36ff266dc82 ("spi: Extend the core to ease integration of SPI memory controllers")
---
 drivers/spi/spi-mem.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 990770d..5ec2bc9 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -328,10 +328,24 @@ EXPORT_SYMBOL_GPL(spi_mem_exec_op);
 int spi_mem_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
 {
 	struct spi_controller *ctlr = mem->spi->controller;
+	unsigned long opcode_addr_dummy_sum = sizeof(op->cmd.opcode) +
+					      op->addr.nbytes +
+					      op->dummy.nbytes;
 
 	if (ctlr->mem_ops && ctlr->mem_ops->adjust_op_size)
 		return ctlr->mem_ops->adjust_op_size(mem, op);
 
+	if (!ctlr->mem_ops || !ctlr->mem_ops->exec_op) {
+		if (spi_max_message_size(mem->spi) < opcode_addr_dummy_sum ||
+		    spi_max_transfer_size(mem->spi) < opcode_addr_dummy_sum)
+			return -EINVAL;
+
+		op->data.nbytes = min3((unsigned long)(op->data.nbytes),
+				       spi_max_transfer_size(mem->spi),
+				       spi_max_message_size(mem->spi) -
+				       opcode_addr_dummy_sum);
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(spi_mem_adjust_op_size);
-- 
2.7.4

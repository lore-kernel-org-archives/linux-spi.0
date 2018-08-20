From: Chuanhua Han <chuanhua.han@nxp.com>
Subject: [PATCH] mtd: m25p80: consider max message size when use the spi_mem_xx() API
Date: Mon, 20 Aug 2018 17:43:26 +0800
Message-ID: <1534758206-24555-1-git-send-email-chuanhua.han@nxp.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, jiafei.pan@nxp.com, zhiqiang.hou@nxp.com,
        Chuanhua Han <chuanhua.han@nxp.com>
To: broonie@kernel.org, boris.brezillon@bootlin.com
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Signed-off-by: Chuanhua Han <chuanhua.han@nxp.com>
---
Changes in v2:
	- Place the adjusted transfer bytes code in spi_mem_adjust_op_size()
	and  check spi_max_message_size(mem->spi) value before subtracting 
	opcode, addr and dummy bytes.
*fixes:
	spi: Extend the core to ease integration of SPI memory controllers
---
 drivers/spi/spi-mem.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 990770d..f5e75d1 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -328,10 +328,21 @@ EXPORT_SYMBOL_GPL(spi_mem_exec_op);
 int spi_mem_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
 {
 	struct spi_controller *ctlr = mem->spi->controller;
+	unsigned long val =	sizeof(op->cmd.opcode) +
+							  op->addr.nbytes +
+							  op->dummy.nbytes;
 
 	if (ctlr->mem_ops && ctlr->mem_ops->adjust_op_size)
 		return ctlr->mem_ops->adjust_op_size(mem, op);
 
+	if (spi_max_message_size(mem->spi) < val)
+		return -EINVAL;
+
+	if (!ctlr->mem_ops || !ctlr->mem_ops->exec_op)
+		op->data.nbytes = min3((unsigned long)op->data.nbytes,
+				spi_max_transfer_size(mem->spi),
+				spi_max_message_size(mem->spi) - val);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(spi_mem_adjust_op_size);
-- 
2.7.4

From: Chuanhua Han <chuanhua.han@nxp.com>
Subject: [PATCH] spi: spi-mem: Adjust op len based on message/transfer size limitations
Date: Fri, 21 Sep 2018 15:06:28 +0800
Message-ID: <20180921070628.35153-3-chuanhua.han@nxp.com>
References: <20180921070628.35153-1-chuanhua.han@nxp.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        eha@deif.com, boris.brezillon@bootlin.com,
        Chuanhua Han <chuanhua.han@nxp.com>, stable@vger.kernel.org
To: broonie@kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180921070628.35153-1-chuanhua.han@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

We need that to adjust the len of the 2nd transfer (called data in
spi-mem) if it's too long to fit in a SPI message or SPI transfer.

Fixes: c36ff266dc82 ("spi: Extend the core to ease integration of SPI memory controllers")
Cc: <stable@vger.kernel.org>
Signed-off-by: Chuanhua Han <chuanhua.han@nxp.com>
Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-mem.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 990770dfa5cf..ec0c24e873cd 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -328,10 +328,25 @@ EXPORT_SYMBOL_GPL(spi_mem_exec_op);
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
2.17.1

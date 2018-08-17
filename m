From: Chuanhua Han <chuanhua.han@nxp.com>
Subject: [PATCH] spi: fsl-espi: master->mem_ops is implemented in the controller
Date: Fri, 17 Aug 2018 18:07:05 +0800
Message-ID: <1534500425-9977-1-git-send-email-chuanhua.han@nxp.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        cheetah0585@163.com, Chuanhua Han <chuanhua.han@nxp.com>
To: broonie@kernel.org, boris.brezillon@bootlin.com
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The length of the transmitted data needs to be adjusted due to the maximum 
length limit for espi transmission messages

Signed-off-by: Chuanhua Han <chuanhua.han@nxp.com>
---
 drivers/spi/spi-fsl-espi.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 1d332e2..4724127 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -22,6 +22,7 @@
 #include <linux/spi/spi.h>
 #include <linux/pm_runtime.h>
 #include <sysdev/fsl_soc.h>
+#include <linux/spi/spi-mem.h>
 
 /* eSPI Controller registers */
 #define ESPI_SPMODE	0x00	/* eSPI mode register */
@@ -659,6 +660,29 @@ static void fsl_espi_init_regs(struct device *dev, bool initial)
 	fsl_espi_write_reg(espi, ESPI_SPMODE, SPMODE_INIT_VAL | SPMODE_ENABLE);
 }
 
+static int fsl_espi_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
+{
+	if (!mem || !op)
+		return -EINVAL;
+	op->data.nbytes = min3((unsigned long)op->data.nbytes,
+			spi_max_transfer_size(mem->spi),
+			spi_max_message_size(mem->spi) -
+			sizeof(op->cmd.opcode) -
+			op->addr.nbytes -
+			op->dummy.nbytes);
+	return 0;
+}
+
+static int fsl_espi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
+{
+	return -ENOTSUPP;
+}
+
+static const struct spi_controller_mem_ops fsl_espi_mem_ops = {
+	.adjust_op_size = fsl_espi_adjust_op_size,
+	.exec_op = fsl_espi_exec_op,
+};
+
 static int fsl_espi_probe(struct device *dev, struct resource *mem,
 			  unsigned int irq, unsigned int num_cs)
 {
@@ -682,6 +706,7 @@ static int fsl_espi_probe(struct device *dev, struct resource *mem,
 	master->auto_runtime_pm = true;
 	master->max_message_size = fsl_espi_max_message_size;
 	master->num_chipselect = num_cs;
+	master->mem_ops = &fsl_espi_mem_ops;
 
 	espi = spi_master_get_devdata(master);
 	spin_lock_init(&espi->lock);
-- 
2.7.4

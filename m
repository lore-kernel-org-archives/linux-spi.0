From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: spi-mem: Adjust op len based on message/transfer size limitations" to the spi tree
Date: Mon, 10 Sep 2018 18:54:06 +0100 (BST)
Message-ID: <20180910175406.9142B11227B6@debutante.sirena.org.uk>
References: <1535618604-21706-1-git-send-email-chuanhua.han@nxp.com>
Cc: <stable@vger.kernel.org>, Mark Brown <broonie@kernel.org>,
        broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, boris.brezillon@bootlin.com,
        stable@vger.kernel.org, linux-spi@vger.kernel.org
To: Chuanhua Han <chuanhua.han@nxp.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1535618604-21706-1-git-send-email-chuanhua.han@nxp.com>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: spi-mem: Adjust op len based on message/transfer size limitations

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From e757996cafbeb6b71234a17130674bcd8f44c59e Mon Sep 17 00:00:00 2001
From: Chuanhua Han <chuanhua.han@nxp.com>
Date: Thu, 30 Aug 2018 16:43:24 +0800
Subject: [PATCH] spi: spi-mem: Adjust op len based on message/transfer size
 limitations

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
index e43842c7a31a..eb72dba71d83 100644
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
2.19.0.rc1

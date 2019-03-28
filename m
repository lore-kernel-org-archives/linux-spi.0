From: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Subject: [LINUX PATCH 2/3] spi: spi-mem: call spi_mem_default_supports_op() first
Date: Thu, 28 Mar 2019 16:46:24 +0530
Message-ID: <1553771784-3364-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <vigneshr@ti.com>, <linux-spi@vger.kernel.org>,
        <dwmw2@infradead.org>, <marek.vasut@gmail.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <michal.simek@xilinx.com>, <nagasuresh12@gmail.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
To: <broonie@kernel.org>, <bbrezillon@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Call spi_mem_default_supports_op() first, before calling controller
specific ctlr->supports_op().
With this, controller drivers can drop checking the buswidths again.

Suggested-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
---
Details can be found at https://lkml.org/lkml/2019/3/1/183
---
 drivers/spi/spi-mem.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 5217a56..56aa158 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -189,11 +189,14 @@ static bool spi_mem_internal_supports_op(struct spi_mem *mem,
 					 const struct spi_mem_op *op)
 {
 	struct spi_controller *ctlr = mem->spi->controller;
+	bool ret;
+
+	ret = spi_mem_default_supports_op(mem, op);
 
 	if (ctlr->mem_ops && ctlr->mem_ops->supports_op)
-		return ctlr->mem_ops->supports_op(mem, op);
+		ret =  ctlr->mem_ops->supports_op(mem, op);
 
-	return spi_mem_default_supports_op(mem, op);
+	return ret;
 }
 
 /**
-- 
2.7.4

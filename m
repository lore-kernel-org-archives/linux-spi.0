From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: spi-mem: Compute length only when needed" to the spi tree
Date: Fri, 28 Feb 2020 18:25:24 +0000
Message-ID: <applied-20200228160735.1565047-1-tudor.ambarus@microchip.com>
References: <20200228160735.1565047-1-tudor.ambarus@microchip.com>
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Tudor.Ambarus-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org
To: Tudor Ambarus <tudor.ambarus-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200228160735.1565047-1-tudor.ambarus-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: spi-mem: Compute length only when needed

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

>From c0e035ac56680e74b27fc218c07e70f4b9b8b7a5 Mon Sep 17 00:00:00 2001
From: Tudor Ambarus <tudor.ambarus-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Date: Fri, 28 Feb 2020 16:07:44 +0000
Subject: [PATCH] spi: spi-mem: Compute length only when needed

When adjust_op_size is defined, len is never used. Move the len
computation where it's actually used.

Signed-off-by: Tudor Ambarus <tudor.ambarus-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Link: https://lore.kernel.org/r/20200228160735.1565047-1-tudor.ambarus-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-mem.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 3c46747bacb1..adaa0c49f966 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -418,12 +418,13 @@ int spi_mem_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
 	struct spi_controller *ctlr = mem->spi->controller;
 	size_t len;
 
-	len = sizeof(op->cmd.opcode) + op->addr.nbytes + op->dummy.nbytes;
-
 	if (ctlr->mem_ops && ctlr->mem_ops->adjust_op_size)
 		return ctlr->mem_ops->adjust_op_size(mem, op);
 
 	if (!ctlr->mem_ops || !ctlr->mem_ops->exec_op) {
+		len = sizeof(op->cmd.opcode) + op->addr.nbytes +
+		      op->dummy.nbytes;
+
 		if (len > spi_max_transfer_size(mem->spi))
 			return -EINVAL;
 
-- 
2.20.1

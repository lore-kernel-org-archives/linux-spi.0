From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: spi-mem: Fix build error without CONFIG_SPI_MEM" to the spi tree
Date: Wed, 10 Apr 2019 13:26:59 +0100 (BST)
Message-ID: <20190410122659.3635D1128ED2@debutante.sirena.org.uk>
References: <20190408143949.10688-1-yuehaibing@huawei.com>
Cc: broonie@kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        naga.sureshkumar.relli@xilinx.com
To: YueHaibing <yuehaibing@huawei.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190408143949.10688-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: spi-mem: Fix build error without CONFIG_SPI_MEM

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

>From 0e530e4eba5e9003af83c6afda833c64c7fcae08 Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Mon, 8 Apr 2019 22:39:49 +0800
Subject: [PATCH] spi: spi-mem: Fix build error without CONFIG_SPI_MEM

When building with CONFIG_SPI_MEM is not set
gc warns this:

drivers/spi/spi-zynq-qspi.o: In function `zynq_qspi_supports_op':
spi-zynq-qspi.c:(.text+0x1da): undefined reference to `spi_mem_default_supports_op'

Fixes: 67dca5e580f1 ("spi: spi-mem: Add support for Zynq QSPI controller")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/linux/spi/spi-mem.h | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index c845cd6e22ba..1941b845aa15 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -295,6 +295,10 @@ int spi_controller_dma_map_mem_op_data(struct spi_controller *ctlr,
 void spi_controller_dma_unmap_mem_op_data(struct spi_controller *ctlr,
 					  const struct spi_mem_op *op,
 					  struct sg_table *sg);
+
+bool spi_mem_default_supports_op(struct spi_mem *mem,
+				 const struct spi_mem_op *op);
+
 #else
 static inline int
 spi_controller_dma_map_mem_op_data(struct spi_controller *ctlr,
@@ -310,6 +314,13 @@ spi_controller_dma_unmap_mem_op_data(struct spi_controller *ctlr,
 				     struct sg_table *sg)
 {
 }
+
+bool spi_mem_default_supports_op(struct spi_mem *mem,
+				 const struct spi_mem_op *op)
+{
+	return false;
+}
+
 #endif /* CONFIG_SPI_MEM */
 
 int spi_mem_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op);
@@ -341,9 +352,6 @@ int spi_mem_driver_register_with_owner(struct spi_mem_driver *drv,
 
 void spi_mem_driver_unregister(struct spi_mem_driver *drv);
 
-bool spi_mem_default_supports_op(struct spi_mem *mem,
-				 const struct spi_mem_op *op);
-
 #define spi_mem_driver_register(__drv)                                  \
 	spi_mem_driver_register_with_owner(__drv, THIS_MODULE)
 
-- 
2.20.1

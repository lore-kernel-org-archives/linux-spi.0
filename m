From: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Subject: [LINUX PATCH v3] spi: spi-mem: Fix build error without CONFIG_SPI_MEM
Date: Wed, 10 Apr 2019 17:27:09 +0530
Message-ID: <1554897429-5959-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <michal.simek@xilinx.com>, <nagasuresh12@gmail.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
To: <yuehaibing@huawei.com>, <vigneshr@ti.com>, <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

When building with CONFIG_SPI_MEM is not set
gc warns this:

drivers/spi/spi-zynq-qspi.o: In function `zynq_qspi_supports_op':
spi-zynq-qspi.c:(.text+0x1da): undefined reference to `spi_mem_default_supports_op'

Fixes: 67dca5e580f1 ("spi: spi-mem: Add support for Zynq QSPI controller")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
---
Changes in v3
 - Updated the Author name
 - Removed extra line between Fixes and rest of the tags
Changes in v2
 - Added static inline to the function spi_mem_default_supports_op();
---
 include/linux/spi/spi-mem.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index eb71e9d..bf399f2 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -295,6 +295,8 @@ int spi_controller_dma_map_mem_op_data(struct spi_controller *ctlr,
 void spi_controller_dma_unmap_mem_op_data(struct spi_controller *ctlr,
 					  const struct spi_mem_op *op,
 					  struct sg_table *sg);
+bool spi_mem_default_supports_op(struct spi_mem *mem,
+				 const struct spi_mem_op *op);
 #else
 static inline int
 spi_controller_dma_map_mem_op_data(struct spi_controller *ctlr,
@@ -310,6 +312,9 @@ spi_controller_dma_unmap_mem_op_data(struct spi_controller *ctlr,
 				     struct sg_table *sg)
 {
 }
+
+static inline bool spi_mem_default_supports_op(struct spi_mem *mem,
+				 const struct spi_mem_op *op);
 #endif /* CONFIG_SPI_MEM */
 
 int spi_mem_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op);
@@ -336,9 +341,6 @@ int spi_mem_driver_register_with_owner(struct spi_mem_driver *drv,
 
 void spi_mem_driver_unregister(struct spi_mem_driver *drv);
 
-bool spi_mem_default_supports_op(struct spi_mem *mem,
-				 const struct spi_mem_op *op);
-
 #define spi_mem_driver_register(__drv)                                  \
 	spi_mem_driver_register_with_owner(__drv, THIS_MODULE)
 
-- 
2.7.4

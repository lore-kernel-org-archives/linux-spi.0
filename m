From: Yue Haibing <yuehaibing@huawei.com>
Subject: [PATCH] spi: spi-mem: Make spi_mem_default_supports_op() static inline
Date: Wed, 10 Apr 2019 21:18:28 +0800
Message-ID: <20190410131828.35316-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <vigneshr@ti.com>, YueHaibing <yuehaibing@huawei.com>
To: <broonie@kernel.org>, <naga.sureshkumar.relli@xilinx.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

Stub helper spi_mem_default_supports_op() should
be set to static inline

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 include/linux/spi/spi-mem.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index 1941b84..af9ff2f 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -315,6 +315,7 @@ spi_controller_dma_unmap_mem_op_data(struct spi_controller *ctlr,
 {
 }
 
+static inline
 bool spi_mem_default_supports_op(struct spi_mem *mem,
 				 const struct spi_mem_op *op)
 {
-- 
2.7.4

From: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Subject: [LINUX PATCH v2 2/3] spi: spi-mem: export spi_mem_default_supports_op()
Date: Mon, 1 Apr 2019 13:29:00 +0530
Message-ID: <1554105540-19704-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
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

Export spi_mem_default_supports_op(), so that controller drivers
can use this.
spi-mem driver already exports this using EXPORT_SYMBOL,
but not declared it in spi-mem.h.
This patch declares spi_mem_default_supports_op() in spi-mem.h and
also removes the static from the function prototype.

Signed-off-by: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
---
Changes in v2
 - Export spi_mem_default_supports_op(), so that controller drivers
   can use it
 - Removed the code, which modifies calling spi_mem_default_supports_op()
   before calling ctrl->supports_op()
Changes in v1
 - None
---
 drivers/spi/spi-mem.c       | 4 ++--
 include/linux/spi/spi-mem.h | 3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 5217a56..10ebf20 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -135,8 +135,8 @@ static int spi_check_buswidth_req(struct spi_mem *mem, u8 buswidth, bool tx)
 	return -ENOTSUPP;
 }
 
-static bool spi_mem_default_supports_op(struct spi_mem *mem,
-					const struct spi_mem_op *op)
+bool spi_mem_default_supports_op(struct spi_mem *mem,
+				 const struct spi_mem_op *op)
 {
 	if (spi_check_buswidth_req(mem, op->cmd.buswidth, true))
 		return false;
diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index 3fe2450..eb71e9d 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -336,6 +336,9 @@ int spi_mem_driver_register_with_owner(struct spi_mem_driver *drv,
 
 void spi_mem_driver_unregister(struct spi_mem_driver *drv);
 
+bool spi_mem_default_supports_op(struct spi_mem *mem,
+				 const struct spi_mem_op *op);
+
 #define spi_mem_driver_register(__drv)                                  \
 	spi_mem_driver_register_with_owner(__drv, THIS_MODULE)
 
-- 
2.7.4

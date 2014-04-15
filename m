From: Harini Katakam <harinik@xilinx.com>
Subject: [PATCH v2] spi: cadence: Add dependency on ARCH_ARM
Date: Tue, 15 Apr 2014 15:42:15 +0530
Message-ID: <1397556735-2536-1-git-send-email-harinik@xilinx.com>
Cc: michals@xilinx.com, Harini Katakam <harinik@xilinx.com>
To: broonie@kernel.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Add dependency on ARCH_ARM in Kconfig.
This is to fix the build error related to _relaxed IO.

Signed-off-by: Harini Katakam <harinik@xilinx.com>
---

v2 changes:
Dependency on ARCH_ARM instead of restricting to ARCH_ZYNQ.

---
 drivers/spi/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index b0f091b..32c27dd 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -150,6 +150,7 @@ config SPI_BUTTERFLY
 
 config SPI_CADENCE
 	tristate "Cadence SPI controller"
+	depends on ARCH_ARM
 	depends on SPI_MASTER
 	help
 	  This selects the Cadence SPI controller master driver
-- 
1.7.9.5

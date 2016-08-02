From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0918/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 19:57:54 +0800
Message-ID: <20160802115754.11187-1-baolex.ni@intel.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	chuansheng.liu@intel.com, baolex.ni@intel.com
To: broonie@kernel.org, jejb@linux.vnet.ibm.com,
	martin.petersen@oracle.com, m.chehab@samsung.com, pawel@osciak.com,
	m.szyprowski@samsung.com, kyungmin.park@samsung.com,
	k.kozlowski@samsung.com
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/spi/spi-au1550.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-au1550.c b/drivers/spi/spi-au1550.c
index afd239d..6236cda 100644
--- a/drivers/spi/spi-au1550.c
+++ b/drivers/spi/spi-au1550.c
@@ -36,7 +36,7 @@
 #include <asm/mach-au1x00/au1550_spi.h>
 
 static unsigned usedma = 1;
-module_param(usedma, uint, 0644);
+module_param(usedma, uint, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 
 /*
 #define AU1550_SPI_DEBUG_LOOPBACK
-- 
2.9.2

From: Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 8/9 v3] MIPS: BCM63XX: make board setup code register the spi platform device
Date: Tue, 31 Jan 2012 15:10:47 +0100
Message-ID: <1328019048-5892-9-git-send-email-florian@openwrt.org>
References: <1328019048-5892-1-git-send-email-florian@openwrt.org>
Cc: linux-mips@linux-mips.org, grant.likely@secretlab.ca,
        spi-devel-general@lists.sourceforge.net,
        Florian Fainelli <florian@openwrt.org>
To: ralf@linux-mips.org
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <1328019048-5892-1-git-send-email-florian@openwrt.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-Id: linux-spi.vger.kernel.org

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
No changes since v1 and v2

 arch/mips/bcm63xx/boards/board_bcm963xx.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/mips/bcm63xx/boards/board_bcm963xx.c b/arch/mips/bcm63xx/boards/board_bcm963xx.c
index 2f1773f..ea65c0f 100644
--- a/arch/mips/bcm63xx/boards/board_bcm963xx.c
+++ b/arch/mips/bcm63xx/boards/board_bcm963xx.c
@@ -25,6 +25,7 @@
 #include <bcm63xx_dev_enet.h>
 #include <bcm63xx_dev_dsp.h>
 #include <bcm63xx_dev_pcmcia.h>
+#include <bcm63xx_dev_spi.h>
 #include <board_bcm963xx.h>
 
 #define PFX	"board_bcm963xx: "
@@ -890,6 +891,8 @@ int __init board_register_devices(void)
 	}
 #endif
 
+	bcm63xx_spi_register();
+
 	/* read base address of boot chip select (0) */
 	val = bcm_mpi_readl(MPI_CSBASE_REG(0));
 	val &= MPI_CSBASE_BASE_MASK;
-- 
1.7.5.4

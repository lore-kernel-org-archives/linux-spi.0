From: Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 2/9 v3] MIPS: BCM63XX: define BCM6358 SPI base address
Date: Tue, 31 Jan 2012 15:10:41 +0100
Message-ID: <1328019048-5892-3-git-send-email-florian@openwrt.org>
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
No changes in v1 and v2

 arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
index 9975727..016dc9e 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
@@ -289,7 +289,7 @@ enum bcm63xx_regs_set {
 #define BCM_6358_UART0_BASE		(0xfffe0100)
 #define BCM_6358_UART1_BASE		(0xfffe0120)
 #define BCM_6358_GPIO_BASE		(0xfffe0080)
-#define BCM_6358_SPI_BASE		(0xdeadbeef)
+#define BCM_6358_SPI_BASE		(0xfffe0800)
 #define BCM_6358_SPI2_BASE		(0xfffe0800)
 #define BCM_6358_UDC0_BASE		(0xfffe0800)
 #define BCM_6358_OHCI0_BASE		(0xfffe1400)
-- 
1.7.5.4

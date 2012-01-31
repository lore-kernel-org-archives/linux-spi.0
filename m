From: Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 3/9 v3] MIPS: BCM63XX: add BCM6368 SPI clock mask
Date: Tue, 31 Jan 2012 15:10:42 +0100
Message-ID: <1328019048-5892-4-git-send-email-florian@openwrt.org>
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

 arch/mips/bcm63xx/clk.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/mips/bcm63xx/clk.c b/arch/mips/bcm63xx/clk.c
index 8d2ea22..be49b9a 100644
--- a/arch/mips/bcm63xx/clk.c
+++ b/arch/mips/bcm63xx/clk.c
@@ -181,9 +181,11 @@ static void spi_set(struct clk *clk, int enable)
 		mask = CKCTL_6338_SPI_EN;
 	else if (BCMCPU_IS_6348())
 		mask = CKCTL_6348_SPI_EN;
-	else
-		/* BCMCPU_IS_6358 */
+	else if (BCMCPU_IS_6358())
 		mask = CKCTL_6358_SPI_EN;
+	else
+		/* BCMCPU_IS_6368 */
+		mask = CKCTL_6368_SPI_EN;
 	bcm_hwclock_set(mask, enable);
 }
 
-- 
1.7.5.4

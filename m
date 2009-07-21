From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 1/4] OMAP: McSPI: enable wake-ups and smart-idle
Date: Tue, 21 Jul 2009 16:03:29 -0700
Message-ID: <1248217412-24078-2-git-send-email-khilman@deeprootsystems.com>
References: <1248217412-24078-1-git-send-email-khilman@deeprootsystems.com>
Cc: dbrownell@users.sourceforge.net, linux-omap@vger.kernel.org,
	Jouni Hogander <jouni.hogander@nokia.com>,
	Tony Lindgren <tony@atomide.com>
To: spi-devel-general@lists.sourceforge.net
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1248217412-24078-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Jouni Hogander <jouni.hogander@nokia.com>

By default, enable module wakeups and put module in smart-idle.

Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 drivers/spi/omap2_mcspi.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
index eee4b6e..2b64091 100644
--- a/drivers/spi/omap2_mcspi.c
+++ b/drivers/spi/omap2_mcspi.c
@@ -59,6 +59,8 @@
 
 /* per-register bitmasks: */
 
+#define OMAP2_MCSPI_SYSCONFIG_SMARTIDLE	(2 << 3)
+#define OMAP2_MCSPI_SYSCONFIG_ENAWAKEUP	(1 << 2)
 #define OMAP2_MCSPI_SYSCONFIG_AUTOIDLE	(1 << 0)
 #define OMAP2_MCSPI_SYSCONFIG_SOFTRESET	(1 << 1)
 
@@ -90,6 +92,7 @@
 
 #define OMAP2_MCSPI_CHCTRL_EN		(1 << 0)
 
+#define OMAP2_MCSPI_WAKEUPENABLE_WKEN	(1 << 0)
 
 /* We have 2 DMA channels per CS, one for RX and one for TX */
 struct omap2_mcspi_dma {
@@ -873,8 +876,12 @@ static int __init omap2_mcspi_reset(struct omap2_mcspi *mcspi)
 	} while (!(tmp & OMAP2_MCSPI_SYSSTATUS_RESETDONE));
 
 	mcspi_write_reg(master, OMAP2_MCSPI_SYSCONFIG,
-			/* (3 << 8) | (2 << 3) | */
-			OMAP2_MCSPI_SYSCONFIG_AUTOIDLE);
+			OMAP2_MCSPI_SYSCONFIG_AUTOIDLE |
+			OMAP2_MCSPI_SYSCONFIG_ENAWAKEUP |
+			OMAP2_MCSPI_SYSCONFIG_SMARTIDLE);
+
+	mcspi_write_reg(master, OMAP2_MCSPI_WAKEUPENABLE,
+			OMAP2_MCSPI_WAKEUPENABLE_WKEN);
 
 	omap2_mcspi_set_master_mode(master);
 
-- 
1.6.3.3


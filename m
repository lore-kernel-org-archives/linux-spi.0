From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch 2/2] spi: omap2_mcspi use BIT(n)
Date: Thu, 2 Jul 2009 16:30:23 -0700
Message-ID: <200907021630.23641.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Jouni Hogander <jouni.hogander-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Author: Jouni Hogander <jouni.hogander-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>

Convert bit shifted values into BIT format

Signed-off-by: Jouni Hogander <jouni.hogander-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
 drivers/spi/omap2_mcspi.c |   50 ++++++++++++++++++++++----------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

--- a/drivers/spi/omap2_mcspi.c
+++ b/drivers/spi/omap2_mcspi.c
@@ -59,40 +59,40 @@
 
 /* per-register bitmasks: */
 
-#define OMAP2_MCSPI_SYSCONFIG_SMARTIDLE	(2 << 3)
-#define OMAP2_MCSPI_SYSCONFIG_ENAWAKEUP	(1 << 2)
-#define OMAP2_MCSPI_SYSCONFIG_AUTOIDLE	(1 << 0)
-#define OMAP2_MCSPI_SYSCONFIG_SOFTRESET	(1 << 1)
+#define OMAP2_MCSPI_SYSCONFIG_SMARTIDLE	BIT(4)
+#define OMAP2_MCSPI_SYSCONFIG_ENAWAKEUP	BIT(2)
+#define OMAP2_MCSPI_SYSCONFIG_AUTOIDLE	BIT(0)
+#define OMAP2_MCSPI_SYSCONFIG_SOFTRESET	BIT(1)
 
-#define OMAP2_MCSPI_SYSSTATUS_RESETDONE	(1 << 0)
+#define OMAP2_MCSPI_SYSSTATUS_RESETDONE	BIT(0)
 
-#define OMAP2_MCSPI_MODULCTRL_SINGLE	(1 << 0)
-#define OMAP2_MCSPI_MODULCTRL_MS	(1 << 2)
-#define OMAP2_MCSPI_MODULCTRL_STEST	(1 << 3)
+#define OMAP2_MCSPI_MODULCTRL_SINGLE	BIT(0)
+#define OMAP2_MCSPI_MODULCTRL_MS	BIT(2)
+#define OMAP2_MCSPI_MODULCTRL_STEST	BIT(3)
 
-#define OMAP2_MCSPI_CHCONF_PHA		(1 << 0)
-#define OMAP2_MCSPI_CHCONF_POL		(1 << 1)
+#define OMAP2_MCSPI_CHCONF_PHA		BIT(0)
+#define OMAP2_MCSPI_CHCONF_POL		BIT(1)
 #define OMAP2_MCSPI_CHCONF_CLKD_MASK	(0x0f << 2)
-#define OMAP2_MCSPI_CHCONF_EPOL		(1 << 6)
+#define OMAP2_MCSPI_CHCONF_EPOL		BIT(6)
 #define OMAP2_MCSPI_CHCONF_WL_MASK	(0x1f << 7)
-#define OMAP2_MCSPI_CHCONF_TRM_RX_ONLY	(0x01 << 12)
-#define OMAP2_MCSPI_CHCONF_TRM_TX_ONLY	(0x02 << 12)
+#define OMAP2_MCSPI_CHCONF_TRM_RX_ONLY	BIT(12)
+#define OMAP2_MCSPI_CHCONF_TRM_TX_ONLY	BIT(13)
 #define OMAP2_MCSPI_CHCONF_TRM_MASK	(0x03 << 12)
-#define OMAP2_MCSPI_CHCONF_DMAW		(1 << 14)
-#define OMAP2_MCSPI_CHCONF_DMAR		(1 << 15)
-#define OMAP2_MCSPI_CHCONF_DPE0		(1 << 16)
-#define OMAP2_MCSPI_CHCONF_DPE1		(1 << 17)
-#define OMAP2_MCSPI_CHCONF_IS		(1 << 18)
-#define OMAP2_MCSPI_CHCONF_TURBO	(1 << 19)
-#define OMAP2_MCSPI_CHCONF_FORCE	(1 << 20)
+#define OMAP2_MCSPI_CHCONF_DMAW		BIT(14)
+#define OMAP2_MCSPI_CHCONF_DMAR		BIT(15)
+#define OMAP2_MCSPI_CHCONF_DPE0		BIT(16)
+#define OMAP2_MCSPI_CHCONF_DPE1		BIT(17)
+#define OMAP2_MCSPI_CHCONF_IS		BIT(18)
+#define OMAP2_MCSPI_CHCONF_TURBO	BIT(19)
+#define OMAP2_MCSPI_CHCONF_FORCE	BIT(20)
 
-#define OMAP2_MCSPI_CHSTAT_RXS		(1 << 0)
-#define OMAP2_MCSPI_CHSTAT_TXS		(1 << 1)
-#define OMAP2_MCSPI_CHSTAT_EOT		(1 << 2)
+#define OMAP2_MCSPI_CHSTAT_RXS		BIT(0)
+#define OMAP2_MCSPI_CHSTAT_TXS		BIT(1)
+#define OMAP2_MCSPI_CHSTAT_EOT		BIT(2)
 
-#define OMAP2_MCSPI_CHCTRL_EN		(1 << 0)
+#define OMAP2_MCSPI_CHCTRL_EN		BIT(0)
 
-#define OMAP2_MCSPI_WAKEUPENABLE_WKEN	(1 << 0)
+#define OMAP2_MCSPI_WAKEUPENABLE_WKEN	BIT(0)
 
 /* We have 2 DMA channels per CS, one for RX and one for TX */
 struct omap2_mcspi_dma {


------------------------------------------------------------------------------

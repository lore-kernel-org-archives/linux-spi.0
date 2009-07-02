From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch 1/2] spi: omap2_mcspi supports wake
	events
Date: Thu, 2 Jul 2009 16:29:33 -0700
Message-ID: <200907021629.33372.david-b@pacbell.net>
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

Currently mcspi wake-ups are not enabled. This might cause case where
OMAP is not waking up on mcspi events.

Signed-off-by: Jouni Hogander <jouni.hogander-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
 drivers/spi/omap2_mcspi.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

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
@@ -873,8 +876,12 @@ static int __init omap2_mcspi_reset(stru
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
 


------------------------------------------------------------------------------

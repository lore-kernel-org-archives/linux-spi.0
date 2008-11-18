From: Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 01/16] Blackfin SPI Driver: ensure cache
	coherency before doing DMA
Date: Tue, 18 Nov 2008 15:52:25 +0800
Message-ID: <1226994760-4301-2-git-send-email-cooloney@kernel.org>
References: <1226994760-4301-1-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Vitja Makarov <vitja.makarov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1226994760-4301-1-git-send-email-cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Vitja Makarov <vitja.makarov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

flush or invalidate caches before doing DMA transfer, if needed.

Signed-off-by: Vitja Makarov <vitja.makarov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi_bfin5xx.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/drivers/spi/spi_bfin5xx.c b/drivers/spi/spi_bfin5xx.c
index 7fea3cf..e9b7366 100644
--- a/drivers/spi/spi_bfin5xx.c
+++ b/drivers/spi/spi_bfin5xx.c
@@ -26,6 +26,10 @@
 #include <asm/portmux.h>
 #include <asm/bfin5xx_spi.h>
 
+/* reserved_mem_dcache_on and cache friends */
+#include <asm/cplbinit.h>
+#include <asm/cacheflush.h>
+
 #define DRV_NAME	"bfin-spi"
 #define DRV_AUTHOR	"Bryan Wu, Luke Yang"
 #define DRV_DESC	"Blackfin BF5xx on-chip SPI Controller Driver"
@@ -795,6 +799,12 @@ static void pump_transfers(unsigned long data)
 			/* set transfer mode, and enable SPI */
 			dev_dbg(&drv_data->pdev->dev, "doing DMA in.\n");
 
+			/* invalidate caches, if needed */
+			if (bfin_addr_dcachable((unsigned long) drv_data->rx))
+				invalidate_dcache_range((unsigned long) drv_data->rx,
+							(unsigned long) (drv_data->rx +
+							drv_data->len));
+
 			/* clear tx reg soformer data is not shifted out */
 			write_TDBR(drv_data, 0xFFFF);
 
@@ -815,6 +825,12 @@ static void pump_transfers(unsigned long data)
 		} else if (drv_data->tx != NULL) {
 			dev_dbg(&drv_data->pdev->dev, "doing DMA out.\n");
 
+			/* flush caches, if needed */
+			if (bfin_addr_dcachable((unsigned long) drv_data->tx))
+				flush_dcache_range((unsigned long) drv_data->tx,
+						(unsigned long) (drv_data->tx +
+						drv_data->len));
+
 			/* start dma */
 			dma_enable_irq(drv_data->dma_channel);
 			dma_config = (RESTART | dma_width | DI_EN);
-- 
1.5.6.3

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/

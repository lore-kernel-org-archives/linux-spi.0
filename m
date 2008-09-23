From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch 2.6.27-rc7] pxa2xx_spi buildfix
Date: Tue, 23 Sep 2008 00:56:24 -0700
Message-ID: <200809230056.25075.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mike Rapoport <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
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

From: Mike Rapoport <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>

This patch fixes a build error in the pxa2xx-spi driver,
introduced by commit 7e96445533ac3f4f7964646a202ff3620602fab4

[dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org: fix sparse warning too ]

Signed-off-by: Mike Rapoport <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Acked-by: Eric Miao <eric.miao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
for 2.6.27-final, please ...

 drivers/spi/pxa2xx_spi.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/spi/pxa2xx_spi.c
+++ b/drivers/spi/pxa2xx_spi.c
@@ -49,7 +49,7 @@ MODULE_ALIAS("platform:pxa2xx-spi");
 
 #define DMA_INT_MASK		(DCSR_ENDINTR | DCSR_STARTINTR | DCSR_BUSERR)
 #define RESET_DMA_CHANNEL	(DCSR_NODESC | DMA_INT_MASK)
-#define IS_DMA_ALIGNED(x)	(((x) & 0x07) == 0)
+#define IS_DMA_ALIGNED(x)	((((u32)(x)) & 0x07) == 0)
 #define MAX_DMA_LEN		8191
 
 /*
@@ -896,7 +896,7 @@ static void pump_transfers(unsigned long
 				|| transfer->rx_dma || transfer->tx_dma) {
 			dev_err(&drv_data->pdev->dev,
 				"pump_transfers: mapped transfer length "
-				"of %lu is greater than %d\n",
+				"of %u is greater than %d\n",
 				transfer->len, MAX_DMA_LEN);
 			message->status = -EINVAL;
 			giveback(drv_data);

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/

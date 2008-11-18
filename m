From: Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 10/16] Blackfin SPI Driver: use the
	properl BIT_CTL_xxx defines
Date: Tue, 18 Nov 2008 15:52:34 +0800
Message-ID: <1226994760-4301-11-git-send-email-cooloney@kernel.org>
References: <1226994760-4301-1-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mike Frysinger <vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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

From: Mike Frysinger <vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

use the properl BIT_CTL_... defines rather than the internal driv
er CFG_SPI_... defines

Signed-off-by: Mike Frysinger <vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi_bfin5xx.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi_bfin5xx.c b/drivers/spi/spi_bfin5xx.c
index 3f4a603..4343a92 100644
--- a/drivers/spi/spi_bfin5xx.c
+++ b/drivers/spi/spi_bfin5xx.c
@@ -798,7 +798,7 @@ static void pump_transfers(unsigned long data)
 
 			/* start SPI transfer */
 			write_CTRL(drv_data,
-				(cr | CFG_SPI_DMAWRITE | BIT_CTL_ENABLE));
+				(cr | BIT_CTL_TIMOD_DMA_TX | BIT_CTL_ENABLE));
 
 			/* just return here, there can only be one transfer
 			 * in this mode
@@ -821,12 +821,9 @@ static void pump_transfers(unsigned long data)
 							(unsigned long) (drv_data->rx +
 							drv_data->len_in_bytes));
 
-			/* clear tx reg soformer data is not shifted out */
-			write_TDBR(drv_data, 0xFFFF);
-
 			dma_config |= WNR;
 			dma_start_addr = (unsigned long)drv_data->rx;
-			cr |= CFG_SPI_DMAREAD;
+			cr |= BIT_CTL_TIMOD_DMA_RX | BIT_CTL_SENDOPT;
 
 		} else if (drv_data->tx != NULL) {
 			dev_dbg(&drv_data->pdev->dev, "doing DMA out.\n");
@@ -838,7 +835,7 @@ static void pump_transfers(unsigned long data)
 						drv_data->len_in_bytes));
 
 			dma_start_addr = (unsigned long)drv_data->tx;
-			cr |= CFG_SPI_DMAWRITE;
+			cr |= BIT_CTL_TIMOD_DMA_TX;
 
 		} else
 			BUG();
-- 
1.5.6.3

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/

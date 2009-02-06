From: Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 10/20] Blackfin SPI Driver: use the
	properl BIT_CTL_xxx defines
Date: Fri,  6 Feb 2009 15:12:58 +0800
Message-ID: <1233904388-5765-11-git-send-email-cooloney@kernel.org>
References: <1233904388-5765-1-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Mike Frysinger <vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1233904388-5765-1-git-send-email-cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
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
 drivers/spi/spi_bfin5xx.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi_bfin5xx.c b/drivers/spi/spi_bfin5xx.c
index f7a4b5b..54d8948 100644
--- a/drivers/spi/spi_bfin5xx.c
+++ b/drivers/spi/spi_bfin5xx.c
@@ -799,7 +799,7 @@ static void pump_transfers(unsigned long data)
 
 			/* start SPI transfer */
 			write_CTRL(drv_data,
-				(cr | CFG_SPI_DMAWRITE | BIT_CTL_ENABLE));
+				(cr | BIT_CTL_TIMOD_DMA_TX | BIT_CTL_ENABLE));
 
 			/* just return here, there can only be one transfer
 			 * in this mode
@@ -827,7 +827,7 @@ static void pump_transfers(unsigned long data)
 
 			dma_config |= WNR;
 			dma_start_addr = (unsigned long)drv_data->rx;
-			cr |= CFG_SPI_DMAREAD;
+			cr |= BIT_CTL_TIMOD_DMA_RX | BIT_CTL_SENDOPT;
 
 		} else if (drv_data->tx != NULL) {
 			dev_dbg(&drv_data->pdev->dev, "doing DMA out.\n");
@@ -839,7 +839,7 @@ static void pump_transfers(unsigned long data)
 						drv_data->len_in_bytes));
 
 			dma_start_addr = (unsigned long)drv_data->tx;
-			cr |= CFG_SPI_DMAWRITE;
+			cr |= BIT_CTL_TIMOD_DMA_TX;
 
 		} else
 			BUG();
-- 
1.5.6.3

------------------------------------------------------------------------------
Create and Deploy Rich Internet Apps outside the browser with Adobe(R)AIR(TM)
software. With Adobe AIR, Ajax developers can use existing skills and code to
build responsive, highly engaging applications that combine the power of local
resources and data with the reach of the web. Download the Adobe AIR SDK and
Ajax docs to start building applications today-http://p.sf.net/sfu/adobe-com

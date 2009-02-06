From: Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 06/20] Blackfin SPI Driver: unify
	duplicated code in dma read/write paths
Date: Fri,  6 Feb 2009 15:12:54 +0800
Message-ID: <1233904388-5765-7-git-send-email-cooloney@kernel.org>
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

For DMA TX/RX operation in pump_transfers, DMA contriguration code
in TX and RX paths are almost the same. This patch unify the duplicated
DMA code to make it more readable.

Signed-off-by: Mike Frysinger <vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Acked-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
 drivers/spi/spi_bfin5xx.c |   47 ++++++++++++++++++++------------------------
 1 files changed, 21 insertions(+), 26 deletions(-)

diff --git a/drivers/spi/spi_bfin5xx.c b/drivers/spi/spi_bfin5xx.c
index 3945b59..acb9739 100644
--- a/drivers/spi/spi_bfin5xx.c
+++ b/drivers/spi/spi_bfin5xx.c
@@ -756,18 +756,19 @@ static void pump_transfers(unsigned long data)
 	if (!full_duplex && drv_data->cur_chip->enable_dma
 				&& drv_data->len > 6) {
 
+		unsigned long dma_start_addr;
+
 		disable_dma(drv_data->dma_channel);
 		clear_dma_irqstat(drv_data->dma_channel);
 		bfin_spi_disable(drv_data);
 
 		/* config dma channel */
 		dev_dbg(&drv_data->pdev->dev, "doing dma transfer\n");
+		set_dma_x_count(drv_data->dma_channel, drv_data->len);
 		if (width == CFG_SPI_WORDSIZE16) {
-			set_dma_x_count(drv_data->dma_channel, drv_data->len);
 			set_dma_x_modify(drv_data->dma_channel, 2);
 			dma_width = WDSIZE_16;
 		} else {
-			set_dma_x_count(drv_data->dma_channel, drv_data->len);
 			set_dma_x_modify(drv_data->dma_channel, 1);
 			dma_width = WDSIZE_8;
 		}
@@ -802,6 +803,7 @@ static void pump_transfers(unsigned long data)
 		}
 
 		/* In dma mode, rx or tx must be NULL in one transfer */
+		dma_config = (RESTART | dma_width | DI_EN);
 		if (drv_data->rx != NULL) {
 			/* set transfer mode, and enable SPI */
 			dev_dbg(&drv_data->pdev->dev, "doing DMA in.\n");
@@ -815,19 +817,9 @@ static void pump_transfers(unsigned long data)
 			/* clear tx reg soformer data is not shifted out */
 			write_TDBR(drv_data, 0xFFFF);
 
-			set_dma_x_count(drv_data->dma_channel, drv_data->len);
-
-			/* start dma */
-			dma_enable_irq(drv_data->dma_channel);
-			dma_config = (WNR | RESTART | dma_width | DI_EN);
-			set_dma_config(drv_data->dma_channel, dma_config);
-			set_dma_start_addr(drv_data->dma_channel,
-					(unsigned long)drv_data->rx);
-			enable_dma(drv_data->dma_channel);
-
-			/* start SPI transfer */
-			write_CTRL(drv_data,
-				(cr | CFG_SPI_DMAREAD | BIT_CTL_ENABLE));
+			dma_config |= WNR;
+			dma_start_addr = (unsigned long)drv_data->rx;
+			cr |= CFG_SPI_DMAREAD;
 
 		} else if (drv_data->tx != NULL) {
 			dev_dbg(&drv_data->pdev->dev, "doing DMA out.\n");
@@ -838,18 +830,21 @@ static void pump_transfers(unsigned long data)
 						(unsigned long) (drv_data->tx +
 						drv_data->len_in_bytes));
 
-			/* start dma */
-			dma_enable_irq(drv_data->dma_channel);
-			dma_config = (RESTART | dma_width | DI_EN);
-			set_dma_config(drv_data->dma_channel, dma_config);
-			set_dma_start_addr(drv_data->dma_channel,
-					(unsigned long)drv_data->tx);
-			enable_dma(drv_data->dma_channel);
+			dma_start_addr = (unsigned long)drv_data->tx;
+			cr |= CFG_SPI_DMAWRITE;
+
+		} else
+			BUG();
+
+		/* start dma */
+		dma_enable_irq(drv_data->dma_channel);
+		set_dma_config(drv_data->dma_channel, dma_config);
+		set_dma_start_addr(drv_data->dma_channel, dma_start_addr);
+		enable_dma(drv_data->dma_channel);
+
+		/* start SPI transfer */
+		write_CTRL(drv_data, (cr | BIT_CTL_ENABLE));
 
-			/* start SPI transfer */
-			write_CTRL(drv_data,
-				(cr | CFG_SPI_DMAWRITE | BIT_CTL_ENABLE));
-		}
 	} else {
 		/* IO mode write then read */
 		dev_dbg(&drv_data->pdev->dev, "doing IO transfer\n");
-- 
1.5.6.3

------------------------------------------------------------------------------
Create and Deploy Rich Internet Apps outside the browser with Adobe(R)AIR(TM)
software. With Adobe AIR, Ajax developers can use existing skills and code to
build responsive, highly engaging applications that combine the power of local
resources and data with the reach of the web. Download the Adobe AIR SDK and
Ajax docs to start building applications today-http://p.sf.net/sfu/adobe-com

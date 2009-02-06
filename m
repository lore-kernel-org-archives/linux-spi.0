From: Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 12/20] Blackfin SPI Driver: get dma
	working for SPI flashes
Date: Fri,  6 Feb 2009 15:13:00 +0800
Message-ID: <1233904388-5765-13-git-send-email-cooloney@kernel.org>
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

When using a BF533-STAMP here with a W25X10 SPI flash. It works fine when
enable_dma is disabled, but doesn't work at all when turning DMA on.
We get just 0xff bytes back when trying to read the device.

If change the code around so that it programs the SPI first and then
enables DMA, it seems to work a lot better ...

Signed-off-by: Mike Frysinger <vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Acked-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
 drivers/spi/spi_bfin5xx.c |   26 ++++++++++++++++----------
 1 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi_bfin5xx.c b/drivers/spi/spi_bfin5xx.c
index bfb587e..83398b3 100644
--- a/drivers/spi/spi_bfin5xx.c
+++ b/drivers/spi/spi_bfin5xx.c
@@ -761,11 +761,10 @@ static void pump_transfers(unsigned long data)
 	if (!full_duplex && drv_data->cur_chip->enable_dma
 				&& drv_data->len > 6) {
 
-		unsigned long dma_start_addr;
+		unsigned long dma_start_addr, flags;
 
 		disable_dma(drv_data->dma_channel);
 		clear_dma_irqstat(drv_data->dma_channel);
-		bfin_spi_disable(drv_data);
 
 		/* config dma channel */
 		dev_dbg(&drv_data->pdev->dev, "doing dma transfer\n");
@@ -796,8 +795,7 @@ static void pump_transfers(unsigned long data)
 			enable_dma(drv_data->dma_channel);
 
 			/* start SPI transfer */
-			write_CTRL(drv_data,
-				(cr | BIT_CTL_TIMOD_DMA_TX | BIT_CTL_ENABLE));
+			write_CTRL(drv_data, cr | BIT_CTL_TIMOD_DMA_TX);
 
 			/* just return here, there can only be one transfer
 			 * in this mode
@@ -842,14 +840,22 @@ static void pump_transfers(unsigned long data)
 		} else
 			BUG();
 
-		/* start dma */
-		dma_enable_irq(drv_data->dma_channel);
-		set_dma_config(drv_data->dma_channel, dma_config);
+		/* oh man, here there be monsters ... and i dont mean the
+		 * fluffy cute ones from pixar, i mean the kind that'll eat
+		 * your data, kick your dog, and love it all.  do *not* try
+		 * and change these lines unless you (1) heavily test DMA
+		 * with SPI flashes on a loaded system (e.g. ping floods),
+		 * (2) know just how broken the DMA engine interaction with
+		 * the SPI peripheral is, and (3) have someone else to blame
+		 * when you screw it all up anyways.
+		 */
 		set_dma_start_addr(drv_data->dma_channel, dma_start_addr);
+		set_dma_config(drv_data->dma_channel, dma_config);
+		local_irq_save(flags);
 		enable_dma(drv_data->dma_channel);
-
-		/* start SPI transfer */
-		write_CTRL(drv_data, (cr | BIT_CTL_ENABLE));
+		write_CTRL(drv_data, cr);
+		dma_enable_irq(drv_data->dma_channel);
+		local_irq_restore(flags);
 
 	} else {
 		/* IO mode write then read */
-- 
1.5.6.3

------------------------------------------------------------------------------
Create and Deploy Rich Internet Apps outside the browser with Adobe(R)AIR(TM)
software. With Adobe AIR, Ajax developers can use existing skills and code to
build responsive, highly engaging applications that combine the power of local
resources and data with the reach of the web. Download the Adobe AIR SDK and
Ajax docs to start building applications today-http://p.sf.net/sfu/adobe-com

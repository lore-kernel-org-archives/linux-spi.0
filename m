From: Bryan Wu <bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 14/14] Blackfin SPI driver: set correct
	baud for spi mmc and enable SPI after DMA.
Date: Tue, 30 Oct 2007 17:18:05 +0800
Message-ID: <1193735885-8202-15-git-send-email-bryan.wu@analog.com>
References: <1193735885-8202-1-git-send-email-bryan.wu@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Bryan Wu <bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>,
	Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1193735885-8202-1-git-send-email-bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>

SPI is enabled only after DMA is started.

Signed-off-by: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Bryan Wu <bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi_bfin5xx.c |   23 +++++++++++++----------
 1 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi_bfin5xx.c b/drivers/spi/spi_bfin5xx.c
index 0b22932..83c866d 100644
--- a/drivers/spi/spi_bfin5xx.c
+++ b/drivers/spi/spi_bfin5xx.c
@@ -231,13 +231,13 @@ static int restore_state(struct driver_data *drv_data)
 	dev_dbg(&drv_data->pdev->dev, "restoring spi ctl state\n");
 
 	/* Load the registers */
-	cs_deactive(drv_data, chip);
 	write_BAUD(drv_data, chip->baud);
 	chip->ctl_reg &= (~BIT_CTL_TIMOD);
 	chip->ctl_reg |= (chip->width << 8);
 	write_CTRL(drv_data, chip->ctl_reg);
 
 	bfin_spi_enable(drv_data);
+	cs_active(drv_data, chip);
 
 	if (ret)
 		dev_dbg(&drv_data->pdev->dev,
@@ -767,6 +767,7 @@ static void pump_transfers(unsigned long data)
 
 		disable_dma(drv_data->dma_channel);
 		clear_dma_irqstat(drv_data->dma_channel);
+		bfin_spi_disable(drv_data);
 
 		/* config dma channel */
 		dev_dbg(&drv_data->pdev->dev, "doing dma transfer\n");
@@ -789,9 +790,6 @@ static void pump_transfers(unsigned long data)
 			dev_dbg(&drv_data->pdev->dev,
 				"doing autobuffer DMA out.\n");
 
-			/* set SPI transfer mode */
-			write_CTRL(drv_data, (cr | CFG_SPI_DMAWRITE));
-
 			/* no irq in autobuffer mode */
 			dma_config =
 			    (DMAFLOW_AUTO | RESTART | dma_width | DI_EN);
@@ -800,6 +798,9 @@ static void pump_transfers(unsigned long data)
 					(unsigned long)drv_data->tx);
 			enable_dma(drv_data->dma_channel);
 
+			/* start SPI transfer */
+			write_CTRL(drv_data, (cr | CFG_SPI_DMAWRITE | BIT_CTL_ENABLE));
+
 			/* just return here, there can only be one transfer in this mode */
 			message->status = 0;
 			giveback(drv_data);
@@ -811,9 +812,6 @@ static void pump_transfers(unsigned long data)
 			/* set transfer mode, and enable SPI */
 			dev_dbg(&drv_data->pdev->dev, "doing DMA in.\n");
 
-			/* set SPI transfer mode */
-			write_CTRL(drv_data, (cr | CFG_SPI_DMAREAD));
-
 			/* clear tx reg soformer data is not shifted out */
 			write_TDBR(drv_data, 0xFFFF);
 
@@ -827,12 +825,12 @@ static void pump_transfers(unsigned long data)
 					(unsigned long)drv_data->rx);
 			enable_dma(drv_data->dma_channel);
 
+			/* start SPI transfer */
+			write_CTRL(drv_data, (cr | CFG_SPI_DMAREAD | BIT_CTL_ENABLE));
+
 		} else if (drv_data->tx != NULL) {
 			dev_dbg(&drv_data->pdev->dev, "doing DMA out.\n");
 
-			/* set SPI transfer mode */
-			write_CTRL(drv_data, (cr | CFG_SPI_DMAWRITE));
-
 			/* start dma */
 			dma_enable_irq(drv_data->dma_channel);
 			dma_config = (RESTART | dma_width | DI_EN);
@@ -840,6 +838,9 @@ static void pump_transfers(unsigned long data)
 			set_dma_start_addr(drv_data->dma_channel,
 					(unsigned long)drv_data->tx);
 			enable_dma(drv_data->dma_channel);
+
+			/* start SPI transfer */
+			write_CTRL(drv_data, (cr | CFG_SPI_DMAWRITE | BIT_CTL_ENABLE));
 		}
 	} else {
 		/* IO mode write then read */
@@ -1138,6 +1139,8 @@ static int setup(struct spi_device *spi)
 		peripheral_request(ssel[spi->master->bus_num]
 			[chip->chip_select_num-1], DRV_NAME);
 
+	cs_deactive(drv_data, chip);
+
 	return 0;
 }
 
-- 
1.5.3.4

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/

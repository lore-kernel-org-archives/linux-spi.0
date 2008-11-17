From: Andrea Paterniani <a.paterniani@swapp-eng.it>
Subject: [patch 2.6.28-rc5] SPI -- Freescale iMX SPI controller driver
Date: Mon, 17 Nov 2008 15:08:15 +0100
Message-ID: <49217ACF.7080904@swapp-eng.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Linux ARM Kernel <linux-arm-kernel@lists.arm.linux.org.uk>
To: SPI Devel General <spi-devel-general@lists.sourceforge.net>,
	david-b@pacbell.net
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
List-Id: linux-spi.vger.kernel.org

Subject: [patch-2.6.28-rc5-spi_imx] arm: SPI controller driver for 
Freescale iMX
From: Andrea Paterniani <a.paterniani@swapp-eng.it>

Kernel version: linux-2.6.28-rc5.
Patch description:
Fix unsafe order in dma mapping operation.

Signed-off-by: Andrea Paterniani <a.paterniani@swapp-eng.it>
---

diff -uprN -X linux-2.6.28-rc5/Documentation/dontdiff 
linux-2.6.28-rc5/drivers/spi/spi_imx.c 
linux-2.6.28-rc5-spi_imx/drivers/spi/spi_imx.c
--- linux-2.6.28-rc5/drivers/spi/spi_imx.c    2008-10-10 
00:13:53.000000000 +0200
+++ linux-2.6.28-rc5-spi_imx/drivers/spi/spi_imx.c    2008-11-17 
11:26:54.000000000 +0100
@@ -506,20 +506,6 @@ static int map_dma_buffers(struct driver
     if (!IS_DMA_ALIGNED(drv_data->rx) || !IS_DMA_ALIGNED(drv_data->tx))
         return -1;
 
-    /* NULL rx means write-only transfer and no map needed
-       since rx DMA will not be used */
-    if (drv_data->rx) {
-        buf = drv_data->rx;
-        drv_data->rx_dma = dma_map_single(
-                    dev,
-                    buf,
-                    drv_data->len,
-                    DMA_FROM_DEVICE);
-        if (dma_mapping_error(dev, drv_data->rx_dma))
-            return -1;
-        drv_data->rx_dma_needs_unmap = 1;
-    }
-
     if (drv_data->tx == NULL) {
         /* Read only message --> use drv_data->dummy_dma_buf for dummy
            writes to achive reads */
@@ -533,18 +519,31 @@ static int map_dma_buffers(struct driver
                     buf,
                     drv_data->tx_map_len,
                     DMA_TO_DEVICE);
-    if (dma_mapping_error(dev, drv_data->tx_dma)) {
-        if (drv_data->rx_dma) {
-            dma_unmap_single(dev,
-                    drv_data->rx_dma,
-                    drv_data->len,
-                    DMA_FROM_DEVICE);
-            drv_data->rx_dma_needs_unmap = 0;
-        }
+    if (dma_mapping_error(dev, drv_data->tx_dma))
         return -1;
-    }
     drv_data->tx_dma_needs_unmap = 1;
 
+    /* NULL rx means write-only transfer and no map needed
+       since rx DMA will not be used */
+    if (drv_data->rx) {
+        buf = drv_data->rx;
+        drv_data->rx_dma = dma_map_single(dev,
+                        buf,
+                        drv_data->len,
+                        DMA_FROM_DEVICE);
+        if (dma_mapping_error(dev, drv_data->rx_dma)) {
+            if (drv_data->tx_dma) {
+                dma_unmap_single(dev,
+                        drv_data->tx_dma,
+                        drv_data->tx_map_len,
+                        DMA_TO_DEVICE);
+                drv_data->tx_dma_needs_unmap = 0;
+            }
+            return -1;
+        }
+        drv_data->rx_dma_needs_unmap = 1;
+    }
+
     return 0;
 }
 

-- 

------------------------------------------------------------------------

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php

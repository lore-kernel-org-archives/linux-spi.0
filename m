From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/2] spi: pxa2xx: Introduce DMA burst size support
Date: Tue, 26 Feb 2019 14:49:20 +0300
Message-ID: <20190226114921.48205-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>,
 Robert Jarzmik <robert.jarzmik@free.fr>,
 linux-arm-kernel@lists.infradead.org, Mark Brown <broonie@kernel.org>,
 linux-spi@vger.kernel.org, Jarkko Nikula <jarkko.nikula@linux.intel.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

Some masters may have different DMA burst size than hard coded default.
In such case respect the value given by DMA burst size provided via
platform data.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx-dma.c   | 4 +++-
 drivers/spi/spi-pxa2xx-pci.c   | 5 ++++-
 drivers/spi/spi-pxa2xx.c       | 1 +
 include/linux/spi/pxa2xx_spi.h | 1 +
 4 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx-dma.c b/drivers/spi/spi-pxa2xx-dma.c
index 2fa7f4b43492..3343fff81c7b 100644
--- a/drivers/spi/spi-pxa2xx-dma.c
+++ b/drivers/spi/spi-pxa2xx-dma.c
@@ -239,13 +239,15 @@ int pxa2xx_spi_set_dma_burst_and_threshold(struct chip_data *chip,
 					   u32 *threshold)
 {
 	struct pxa2xx_spi_chip *chip_info = spi->controller_data;
+	struct driver_data *drv_data = spi_controller_get_devdata(spi->controller);
+	u32 dma_burst_size = drv_data->master_info->dma_burst_size;
 
 	/*
 	 * If the DMA burst size is given in chip_info we use that,
 	 * otherwise we use the default. Also we use the default FIFO
 	 * thresholds for now.
 	 */
-	*burst_code = chip_info ? chip_info->dma_burst_size : 1;
+	*burst_code = chip_info ? chip_info->dma_burst_size : dma_burst_size;
 	*threshold = SSCR1_RxTresh(RX_THRESH_DFLT)
 		   | SSCR1_TxTresh(TX_THRESH_DFLT);
 
diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
index d3de925892cb..3faef7335137 100644
--- a/drivers/spi/spi-pxa2xx-pci.c
+++ b/drivers/spi/spi-pxa2xx-pci.c
@@ -5,7 +5,6 @@
  */
 #include <linux/clk-provider.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/spi/pxa2xx_spi.h>
@@ -35,6 +34,8 @@ struct pxa_spi_info {
 	void *tx_param;
 	void *rx_param;
 
+	int dma_burst_size;
+
 	int (*setup)(struct pci_dev *pdev, struct pxa_spi_info *c);
 };
 
@@ -133,6 +134,7 @@ static int mrfld_spi_setup(struct pci_dev *dev, struct pxa_spi_info *c)
 	rx->dma_dev = &dma_dev->dev;
 
 	c->dma_filter = lpss_dma_filter;
+	c->dma_burst_size = 8;
 	return 0;
 }
 
@@ -223,6 +225,7 @@ static int pxa2xx_spi_pci_probe(struct pci_dev *dev,
 	spi_pdata.tx_param = c->tx_param;
 	spi_pdata.rx_param = c->rx_param;
 	spi_pdata.enable_dma = c->rx_param && c->tx_param;
+	spi_pdata.dma_burst_size = c->dma_burst_size ? c->dma_burst_size : 1;
 
 	ssp = &spi_pdata.ssp;
 	ssp->phys_base = pci_resource_start(dev, 0);
diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 8dd67d722aae..7a86654045fc 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1569,6 +1569,7 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 	pdata->is_slave = of_property_read_bool(pdev->dev.of_node, "spi-slave");
 	pdata->num_chipselect = 1;
 	pdata->enable_dma = true;
+	pdata->dma_burst_size = 1;
 
 	return pdata;
 }
diff --git a/include/linux/spi/pxa2xx_spi.h b/include/linux/spi/pxa2xx_spi.h
index b0674e330ef6..154da8cd4781 100644
--- a/include/linux/spi/pxa2xx_spi.h
+++ b/include/linux/spi/pxa2xx_spi.h
@@ -25,6 +25,7 @@ struct dma_chan;
 struct pxa2xx_spi_master {
 	u16 num_chipselect;
 	u8 enable_dma;
+	u8 dma_burst_size;
 	bool is_slave;
 
 	/* DMA engine specific config */
-- 
2.20.1

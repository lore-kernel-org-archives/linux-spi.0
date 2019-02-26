From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/3] spi: pxa2xx: Introduce dma-burst-sz property support
Date: Tue, 26 Feb 2019 12:24:40 +0300
Message-ID: <20190226092441.49198-2-andriy.shevchenko@linux.intel.com>
References: <20190226092441.49198-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 devicetree@vger.kernel.org, Daniel Mack <daniel@zonque.org>,
 Haojian Zhuang <haojian.zhuang@gmail.com>,
 Robert Jarzmik <robert.jarzmik@free.fr>,
 linux-arm-kernel@lists.infradead.org, Mark Brown <broonie@kernel.org>,
 linux-spi@vger.kernel.org, Jarkko Nikula <jarkko.nikula@linux.intel.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190226092441.49198-1-andriy.shevchenko@linux.intel.com>
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
In such case respect the value given by dma-burst-size property.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx-dma.c   | 4 +++-
 drivers/spi/spi-pxa2xx-pci.c   | 8 +++++++-
 drivers/spi/spi-pxa2xx.c       | 5 ++++-
 include/linux/spi/pxa2xx_spi.h | 1 +
 4 files changed, 15 insertions(+), 3 deletions(-)

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
index d3de925892cb..1db1b64cfba8 100644
--- a/drivers/spi/spi-pxa2xx-pci.c
+++ b/drivers/spi/spi-pxa2xx-pci.c
@@ -5,9 +5,9 @@
  */
 #include <linux/clk-provider.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/spi/pxa2xx_spi.h>
 
 #include <linux/dmaengine.h>
@@ -200,6 +200,7 @@ static int pxa2xx_spi_pci_probe(struct pci_dev *dev,
 	struct pxa2xx_spi_master spi_pdata;
 	struct ssp_device *ssp;
 	struct pxa_spi_info *c;
+	u32 dma_burst_sz;
 	char buf[40];
 
 	ret = pcim_enable_device(dev);
@@ -217,12 +218,17 @@ static int pxa2xx_spi_pci_probe(struct pci_dev *dev,
 			return ret;
 	}
 
+	ret = device_property_read_u32(&dev->dev, "dma-burst-sz", &dma_burst_sz);
+	if (ret)
+		dma_burst_sz = 1;
+
 	memset(&spi_pdata, 0, sizeof(spi_pdata));
 	spi_pdata.num_chipselect = (c->num_chipselect > 0) ? c->num_chipselect : dev->devfn;
 	spi_pdata.dma_filter = c->dma_filter;
 	spi_pdata.tx_param = c->tx_param;
 	spi_pdata.rx_param = c->rx_param;
 	spi_pdata.enable_dma = c->rx_param && c->tx_param;
+	spi_pdata.dma_burst_size = dma_burst_sz;
 
 	ssp = &spi_pdata.ssp;
 	ssp->phys_base = pci_resource_start(dev, 0);
diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 8dd67d722aae..393e020c757a 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -24,6 +24,7 @@
 #include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/spi/pxa2xx_spi.h>
 #include <linux/spi/spi.h>
 #include <linux/delay.h>
@@ -1512,6 +1513,7 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 	const struct acpi_device_id *adev_id = NULL;
 	const struct pci_device_id *pcidev_id = NULL;
 	const struct of_device_id *of_id = NULL;
+	struct device *dev = &pdev->dev;
 	enum pxa_ssp_type type;
 
 	adev = ACPI_COMPANION(&pdev->dev);
@@ -1566,9 +1568,10 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 	ssp->pdev = pdev;
 	ssp->port_id = pxa2xx_spi_get_port_id(adev);
 
-	pdata->is_slave = of_property_read_bool(pdev->dev.of_node, "spi-slave");
+	pdata->is_slave = device_property_read_bool(dev, "spi-slave");
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

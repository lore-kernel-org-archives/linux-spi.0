From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v5 1/2] spi: pxa2xx: Introduce DMA burst size support
Date: Tue, 19 Mar 2019 17:48:42 +0200
Message-ID: <20190319154843.74684-2-andriy.shevchenko@linux.intel.com>
References: <20190319154843.74684-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>,
 Robert Jarzmik <robert.jarzmik@free.fr>,
 linux-arm-kernel@lists.infradead.org, Mark Brown <broonie@kernel.org>,
 linux-spi@vger.kernel.org, Jarkko Nikula <jarkko.nikula@linux.intel.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190319154843.74684-1-andriy.shevchenko@linux.intel.com>
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
 drivers/spi/spi-pxa2xx-pci.c   | 4 ++++
 drivers/spi/spi-pxa2xx.c       | 1 +
 include/linux/spi/pxa2xx_spi.h | 1 +
 4 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pxa2xx-dma.c b/drivers/spi/spi-pxa2xx-dma.c
index 15592598273e..e5c26c1779ab 100644
--- a/drivers/spi/spi-pxa2xx-dma.c
+++ b/drivers/spi/spi-pxa2xx-dma.c
@@ -239,13 +239,15 @@ int pxa2xx_spi_set_dma_burst_and_threshold(struct chip_data *chip,
 					   u32 *threshold)
 {
 	struct pxa2xx_spi_chip *chip_info = spi->controller_data;
+	struct driver_data *drv_data = spi_controller_get_devdata(spi->controller);
+	u32 dma_burst_size = drv_data->controller_info->dma_burst_size;
 
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
index 1727fdfbac28..33029ca0687a 100644
--- a/drivers/spi/spi-pxa2xx-pci.c
+++ b/drivers/spi/spi-pxa2xx-pci.c
@@ -35,6 +35,8 @@ struct pxa_spi_info {
 	void *tx_param;
 	void *rx_param;
 
+	int dma_burst_size;
+
 	int (*setup)(struct pci_dev *pdev, struct pxa_spi_info *c);
 };
 
@@ -133,6 +135,7 @@ static int mrfld_spi_setup(struct pci_dev *dev, struct pxa_spi_info *c)
 	rx->dma_dev = &dma_dev->dev;
 
 	c->dma_filter = lpss_dma_filter;
+	c->dma_burst_size = 8;
 	return 0;
 }
 
@@ -223,6 +226,7 @@ static int pxa2xx_spi_pci_probe(struct pci_dev *dev,
 	spi_pdata.tx_param = c->tx_param;
 	spi_pdata.rx_param = c->rx_param;
 	spi_pdata.enable_dma = c->rx_param && c->tx_param;
+	spi_pdata.dma_burst_size = c->dma_burst_size ? c->dma_burst_size : 1;
 
 	ssp = &spi_pdata.ssp;
 	ssp->phys_base = pci_resource_start(dev, 0);
diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index b6ddba833d02..461c6b796b8f 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1564,6 +1564,7 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 	pdata->is_slave = of_property_read_bool(pdev->dev.of_node, "spi-slave");
 	pdata->num_chipselect = 1;
 	pdata->enable_dma = true;
+	pdata->dma_burst_size = 1;
 
 	return pdata;
 }
diff --git a/include/linux/spi/pxa2xx_spi.h b/include/linux/spi/pxa2xx_spi.h
index c1c59473cef9..6005f0126631 100644
--- a/include/linux/spi/pxa2xx_spi.h
+++ b/include/linux/spi/pxa2xx_spi.h
@@ -25,6 +25,7 @@ struct dma_chan;
 struct pxa2xx_spi_controller {
 	u16 num_chipselect;
 	u8 enable_dma;
+	u8 dma_burst_size;
 	bool is_slave;
 
 	/* DMA engine specific config */
-- 
2.20.1

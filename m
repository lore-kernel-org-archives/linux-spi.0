From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/2] spi: pxa2xx: Introduce temporary variables to increase
 readability
Date: Mon, 21 Oct 2019 13:36:24 +0300
Message-ID: <20191021103625.4250-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>,
 Robert Jarzmik <robert.jarzmik@free.fr>,
 linux-arm-kernel@lists.infradead.org, Mark Brown <broonie@kernel.org>,
 linux-spi@vger.kernel.org
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

The current conditional for PCI ID matching is hard to read.
Introduce couple of temporary variables to increase readability
of the code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 0390053ed8f5..02daba3dbd0d 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1516,13 +1516,14 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 	struct pxa2xx_spi_controller *pdata;
 	struct ssp_device *ssp;
 	struct resource *res;
+	struct device *parent = pdev->dev.parent;
+	struct pci_dev *pcidev = dev_is_pci(parent) ? to_pci_dev(parent) : NULL;
 	const struct pci_device_id *pcidev_id = NULL;
 	enum pxa_ssp_type type;
 	const void *match;
 
-	if (dev_is_pci(pdev->dev.parent))
-		pcidev_id = pci_match_id(pxa2xx_spi_pci_compound_match,
-					 to_pci_dev(pdev->dev.parent));
+	if (pcidev)
+		pcidev_id = pci_match_id(pxa2xx_spi_pci_compound_match, pcidev);
 
 	match = device_get_match_data(&pdev->dev);
 	if (match)
@@ -1549,8 +1550,8 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 
 #ifdef CONFIG_PCI
 	if (pcidev_id) {
-		pdata->tx_param = pdev->dev.parent;
-		pdata->rx_param = pdev->dev.parent;
+		pdata->tx_param = parent;
+		pdata->rx_param = parent;
 		pdata->dma_filter = pxa2xx_spi_idma_filter;
 	}
 #endif
-- 
2.23.0

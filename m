From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: pxa2xx: Introduce temporary variables to increase
 readability" to the spi tree
Date: Fri, 25 Oct 2019 11:12:18 +0100 (BST)
Message-ID: <20191025101218.D8076274326E@ypsilon.sirena.org.uk>
References: <20191021103625.4250-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>, linux-spi@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, Daniel Mack <daniel@zonque.org>,
 Robert Jarzmik <robert.jarzmik@free.fr>, linux-arm-kernel@lists.infradead.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191021103625.4250-1-andriy.shevchenko@linux.intel.com>
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

The patch

   spi: pxa2xx: Introduce temporary variables to increase readability

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.5

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 6fb7427d84f6ed064776434436485cfb0f6711e9 Mon Sep 17 00:00:00 2001
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Mon, 21 Oct 2019 13:36:24 +0300
Subject: [PATCH] spi: pxa2xx: Introduce temporary variables to increase
 readability

The current conditional for PCI ID matching is hard to read.
Introduce couple of temporary variables to increase readability
of the code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20191021103625.4250-1-andriy.shevchenko@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-pxa2xx.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 443c1f4d2a9a..6eb6805ee51d 100644
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
2.20.1

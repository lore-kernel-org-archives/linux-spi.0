From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: pxa2xx: Convert to use device_get_match_data()" to the
 spi tree
Date: Fri, 18 Oct 2019 19:07:09 +0100 (BST)
Message-ID: <20191018180709.7A1482741DEA@ypsilon.sirena.org.uk>
References: <20191018105429.82782-4-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>, linux-spi@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, Daniel Mack <daniel@zonque.org>,
 Robert Jarzmik <robert.jarzmik@free.fr>, linux-arm-kernel@lists.infradead.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191018105429.82782-4-andriy.shevchenko@linux.intel.com>
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

   spi: pxa2xx: Convert to use device_get_match_data()

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

>From f2faa3ec79ac11db8c26b10f8c978d4d0f7392dd Mon Sep 17 00:00:00 2001
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Fri, 18 Oct 2019 13:54:28 +0300
Subject: [PATCH] spi: pxa2xx: Convert to use device_get_match_data()

Convert to use device_get_match_data() instead of open coded variant.

While here, switch of_property_read_bool() to device_property_read_bool().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20191018105429.82782-4-andriy.shevchenko@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-pxa2xx.c | 26 +++++++-------------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 04ca80770e35..684a5585ac7f 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -22,6 +22,7 @@
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 #include <linux/spi/pxa2xx_spi.h>
 #include <linux/spi/spi.h>
@@ -1512,34 +1513,21 @@ static struct pxa2xx_spi_controller *
 pxa2xx_spi_init_pdata(struct platform_device *pdev)
 {
 	struct pxa2xx_spi_controller *pdata;
-	struct acpi_device *adev;
 	struct ssp_device *ssp;
 	struct resource *res;
-	const struct acpi_device_id *adev_id = NULL;
 	const struct pci_device_id *pcidev_id = NULL;
-	const struct of_device_id *of_id = NULL;
 	enum pxa_ssp_type type;
+	const void *match;
 
-	adev = ACPI_COMPANION(&pdev->dev);
-
-	if (pdev->dev.of_node)
-		of_id = of_match_device(pdev->dev.driver->of_match_table,
-					&pdev->dev);
-	else if (dev_is_pci(pdev->dev.parent))
+	if (dev_is_pci(pdev->dev.parent))
 		pcidev_id = pci_match_id(pxa2xx_spi_pci_compound_match,
 					 to_pci_dev(pdev->dev.parent));
-	else if (adev)
-		adev_id = acpi_match_device(pdev->dev.driver->acpi_match_table,
-					    &pdev->dev);
-	else
-		return NULL;
 
-	if (adev_id)
-		type = (enum pxa_ssp_type)adev_id->driver_data;
+	match = device_get_match_data(&pdev->dev);
+	if (match)
+		type = (enum pxa_ssp_type)match;
 	else if (pcidev_id)
 		type = (enum pxa_ssp_type)pcidev_id->driver_data;
-	else if (of_id)
-		type = (enum pxa_ssp_type)of_id->data;
 	else
 		return NULL;
 
@@ -1572,7 +1560,7 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 	ssp->dev = &pdev->dev;
 	ssp->port_id = pxa2xx_spi_get_port_id(&pdev->dev);
 
-	pdata->is_slave = of_property_read_bool(pdev->dev.of_node, "spi-slave");
+	pdata->is_slave = device_property_read_bool(&pdev->dev, "spi-slave");
 	pdata->num_chipselect = 1;
 	pdata->enable_dma = true;
 	pdata->dma_burst_size = 1;
-- 
2.20.1

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 3/5] spi: pxa2xx: Convert pxa2xx_spi_get_port_id() to take
 struct device
Date: Fri, 18 Oct 2019 13:54:27 +0300
Message-ID: <20191018105429.82782-3-andriy.shevchenko@linux.intel.com>
References: <20191018105429.82782-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>,
 Robert Jarzmik <robert.jarzmik@free.fr>,
 linux-arm-kernel@lists.infradead.org, Mark Brown <broonie@kernel.org>,
 linux-spi@vger.kernel.org
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191018105429.82782-1-andriy.shevchenko@linux.intel.com>
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

This is preparatory patch before converting to use device_get_match_data() API.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 670734b3d56a..04ca80770e35 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1476,11 +1476,13 @@ MODULE_DEVICE_TABLE(of, pxa2xx_spi_of_match);
 
 #ifdef CONFIG_ACPI
 
-static int pxa2xx_spi_get_port_id(struct acpi_device *adev)
+static int pxa2xx_spi_get_port_id(struct device *dev)
 {
+	struct acpi_device *adev;
 	unsigned int devid;
 	int port_id = -1;
 
+	adev = ACPI_COMPANION(dev);
 	if (adev && adev->pnp.unique_id &&
 	    !kstrtouint(adev->pnp.unique_id, 0, &devid))
 		port_id = devid;
@@ -1489,7 +1491,7 @@ static int pxa2xx_spi_get_port_id(struct acpi_device *adev)
 
 #else /* !CONFIG_ACPI */
 
-static int pxa2xx_spi_get_port_id(struct acpi_device *adev)
+static int pxa2xx_spi_get_port_id(struct device *dev)
 {
 	return -1;
 }
@@ -1568,7 +1570,7 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 	ssp->irq = platform_get_irq(pdev, 0);
 	ssp->type = type;
 	ssp->dev = &pdev->dev;
-	ssp->port_id = pxa2xx_spi_get_port_id(adev);
+	ssp->port_id = pxa2xx_spi_get_port_id(&pdev->dev);
 
 	pdata->is_slave = of_property_read_bool(pdev->dev.of_node, "spi-slave");
 	pdata->num_chipselect = 1;
-- 
2.23.0

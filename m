From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: pxa2xx: Drop extra check of platform_get_resource()
 returned value" to the spi tree
Date: Wed, 23 Oct 2019 19:56:17 +0100 (BST)
Message-ID: <20191023185617.770E32743021@ypsilon.sirena.org.uk>
References: <20191021103625.4250-2-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>, linux-spi@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, Daniel Mack <daniel@zonque.org>,
 Robert Jarzmik <robert.jarzmik@free.fr>, linux-arm-kernel@lists.infradead.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191021103625.4250-2-andriy.shevchenko@linux.intel.com>
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

   spi: pxa2xx: Drop extra check of platform_get_resource() returned value

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.4

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

>From 77c544d243f3b0d1ae3487ebb170c07c79734fe7 Mon Sep 17 00:00:00 2001
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Mon, 21 Oct 2019 13:36:25 +0300
Subject: [PATCH] spi: pxa2xx: Drop extra check of platform_get_resource()
 returned value

The devm_ioremap_resource() has already a check for resource pointer
being NULL. No need to double check this.

Drop extra check of platform_get_resource() returned value.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20191021103625.4250-2-andriy.shevchenko@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-pxa2xx.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 068c21037679..4249bcaf77bd 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1545,17 +1545,15 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 	if (!pdata)
 		return NULL;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return NULL;
-
 	ssp = &pdata->ssp;
 
-	ssp->phys_base = res->start;
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	ssp->mmio_base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(ssp->mmio_base))
 		return NULL;
 
+	ssp->phys_base = res->start;
+
 #ifdef CONFIG_PCI
 	if (pcidev_id) {
 		pdata->tx_param = pdev->dev.parent;
-- 
2.20.1

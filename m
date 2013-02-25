From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] SPI: spi-ppc4xx - remove incorrect __exit markup
Date: Sun, 24 Feb 2013 19:29:40 -0800
Message-ID: <20130225032939.GA11603@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Even if bus is not hot-pluggable, the devices can be unbound from the
driver via sysfs, so we should not be using __exit annotations on
remove() methods. The only exception is drivers registered with
platform_driver_probe() which specifically disables sysfs bind/unbind
attributes.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/spi/spi-ppc4xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-ppc4xx.c b/drivers/spi/spi-ppc4xx.c
index 7a85f22..027b474 100644
--- a/drivers/spi/spi-ppc4xx.c
+++ b/drivers/spi/spi-ppc4xx.c
@@ -560,7 +560,7 @@ free_master:
 	return ret;
 }
 
-static int __exit spi_ppc4xx_of_remove(struct platform_device *op)
+static int spi_ppc4xx_of_remove(struct platform_device *op)
 {
 	struct spi_master *master = dev_get_drvdata(&op->dev);
 	struct ppc4xx_spi *hw = spi_master_get_devdata(master);
@@ -583,7 +583,7 @@ MODULE_DEVICE_TABLE(of, spi_ppc4xx_of_match);
 
 static struct platform_driver spi_ppc4xx_of_driver = {
 	.probe = spi_ppc4xx_of_probe,
-	.remove = __exit_p(spi_ppc4xx_of_remove),
+	.remove = spi_ppc4xx_of_remove,
 	.driver = {
 		.name = DRIVER_NAME,
 		.owner = THIS_MODULE,
-- 
1.7.11.7


-- 
Dmitry

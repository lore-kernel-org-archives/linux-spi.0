From: Flavio Suligoi <f.suligoi@asem.it>
Subject: [PATCH v2 1/1] spi: pxa2xx: add driver enabling message
Date: Wed, 10 Apr 2019 11:47:04 +0200
Message-ID: <1554889624-25000-1-git-send-email-f.suligoi@asem.it>
References: <358f26bc47bd4aa289971f0a763b27cb@asem.it>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <f.suligoi@asem.it>
To: Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <358f26bc47bd4aa289971f0a763b27cb@asem.it>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Add an info message for the PXA2xx device driver start-up,
with the indication of:

- mode (slave device or master controller)
- transfer mode (DMA or GPIO)

Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
---

v1:	- first version
v2:	- remove warning message "no DMA channels available, using PIO"
	- add "slave device"/"master controller" indication message

 drivers/spi/spi-pxa2xx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index f7068cc..b9e04e2 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1696,7 +1696,6 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 	if (platform_info->enable_dma) {
 		status = pxa2xx_spi_dma_setup(drv_data);
 		if (status) {
-			dev_warn(dev, "no DMA channels available, using PIO\n");
 			platform_info->enable_dma = false;
 		} else {
 			controller->can_dma = pxa2xx_spi_can_dma;
@@ -1818,6 +1817,10 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
+	dev_info(dev, "PXA2xx SPI %s (%s mode)\n",
+		platform_info->is_slave ? "slave device" : "master controller",
+		platform_info->enable_dma ? "DMA" : "PIO");
+
 	/* Register with the SPI framework */
 	platform_set_drvdata(pdev, drv_data);
 	status = devm_spi_register_controller(&pdev->dev, controller);
-- 
2.7.4

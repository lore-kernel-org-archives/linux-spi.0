From: "Ivan T. Ivanov" <iivanov@mm-sol.com>
Subject: [PATCH 2/2] spi: qup: Request CS GPIO's during probe
Date: Fri,  6 Mar 2015 17:26:18 +0200
Message-ID: <1425655578-22400-2-git-send-email-iivanov@mm-sol.com>
References: <1425655578-22400-1-git-send-email-iivanov@mm-sol.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1425655578-22400-1-git-send-email-iivanov@mm-sol.com>
Sender: linux-arm-msm-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Ensure that driver is owner of the GPIO's used for CS signals.

Signed-off-by: Ivan T. Ivanov <iivanov@mm-sol.com>
---
 drivers/spi/spi-qup.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index 2b2c359..a07ba46 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -14,11 +14,13 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/err.h>
+#include <linux/gpio.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_gpio.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/spi/spi.h>
@@ -499,7 +501,7 @@ static int spi_qup_probe(struct platform_device *pdev)
 	struct device *dev;
 	void __iomem *base;
 	u32 max_freq, iomode, num_cs;
-	int ret, irq, size;
+	int ret, irq, size, cs, cs_gpio;

 	dev = &pdev->dev;
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -556,6 +558,19 @@ static int spi_qup_probe(struct platform_device *pdev)
 	else
 		master->num_chipselect = num_cs;

+	for (cs = 0; cs < master->num_chipselect; cs++) {
+		cs_gpio = of_get_named_gpio(dev->of_node, "cs-gpios", cs);
+
+		if (!gpio_is_valid(cs_gpio))
+			continue;
+
+		ret = devm_gpio_request(&pdev->dev, cs_gpio, "spi-qup-cs");
+		if (ret) {
+			dev_err(&pdev->dev, "can't get cs gpios\n");
+			goto error;
+		}
+	}
+
 	master->bus_num = pdev->id;
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LOOP;
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
--
1.9.1

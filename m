From: Jonas Gorski <jonas.gorski-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH V2 3/3] spi/bcm63xx-hsspi: allow for probing through devicetree
Date: Wed,  1 Mar 2017 10:08:14 +0100
Message-ID: <20170301090814.7097-3-jonas.gorski@gmail.com>
References: <20170301090814.7097-1-jonas.gorski@gmail.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170301090814.7097-1-jonas.gorski-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Add required binding support to probe through device tree.

Signed-off-by: Jonas Gorski <jonas.gorski-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Acked-by: Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
Changes v1 -> v2:
 * do everything except the bus_num assignment regardless of of_node
   being populated
 * Added Florian's Ack

 drivers/spi/spi-bcm63xx-hsspi.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hsspi.c
index 79096d17ebde..5514cd02e93a 100644
--- a/drivers/spi/spi-bcm63xx-hsspi.c
+++ b/drivers/spi/spi-bcm63xx-hsspi.c
@@ -19,6 +19,7 @@
 #include <linux/interrupt.h>
 #include <linux/spi/spi.h>
 #include <linux/mutex.h>
+#include <linux/of.h>
 
 #define HSSPI_GLOBAL_CTRL_REG			0x0
 #define GLOBAL_CTRL_CS_POLARITY_SHIFT		0
@@ -91,6 +92,7 @@
 
 #define HSSPI_MAX_SYNC_CLOCK			30000000
 
+#define HSSPI_SPI_MAX_CS			8
 #define HSSPI_BUS_NUM				1 /* 0 is legacy SPI */
 
 struct bcm63xx_hsspi {
@@ -332,7 +334,7 @@ static int bcm63xx_hsspi_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct clk *clk;
 	int irq, ret;
-	u32 reg, rate;
+	u32 reg, rate, num_cs = HSSPI_SPI_MAX_CS;
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
@@ -382,8 +384,17 @@ static int bcm63xx_hsspi_probe(struct platform_device *pdev)
 	mutex_init(&bs->bus_mutex);
 	init_completion(&bs->done);
 
-	master->bus_num = HSSPI_BUS_NUM;
-	master->num_chipselect = 8;
+	master->dev.of_node = dev->of_node;
+	if (!dev->of_node)
+		master->bus_num = HSSPI_BUS_NUM;
+
+	of_property_read_u32(dev->of_node, "num-cs", &num_cs);
+	if (num_cs > 8) {
+		dev_warn(dev, "unsupported number of cs (%i), reducing to 8\n",
+			 num_cs);
+		num_cs = HSSPI_SPI_MAX_CS;
+	}
+	master->num_chipselect = num_cs;
 	master->setup = bcm63xx_hsspi_setup;
 	master->transfer_one_message = bcm63xx_hsspi_transfer_one;
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH |
@@ -469,10 +480,16 @@ static int bcm63xx_hsspi_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(bcm63xx_hsspi_pm_ops, bcm63xx_hsspi_suspend,
 			 bcm63xx_hsspi_resume);
 
+static const struct of_device_id bcm63xx_hsspi_of_match[] = {
+	{ .compatible = "brcm,bcm6328-hsspi", },
+	{ },
+};
+
 static struct platform_driver bcm63xx_hsspi_driver = {
 	.driver = {
 		.name	= "bcm63xx-hsspi",
 		.pm	= &bcm63xx_hsspi_pm_ops,
+		.of_match_table = bcm63xx_hsspi_of_match,
 	},
 	.probe		= bcm63xx_hsspi_probe,
 	.remove		= bcm63xx_hsspi_remove,
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

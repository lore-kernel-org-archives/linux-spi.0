From: Jonas Gorski <jonas.gorski-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/2] spi/bcm63xx: allow for probing through devicetree
Date: Tue, 21 Feb 2017 11:58:22 +0100
Message-ID: <20170221105822.10437-2-jonas.gorski@gmail.com>
References: <20170221105822.10437-1-jonas.gorski@gmail.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170221105822.10437-1-jonas.gorski-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Add required binding support to probe through device tree.

Use the compatible instead of the resource size for identifiying the
block type, and allow reducing the number of cs lines through OF.

Signed-off-by: Jonas Gorski <jonas.gorski-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-bcm63xx.c | 42 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 36 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index caa733ec405c..325131370941 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -26,6 +26,7 @@
 #include <linux/completion.h>
 #include <linux/err.h>
 #include <linux/pm_runtime.h>
+#include <linux/of.h>
 
 /* BCM 6338/6348 SPI core */
 #define SPI_6348_RSET_SIZE		64
@@ -484,21 +485,48 @@ static const struct platform_device_id bcm63xx_spi_dev_match[] = {
 	},
 };
 
+static const struct of_device_id bcm63xx_spi_of_match[] = {
+	{ .compatible = "brcm,bcm6348-spi", .data = &bcm6348_spi_reg_offsets },
+	{ .compatible = "brcm,bcm6358-spi", .data = &bcm6358_spi_reg_offsets },
+	{ },
+};
+
 static int bcm63xx_spi_probe(struct platform_device *pdev)
 {
 	struct resource *r;
 	const unsigned long *bcm63xx_spireg;
 	struct device *dev = &pdev->dev;
-	int irq;
+	int irq, bus_num;
 	struct spi_master *master;
 	struct clk *clk;
 	struct bcm63xx_spi *bs;
 	int ret;
+	u32 num_cs = BCM63XX_SPI_MAX_CS;
 
-	if (!pdev->id_entry->driver_data)
-		return -EINVAL;
+	if (dev->of_node) {
+		const struct of_device_id *match;
 
-	bcm63xx_spireg = (const unsigned long *)pdev->id_entry->driver_data;
+		match = of_match_node(bcm63xx_spi_of_match, dev->of_node);
+		if (!match)
+			return -EINVAL;
+		bcm63xx_spireg = match->data;
+
+		of_property_read_u32(dev->of_node, "num-cs", &num_cs);
+		if (num_cs > BCM63XX_SPI_MAX_CS) {
+			dev_warn(dev, "unsupported number of cs (%i), reducing to 8\n",
+				 num_cs);
+			num_cs = BCM63XX_SPI_MAX_CS;
+		}
+
+		bus_num = -1;
+	} else if (pdev->id_entry->driver_data) {
+		const struct platform_device_id *match = pdev->id_entry;
+
+		bcm63xx_spireg = (const unsigned long *)match->driver_data;
+		bus_num = BCM63XX_SPI_BUS_NUM;
+	} else {
+		return -EINVAL;
+	}
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
@@ -543,8 +571,9 @@ static int bcm63xx_spi_probe(struct platform_device *pdev)
 		goto out_err;
 	}
 
-	master->bus_num = BCM63XX_SPI_BUS_NUM;
-	master->num_chipselect = BCM63XX_SPI_MAX_CS;
+	master->dev.of_node = dev->of_node;
+	master->bus_num = bus_num;
+	master->num_chipselect = num_cs;
 	master->transfer_one_message = bcm63xx_spi_transfer_one;
 	master->mode_bits = MODEBITS;
 	master->bits_per_word_mask = SPI_BPW_MASK(8);
@@ -633,6 +662,7 @@ static struct platform_driver bcm63xx_spi_driver = {
 	.driver = {
 		.name	= "bcm63xx-spi",
 		.pm	= &bcm63xx_spi_pm_ops,
+		.of_match_table = bcm63xx_spi_of_match,
 	},
 	.id_table	= bcm63xx_spi_dev_match,
 	.probe		= bcm63xx_spi_probe,
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

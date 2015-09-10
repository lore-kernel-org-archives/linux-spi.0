From: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Subject: [PATCH 2/2] spi/bcm63xx: add support for probing through devicetree
Date: Thu, 10 Sep 2015 17:29:35 +0200
Message-ID: <1441898975-22540-3-git-send-email-jogo@openwrt.org>
References: <1441898975-22540-1-git-send-email-jogo@openwrt.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1441898975-22540-1-git-send-email-jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Add required binding support to probe through device tree.

Use the compatible instead of the resource size for identifiying the
block type, and allow reducing the number of cs lines through OF.

Signed-off-by: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
---
 drivers/spi/spi-bcm63xx.c | 56 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 42 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index 42f33bc..ec094b1 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -26,6 +26,7 @@
 #include <linux/completion.h>
 #include <linux/err.h>
 #include <linux/pm_runtime.h>
+#include <linux/of.h>
 
 /* BCM 6338/6348 SPI core */
 #define SPI_6348_RSET_SIZE		64
@@ -465,6 +466,12 @@ static const unsigned long bcm6358_spi_reg_offsets[] = {
 	[SPI_MSG_DATA_SIZE]	= SPI_6358_MSG_DATA_SIZE,
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
@@ -474,6 +481,7 @@ static int bcm63xx_spi_probe(struct platform_device *pdev)
 	struct clk *clk;
 	struct bcm63xx_spi *bs;
 	int ret;
+	u32 num_cs = BCM63XX_SPI_MAX_CS;
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
@@ -516,27 +524,46 @@ static int bcm63xx_spi_probe(struct platform_device *pdev)
 		goto out_err;
 	}
 
-	master->bus_num = BCM63XX_SPI_BUS_NUM;
-	master->num_chipselect = BCM63XX_SPI_MAX_CS;
 	master->transfer_one_message = bcm63xx_spi_transfer_one;
 	master->mode_bits = MODEBITS;
 	master->bits_per_word_mask = SPI_BPW_MASK(8);
 	master->auto_runtime_pm = true;
 
-	switch (resource_size(r)) {
-	case SPI_6348_RSET_SIZE:
-		bs->reg_offsets = bcm6348_spi_reg_offsets;
-		break;
-	case SPI_6358_RSET_SIZE:
-		bs->reg_offsets = bcm6358_spi_reg_offsets;
-		break;
-	default:
-		ret = -EINVAL;
-		dev_err(dev, "unsupported register size: %i\n",
-			resource_size(r));
-		goto out_err;
+	if (dev->of_node) {
+		const struct of_device_id *match;
+
+		match = of_match_node(bcm63xx_spi_of_match, dev->of_node);
+		if (!match) {
+			ret = -EINVAL;
+			goto out_err;
+		}
+		bs->reg_offsets = match->data;
+		master->dev.of_node = dev->of_node;
+		of_property_read_u32(dev->of_node, "num-cs", &num_cs);
+		if (num_cs > BCM63XX_SPI_MAX_CS) {
+			dev_warn(dev, "unsupported number of cs (%i), reducing to 8\n",
+				 num_cs);
+			num_cs = BCM63XX_SPI_MAX_CS;
+		}
+	} else {
+		master->bus_num = BCM63XX_SPI_BUS_NUM;
+
+		switch (resource_size(r)) {
+		case SPI_6348_RSET_SIZE:
+			bs->reg_offsets = bcm6348_spi_reg_offsets;
+			break;
+		case SPI_6358_RSET_SIZE:
+			bs->reg_offsets = bcm6358_spi_reg_offsets;
+			break;
+		default:
+			ret = -EINVAL;
+			dev_err(dev, "unsupported register size: %i\n",
+				resource_size(r));
+			goto out_err;
+		}
 	}
 
+	master->num_chipselect = num_cs;
 	bs->msg_type_shift = bs->reg_offsets[SPI_MSG_TYPE_SHIFT];
 	bs->msg_ctl_width = bs->reg_offsets[SPI_MSG_CTL_WIDTH];
 	bs->fifo_size = bs->reg_offsets[SPI_MSG_DATA_SIZE];
@@ -621,6 +648,7 @@ static struct platform_driver bcm63xx_spi_driver = {
 	.driver = {
 		.name	= "bcm63xx-spi",
 		.pm	= &bcm63xx_spi_pm_ops,
+		.of_match_table = bcm63xx_spi_of_match,
 	},
 	.probe		= bcm63xx_spi_probe,
 	.remove		= bcm63xx_spi_remove,
-- 
2.1.4
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

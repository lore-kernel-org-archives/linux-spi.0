From: Tobias Klauser <tklauser-93Khv+1bN0NyDzI6CaY1VQ@public.gmane.org>
Subject: [PATCH] spi: oc-tiny: Use of_property_read_u32 instead of open-coding it
Date: Wed,  9 Sep 2015 13:55:53 +0200
Message-ID: <1441799753-27183-1-git-send-email-tklauser@distanz.ch>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Use of_property_read_u32 instead of of_get_property with return value
checks and endianness conversion.

Signed-off-by: Tobias Klauser <tklauser-93Khv+1bN0NyDzI6CaY1VQ@public.gmane.org>
---
 drivers/spi/spi-oc-tiny.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-oc-tiny.c b/drivers/spi/spi-oc-tiny.c
index 76656a7..b591128 100644
--- a/drivers/spi/spi-oc-tiny.c
+++ b/drivers/spi/spi-oc-tiny.c
@@ -207,8 +207,7 @@ static int tiny_spi_of_probe(struct platform_device *pdev)
 	struct tiny_spi *hw = platform_get_drvdata(pdev);
 	struct device_node *np = pdev->dev.of_node;
 	unsigned int i;
-	const __be32 *val;
-	int len;
+	u32 val;
 
 	if (!np)
 		return 0;
@@ -226,13 +225,10 @@ static int tiny_spi_of_probe(struct platform_device *pdev)
 			return -ENODEV;
 	}
 	hw->bitbang.master->dev.of_node = pdev->dev.of_node;
-	val = of_get_property(pdev->dev.of_node,
-			      "clock-frequency", &len);
-	if (val && len >= sizeof(__be32))
-		hw->freq = be32_to_cpup(val);
-	val = of_get_property(pdev->dev.of_node, "baud-width", &len);
-	if (val && len >= sizeof(__be32))
-		hw->baudwidth = be32_to_cpup(val);
+	if (!of_property_read_u32(np, "clock-frequency", &val))
+		hw->freq = val;
+	if (!of_property_read_u32(np, "baud-width", &val))
+		hw->baudwidth = val;
 	return 0;
 }
 #else /* !CONFIG_OF */
-- 
2.5.0


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

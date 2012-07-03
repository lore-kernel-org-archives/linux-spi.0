From: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Subject: [PATCH v2 04/12] spi-orion: add device tree binding
Date: Tue,  3 Jul 2012 16:22:37 +0200
Message-ID: <1341325365-21393-5-git-send-email-andrew@lunn.ch>
References: <1341325365-21393-1-git-send-email-andrew@lunn.ch>
Cc: grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org,
	devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
To: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1341325365-21393-1-git-send-email-andrew-g2DYL2Zd6BY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>

Signed-off-by: Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>
Signed-off-by: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Acked-by: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>
---
 Documentation/devicetree/bindings/spi/spi-orion.txt |    5 +++++
 drivers/spi/spi-orion.c                             |    9 +++++++++
 2 files changed, 14 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-orion.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-orion.txt b/Documentation/devicetree/bindings/spi/spi-orion.txt
new file mode 100644
index 0000000..e68597a
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-orion.txt
@@ -0,0 +1,5 @@
+Marvell Orion SPI device
+
+Required properties:
+- compatible : should be "marvell,orion-spi".
+- reg : offset and length of the register set for the device
diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index 8c3d625..b16db3d 100644
--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -17,6 +17,7 @@
 #include <linux/io.h>
 #include <linux/spi/spi.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/clk.h>
 #include <asm/unaligned.h>
 
@@ -429,6 +430,7 @@ static int __init orion_spi_probe(struct platform_device *pdev)
 	if (orion_spi_reset(spi) < 0)
 		goto out_rel_mem;
 
+	master->dev.of_node = pdev->dev.of_node;
 	status = spi_register_master(master);
 	if (status < 0)
 		goto out_rel_mem;
@@ -468,10 +470,17 @@ static int __exit orion_spi_remove(struct platform_device *pdev)
 
 MODULE_ALIAS("platform:" DRIVER_NAME);
 
+static const struct of_device_id orion_spi_of_match_table[] __devinitdata = {
+	{ .compatible = "marvell,orion-spi", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, orion_spi_of_match_table);
+
 static struct platform_driver orion_spi_driver = {
 	.driver = {
 		.name	= DRIVER_NAME,
 		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(orion_spi_of_match_table),
 	},
 	.remove		= __exit_p(orion_spi_remove),
 };
-- 
1.7.10

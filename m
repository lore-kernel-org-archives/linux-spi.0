From: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Subject: [PATCH v2 12/12] Crypto: CESA: Add support for DT based instantiation.
Date: Tue,  3 Jul 2012 16:22:45 +0200
Message-ID: <1341325365-21393-13-git-send-email-andrew@lunn.ch>
References: <1341325365-21393-1-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org,
	rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>,
	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1341325365-21393-1-git-send-email-andrew-g2DYL2Zd6BY@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Based on work by Michael Waller and Jason Cooper.

Added support for getting the interrupt number from DT.

Signed-off-by: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
---
 .../devicetree/bindings/crypto/mv_cesa.txt         |   18 ++++++++++++
 drivers/crypto/mv_cesa.c                           |   31 +++++++++++++++++---
 2 files changed, 45 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/crypto/mv_cesa.txt

diff --git a/Documentation/devicetree/bindings/crypto/mv_cesa.txt b/Documentation/devicetree/bindings/crypto/mv_cesa.txt
new file mode 100644
index 0000000..f191122
--- /dev/null
+++ b/Documentation/devicetree/bindings/crypto/mv_cesa.txt
@@ -0,0 +1,18 @@
+Marvell Cryptographic Engines And Security Accelerator
+
+Required properties:
+- compatible : should be "mrvl,orion-crypto"
+- reg : base physical address of the engine and length of memory mapped
+        region, followed by base physical address of sram and its memory
+               length
+- interrupts : interrupt number
+
+Examples:
+
+crypto@f1030000 {
+       compatible = "mrvl,orion-crypto";
+       reg = <0xf1030000 0x10000
+              0xf5000000 0x800>;    /* sram */
+       interrupts = <22>;
+};
+
diff --git a/drivers/crypto/mv_cesa.c b/drivers/crypto/mv_cesa.c
index 1cc6b3f..964c4c5 100644
--- a/drivers/crypto/mv_cesa.c
+++ b/drivers/crypto/mv_cesa.c
@@ -19,6 +19,9 @@
 #include <linux/clk.h>
 #include <crypto/internal/hash.h>
 #include <crypto/sha.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/of_irq.h>
 
 #include "mv_cesa.h"
 
@@ -1005,7 +1008,11 @@ static int mv_probe(struct platform_device *pdev)
 		return -EEXIST;
 	}
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "regs");
+	if (pdev->dev.of_node)
+		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
+						   "regs");
+	else
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res)
 		return -ENXIO;
 
@@ -1021,7 +1028,11 @@ static int mv_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "sram");
+	if (pdev->dev.of_node)
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	else
+		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
+						   "sram");
 	if (!res) {
 		ret = -ENXIO;
 		goto err_unmap_reg;
@@ -1034,7 +1045,10 @@ static int mv_probe(struct platform_device *pdev)
 		goto err_unmap_reg;
 	}
 
-	irq = platform_get_irq(pdev, 0);
+	if (pdev->dev.of_node)
+		irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
+	else
+		irq = platform_get_irq(pdev, 0);
 	if (irq < 0 || irq == NO_IRQ) {
 		ret = irq;
 		goto err_unmap_sram;
@@ -1137,12 +1151,21 @@ static int mv_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id mv_cesa_of_match_table[] __devinitdata = {
+	{ .compatible = "marvell,orion-crypto", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, mv_cesa_of_match_table);
+#endif
+
 static struct platform_driver marvell_crypto = {
 	.probe		= mv_probe,
-	.remove		= mv_remove,
+	.remove		= __devexit_p(mv_remove),
 	.driver		= {
 		.owner	= THIS_MODULE,
 		.name	= "mv_crypto",
+		.of_match_table = of_match_ptr(mv_cesa_of_match_table),
 	},
 };
 MODULE_ALIAS("platform:mv_crypto");
-- 
1.7.10


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/

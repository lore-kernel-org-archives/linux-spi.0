From: Youngmin Nam <ym0914-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi: s3c64xx: Get fifosize via device tree
Date: Wed, 10 Feb 2016 00:26:25 +0900
Message-ID: <1455031585-11113-1-git-send-email-ym0914@gmail.com>
Cc: linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Youngmin Nam <ym0914-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

SPI driver on some SoCs only differ in the fifosize of each
SPI channel. It is useless to duplicate the s3c64xx_spi_port_config structure
or create a compatible name for such a change.

We can get fifosize via the device tree nodes (not mandatory).
Also the device tree binding document was updated.

Signed-off-by: Youngmin Nam <ym0914-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 Documentation/devicetree/bindings/spi/spi-samsung.txt |  6 ++++++
 drivers/spi/spi-s3c64xx.c                             | 13 +++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-samsung.txt b/Documentation/devicetree/bindings/spi/spi-samsung.txt
index 6dbdeb3..5c4a08d 100644
--- a/Documentation/devicetree/bindings/spi/spi-samsung.txt
+++ b/Documentation/devicetree/bindings/spi/spi-samsung.txt
@@ -23,6 +23,11 @@ Required SoC Specific Properties:
 - dma-names: Names for the dma channels. There must be at least one channel
   named "tx" for transmit and named "rx" for receive.
 
+Optional SoC Specific properties:
+
+- samsung,spi-fifosize: The fifo size supported by the SPI channel
+
+
 Required Board Specific Properties:
 
 - #address-cells: should be 1.
@@ -73,6 +78,7 @@ Example:
 		dma-names = "tx", "rx";
 		#address-cells = <1>;
 		#size-cells = <0>;
+		samsung,spi-fifosize = <64>;
 	};
 
 - Board Specific Portion:
diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 5a76a50..44f1aeb 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1032,6 +1032,7 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 	struct spi_master *master;
 	int ret, irq;
 	char clk_name[16];
+	int fifosize;
 
 	if (!sci && pdev->dev.of_node) {
 		sci = s3c64xx_spi_parse_dt(&pdev->dev);
@@ -1083,6 +1084,18 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 		sdd->port_id = pdev->id;
 	}
 
+	if (pdev->dev.of_node) {
+		if (of_property_read_u32(pdev->dev.of_node,
+			"samsung,spi-fifosize", &fifosize)) {
+		} else {
+			sdd->port_conf->fifo_lvl_mask[sdd->port_id] =
+							(fifosize << 1) - 1;
+			dev_info(&pdev->dev, "PORT %d fifo_lvl_mask = 0x%x\n",
+				sdd->port_id,
+				sdd->port_conf->fifo_lvl_mask[sdd->port_id]);
+		}
+	}
+
 	sdd->cur_bpw = 8;
 
 	if (!sdd->pdev->dev.of_node && (!sci->dma_tx || !sci->dma_rx)) {
-- 
2.7.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

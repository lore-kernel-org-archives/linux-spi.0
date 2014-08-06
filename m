From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 08/12] [v2] spi: sh-msiof: Add DT support to DMA setup
Date: Wed,  6 Aug 2014 14:59:05 +0200
Message-ID: <1407329949-5695-9-git-send-email-geert+renesas@glider.be>
References: <1407329949-5695-1-git-send-email-geert+renesas@glider.be>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	linux-spi@vger.kernel.org, linux-sh@vger.kernel.org,
	dmaengine@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	devicetree@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Simon Horman <horms@verge.net.au>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1407329949-5695-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: devicetree@vger.kernel.org
---
v2:
  - Update DMA specifiers to match the renesas,rcar-dmac bindings
---
 Documentation/devicetree/bindings/spi/sh-msiof.txt | 17 ++++++++++++---
 drivers/spi/spi-sh-msiof.c                         | 25 ++++++++++++++++------
 2 files changed, 32 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/sh-msiof.txt b/Documentation/devicetree/bindings/spi/sh-msiof.txt
index f24baf3b6cc1..98e07f1c3dab 100644
--- a/Documentation/devicetree/bindings/spi/sh-msiof.txt
+++ b/Documentation/devicetree/bindings/spi/sh-msiof.txt
@@ -6,8 +6,13 @@ Required properties:
 			 "renesas,sh-mobile-msiof" for SH Mobile series.
 			 Examples with soctypes are:
 			 "renesas,msiof-r8a7790" (R-Car H2)
-			 "renesas,msiof-r8a7791" (R-Car M2)
-- reg                  : Offset and length of the register set for the device
+- reg                  : A list of offsets and lengths of the register sets for
+			 the device.
+			 If only one register set is present, it is to be used
+			 by both the CPU and the DMA engine.
+			 If two register sets are present, the first is to be
+			 used by the CPU, and the second is to be used by the
+			 DMA engine.
 - interrupt-parent     : The phandle for the interrupt controller that
 			 services interrupts for this device
 - interrupts           : Interrupt specifier
@@ -17,6 +22,10 @@ Required properties:
 Optional properties:
 - clocks               : Must contain a reference to the functional clock.
 - num-cs               : Total number of chip-selects (default is 1)
+- dmas                 : Must contain a list of two references to DMA
+			 specifiers, one for transmission, and one for
+			 reception.
+- dma-names            : Must contain a list of two DMA names, "tx" and "rx".
 
 Optional properties, deprecated for soctype-specific bindings:
 - renesas,tx-fifo-size : Overrides the default tx fifo size given in words
@@ -31,9 +40,11 @@ Example:
 
 	msiof0: spi@e6e20000 {
 		compatible = "renesas,msiof-r8a7791";
-		reg = <0 0xe6e20000 0 0x0064>;
+		reg = <0 0xe6e20000 0 0x0064>, <0 0xe7e20000 0 0x0064>;
 		interrupts = <0 156 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7791_CLK_MSIOF0>;
+		dmas = <&dmac0 0x51>, <&dmac0 0x52>;
+		dma-names = "tx", "rx";
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "disabled";
diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index b19cbb4cb4a0..811a42dba92a 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -977,10 +977,11 @@ static struct dma_chan *sh_msiof_request_dma_chan(struct device *dev,
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
 
-	chan = dma_request_channel(mask, shdma_chan_filter,
-				  (void *)(unsigned long)id);
+	chan = dma_request_slave_channel_compat(mask, shdma_chan_filter,
+				(void *)(unsigned long)id, dev,
+				dir == DMA_MEM_TO_DEV ? "tx" : "rx");
 	if (!chan) {
-		dev_warn(dev, "dma_request_channel failed\n");
+		dev_warn(dev, "dma_request_slave_channel_compat failed\n");
 		return NULL;
 	}
 
@@ -1010,12 +1011,22 @@ static int sh_msiof_request_dma(struct sh_msiof_spi_priv *p)
 	struct platform_device *pdev = p->pdev;
 	struct device *dev = &pdev->dev;
 	const struct sh_msiof_spi_info *info = dev_get_platdata(dev);
+	unsigned int dma_tx_id, dma_rx_id;
 	const struct resource *res;
 	struct spi_master *master;
 	struct device *tx_dev, *rx_dev;
 
-	if (!info || !info->dma_tx_id || !info->dma_rx_id)
-		return 0;	/* The driver assumes no error */
+	if (dev->of_node) {
+		/* In the OF case we will get the slave IDs from the DT */
+		dma_tx_id = 0;
+		dma_rx_id = 0;
+	} else if (info && info->dma_tx_id && info->dma_rx_id) {
+		dma_tx_id = info->dma_tx_id;
+		dma_rx_id = info->dma_rx_id;
+	} else {
+		/* The driver assumes no error */
+		return 0;
+	}
 
 	/* The DMA engine uses the second register set, if present */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
@@ -1024,13 +1035,13 @@ static int sh_msiof_request_dma(struct sh_msiof_spi_priv *p)
 
 	master = p->master;
 	master->dma_tx = sh_msiof_request_dma_chan(dev, DMA_MEM_TO_DEV,
-						   info->dma_tx_id,
+						   dma_tx_id,
 						   res->start + TFDR);
 	if (!master->dma_tx)
 		return -ENODEV;
 
 	master->dma_rx = sh_msiof_request_dma_chan(dev, DMA_DEV_TO_MEM,
-						   info->dma_rx_id,
+						   dma_rx_id,
 						   res->start + RFDR);
 	if (!master->dma_rx)
 		goto free_tx_chan;
-- 
1.9.1


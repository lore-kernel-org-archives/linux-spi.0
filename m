From: Jiada Wang <jiada_wang@mentor.com>
Subject: [PATCH 1/1] spi: imx: support to set watermark level via DTS
Date: Thu, 5 Jan 2017 15:10:15 +0900
Message-ID: <20170105061015.7816-1-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jiada_wang@mentor.com>
To: <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Previously watermark level is configured to fifosize/2,
DMA mode can be used only when transfer length can be divided
by 'watermark level * bpw', which makes DMA mode not practical.

This patch adds new DTS property 'dma-wml', user can configure
DMA watermark level, by specify 'dma-wml' in corresponding ecspi
node.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt |  2 ++
 drivers/spi/spi-imx.c                                  | 12 ++++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt b/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
index 8bc95e2..1e9345f 100644
--- a/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
+++ b/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
@@ -19,6 +19,7 @@ See the clock consumer binding,
 - dmas: DMA specifiers for tx and rx dma. See the DMA client binding,
 		Documentation/devicetree/bindings/dma/dma.txt
 - dma-names: DMA request names should include "tx" and "rx" if present.
+- dma-wml: Specifies DMA watermark level
 
 Obsolete properties:
 - fsl,spi-num-chipselects : Contains the number of the chipselect
@@ -35,4 +36,5 @@ ecspi@70010000 {
 		   <&gpio3 25 0>; /* GPIO3_25 */
 	dmas = <&sdma 3 7 1>, <&sdma 4 7 2>;
 	dma-names = "rx", "tx";
+        dma-wml = <16>;
 };
diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index deb782f..5c0ce19 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -929,8 +929,6 @@ static int spi_imx_sdma_init(struct device *dev, struct spi_imx_data *spi_imx,
 	if (of_machine_is_compatible("fsl,imx6dl"))
 		return 0;
 
-	spi_imx->wml = spi_imx_get_fifosize(spi_imx) / 2;
-
 	/* Prepare for TX DMA: */
 	master->dma_tx = dma_request_slave_channel_reason(dev, "tx");
 	if (IS_ERR(master->dma_tx)) {
@@ -1155,6 +1153,7 @@ static int spi_imx_probe(struct platform_device *pdev)
 	struct spi_imx_data *spi_imx;
 	struct resource *res;
 	int i, ret, irq;
+	u32 wml;
 
 	if (!np && !mxc_platform_info) {
 		dev_err(&pdev->dev, "can't get the platform data\n");
@@ -1177,6 +1176,15 @@ static int spi_imx_probe(struct platform_device *pdev)
 	spi_imx->devtype_data = of_id ? of_id->data :
 		(struct spi_imx_devtype_data *)pdev->id_entry->driver_data;
 
+	if (of_property_read_u32(np, "dma-wml", &wml) == 0) {
+		if (wml > spi_imx_get_fifosize(spi_imx) || wml == 0) {
+			dev_warn(&pdev->dev, "mis-configured dma-wml\n");
+			spi_imx->wml = spi_imx_get_fifosize(spi_imx) / 2;
+		} else
+			spi_imx->wml = wml;
+	} else
+		spi_imx->wml = spi_imx_get_fifosize(spi_imx) / 2;
+
 	if (mxc_platform_info) {
 		master->num_chipselect = mxc_platform_info->num_chipselect;
 		master->cs_gpios = devm_kzalloc(&master->dev,
-- 
2.9.3

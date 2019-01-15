From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH 3/4] dt-bindings: spi: Add the DMA properties for the SPI dma mode
Date: Tue, 15 Jan 2019 21:46:52 +0800
Message-ID: <7538d5806003b8f67e7e0d35638315974b7c2b50.1547559542.git.baolin.wang@linaro.org>
References: <ab49bb74e921474aa9390f81cdf65f32c3d9d898.1547559542.git.baolin.wang@linaro.org>
Cc: orsonzhai@gmail.com, zhang.lyra@gmail.com, lanqing.liu@unisoc.com,
        baolin.wang@linaro.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To: broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ab49bb74e921474aa9390f81cdf65f32c3d9d898.1547559542.git.baolin.wang@linaro.org>
In-Reply-To: <ab49bb74e921474aa9390f81cdf65f32c3d9d898.1547559542.git.baolin.wang@linaro.org>
References: <ab49bb74e921474aa9390f81cdf65f32c3d9d898.1547559542.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Lanqing Liu <lanqing.liu@spreadtrum.com>

Add the DMA properties for the SPI dma mode.

Signed-off-by: Lanqing Liu <lanqing.liu@spreadtrum.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 Documentation/devicetree/bindings/spi/spi-sprd.txt |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-sprd.txt b/Documentation/devicetree/bindings/spi/spi-sprd.txt
index bad211a..01ef53f 100644
--- a/Documentation/devicetree/bindings/spi/spi-sprd.txt
+++ b/Documentation/devicetree/bindings/spi/spi-sprd.txt
@@ -14,6 +14,12 @@ Required properties:
 	address on the SPI bus. Should be set to 1.
 - #size-cells: Should be set to 0.
 
+Optional properties:
+dma-names: Should contain names of the SPI used DMA channel.
+dmas: Should contain DMA channels which the SPI used sorted in the
+	same order as the dma-names property.
+sprd,dma-slave-ids: Should contain the DMA number that the SPI hardware required.
+
 Example:
 spi0: spi@70a00000{
 	compatible = "sprd,sc9860-spi";
@@ -21,6 +27,9 @@ spi0: spi@70a00000{
 	interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
 	clock-names = "spi", "source","enable";
 	clocks = <&clk_spi0>, <&ext_26m>, <&clk_ap_apb_gates 5>;
+	dma-names = "rx_chn", "tx_chn";
+	dmas = <&apdma 11>, <&apdma 12>;
+	sprd,dma-slave-ids = <11 12>;
 	#address-cells = <1>;
 	#size-cells = <0>;
 };
-- 
1.7.9.5

From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH v2 2/3] dt-bindings: spi: Add Spreadtrum SPI controller documentation
Date: Thu, 16 Aug 2018 20:54:50 +0800
Message-ID: <53e9467b4b16911576bcfb71c50c108ea83a803c.1534423916.git.baolin.wang@linaro.org>
References: <a77a6bb8b3abf1c127014c78f71533c24afacd93.1534423916.git.baolin.wang@linaro.org>
Cc: orsonzhai@gmail.com, zhang.lyra@gmail.com,
        lanqing.liu@spreadtrum.com, baolin.wang@linaro.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
To: broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a77a6bb8b3abf1c127014c78f71533c24afacd93.1534423916.git.baolin.wang@linaro.org>
In-Reply-To: <a77a6bb8b3abf1c127014c78f71533c24afacd93.1534423916.git.baolin.wang@linaro.org>
References: <a77a6bb8b3abf1c127014c78f71533c24afacd93.1534423916.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Lanqing Liu <lanqing.liu@spreadtrum.com>

This patch adds the binding documentation for Spreadtrum SPI
controller device.

Signed-off-by: Lanqing Liu <lanqing.liu@spreadtrum.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
Changes from v1:
 - Remove the sprd,spi-interval property.
---
 Documentation/devicetree/bindings/spi/spi-sprd.txt |   26 ++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-sprd.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-sprd.txt b/Documentation/devicetree/bindings/spi/spi-sprd.txt
new file mode 100644
index 0000000..bad211a
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-sprd.txt
@@ -0,0 +1,26 @@
+Spreadtrum SPI Controller
+
+Required properties:
+- compatible: Should be "sprd,sc9860-spi".
+- reg: Offset and length of SPI controller register space.
+- interrupts: Should contain SPI interrupt.
+- clock-names: Should contain following entries:
+	"spi" for SPI clock,
+	"source" for SPI source (parent) clock,
+	"enable" for SPI module enable clock.
+- clocks: List of clock input name strings sorted in the same order
+	as the clock-names property.
+- #address-cells: The number of cells required to define a chip select
+	address on the SPI bus. Should be set to 1.
+- #size-cells: Should be set to 0.
+
+Example:
+spi0: spi@70a00000{
+	compatible = "sprd,sc9860-spi";
+	reg = <0 0x70a00000 0 0x1000>;
+	interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+	clock-names = "spi", "source","enable";
+	clocks = <&clk_spi0>, <&ext_26m>, <&clk_ap_apb_gates 5>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+};
-- 
1.7.9.5

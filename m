From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: Add Spreadtrum SPI controller documentation" to the spi tree
Date: Tue, 28 Aug 2018 21:57:35 +0100 (BST)
Message-ID: <20180828205735.3411A44009A@finisterre.ee.mobilebroadband>
Cc: Baolin Wang <baolin.wang@linaro.org>,
        Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, orsonzhai@gmail.com,
        zhang.lyra@gmail.com, lanqing.liu@spreadtrum.com,
        baolin.wang@linaro.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
To: Lanqing Liu <lanqing.liu@spreadtrum.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: 
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: Add Spreadtrum SPI controller documentation

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 862cf93e4b9ba17f6375dc68c1e01da3210d5310 Mon Sep 17 00:00:00 2001
From: Lanqing Liu <lanqing.liu@spreadtrum.com>
Date: Thu, 16 Aug 2018 20:54:50 +0800
Subject: [PATCH] spi: Add Spreadtrum SPI controller documentation

This patch adds the binding documentation for Spreadtrum SPI
controller device.

Signed-off-by: Lanqing Liu <lanqing.liu@spreadtrum.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/spi/spi-sprd.txt      | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-sprd.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-sprd.txt b/Documentation/devicetree/bindings/spi/spi-sprd.txt
new file mode 100644
index 000000000000..bad211a19da4
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
2.18.0

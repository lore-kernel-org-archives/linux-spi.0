From: Mark Brown <broonie@kernel.org>
Subject: Applied "dt-bindings: spi: Add the DMA properties for the SPI dma mode" to the spi tree
Date: Wed, 13 Feb 2019 12:31:54 +0000 (GMT)
Message-ID: <20190213123154.6E51D1128159@debutante.sirena.org.uk>
References: <2be9d6de92507e5886433fb2cd55117c63b63d72.1550043082.git.baolin.wang@linaro.org>
Cc: Baolin Wang <baolin.wang@linaro.org>,
        Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, orsonzhai@gmail.com,
        zhang.lyra@gmail.com, lanqing.liu@unisoc.com,
        baolin.wang@linaro.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
To: Lanqing Liu <lanqing.liu@unisoc.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2be9d6de92507e5886433fb2cd55117c63b63d72.1550043082.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   dt-bindings: spi: Add the DMA properties for the SPI dma mode

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

>From 6dcb144f7da634e4a0f8837e5076ef48e4d6ac12 Mon Sep 17 00:00:00 2001
From: Lanqing Liu <lanqing.liu@unisoc.com>
Date: Wed, 13 Feb 2019 15:36:10 +0800
Subject: [PATCH] dt-bindings: spi: Add the DMA properties for the SPI dma mode

Add the DMA properties for the SPI dma mode.

Signed-off-by: Lanqing Liu <lanqing.liu@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/spi/spi-sprd.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-sprd.txt b/Documentation/devicetree/bindings/spi/spi-sprd.txt
index bad211a19da4..3c7eacce0ee3 100644
--- a/Documentation/devicetree/bindings/spi/spi-sprd.txt
+++ b/Documentation/devicetree/bindings/spi/spi-sprd.txt
@@ -14,6 +14,11 @@ Required properties:
 	address on the SPI bus. Should be set to 1.
 - #size-cells: Should be set to 0.
 
+Optional properties:
+dma-names: Should contain names of the SPI used DMA channel.
+dmas: Should contain DMA channels and DMA slave ids which the SPI used
+	sorted in the same order as the dma-names property.
+
 Example:
 spi0: spi@70a00000{
 	compatible = "sprd,sc9860-spi";
@@ -21,6 +26,8 @@ spi0: spi@70a00000{
 	interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
 	clock-names = "spi", "source","enable";
 	clocks = <&clk_spi0>, <&ext_26m>, <&clk_ap_apb_gates 5>;
+	dma-names = "rx_chn", "tx_chn";
+	dmas = <&apdma 11 11>, <&apdma 12 12>;
 	#address-cells = <1>;
 	#size-cells = <0>;
 };
-- 
2.20.1

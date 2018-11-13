From: Mark Brown <broonie@kernel.org>
Subject: Applied "dt-binding: spi: add NPCM PSPI controller documentation" to the spi tree
Date: Tue, 13 Nov 2018 20:02:55 +0000 (GMT)
Message-ID: <20181113200255.3B117440079@finisterre.ee.mobilebroadband>
References: <20181112164232.435629-2-tmaimon77@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, yuenn@google.com,
        venture@google.com, brendanhiggins@google.com,
        avifishman70@gmail.com, joel@jms.id.au, linux-spi@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org
To: Tomer Maimon <tmaimon77@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181112164232.435629-2-tmaimon77@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   dt-binding: spi: add NPCM PSPI controller documentation

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

>From 4ad26864df53b265976c4a3ae61b1e6cad92fe40 Mon Sep 17 00:00:00 2001
From: Tomer Maimon <tmaimon77@gmail.com>
Date: Mon, 12 Nov 2018 18:42:31 +0200
Subject: [PATCH] dt-binding: spi: add NPCM PSPI controller documentation

Added device tree binding documentation for Nuvoton BMC
NPCM Peripheral SPI controller.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/spi/nuvoton,npcm-pspi.txt        | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/nuvoton,npcm-pspi.txt

diff --git a/Documentation/devicetree/bindings/spi/nuvoton,npcm-pspi.txt b/Documentation/devicetree/bindings/spi/nuvoton,npcm-pspi.txt
new file mode 100644
index 000000000000..99606b22e5c2
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/nuvoton,npcm-pspi.txt
@@ -0,0 +1,35 @@
+Nuvoton NPCM Peripheral Serial Peripheral Interface(PSPI) controller driver
+
+Nuvoton NPCM7xx SOC support two PSPI channels.
+
+Required properties:
+ - compatible : "nuvoton,npcm750-pspi" for NPCM7XX BMC
+ - #address-cells : should be 1. see spi-bus.txt
+ - #size-cells : should be 0. see spi-bus.txt
+ - specifies physical base address and size of the register.
+ - interrupts : contain PSPI interrupt.
+ - clocks : phandle of PSPI reference clock.
+ - clock-names: Should be "clk_apb5".
+ - pinctrl-names : a pinctrl state named "default" must be defined.
+ - pinctrl-0 : phandle referencing pin configuration of the device.
+ - cs-gpios: Specifies the gpio pins to be used for chipselects.
+            See: Documentation/devicetree/bindings/spi/spi-bus.txt
+
+Optional properties:
+- clock-frequency : Input clock frequency to the PSPI block in Hz.
+		    Default is 25000000 Hz.
+
+Example:
+
+spi0: spi@f0200000 {
+	compatible = "nuvoton,npcm750-pspi";
+	reg = <0xf0200000 0x1000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pspi1_pins>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+	clocks = <&clk NPCM7XX_CLK_APB5>;
+	clock-names = "clk_apb5";
+	cs-gpios = <&gpio6 11 GPIO_ACTIVE_LOW>;
+};
-- 
2.19.1

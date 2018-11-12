From: Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v1 1/2] dt-binding: spi: add NPCM PSPI controller documentation
Date: Mon, 12 Nov 2018 18:42:31 +0200
Message-ID: <20181112164232.435629-2-tmaimon77@gmail.com>
References: <20181112164232.435629-1-tmaimon77@gmail.com>
Cc: linux-spi@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tomer Maimon <tmaimon77@gmail.com>
To: broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        yuenn@google.com, venture@google.com, brendanhiggins@google.com,
        avifishman70@gmail.com, joel@jms.id.au
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181112164232.435629-1-tmaimon77@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Added device tree binding documentation for Nuvoton BMC
NPCM Peripheral SPI controller.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 .../devicetree/bindings/spi/nuvoton,npcm-pspi.txt  | 35 ++++++++++++++++++++++
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
2.14.1

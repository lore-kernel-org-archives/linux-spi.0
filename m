From: Purna Chandra Mandal <purna.mandal@microchip.com>
Subject: [PATCH v5 1/2] dt/bindings: Add bindings for PIC32 SPI peripheral
Date: Fri, 1 Apr 2016 16:48:49 +0530
Message-ID: <1459509530-22716-1-git-send-email-purna.mandal@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Mark Brown <broonie@kernel.org>,
	Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
	Joshua Henderson <digitalpeer@digitalpeer.com>,
	Purna Chandra Mandal <purna.mandal@microchip.com>,
	<devicetree@vger.kernel.org>, <linux-mips@linux-mips.org>,
	Kumar Gala <galak@codeaurora.org>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>
To: <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Document the devicetree bindings for the SPI peripheral found
on Microchip PIC32 class devices.

Signed-off-by: Purna Chandra Mandal <purna.mandal@microchip.com>
Acked-by: Rob Herring <robh@kernel.org>

---

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2:
 - fix indentation
 - add space after comma
 - moved 'cs-gpios' section under 'required' properties.

 .../bindings/spi/microchip,spi-pic32.txt           | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/microchip,spi-pic32.txt

diff --git a/Documentation/devicetree/bindings/spi/microchip,spi-pic32.txt b/Documentation/devicetree/bindings/spi/microchip,spi-pic32.txt
new file mode 100644
index 0000000..79de379f
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/microchip,spi-pic32.txt
@@ -0,0 +1,34 @@
+Microchip PIC32 SPI Master controller
+
+Required properties:
+- compatible: Should be "microchip,pic32mzda-spi".
+- reg: Address and length of register space for the device.
+- interrupts: Should contain all three spi interrupts in sequence
+              of <fault-irq>, <receive-irq>, <transmit-irq>.
+- interrupt-names: Should be "fault", "rx", "tx" in order.
+- clocks: Phandle of the clock generating SPI clock on the bus.
+- clock-names: Should be "mck0".
+- cs-gpios: Specifies the gpio pins to be used for chipselects.
+            See: Documentation/devicetree/bindings/spi/spi-bus.txt
+
+Optional properties:
+- dmas: Two or more DMA channel specifiers following the convention outlined
+        in Documentation/devicetree/bindings/dma/dma.txt
+- dma-names: Names for the dma channels. There must be at least one channel
+             named "spi-tx" for transmit and named "spi-rx" for receive.
+
+Example:
+
+spi1: spi@1f821000 {
+        compatible = "microchip,pic32mzda-spi";
+        reg = <0x1f821000 0x200>;
+        interrupts = <109 IRQ_TYPE_LEVEL_HIGH>,
+                     <110 IRQ_TYPE_LEVEL_HIGH>,
+                     <111 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "fault", "rx", "tx";
+        clocks = <&PBCLK2>;
+        clock-names = "mck0";
+        cs-gpios = <&gpio3 4 GPIO_ACTIVE_LOW>;
+        dmas = <&dma 134>, <&dma 135>;
+        dma-names = "spi-rx", "spi-tx";
+};
-- 
1.8.3.1

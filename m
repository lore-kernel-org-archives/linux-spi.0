From: Jonathan Richardson <jonathar@broadcom.com>
Subject: [PATCH 1/2] ARM: dts: Add binding for Broadcom MSPI driver.
Date: Tue, 12 May 2015 10:38:12 -0700
Message-ID: <1431452293-16697-2-git-send-email-jonathar@broadcom.com>
References: <1431452293-16697-1-git-send-email-jonathar@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Richardson <jonathar@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	<linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
	bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
	<devicetree@vger.kernel.org>
To: Mark Brown <broonie@kernel.org>, Dmitry Torokhov <dtor@google.com>,
	Anatol Pomazau <anatol@google.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1431452293-16697-1-git-send-email-jonathar@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


Signed-off-by: Jonathan Richardson <jonathar@broadcom.com>
---
 .../devicetree/bindings/spi/brcm,mspi-spi.txt      |   39 ++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/brcm,mspi-spi.txt

diff --git a/Documentation/devicetree/bindings/spi/brcm,mspi-spi.txt b/Documentation/devicetree/bindings/spi/brcm,mspi-spi.txt
new file mode 100644
index 0000000..e86a7a0
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/brcm,mspi-spi.txt
@@ -0,0 +1,39 @@
+Broadcom MSPI controller
+
+The Broadcom MSPI controller is a SPI controller found on various chips such
+as Cygnus.
+
+Required properties:
+- compatible: Must be "brcm,mspi-v0".
+
+- reg:  The first register is the physical base address of the MSPI controller.
+  The second register is the address of the MSPI interrupt control registers. It
+  is only required for chips that have a separate register set for extended
+  interrupt control. This is required for Cygnus.
+
+- interrupts: Interrupt ID of the controller.
+
+Optional properties:
+- clocks: The MSPI reference clock. If not provided then it is assumed a clock
+  is enabled by default and no control of clock-frequency (see below) is
+  possible.
+
+- clock-names: The name of the reference clock.
+
+- clock-frequency: Desired frequency of the clock. This will set the serial
+  clock baud rate (SPBR) based on the reference clock frequency. The frequency
+  of the SPBR is mspi_clk / (2 * SPBR) where SPBR is a value between 1-255
+  determined by the desired 'clock-frequency'. If not provided then the default
+  baud rate of the controller is used.
+
+Example:
+
+mspi: mspi@18047200 {
+	compatible = "brcm,mspi-v0";
+	reg = <0x18047200 0x188>,
+	      <0x180473a0 0x1c>;
+	interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
+	clocks = <&axi41_clk>;
+	clock-names = "mspi_clk";
+	clock-frequency = <12500000>;
+};
-- 
1.7.9.5

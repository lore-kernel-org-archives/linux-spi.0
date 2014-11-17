From: Beniamino Galvani <b.galvani@gmail.com>
Subject: [PATCH v2 2/4] spi: meson: Add device tree bindings documentation for SPIFC
Date: Mon, 17 Nov 2014 23:47:49 +0100
Message-ID: <1416264471-774-3-git-send-email-b.galvani@gmail.com>
References: <1416264471-774-1-git-send-email-b.galvani@gmail.com>
Cc: linux-spi@vger.kernel.org, Carlo Caione <carlo@caione.org>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, Russell King <linux@arm.linux.org.uk>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Jerry Cao <jerry.cao@amlogic.com>,
	Victor Wan <victor.wan@amlogic.com>,
	Beniamino Galvani <b.galvani@gmail.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1416264471-774-1-git-send-email-b.galvani@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This adds documentation of device tree bindings for the Amlogic Meson
SPIFC (SPI Flash Controller).

Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
---
 .../devicetree/bindings/spi/spi-meson.txt          | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-meson.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-meson.txt b/Documentation/devicetree/bindings/spi/spi-meson.txt
new file mode 100644
index 0000000..bb52a86
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-meson.txt
@@ -0,0 +1,22 @@
+Amlogic Meson SPI controllers
+
+* SPIFC (SPI Flash Controller)
+
+The Meson SPIFC is a controller optimized for communication with SPI
+NOR memories, without DMA support and a 64-byte unified transmit /
+receive buffer.
+
+Required properties:
+ - compatible: should be "amlogic,meson6-spifc"
+ - reg: physical base address and length of the controller registers
+ - clocks: phandle of the input clock for the baud rate generator
+ - #address-cells: should be 1
+ - #size-cells: should be 0
+
+	spi@c1108c80 {
+		compatible = "amlogic,meson6-spifc";
+		reg = <0xc1108c80 0x80>;
+		clocks = <&clk81>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
-- 
1.9.1

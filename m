From: Joel Holdsworth <joel@airwebreathe.org.uk>
Subject: [PATCH v9 2/3] Documentation: Add binding document for Lattice iCE40 FPGA manager
Date: Thu,  8 Dec 2016 22:35:48 -0700
Message-ID: <1481261749-15301-2-git-send-email-joel@airwebreathe.org.uk>
References: <1481261749-15301-1-git-send-email-joel@airwebreathe.org.uk>
Cc: Joel Holdsworth <joel@airwebreathe.org.uk>
To: atull@opensource.altera.com, moritz.fischer@ettus.com,
        robh@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        marex@denx.de
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1481261749-15301-1-git-send-email-joel@airwebreathe.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This adds documentation of the device tree bindings of the Lattice iCE40
FPGA driver for the FPGA manager framework.

Signed-off-by: Joel Holdsworth <joel@airwebreathe.org.uk>
Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Alan Tull <atull@opensource.altera.com>
Acked-by: Moritz Fischer <moritz.fischer@ettus.com>
Acked-by: Marek Vasut <marex@denx.de>
---
 .../bindings/fpga/lattice-ice40-fpga-mgr.txt        | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/lattice-ice40-fpga-mgr.txt

diff --git a/Documentation/devicetree/bindings/fpga/lattice-ice40-fpga-mgr.txt b/Documentation/devicetree/bindings/fpga/lattice-ice40-fpga-mgr.txt
new file mode 100644
index 0000000..7e7a78b
--- /dev/null
+++ b/Documentation/devicetree/bindings/fpga/lattice-ice40-fpga-mgr.txt
@@ -0,0 +1,21 @@
+Lattice iCE40 FPGA Manager
+
+Required properties:
+- compatible:		Should contain "lattice,ice40-fpga-mgr"
+- reg:			SPI chip select
+- spi-max-frequency:	Maximum SPI frequency (>=1000000, <=25000000)
+- cdone-gpios:		GPIO input connected to CDONE pin
+- reset-gpios:		Active-low GPIO output connected to CRESET_B pin. Note
+			that unless the GPIO is held low during startup, the
+			FPGA will enter Master SPI mode and drive SCK with a
+			clock signal potentially jamming other devices on the
+			bus until the firmware is loaded.
+
+Example:
+	ice40: ice40@0 {
+		compatible = "lattice,ice40-fpga-mgr";
+		reg = <0>;
+		spi-max-frequency = <1000000>;
+		cdone-gpios = <&gpio 24 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&gpio 22 GPIO_ACTIVE_LOW>;
+	};
-- 
2.7.4

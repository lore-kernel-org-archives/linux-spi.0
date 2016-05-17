From: Rich Felker <dalias@libc.org>
Subject: [PATCH v5 1/2] of: add J-Core SPI master bindings
Date: Tue, 17 May 2016 23:19:25 +0000
Message-ID: <bc53c38fe100bd17b278dfb214eefea323a3ac4a.1470187592.git.dalias@libc.org>
References: <cover.1470187592.git.dalias@libc.org>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
To: linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <cover.1470187592.git.dalias@libc.org>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Signed-off-by: Rich Felker <dalias@libc.org>
---
 .../devicetree/bindings/spi/jcore,spi.txt          | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/jcore,spi.txt

diff --git a/Documentation/devicetree/bindings/spi/jcore,spi.txt b/Documentation/devicetree/bindings/spi/jcore,spi.txt
new file mode 100644
index 0000000..93936d1
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/jcore,spi.txt
@@ -0,0 +1,34 @@
+J-Core SPI master
+
+Required properties:
+
+- compatible: Must be "jcore,spi2".
+
+- reg: Memory region for registers.
+
+- #address-cells: Must be 1.
+
+- #size-cells: Must be 0.
+
+Optional properties:
+
+- clocks: If a phandle named "ref_clk" is present, SPI clock speed
+  programming is relative to the frequency of the indicated clock.
+  Necessary only if the input clock rate is something other than a
+  fixed 50 MHz.
+
+- clock-names: Clock names, one for each phandle in clocks.
+
+See spi-bus.txt for additional properties not specific to this device.
+
+Example:
+
+spi@40 {
+	compatible = "jcore,spi2";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	reg = <0x40 0x8>;
+	spi-max-frequency = <25000000>;
+	clocks = <&bus_clk>;
+	clock-names = "ref_clk";
+}
-- 
2.8.1



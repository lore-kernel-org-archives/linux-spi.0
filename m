From: Rich Felker <dalias@libc.org>
Subject: [PATCH v4 1/2] of: add J-Core SPI master bindings
Date: Tue, 17 May 2016 23:19:25 +0000
Message-ID: <9813bf559ad89ca6fecc438d9176d634bbc122a0.1469686300.git.dalias@libc.org>
References: <cover.1469686300.git.dalias@libc.org>
Cc: Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mark Brown <broonie@kernel.org>
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-sh@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1469686300.git.dalias@libc.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Signed-off-by: Rich Felker <dalias@libc.org>
---
 .../devicetree/bindings/spi/jcore,spi.txt          | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/jcore,spi.txt

diff --git a/Documentation/devicetree/bindings/spi/jcore,spi.txt b/Documentation/devicetree/bindings/spi/jcore,spi.txt
new file mode 100644
index 0000000..815106d
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/jcore,spi.txt
@@ -0,0 +1,30 @@
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
+- clock-frequency: Specifies an input clock frequency relative to
+  which the SPI clock speed must be programmed. Necessary only if
+  the input clock rate is something other than 50 MHz.
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
+	clock-frequency = <50000000>;
+}
-- 
2.8.1

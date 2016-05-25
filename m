From: Rich Felker <dalias@libc.org>
Subject: [PATCH v3 05/12] of: add J-Core SPI master bindings
Date: Wed, 25 May 2016 05:43:03 +0000
Message-ID: <5795fc62265da8ef84d7c42eb9c3303df4444522.1464148904.git.dalias@libc.org>
References: <cover.1464148904.git.dalias@libc.org>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Rob Herring <robh+dt@kernel.org>
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-sh@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1464148904.git.dalias@libc.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Signed-off-by: Rich Felker <dalias@libc.org>
---
 .../devicetree/bindings/spi/jcore,spi.txt          | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/jcore,spi.txt

diff --git a/Documentation/devicetree/bindings/spi/jcore,spi.txt b/Documentation/devicetree/bindings/spi/jcore,spi.txt
new file mode 100644
index 0000000..7bff8c0
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/jcore,spi.txt
@@ -0,0 +1,23 @@
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
+See spi-bus.txt for additional properties not specific to this device.
+
+Example:
+
+spi@40 {
+	compatible = "jcore,spi2";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	reg = < 0x40 0x8 >;
+	spi-max-frequency = <12500000>;
+}
-- 
2.8.1

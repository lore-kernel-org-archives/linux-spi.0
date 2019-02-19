From: Yash Shah <yash.shah@sifive.com>
Subject: [PATCH 1/2] spi: sifive: Add DT documentation for SiFive SPI controller
Date: Tue, 19 Feb 2019 17:10:06 +0530
Message-ID: <1550576407-17778-2-git-send-email-yash.shah@sifive.com>
References: <1550576407-17778-1-git-send-email-yash.shah@sifive.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sachin.ghadi@sifive.com, paul.walmsley@sifive.com,
        Yash Shah <yash.shah@sifive.com>
To: palmer@sifive.com, linux-spi@vger.kernel.org,
        linux-riscv@lists.infradead.org, broonie@kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1550576407-17778-1-git-send-email-yash.shah@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

DT documentation for SPI controller added.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
Signed-off-by: Yash Shah <yash.shah@sifive.com>
---
 .../devicetree/bindings/spi/spi-sifive.txt         | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-sifive.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-sifive.txt b/Documentation/devicetree/bindings/spi/spi-sifive.txt
new file mode 100644
index 0000000..3f5c6e4
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-sifive.txt
@@ -0,0 +1,37 @@
+SiFive SPI controller Device Tree Bindings
+------------------------------------------
+
+Required properties:
+- compatible		: Should be "sifive,<chip>-spi" and "sifive,spi<version>".
+			  Supported compatible strings are:
+			  "sifive,fu540-c000-spi" for the SiFive SPI v0 as integrated
+			  onto the SiFive FU540 chip, and "sifive,spi0" for the SiFive
+			  SPI v0 IP block with no chip integration tweaks.
+			  Please refer to sifive-blocks-ip-versioning.txt for details
+- reg			: Physical base address and size of SPI registers map
+			  A second (optional) range can indicate memory mapped flash
+- interrupts		: Must contain one entry
+- interrupt-parent	: Must be core interrupt controller
+- clocks		: Must reference the frequency given to the controller
+- #address-cells	: Must be '1', indicating which CS to use
+- #size-cells		: Must be '0'
+
+Optional properties:
+- sifive,fifo-depth		: Depth of hardware queues; defaults to 8
+- sifive,max-bits-per-word	: Maximum bits per word; defaults to 8
+
+SPI RTL that corresponds to the IP block version numbers can be found here:
+https://github.com/sifive/sifive-blocks/tree/master/src/main/scala/devices/spi
+
+Example:
+	spi: spi@10040000 {
+		compatible = "sifive,fu540-c000-spi", "sifive,spi0";
+		reg = <0x0 0x10040000 0x0 0x1000 0x0 0x20000000 0x0 0x10000000>;
+		interrupt-parent = <&plic>;
+		interrupts = <51>;
+		clocks = <&tlclk>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		sifive,fifo-depth = <8>;
+		sifive,max-bits-per-word = <8>;
+	};
-- 
1.9.1

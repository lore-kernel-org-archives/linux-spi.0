From: Frieder Schrempf <frieder.schrempf@exceet.de>
Subject: [PATCH v2 04/12] dt-bindings: spi: Move the bindings for the FSL QSPI driver
Date: Thu,  5 Jul 2018 13:15:00 +0200
Message-ID: <1530789310-16254-5-git-send-email-frieder.schrempf@exceet.de>
References: <1530789310-16254-1-git-send-email-frieder.schrempf@exceet.de>
Cc: dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, richard@nod.at, miquel.raynal@bootlin.com,
        broonie@kernel.org, david.wolfe@nxp.com, fabio.estevam@nxp.com,
        prabhakar.kushwaha@nxp.com, yogeshnarayan.gaur@nxp.com,
        han.xu@nxp.com, shawnguo@kernel.org,
        Frieder Schrempf <frieder.schrempf@exceet.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To: linux-mtd@lists.infradead.org, boris.brezillon@bootlin.com,
        linux-spi@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1530789310-16254-1-git-send-email-frieder.schrempf@exceet.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Move the documentation of the old SPI NOR driver to the place of the new
SPI memory interface based driver.

Signed-off-by: Frieder Schrempf <frieder.schrempf@exceet.de>
---
Changes in v2:
==============
* Split the moving and editing of the dt-bindings in two patches

 .../devicetree/bindings/mtd/fsl-quadspi.txt     | 65 --------------------
 .../devicetree/bindings/spi/spi-fsl-qspi.txt    | 65 ++++++++++++++++++++
 2 files changed, 65 insertions(+), 65 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/fsl-quadspi.txt b/Documentation/devicetree/bindings/mtd/fsl-quadspi.txt
deleted file mode 100644
index 483e9cf..0000000
--- a/Documentation/devicetree/bindings/mtd/fsl-quadspi.txt
+++ /dev/null
@@ -1,65 +0,0 @@
-* Freescale Quad Serial Peripheral Interface(QuadSPI)
-
-Required properties:
-  - compatible : Should be "fsl,vf610-qspi", "fsl,imx6sx-qspi",
-		 "fsl,imx7d-qspi", "fsl,imx6ul-qspi",
-		 "fsl,ls1021a-qspi"
-		 or
-		 "fsl,ls2080a-qspi" followed by "fsl,ls1021a-qspi",
-		 "fsl,ls1043a-qspi" followed by "fsl,ls1021a-qspi"
-  - reg : the first contains the register location and length,
-          the second contains the memory mapping address and length
-  - reg-names: Should contain the reg names "QuadSPI" and "QuadSPI-memory"
-  - interrupts : Should contain the interrupt for the device
-  - clocks : The clocks needed by the QuadSPI controller
-  - clock-names : Should contain the name of the clocks: "qspi_en" and "qspi".
-
-Optional properties:
-  - fsl,qspi-has-second-chip: The controller has two buses, bus A and bus B.
-                              Each bus can be connected with two NOR flashes.
-			      Most of the time, each bus only has one NOR flash
-			      connected, this is the default case.
-			      But if there are two NOR flashes connected to the
-			      bus, you should enable this property.
-			      (Please check the board's schematic.)
-  - big-endian : That means the IP register is big endian
-
-Example:
-
-qspi0: quadspi@40044000 {
-	compatible = "fsl,vf610-qspi";
-	reg = <0x40044000 0x1000>, <0x20000000 0x10000000>;
-	reg-names = "QuadSPI", "QuadSPI-memory";
-	interrupts = <0 24 IRQ_TYPE_LEVEL_HIGH>;
-	clocks = <&clks VF610_CLK_QSPI0_EN>,
-		<&clks VF610_CLK_QSPI0>;
-	clock-names = "qspi_en", "qspi";
-
-	flash0: s25fl128s@0 {
-		....
-	};
-};
-
-Example showing the usage of two SPI NOR devices:
-
-&qspi2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_qspi2>;
-	status = "okay";
-
-	flash0: n25q256a@0 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "micron,n25q256a", "jedec,spi-nor";
-		spi-max-frequency = <29000000>;
-		reg = <0>;
-	};
-
-	flash1: n25q256a@1 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "micron,n25q256a", "jedec,spi-nor";
-		spi-max-frequency = <29000000>;
-		reg = <1>;
-	};
-};
diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt b/Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt
new file mode 100644
index 0000000..483e9cf
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt
@@ -0,0 +1,65 @@
+* Freescale Quad Serial Peripheral Interface(QuadSPI)
+
+Required properties:
+  - compatible : Should be "fsl,vf610-qspi", "fsl,imx6sx-qspi",
+		 "fsl,imx7d-qspi", "fsl,imx6ul-qspi",
+		 "fsl,ls1021a-qspi"
+		 or
+		 "fsl,ls2080a-qspi" followed by "fsl,ls1021a-qspi",
+		 "fsl,ls1043a-qspi" followed by "fsl,ls1021a-qspi"
+  - reg : the first contains the register location and length,
+          the second contains the memory mapping address and length
+  - reg-names: Should contain the reg names "QuadSPI" and "QuadSPI-memory"
+  - interrupts : Should contain the interrupt for the device
+  - clocks : The clocks needed by the QuadSPI controller
+  - clock-names : Should contain the name of the clocks: "qspi_en" and "qspi".
+
+Optional properties:
+  - fsl,qspi-has-second-chip: The controller has two buses, bus A and bus B.
+                              Each bus can be connected with two NOR flashes.
+			      Most of the time, each bus only has one NOR flash
+			      connected, this is the default case.
+			      But if there are two NOR flashes connected to the
+			      bus, you should enable this property.
+			      (Please check the board's schematic.)
+  - big-endian : That means the IP register is big endian
+
+Example:
+
+qspi0: quadspi@40044000 {
+	compatible = "fsl,vf610-qspi";
+	reg = <0x40044000 0x1000>, <0x20000000 0x10000000>;
+	reg-names = "QuadSPI", "QuadSPI-memory";
+	interrupts = <0 24 IRQ_TYPE_LEVEL_HIGH>;
+	clocks = <&clks VF610_CLK_QSPI0_EN>,
+		<&clks VF610_CLK_QSPI0>;
+	clock-names = "qspi_en", "qspi";
+
+	flash0: s25fl128s@0 {
+		....
+	};
+};
+
+Example showing the usage of two SPI NOR devices:
+
+&qspi2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_qspi2>;
+	status = "okay";
+
+	flash0: n25q256a@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "micron,n25q256a", "jedec,spi-nor";
+		spi-max-frequency = <29000000>;
+		reg = <0>;
+	};
+
+	flash1: n25q256a@1 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "micron,n25q256a", "jedec,spi-nor";
+		spi-max-frequency = <29000000>;
+		reg = <1>;
+	};
+};
-- 
2.7.4

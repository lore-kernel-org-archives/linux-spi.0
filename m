From: Frieder Schrempf <frieder.schrempf@exceet.de>
Subject: [PATCH v2 05/12] dt-bindings: spi: Adjust the bindings for the FSL QSPI driver
Date: Thu,  5 Jul 2018 13:15:01 +0200
Message-ID: <1530789310-16254-6-git-send-email-frieder.schrempf@exceet.de>
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

Adjust the documentation of the new SPI memory interface based
driver to reflect the new drivers settings.

Signed-off-by: Frieder Schrempf <frieder.schrempf@exceet.de>
---
Changes in v2:
==============
* Split the moving and editing of the dt-bindings in two patches

 .../devicetree/bindings/spi/spi-fsl-qspi.txt    | 22 ++++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt b/Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt
index 483e9cf..8b4eed7 100644
--- a/Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt
+++ b/Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt
@@ -3,9 +3,8 @@
 Required properties:
   - compatible : Should be "fsl,vf610-qspi", "fsl,imx6sx-qspi",
 		 "fsl,imx7d-qspi", "fsl,imx6ul-qspi",
-		 "fsl,ls1021a-qspi"
+		 "fsl,ls1021a-qspi", "fsl,ls2080a-qspi"
 		 or
-		 "fsl,ls2080a-qspi" followed by "fsl,ls1021a-qspi",
 		 "fsl,ls1043a-qspi" followed by "fsl,ls1021a-qspi"
   - reg : the first contains the register location and length,
           the second contains the memory mapping address and length
@@ -15,14 +14,15 @@ Required properties:
   - clock-names : Should contain the name of the clocks: "qspi_en" and "qspi".
 
 Optional properties:
-  - fsl,qspi-has-second-chip: The controller has two buses, bus A and bus B.
-                              Each bus can be connected with two NOR flashes.
-			      Most of the time, each bus only has one NOR flash
-			      connected, this is the default case.
-			      But if there are two NOR flashes connected to the
-			      bus, you should enable this property.
-			      (Please check the board's schematic.)
-  - big-endian : That means the IP register is big endian
+  - big-endian : That means the IP registers format is big endian
+
+Required SPI slave node properties:
+  - reg: There are two buses (A and B) with two chip selects each.
+	 This encodes to which bus and CS the flash is connected:
+		<0>: Bus A, CS 0
+		<1>: Bus A, CS 1
+		<2>: Bus B, CS 0
+		<3>: Bus B, CS 1
 
 Example:
 
@@ -40,7 +40,7 @@ qspi0: quadspi@40044000 {
 	};
 };
 
-Example showing the usage of two SPI NOR devices:
+Example showing the usage of two SPI NOR devices on bus A:
 
 &qspi2 {
 	pinctrl-names = "default";
-- 
2.7.4

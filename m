From: Frieder Schrempf <frieder.schrempf@kontron.de>
Subject: [PATCH v4 03/10] dt-bindings: spi: Adjust the bindings for the FSL QSPI driver
Date: Wed,  7 Nov 2018 15:43:20 +0100
Message-ID: <1541601809-16950-4-git-send-email-frieder.schrempf@kontron.de>
References: <1541601809-16950-1-git-send-email-frieder.schrempf@kontron.de>
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
In-Reply-To: <1541601809-16950-1-git-send-email-frieder.schrempf@kontron.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@exceet.de>

Adjust the documentation of the new SPI memory interface based
driver to reflect the new drivers settings.

The "old" driver was using the "fsl,qspi-has-second-chip" property to
select one of two dual chip setups (two chips on one bus or two chips
on separate buses). And it used the order in which the subnodes are
defined in the dt to select the CS, the chip is connected to.

Both methods are wrong and in fact the "reg" property should be used to
determine which bus and CS a chip is connected to. This also enables us
to use different setups than just single chip, or symmetric dual chip.

So the porting of the driver from the MTD to the SPI framework actually
enforces the use of the "reg" properties and makes
"fsl,qspi-has-second-chip" superfluous.

As all boards that have "fsl,qspi-has-second-chip" set, also have
correct "reg" properties, the removal of this property shouldn't lead to
any incompatibilities.

The only compatibility issues I can see are with imx6sx-sdb.dts and
imx6sx-sdb-reva.dts, which have their reg properties set incorrectly
(see explanation here: [2]), all other boards should stay compatible.

Also the "big-endian" flag was removed, as this setting is now selected
by the driver, depending on which SoC is in use.

Signed-off-by: Frieder Schrempf <frieder.schrempf@exceet.de>
---
 .../devicetree/bindings/spi/spi-fsl-qspi.txt    | 21 +++++++++-----------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt b/Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt
index 483e9cf..6d7c9ec 100644
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
@@ -14,15 +13,13 @@ Required properties:
   - clocks : The clocks needed by the QuadSPI controller
   - clock-names : Should contain the name of the clocks: "qspi_en" and "qspi".
 
-Optional properties:
-  - fsl,qspi-has-second-chip: The controller has two buses, bus A and bus B.
-                              Each bus can be connected with two NOR flashes.
-			      Most of the time, each bus only has one NOR flash
-			      connected, this is the default case.
-			      But if there are two NOR flashes connected to the
-			      bus, you should enable this property.
-			      (Please check the board's schematic.)
-  - big-endian : That means the IP register is big endian
+Required SPI slave node properties:
+  - reg: There are two buses (A and B) with two chip selects each.
+	 This encodes to which bus and CS the flash is connected:
+		<0>: Bus A, CS 0
+		<1>: Bus A, CS 1
+		<2>: Bus B, CS 0
+		<3>: Bus B, CS 1
 
 Example:
 
@@ -40,7 +37,7 @@ qspi0: quadspi@40044000 {
 	};
 };
 
-Example showing the usage of two SPI NOR devices:
+Example showing the usage of two SPI NOR devices on bus A:
 
 &qspi2 {
 	pinctrl-names = "default";
-- 
2.7.4

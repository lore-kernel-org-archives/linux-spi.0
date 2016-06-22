From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC 1/6] spi: Document DT bindings for SPI controllers in slave mode
Date: Wed, 22 Jun 2016 15:42:04 +0200
Message-ID: <1466602929-4191-2-git-send-email-geert+renesas@glider.be>
References: <1466602929-4191-1-git-send-email-geert+renesas@glider.be>
Cc: Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>,
	Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1466602929-4191-1-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/spi/spi-bus.txt | 31 ++++++++++++++---------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-bus.txt b/Documentation/devicetree/bindings/spi/spi-bus.txt
index 17822860cb98c34d..bcd024e0bb9e0009 100644
--- a/Documentation/devicetree/bindings/spi/spi-bus.txt
+++ b/Documentation/devicetree/bindings/spi/spi-bus.txt
@@ -1,17 +1,23 @@
 SPI (Serial Peripheral Interface) busses
 
-SPI busses can be described with a node for the SPI master device
-and a set of child nodes for each SPI slave on the bus.  For this
-discussion, it is assumed that the system's SPI controller is in
-SPI master mode.  This binding does not describe SPI controllers
-in slave mode.
+SPI busses can be described with a node for the SPI controller device
+and a set of child nodes for each SPI slave on the bus.  The system's SPI
+controller may be described for use in SPI master mode or in SPI slave mode,
+but not for both at the same time.
 
-The SPI master node requires the following properties:
+The SPI controller node requires the following properties:
+- compatible      - name of SPI bus controller following generic names
+		recommended practice.
+
+In master mode, the SPI controller node requires the following additional
+properties:
 - #address-cells  - number of cells required to define a chip select
 		address on the SPI bus.
 - #size-cells     - should be zero.
-- compatible      - name of SPI bus controller following generic names
-		recommended practice.
+
+In slave node, the SPI controller node requires the presence of a child node
+named "slave", further following the practices for SPI slave nodes below.
+
 No other properties are required in the SPI bus node.  It is assumed
 that a driver for an SPI bus device will understand that it is an SPI bus.
 However, the binding does not attempt to define the specific method for
@@ -21,7 +27,7 @@ assumption that board specific platform code will be used to manage
 chip selects.  Individual drivers can define additional properties to
 support describing the chip select layout.
 
-Optional properties:
+Optional properties (master mode only):
 - cs-gpios	  - gpios chip select.
 - num-cs	  - total number of chipselects.
 
@@ -41,12 +47,13 @@ cs1 : native
 cs2 : &gpio1 1 0
 cs3 : &gpio1 2 0
 
-SPI slave nodes must be children of the SPI master node and can
+SPI slave nodes must be children of the SPI controller node and can
 contain the following properties.
-- reg             - (required) chip select address of device.
+- reg             - (required, master mode only) chip select address of device.
 - compatible      - (required) name of SPI device following generic names
 		recommended practice.
-- spi-max-frequency - (required) Maximum SPI clocking speed of device in Hz.
+- spi-max-frequency - (required, master mode only) Maximum SPI clocking speed
+		of device in Hz.
 - spi-cpol        - (optional) Empty property indicating device requires
 		inverse clock polarity (CPOL) mode.
 - spi-cpha        - (optional) Empty property indicating device requires
-- 
1.9.1

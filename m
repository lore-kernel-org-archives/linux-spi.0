From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: Document DT bindings for SPI controllers in slave mode" to the spi tree
Date: Fri, 26 May 2017 13:12:58 +0100
Message-ID: <E1dEE70-0001Tk-Ed@debutante>
References: <1493919951-32122-2-git-send-email-geert+renesas@glider.be>
Cc: Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>,
        Jiada Wang <jiada_wang@mentor.com>,
        Matt Porter <mporter@konsulko.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1493919951-32122-2-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: Document DT bindings for SPI controllers in slave mode

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From a8830cb19cfea04edb0381b52fd90eec44986eb9 Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 22 May 2017 15:11:40 +0200
Subject: [PATCH] spi: Document DT bindings for SPI controllers in slave mode

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/spi/spi-bus.txt | 76 ++++++++++++++---------
 1 file changed, 45 insertions(+), 31 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-bus.txt b/Documentation/devicetree/bindings/spi/spi-bus.txt
index 4b1d6e74c744..1f6e86f787ef 100644
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
+- compatible      - Name of SPI bus controller following generic names
+		    recommended practice.
+
+In master mode, the SPI controller node requires the following additional
+properties:
 - #address-cells  - number of cells required to define a chip select
 		address on the SPI bus.
 - #size-cells     - should be zero.
-- compatible      - name of SPI bus controller following generic names
-		recommended practice.
+
+In slave mode, the SPI controller node requires one additional property:
+- spi-slave       - Empty property.
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
 
@@ -41,28 +47,36 @@ cs1 : native
 cs2 : &gpio1 1 0
 cs3 : &gpio1 2 0
 
-SPI slave nodes must be children of the SPI master node and can
-contain the following properties.
-- reg             - (required) chip select address of device.
-- compatible      - (required) name of SPI device following generic names
-		recommended practice.
-- spi-max-frequency - (required) Maximum SPI clocking speed of device in Hz.
-- spi-cpol        - (optional) Empty property indicating device requires
-		inverse clock polarity (CPOL) mode.
-- spi-cpha        - (optional) Empty property indicating device requires
-		shifted clock phase (CPHA) mode.
-- spi-cs-high     - (optional) Empty property indicating device requires
-		chip select active high.
-- spi-3wire       - (optional) Empty property indicating device requires
-		3-wire mode.
-- spi-lsb-first   - (optional) Empty property indicating device requires
-		LSB first mode.
-- spi-tx-bus-width - (optional) The bus width (number of data wires) that is
-                      used for MOSI. Defaults to 1 if not present.
-- spi-rx-bus-width - (optional) The bus width (number of data wires) that is
-                      used for MISO. Defaults to 1 if not present.
-- spi-rx-delay-us  - (optional) Microsecond delay after a read transfer.
-- spi-tx-delay-us  - (optional) Microsecond delay after a write transfer.
+
+SPI slave nodes must be children of the SPI controller node.
+
+In master mode, one or more slave nodes (up to the number of chip selects) can
+be present.  Required properties are:
+- compatible      - Name of SPI device following generic names recommended
+		    practice.
+- reg             - Chip select address of device.
+- spi-max-frequency - Maximum SPI clocking speed of device in Hz.
+
+In slave mode, the (single) slave node is optional.
+If present, it must be called "slave".  Required properties are:
+- compatible      - Name of SPI device following generic names recommended
+		    practice.
+
+All slave nodes can contain the following optional properties:
+- spi-cpol        - Empty property indicating device requires inverse clock
+		    polarity (CPOL) mode.
+- spi-cpha        - Empty property indicating device requires shifted clock
+		    phase (CPHA) mode.
+- spi-cs-high     - Empty property indicating device requires chip select
+		    active high.
+- spi-3wire       - Empty property indicating device requires 3-wire mode.
+- spi-lsb-first   - Empty property indicating device requires LSB first mode.
+- spi-tx-bus-width - The bus width (number of data wires) that is used for MOSI.
+		    Defaults to 1 if not present.
+- spi-rx-bus-width - The bus width (number of data wires) that is used for MISO.
+		    Defaults to 1 if not present.
+- spi-rx-delay-us - Microsecond delay after a read transfer.
+- spi-tx-delay-us - Microsecond delay after a write transfer.
 
 Some SPI controllers and devices support Dual and Quad SPI transfer mode.
 It allows data in the SPI system to be transferred using 2 wires (DUAL) or 4
-- 
2.11.0

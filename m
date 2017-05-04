From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH v3 1/6] spi: Document DT bindings for SPI controllers in slave mode
Date: Thu,  4 May 2017 19:45:46 +0200
Message-ID: <1493919951-32122-2-git-send-email-geert+renesas@glider.be>
References: <1493919951-32122-1-git-send-email-geert+renesas@glider.be>
Cc: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>,
        Hiromitsu Yamasaki <hiromitsu.yamasaki.ym-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
        Jiada Wang <jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>,
        Matt Porter <mporter-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1493919951-32122-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
---
v3:
  - In SPI slave mode, represent the (single) slave device again as a
    child of the controller node, which is now optional, and must be
    named "slave" if present,
  - Split slave node properties in master mode, slave mode, and common
    properties,

v2:
  - Do not create a child node in SPI slave mode. Instead, add an
    "spi-slave" property, and put the mode properties in the controller
    node.
---
 Documentation/devicetree/bindings/spi/spi-bus.txt | 76 ++++++++++++++---------
 1 file changed, 45 insertions(+), 31 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-bus.txt b/Documentation/devicetree/bindings/spi/spi-bus.txt
index 4b1d6e74c744fe96..1f6e86f787efd229 100644
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
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

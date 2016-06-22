From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH] spi: Improve DT binding documentation
Date: Wed, 22 Jun 2016 14:48:26 +0200
Message-ID: <1466599706-2850-1-git-send-email-geert+renesas@glider.be>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

  - Add missing verbs and periods,
  - Add spaces before opening parentheses,
  - Align list layout,
  - Correct grammar,
  - Move "cs-gpios" from the required to the optional properties
    section,
  - Remove spaces before tabs.

Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
---
 Documentation/devicetree/bindings/spi/spi-bus.txt | 35 ++++++++++++-----------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-bus.txt b/Documentation/devicetree/bindings/spi/spi-bus.txt
index 42d595425dfb9f3c..17822860cb98c34d 100644
--- a/Documentation/devicetree/bindings/spi/spi-bus.txt
+++ b/Documentation/devicetree/bindings/spi/spi-bus.txt
@@ -8,11 +8,10 @@ in slave mode.
 
 The SPI master node requires the following properties:
 - #address-cells  - number of cells required to define a chip select
-    		address on the SPI bus.
+		address on the SPI bus.
 - #size-cells     - should be zero.
 - compatible      - name of SPI bus controller following generic names
-    		recommended practice.
-- cs-gpios	  - (optional) gpios chip select.
+		recommended practice.
 No other properties are required in the SPI bus node.  It is assumed
 that a driver for an SPI bus device will understand that it is an SPI bus.
 However, the binding does not attempt to define the specific method for
@@ -22,11 +21,12 @@ assumption that board specific platform code will be used to manage
 chip selects.  Individual drivers can define additional properties to
 support describing the chip select layout.
 
-Optional property:
-- num-cs : total number of chipselects
+Optional properties:
+- cs-gpios	  - gpios chip select.
+- num-cs	  - total number of chipselects.
 
-If cs-gpios is used the number of chip select will automatically increased
-with max(cs-gpios > hw cs)
+If cs-gpios is used the number of chip selects will be increased automatically
+with max(cs-gpios > hw cs).
 
 So if for example the controller has 2 CS lines, and the cs-gpios
 property looks like this:
@@ -45,29 +45,30 @@ SPI slave nodes must be children of the SPI master node and can
 contain the following properties.
 - reg             - (required) chip select address of device.
 - compatible      - (required) name of SPI device following generic names
-    		recommended practice
-- spi-max-frequency - (required) Maximum SPI clocking speed of device in Hz
+		recommended practice.
+- spi-max-frequency - (required) Maximum SPI clocking speed of device in Hz.
 - spi-cpol        - (optional) Empty property indicating device requires
-    		inverse clock polarity (CPOL) mode
+		inverse clock polarity (CPOL) mode.
 - spi-cpha        - (optional) Empty property indicating device requires
-    		shifted clock phase (CPHA) mode
+		shifted clock phase (CPHA) mode.
 - spi-cs-high     - (optional) Empty property indicating device requires
-    		chip select active high
+		chip select active high.
 - spi-3wire       - (optional) Empty property indicating device requires
-    		    3-wire mode.
+		3-wire mode.
 - spi-lsb-first   - (optional) Empty property indicating device requires
 		LSB first mode.
-- spi-tx-bus-width - (optional) The bus width(number of data wires) that
+- spi-tx-bus-width - (optional) The bus width (number of data wires) that is
                       used for MOSI. Defaults to 1 if not present.
-- spi-rx-bus-width - (optional) The bus width(number of data wires) that
+- spi-rx-bus-width - (optional) The bus width (number of data wires) that is
                       used for MISO. Defaults to 1 if not present.
 - spi-rx-delay-us  - (optional) Microsecond delay after a read transfer.
 - spi-tx-delay-us  - (optional) Microsecond delay after a write transfer.
 
 Some SPI controllers and devices support Dual and Quad SPI transfer mode.
-It allows data in the SPI system to be transferred in 2 wires(DUAL) or 4 wires(QUAD).
+It allows data in the SPI system to be transferred using 2 wires (DUAL) or 4
+wires (QUAD).
 Now the value that spi-tx-bus-width and spi-rx-bus-width can receive is
-only 1(SINGLE), 2(DUAL) and 4(QUAD).
+only 1 (SINGLE), 2 (DUAL) and 4 (QUAD).
 Dual/Quad mode is not allowed when 3-wire mode is used.
 
 If a gpio chipselect is used for the SPI slave the gpio number will be passed
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 3/5] spi: spi-gpio: Augment device tree bindings
Date: Mon,  1 Jan 2018 14:37:47 +0100
Message-ID: <20180101133749.29567-4-linus.walleij@linaro.org>
References: <20180101133749.29567-1-linus.walleij@linaro.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
        Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180101133749.29567-1-linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

After we augmented the core to handle "gpio-sck"/"sck-gpios",
"gpio-mosi"/"mosi-gpios", "gpio-miso"/"miso-gpios" alike,
deprecate the old binding and put the strict modern and
recommended binding practice into place as the default for
GPIO-based SPI.

Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 Documentation/devicetree/bindings/spi/spi-gpio.txt | 24 ++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-gpio.txt b/Documentation/devicetree/bindings/spi/spi-gpio.txt
index a95603bcf6ff..52db562f17a4 100644
--- a/Documentation/devicetree/bindings/spi/spi-gpio.txt
+++ b/Documentation/devicetree/bindings/spi/spi-gpio.txt
@@ -1,18 +1,30 @@
 SPI-GPIO devicetree bindings
 
+This represents a group of 3-n GPIO lines used for bit-banged SPI on dedicated
+GPIO lines.
+
 Required properties:
 
  - compatible: should be set to "spi-gpio"
  - #address-cells: should be set to <0x1>
  - ranges
- - gpio-sck: GPIO spec for the SCK line to use
- - gpio-miso: GPIO spec for the MISO line to use
- - gpio-mosi: GPIO spec for the MOSI line to use
+ - sck-gpios: GPIO spec for the SCK line to use
+ - miso-gpios: GPIO spec for the MISO line to use
+ - mosi-gpios: GPIO spec for the MOSI line to use
  - cs-gpios: GPIOs to use for chipselect lines.
              Not needed if num-chipselects = <0>.
  - num-chipselects: Number of chipselect lines. Should be <0> if a single device
                     with no chip select is connected.
 
+Deprecated bindings:
+
+These legacy GPIO line bindings can alternatively be used to define the
+GPIO lines used, they should not be used in new device trees.
+
+ - gpio-sck: GPIO spec for the SCK line to use
+ - gpio-miso: GPIO spec for the MISO line to use
+ - gpio-mosi: GPIO spec for the MOSI line to use
+
 Example:
 
 	spi {
@@ -20,9 +32,9 @@ Example:
 		#address-cells = <0x1>;
 		ranges;
 
-		gpio-sck = <&gpio 95 0>;
-		gpio-miso = <&gpio 98 0>;
-		gpio-mosi = <&gpio 97 0>;
+		sck-gpios = <&gpio 95 0>;
+		miso-gpios = <&gpio 98 0>;
+		mosi-gpios = <&gpio 97 0>;
 		cs-gpios = <&gpio 125 0>;
 		num-chipselects = <1>;
 
-- 
2.14.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

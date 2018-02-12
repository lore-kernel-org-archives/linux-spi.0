From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 3/3] spi: spi-gpio: Augment device tree bindings
Date: Mon, 12 Feb 2018 13:45:32 +0100
Message-ID: <20180212124532.25776-4-linus.walleij@linaro.org>
References: <20180212124532.25776-1-linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20180212124532.25776-1-linus.walleij@linaro.org>
Sender: linux-gpio-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

After we augmented the core to handle "gpio-sck"/"sck-gpios",
"gpio-mosi"/"mosi-gpios", "gpio-miso"/"miso-gpios" alike,
deprecate the old binding and put the strict modern and
recommended binding practice into place as the default for
GPIO-based SPI.

This reflects the similar change in I2C:
commit 7d29f509d2cf
("dt-bindings: i2c: i2c-gpio: Add support for named gpios")

Cc: devicetree@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
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


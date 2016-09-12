From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH/RFC v2 1/7] spi: Document DT bindings for SPI controllers in slave mode
Date: Mon, 12 Sep 2016 22:50:40 +0200
Message-ID: <1473713446-30366-2-git-send-email-geert+renesas@glider.be>
References: <1473713446-30366-1-git-send-email-geert+renesas@glider.be>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>,
        Hisashi Nakamura <hisashi.nakamura.ak-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
        Hiromitsu Yamasaki <hiromitsu.yamasaki.ym-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1473713446-30366-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
---
v2:
  - Do not create a child node in SPI slave mode. Instead, add an
    "spi-slave" property, and put the mode properties in the controller
    node.
---
 Documentation/devicetree/bindings/spi/spi-bus.txt | 34 ++++++++++++++---------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-bus.txt b/Documentation/devicetree/bindings/spi/spi-bus.txt
index 17822860cb98c34d..1ae28d7cafb68dc5 100644
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
 
@@ -41,12 +47,14 @@ cs1 : native
 cs2 : &gpio1 1 0
 cs3 : &gpio1 2 0
 
-SPI slave nodes must be children of the SPI master node and can
-contain the following properties.
-- reg             - (required) chip select address of device.
+In master mode, SPI slave nodes must be children of the SPI controller node.
+In slave mode, the (single) slave device is represented by the controller node
+itself. SPI slave nodes can contain the following properties.
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

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

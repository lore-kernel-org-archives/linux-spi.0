From: Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 1/3] dt-bindings: spi: Add spi-mux-gpio
Date: Fri, 12 Apr 2019 17:02:11 +1200
Message-ID: <20190412050213.17698-2-chris.packham@alliedtelesis.co.nz>
References: <20190412050213.17698-1-chris.packham@alliedtelesis.co.nz>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Cc: Hamish Martin <hamish.martin@alliedtelesis.co.nz>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
To: broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190412050213.17698-1-chris.packham@alliedtelesis.co.nz>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Add binding documentation for spi-mux-gpio which is a slightly more
complicated hardware implementation of using gpios to steer SPI chip
selects.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 .../devicetree/bindings/spi/spi-mux-gpio.txt  | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-mux-gpio.tx=
t

diff --git a/Documentation/devicetree/bindings/spi/spi-mux-gpio.txt b/Doc=
umentation/devicetree/bindings/spi/spi-mux-gpio.txt
new file mode 100644
index 000000000000..a32f25321d37
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-mux-gpio.txt
@@ -0,0 +1,45 @@
+SPI bus gpio multiplexer
+
+The SPI bus gpio multiplexer can be used to implement more complicated a=
ccess
+logic than can be supported with the cs-gpios property of a SPI bus.
+
+In the example below we have a SoC with a single SPI CS that is gated by=
 the
+state of a gpio to select the desired SPI device.
+
+     +----------+  CS    +-----+ CS0  +----+
+     |          |--------|     |------|    |
+     |          |        | \ / |      +----+
+     |   SoC    |        |  +  |
+     |          |  GPIO  | / \ | CS1  +----+
+     |          |--------|     |------|    |
+     +----------+        +-----+      +----+
+
+Required properties:
+- compatible	- must be "spi-mux-gpio"
+- gpios		- gpios used to implement the multiplexing logic
+- spi-parent-bus - parent spi bus to use
+
+Optional properties:
+- spi-parent-cs - chip select on parent bus to use. Defaults to 0 if not
+                  specified.
+
+Example for a multiplexer with a single gpio:
+
+	spi-mux {
+		compatible =3D "spi-mux-gpio";
+		#address-cells =3D <1>;
+		#size-cells =3D <0>;
+		gpios =3D <&gpio0 1 0>;
+		spi-parent-bus =3D <&spi0>;
+		spi-parent-cs =3D <0>;
+
+		spi-dev@0 {
+			compatible =3D "...";
+			reg =3D <0>;
+		}
+
+		spi-dev@1 {
+			compatible =3D "...";
+			reg =3D <1>;
+		}
+	};
--=20
2.21.0

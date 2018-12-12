From: <Tudor.Ambarus@microchip.com>
Subject: [PATCH 1/2] ARM: dts: at91: at91-sama5d27_som1: add QSPI1 + SPI NOR
 memory nodes
Date: Wed, 12 Dec 2018 16:31:08 +0000
Message-ID: <20181212163057.22183-1-tudor.ambarus@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <boris.brezillon@bootlin.com>, <linux-mtd@lists.infradead.org>,
        <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        <Tudor.Ambarus@microchip.com>
To: <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <Claudiu.Beznea@microchip.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Configure the QSPI1 controller pin muxing and declare the
jedec,spi-nor memory (SST26VF064).

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
[tudor.ambarus@microchip.com: add spi-rx/tx-bus-width, drop partitions,
reword commit.]
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 arch/arm/boot/dts/at91-sama5d27_som1.dtsi | 30 +++++++++++++++++++++++++++=
+++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama5d27_som1.dtsi b/arch/arm/boot/dts/=
at91-sama5d27_som1.dtsi
index cf0087b4c9e1..33a159c0163f 100644
--- a/arch/arm/boot/dts/at91-sama5d27_som1.dtsi
+++ b/arch/arm/boot/dts/at91-sama5d27_som1.dtsi
@@ -62,6 +62,20 @@
=20
 	ahb {
 		apb {
+			qspi1: spi@f0024000 {
+				pinctrl-names =3D "default";
+				pinctrl-0 =3D <&pinctrl_qspi1_default>;
+
+				flash@0 {
+					compatible =3D "jedec,spi-nor";
+					reg =3D <0>;
+					spi-max-frequency =3D <80000000>;
+					spi-tx-bus-width =3D <4>;
+					spi-rx-bus-width =3D <4>;
+					m25p,fast-read;
+				};
+			};
+
 			macb0: ethernet@f8008000 {
 				pinctrl-names =3D "default";
 				pinctrl-0 =3D <&pinctrl_macb0_default>;
@@ -78,6 +92,22 @@
=20
 			pinctrl@fc038000 {
=20
+				pinctrl_qspi1_default: qspi1_default {
+					sck_cs {
+						pinmux =3D <PIN_PB5__QSPI1_SCK>,
+							 <PIN_PB6__QSPI1_CS>;
+						bias-disable;
+					};
+
+					data {
+						pinmux =3D <PIN_PB7__QSPI1_IO0>,
+							 <PIN_PB8__QSPI1_IO1>,
+							 <PIN_PB9__QSPI1_IO2>,
+							 <PIN_PB10__QSPI1_IO3>;
+						bias-pull-up;
+					};
+				};
+
 				pinctrl_macb0_default: macb0_default {
 					pinmux =3D <PIN_PD9__GTXCK>,
 						 <PIN_PD10__GTXEN>,
--=20
2.9.4

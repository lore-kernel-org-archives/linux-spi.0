From: <Tudor.Ambarus@microchip.com>
Subject: [PATCH 2/2] ARM: dts: at91: at91-sama5d27_som1_ek: enable qspi1
 memory
Date: Wed, 12 Dec 2018 16:31:11 +0000
Message-ID: <20181212163057.22183-2-tudor.ambarus@microchip.com>
References: <20181212163057.22183-1-tudor.ambarus@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <boris.brezillon@bootlin.com>, <linux-mtd@lists.infradead.org>,
        <broonie@kernel.org>, <linux-spi@vger.kernel.org>
To: <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <Claudiu.Beznea@microchip.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181212163057.22183-1-tudor.ambarus@microchip.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Enable qspi1.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/boot/dts/at91-sama5d27_som1_ek.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts b/arch/arm/boot/dt=
s/at91-sama5d27_som1_ek.dts
index 363a43d77424..73d16d98bf9c 100644
--- a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
+++ b/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
@@ -109,6 +109,10 @@
 				status =3D "okay";
 			};
=20
+			qspi1: spi@f0024000 {
+				status =3D "okay";
+			};
+
 			spi0: spi@f8000000 {
 				pinctrl-names =3D "default";
 				pinctrl-0 =3D <&pinctrl_spi0_default>;
--=20
2.9.4

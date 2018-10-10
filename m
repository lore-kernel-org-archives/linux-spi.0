From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 05/11] DT: marvell,mmp2: Add SSP1 and SSP3
Date: Wed, 10 Oct 2018 19:09:30 +0200
Message-ID: <20181010170936.316862-6-lkundrak@v3.sk>
References: <20181010170936.316862-1-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Cc: James Cameron <quozl@laptop.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Lubomir Rintel <lkundrak@v3.sk>
To: Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181010170936.316862-1-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

There seem to be SSP2, SSP4 and perhaps SSP5 too, but Marvel keeps their
base addresses secret.

The SSP1 and SSP3 addresses were taken from OLPC 1.75, OpenFirmware and
kernel respectively.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

---
Changes since v1:
- Dropped the aliases

 arch/arm/boot/dts/mmp2.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/mmp2.dtsi b/arch/arm/boot/dts/mmp2.dtsi
index 766bbb8495b6..c16531f4d4c7 100644
--- a/arch/arm/boot/dts/mmp2.dtsi
+++ b/arch/arm/boot/dts/mmp2.dtsi
@@ -239,6 +239,22 @@
 				resets =3D <&soc_clocks MMP2_CLK_RTC>;
 				status =3D "disabled";
 			};
+
+			ssp1: ssp@d4035000 {
+				compatible =3D "marvell,mmp2-ssp";
+				reg =3D <0xd4035000 0x1000>;
+				clocks =3D <&soc_clocks MMP2_CLK_SSP0>;
+				interrupts =3D <0>;
+				status =3D "disabled";
+			};
+
+			ssp3: ssp@d4037000 {
+				compatible =3D "marvell,mmp2-ssp";
+				reg =3D <0xd4037000 0x1000>;
+				clocks =3D <&soc_clocks MMP2_CLK_SSP2>;
+				interrupts =3D <20>;
+				status =3D "disabled";
+			};
 		};
=20
 		soc_clocks: clocks{
--=20
2.19.0

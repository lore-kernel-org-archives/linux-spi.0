From: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH v8 3/5] arm64: dts: lx2160a: add FlexSPI node property
Date: Tue, 15 Jan 2019 12:00:26 +0000
Message-ID: <1547553487-9936-4-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1547553487-9936-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@kontron.de" <frieder.schrempf@kontron.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1547553487-9936-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Add fspi node property for LX2160A SoC for FlexSPI driver.
Property added for the FlexSPI controller and for the connected
slave device for the LX2160ARDB target.
This is having two SPI-NOR flash device, mt35xu512aba, connected
at CS0 and CS1.

Signed-off-by: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
---
Changes for v8:
- None
Changes for v7:
- None
Changes for v6:
- None
Changes for v5:
- None
Changes for v4:
- Incorporated Rob review comments.
Changes for v3:
- None.
Changes for v2:
- Incorporated Shawn review comments.

 .../boot/dts/freescale/fsl-lx2160a-rdb.dts    | 22 +++++++++++++++++++
 .../arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 13 +++++++++++
 2 files changed, 35 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts b/arch/arm64=
/boot/dts/freescale/fsl-lx2160a-rdb.dts
index 6481e5f20e69..70658946fbbe 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
@@ -50,6 +50,28 @@
 	status =3D "okay";
 };
=20
+&fspi {
+	status =3D "okay";
+
+	mt35xu512aba0: flash@0 {
+		#address-cells =3D <1>;
+		#size-cells =3D <1>;
+		compatible =3D "spansion,m25p80";
+		m25p,fast-read;
+		spi-max-frequency =3D <50000000>;
+		reg =3D <0>;
+	};
+
+	mt35xu512aba1: flash@1 {
+		#address-cells =3D <1>;
+		#size-cells =3D <1>;
+		compatible =3D "spansion,m25p80";
+		m25p,fast-read;
+		spi-max-frequency =3D <50000000>;
+		reg =3D <1>;
+	};
+};
+
 &i2c0 {
 	status =3D "okay";
=20
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/bo=
ot/dts/freescale/fsl-lx2160a.dtsi
index a79f5c1ea56d..e3ff86201f73 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -762,5 +762,18 @@
 				     <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>;
 			dma-coherent;
 		};
+
+		fspi: spi@20c0000 {
+			compatible =3D "nxp,lx2160a-fspi";
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			reg =3D <0x0 0x20c0000 0x0 0x10000>,
+				<0x0 0x20000000 0x0 0x10000000>;
+			reg-names =3D "fspi_base", "fspi_mmap";
+			interrupts =3D <0 25 0x4>; /* Level high type */
+			clocks =3D <&clockgen 4 3>, <&clockgen 4 3>;
+			clock-names =3D "fspi_en", "fspi";
+			status =3D "disabled";
+		};
 	};
 };
--=20
2.17.1

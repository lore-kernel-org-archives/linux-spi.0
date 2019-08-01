From: Chuanhua Han <chuanhua.han@nxp.com>
Subject: [PATCH 3/3] arm64: dts: ls1088a-qds: Add the spi-flash nodes under the DSPI controller
Date: Thu,  1 Aug 2019 16:31:05 +0800
Message-ID: <20190801083105.30102-3-chuanhua.han@nxp.com>
References: <20190801083105.30102-1-chuanhua.han@nxp.com>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Chuanhua Han <chuanhua.han@nxp.com>
To: broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        shawnguo@kernel.org, leoyang.li@nxp.com
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190801083105.30102-1-chuanhua.han@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This patch adds the spi-flash nodes under the DSPI controller for
ls1088a-qds boards.

Signed-off-by: Chuanhua Han <chuanhua.han@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dts | 33 +++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dts
index 6f48d21..120e62d 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dts
@@ -17,6 +17,39 @@
 	compatible = "fsl,ls1088a-qds", "fsl,ls1088a";
 };
 
+&dspi {
+	bus-num = <0>;
+	status = "okay";
+
+	flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <1000000>;
+	};
+
+	flash@1 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		spi-cpol;
+		spi-cpha;
+		spi-max-frequency = <3500000>;
+		reg = <1>;
+	};
+
+	flash@2 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		spi-cpol;
+		spi-cpha;
+		spi-max-frequency = <3500000>;
+		reg = <2>;
+	};
+};
+
 &i2c0 {
 	status = "okay";
 
-- 
2.9.5

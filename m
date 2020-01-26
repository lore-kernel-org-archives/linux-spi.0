From: Adam Ford <aford173-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 5/5] arm64: dts: enable fspi in imx8mm dts
Date: Sun, 26 Jan 2020 08:09:12 -0600
Message-ID: <20200126140913.2139260-5-aford173@gmail.com>
References: <20200126140913.2139260-1-aford173@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: han.xu-3arQi8VN3Tc@public.gmane.org, Adam Ford <aford173-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Yogesh Gaur <yogeshgaur.83-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Ashish Kumar <ashish.kumar-3arQi8VN3Tc@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
        Pengutronix Kernel Team <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
        Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        NXP Linux Team <linux-imx-3arQi8VN3Tc@public.gmane.org>,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200126140913.2139260-1-aford173-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Pull in upstream patch from NXP repo to:
enable fspi in imx8mm DT file

Signed-off-by: Adam Ford <aford173-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Han Xu <han.xu-3arQi8VN3Tc@public.gmane.org>

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index 1e5e11592f7b..679769fe6cab 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -558,7 +558,21 @@ aips3: bus@30800000 {
 			compatible = "simple-bus";
 			#address-cells = <1>;
 			#size-cells = <1>;
-			ranges = <0x30800000 0x30800000 0x400000>;
+			ranges = <0x30800000 0x30800000 0x400000>,
+				 <0x8000000 0x8000000 0x10000000>;
+
+			flexspi: spi@30bb0000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "nxp,imx8mm-fspi";
+				reg = <0x30bb0000 0x10000>, <0x8000000 0x10000000>;
+				reg-names = "fspi_base", "fspi_mmap";
+				interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX8MM_CLK_QSPI_ROOT>,
+					 <&clk IMX8MM_CLK_QSPI_ROOT>;
+				clock-names = "fspi", "fspi_en";
+				status = "disabled";
+			};
 
 			ecspi1: spi@30820000 {
 				compatible = "fsl,imx8mm-ecspi", "fsl,imx51-ecspi";
-- 
2.24.0

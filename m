From: Sanchayan Maity <maitysanchayan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v1 1/2] ARM: dts: vfxxx: Enable DMA for DSPI on Vybrid
Date: Mon,  3 Oct 2016 18:20:37 +0530
Message-ID: <63fc108e2df00d2297a9b7014955f203bc802f34.1475498805.git.maitysanchayan@gmail.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stefan-XLVq0VzYD2Y@public.gmane.org,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bhuvanchandra.dv-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org,
        Sanchayan Maity <maitysanchayan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Enable DMA for DSPI on Vybrid.

Signed-off-by: Sanchayan Maity <maitysanchayan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 arch/arm/boot/dts/vf-colibri.dtsi | 4 ++++
 arch/arm/boot/dts/vfxxx.dtsi      | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/vf-colibri.dtsi b/arch/arm/boot/dts/vf-colibri.dtsi
index b741709..21bfef9 100644
--- a/arch/arm/boot/dts/vf-colibri.dtsi
+++ b/arch/arm/boot/dts/vf-colibri.dtsi
@@ -108,6 +108,10 @@
 	status = "okay";
 };
 
+&edma1 {
+	status = "okay";
+};
+
 &esdhc1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_esdhc1>;
diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
index 2c13ec6..eac4213 100644
--- a/arch/arm/boot/dts/vfxxx.dtsi
+++ b/arch/arm/boot/dts/vfxxx.dtsi
@@ -194,6 +194,9 @@
 				clocks = <&clks VF610_CLK_DSPI0>;
 				clock-names = "dspi";
 				spi-num-chipselects = <6>;
+				dmas = <&edma1 1 12>,
+					<&edma1 1 13>;
+				dma-names = "rx", "tx";
 				status = "disabled";
 			};
 
@@ -206,6 +209,9 @@
 				clocks = <&clks VF610_CLK_DSPI1>;
 				clock-names = "dspi";
 				spi-num-chipselects = <4>;
+				dmas = <&edma1 1 14>,
+					<&edma1 1 15>;
+				dma-names = "rx", "tx";
 				status = "disabled";
 			};
 
-- 
2.10.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

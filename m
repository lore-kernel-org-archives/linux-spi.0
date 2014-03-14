From: Hou Zhiqiang <B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH 1/2] powerpc/85xx: Add a property bus-num for espi controller
Date: Fri, 14 Mar 2014 17:35:56 +0800
Message-ID: <1394789757-40732-1-git-send-email-B48286@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>,
	<pawel.moll-5wv7dgnIgG8@public.gmane.org>, <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	<ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	<grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	<mingkai.hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Hou Zhiqiang <B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
To: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

To use "mtdparts=..." in cmdline, the spi_master bus_num must be static.
This property is use to asign a static bus number for spi_master other than
allocate dynamically.

Signed-off-by: Hou Zhiqiang <B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 arch/powerpc/boot/dts/fsl/pq3-espi-0.dtsi   | 1 +
 arch/powerpc/boot/dts/fsl/qoriq-espi-0.dtsi | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/powerpc/boot/dts/fsl/pq3-espi-0.dtsi b/arch/powerpc/boot/dts/fsl/pq3-espi-0.dtsi
index 75854b2..cb4d488 100644
--- a/arch/powerpc/boot/dts/fsl/pq3-espi-0.dtsi
+++ b/arch/powerpc/boot/dts/fsl/pq3-espi-0.dtsi
@@ -38,4 +38,5 @@ spi@7000 {
 	compatible = "fsl,mpc8536-espi";
 	reg = <0x7000 0x1000>;
 	interrupts = <59 0x2 0 0>;
+	bus-num = <0>;
 };
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-espi-0.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-espi-0.dtsi
index 6db0697..54358f3 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-espi-0.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-espi-0.dtsi
@@ -38,4 +38,5 @@ spi@110000 {
 	compatible = "fsl,mpc8536-espi";
 	reg = <0x110000 0x1000>;
 	interrupts = <53 0x2 0 0>;
+	bus-num = <0>;
 };
-- 
1.8.5


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

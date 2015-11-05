From: Zhiqiang Hou <Zhiqiang.Hou-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH V2] powerpc/dts: Add DT alias for Freescale eSPI controller
Date: Thu, 5 Nov 2015 11:06:15 +0800
Message-ID: <1446692775-29790-1-git-send-email-Zhiqiang.Hou@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <Mingkai.Hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Hou Zhiqiang <B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
To: <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	<robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <pawel.moll-5wv7dgnIgG8@public.gmane.org>, <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	<ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Hou Zhiqiang <B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org>

Add aliases for eSPI device node to assign the alias id to the
bus number of spi_master.

For the platforms used the device tree, the bus numbers are
dynamically assigned and are not predictable. However, sometimes
it must be figured out, e.g. using mtdparts in cmdline to specify
the layout of spi flash.

Signed-off-by: Hou Zhiqiang <B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
V2:
 - Generate the patch base on the latest source code.

 arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi    | 1 +
 arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi    | 1 +
 arch/powerpc/boot/dts/fsl/b4si-post.dtsi      | 2 +-
 arch/powerpc/boot/dts/fsl/mpc8536si-post.dtsi | 2 +-
 arch/powerpc/boot/dts/fsl/mpc8536si-pre.dtsi  | 1 +
 arch/powerpc/boot/dts/fsl/p1020si-post.dtsi   | 2 +-
 arch/powerpc/boot/dts/fsl/p1020si-pre.dtsi    | 1 +
 arch/powerpc/boot/dts/fsl/p1021si-post.dtsi   | 2 +-
 arch/powerpc/boot/dts/fsl/p1021si-pre.dtsi    | 1 +
 arch/powerpc/boot/dts/fsl/p1022si-post.dtsi   | 2 +-
 arch/powerpc/boot/dts/fsl/p1022si-pre.dtsi    | 1 +
 arch/powerpc/boot/dts/fsl/p1023si-post.dtsi   | 2 +-
 arch/powerpc/boot/dts/fsl/p1023si-pre.dtsi    | 1 +
 arch/powerpc/boot/dts/fsl/p2041si-post.dtsi   | 2 +-
 arch/powerpc/boot/dts/fsl/p2041si-pre.dtsi    | 1 +
 arch/powerpc/boot/dts/fsl/p3041si-post.dtsi   | 2 +-
 arch/powerpc/boot/dts/fsl/p3041si-pre.dtsi    | 1 +
 arch/powerpc/boot/dts/fsl/p4080si-post.dtsi   | 2 +-
 arch/powerpc/boot/dts/fsl/p4080si-pre.dtsi    | 1 +
 arch/powerpc/boot/dts/fsl/p5020si-post.dtsi   | 2 +-
 arch/powerpc/boot/dts/fsl/p5020si-pre.dtsi    | 1 +
 arch/powerpc/boot/dts/fsl/p5040si-post.dtsi   | 2 +-
 arch/powerpc/boot/dts/fsl/p5040si-pre.dtsi    | 1 +
 arch/powerpc/boot/dts/fsl/t1023si-post.dtsi   | 2 +-
 arch/powerpc/boot/dts/fsl/t102xsi-pre.dtsi    | 1 +
 arch/powerpc/boot/dts/fsl/t1040si-post.dtsi   | 2 +-
 arch/powerpc/boot/dts/fsl/t104xsi-pre.dtsi    | 1 +
 arch/powerpc/boot/dts/fsl/t2081si-post.dtsi   | 2 +-
 arch/powerpc/boot/dts/fsl/t208xsi-pre.dtsi    | 1 +
 arch/powerpc/boot/dts/fsl/t4240si-post.dtsi   | 2 +-
 arch/powerpc/boot/dts/fsl/t4240si-pre.dtsi    | 1 +
 31 files changed, 31 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi b/arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi
index 338af7e..7e164da 100644
--- a/arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi
@@ -54,6 +54,7 @@
 		dma0 = &dma0;
 		dma1 = &dma1;
 		sdhc = &sdhc;
+		spi0 = &spi0;
 	};
 
 
diff --git a/arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi b/arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi
index 1948f73..b6e1724 100644
--- a/arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi
@@ -54,6 +54,7 @@
 		dma0 = &dma0;
 		dma1 = &dma1;
 		sdhc = &sdhc;
+		spi0 = &spi0;
 	};
 
 
diff --git a/arch/powerpc/boot/dts/fsl/b4si-post.dtsi b/arch/powerpc/boot/dts/fsl/b4si-post.dtsi
index 603910a..6fbd651 100644
--- a/arch/powerpc/boot/dts/fsl/b4si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/b4si-post.dtsi
@@ -439,7 +439,7 @@
 	};
 
 /include/ "qoriq-espi-0.dtsi"
-	spi@110000 {
+	spi0: spi@110000 {
 		fsl,espi-num-chipselects = <4>;
 	};
 
diff --git a/arch/powerpc/boot/dts/fsl/mpc8536si-post.dtsi b/arch/powerpc/boot/dts/fsl/mpc8536si-post.dtsi
index c8b2daa..1c1c1fe 100644
--- a/arch/powerpc/boot/dts/fsl/mpc8536si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/mpc8536si-post.dtsi
@@ -164,7 +164,7 @@
 /include/ "pq3-duart-0.dtsi"
 
 /include/ "pq3-espi-0.dtsi"
-	spi@7000 {
+	spi0: spi@7000 {
 		fsl,espi-num-chipselects = <4>;
 	};
 
diff --git a/arch/powerpc/boot/dts/fsl/mpc8536si-pre.dtsi b/arch/powerpc/boot/dts/fsl/mpc8536si-pre.dtsi
index 152906f..8a6b7e7 100644
--- a/arch/powerpc/boot/dts/fsl/mpc8536si-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/mpc8536si-pre.dtsi
@@ -51,6 +51,7 @@
 		pci1 = &pci1;
 		pci2 = &pci2;
 		pci3 = &pci3;
+		spi0 = &spi0;
 	};
 
 	cpus {
diff --git a/arch/powerpc/boot/dts/fsl/p1020si-post.dtsi b/arch/powerpc/boot/dts/fsl/p1020si-post.dtsi
index 642dc3a..2ee2c0f 100644
--- a/arch/powerpc/boot/dts/fsl/p1020si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p1020si-post.dtsi
@@ -127,7 +127,7 @@
 /include/ "pq3-duart-0.dtsi"
 
 /include/ "pq3-espi-0.dtsi"
-	spi@7000 {
+	spi0: spi@7000 {
 		fsl,espi-num-chipselects = <4>;
 	};
 
diff --git a/arch/powerpc/boot/dts/fsl/p1020si-pre.dtsi b/arch/powerpc/boot/dts/fsl/p1020si-pre.dtsi
index fed9c4c..e40eef8 100644
--- a/arch/powerpc/boot/dts/fsl/p1020si-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p1020si-pre.dtsi
@@ -50,6 +50,7 @@
 		ethernet2 = &enet2;
 		pci0 = &pci0;
 		pci1 = &pci1;
+		spi0 = &spi0;
 	};
 
 	cpus {
diff --git a/arch/powerpc/boot/dts/fsl/p1021si-post.dtsi b/arch/powerpc/boot/dts/fsl/p1021si-post.dtsi
index 407cb5f..26ffcb5 100644
--- a/arch/powerpc/boot/dts/fsl/p1021si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p1021si-post.dtsi
@@ -127,7 +127,7 @@
 /include/ "pq3-duart-0.dtsi"
 
 /include/ "pq3-espi-0.dtsi"
-	spi@7000 {
+	spi0: spi@7000 {
 		fsl,espi-num-chipselects = <4>;
 	};
 
diff --git a/arch/powerpc/boot/dts/fsl/p1021si-pre.dtsi b/arch/powerpc/boot/dts/fsl/p1021si-pre.dtsi
index 36161b5..0e415f6 100644
--- a/arch/powerpc/boot/dts/fsl/p1021si-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p1021si-pre.dtsi
@@ -50,6 +50,7 @@
 		ethernet2 = &enet2;
 		pci0 = &pci0;
 		pci1 = &pci1;
+		spi0 = &spi0;
 	};
 
 	cpus {
diff --git a/arch/powerpc/boot/dts/fsl/p1022si-post.dtsi b/arch/powerpc/boot/dts/fsl/p1022si-post.dtsi
index 426bf41..0ef6eb5 100644
--- a/arch/powerpc/boot/dts/fsl/p1022si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p1022si-post.dtsi
@@ -159,7 +159,7 @@
 /include/ "pq3-i2c-1.dtsi"
 /include/ "pq3-duart-0.dtsi"
 /include/ "pq3-espi-0.dtsi"
-	spi@7000 {
+	spi0: spi@7000 {
 		fsl,espi-num-chipselects = <4>;
 	};
 
diff --git a/arch/powerpc/boot/dts/fsl/p1022si-pre.dtsi b/arch/powerpc/boot/dts/fsl/p1022si-pre.dtsi
index de76ae8..fcaf3df 100644
--- a/arch/powerpc/boot/dts/fsl/p1022si-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p1022si-pre.dtsi
@@ -50,6 +50,7 @@
 		pci0 = &pci0;
 		pci1 = &pci1;
 		pci2 = &pci2;
+		spi0 = &spi0;
 		vga = &display;
 		display = &display;
 	};
diff --git a/arch/powerpc/boot/dts/fsl/p1023si-post.dtsi b/arch/powerpc/boot/dts/fsl/p1023si-post.dtsi
index da6d3fc..d7f21c8 100644
--- a/arch/powerpc/boot/dts/fsl/p1023si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p1023si-post.dtsi
@@ -189,7 +189,7 @@
 /include/ "pq3-duart-0.dtsi"
 
 /include/ "pq3-espi-0.dtsi"
-	spi@7000 {
+	spi0: spi@7000 {
 		fsl,espi-num-chipselects = <4>;
 	};
 
diff --git a/arch/powerpc/boot/dts/fsl/p1023si-pre.dtsi b/arch/powerpc/boot/dts/fsl/p1023si-pre.dtsi
index 132a152..70601ec8 100644
--- a/arch/powerpc/boot/dts/fsl/p1023si-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p1023si-pre.dtsi
@@ -48,6 +48,7 @@
 		pci0 = &pci0;
 		pci1 = &pci1;
 		pci2 = &pci2;
+		spi0 = &spi0;
 
 		crypto = &crypto;
 		sec_jr0 = &sec_jr0;
diff --git a/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi b/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi
index 04ad177..8edd2bc 100644
--- a/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi
@@ -376,7 +376,7 @@
 	};
 
 /include/ "qoriq-espi-0.dtsi"
-	spi@110000 {
+	spi0: spi@110000 {
 		fsl,espi-num-chipselects = <4>;
 	};
 
diff --git a/arch/powerpc/boot/dts/fsl/p2041si-pre.dtsi b/arch/powerpc/boot/dts/fsl/p2041si-pre.dtsi
index b1ea147..476c032 100644
--- a/arch/powerpc/boot/dts/fsl/p2041si-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p2041si-pre.dtsi
@@ -53,6 +53,7 @@
 		pci0 = &pci0;
 		pci1 = &pci1;
 		pci2 = &pci2;
+		spi0 = &spi0;
 		usb0 = &usb0;
 		usb1 = &usb1;
 		dma0 = &dma0;
diff --git a/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi b/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi
index 2cab18a..c38bf67 100644
--- a/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi
@@ -403,7 +403,7 @@
 	};
 
 /include/ "qoriq-espi-0.dtsi"
-	spi@110000 {
+	spi0: spi@110000 {
 		fsl,espi-num-chipselects = <4>;
 	};
 
diff --git a/arch/powerpc/boot/dts/fsl/p3041si-pre.dtsi b/arch/powerpc/boot/dts/fsl/p3041si-pre.dtsi
index dc5f4b3..e7f290f 100644
--- a/arch/powerpc/boot/dts/fsl/p3041si-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p3041si-pre.dtsi
@@ -54,6 +54,7 @@
 		pci1 = &pci1;
 		pci2 = &pci2;
 		pci3 = &pci3;
+		spi0 = &spi0;
 		usb0 = &usb0;
 		usb1 = &usb1;
 		dma0 = &dma0;
diff --git a/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi b/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi
index dfc76bc..15dd0c4 100644
--- a/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi
@@ -475,7 +475,7 @@
 	};
 
 /include/ "qoriq-espi-0.dtsi"
-	spi@110000 {
+	spi0: spi@110000 {
 		fsl,espi-num-chipselects = <4>;
 	};
 
diff --git a/arch/powerpc/boot/dts/fsl/p4080si-pre.dtsi b/arch/powerpc/boot/dts/fsl/p4080si-pre.dtsi
index 38bde09..110d3bc 100644
--- a/arch/powerpc/boot/dts/fsl/p4080si-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p4080si-pre.dtsi
@@ -53,6 +53,7 @@
 		pci0 = &pci0;
 		pci1 = &pci1;
 		pci2 = &pci2;
+		spi0 = &spi0;
 		usb0 = &usb0;
 		usb1 = &usb1;
 		dma0 = &dma0;
diff --git a/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi b/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi
index b77923a..110c8be 100644
--- a/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi
@@ -390,7 +390,7 @@
 	};
 
 /include/ "qoriq-espi-0.dtsi"
-	spi@110000 {
+	spi0: spi@110000 {
 		fsl,espi-num-chipselects = <4>;
 	};
 
diff --git a/arch/powerpc/boot/dts/fsl/p5020si-pre.dtsi b/arch/powerpc/boot/dts/fsl/p5020si-pre.dtsi
index 1cc61e1..8b846ca 100644
--- a/arch/powerpc/boot/dts/fsl/p5020si-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p5020si-pre.dtsi
@@ -54,6 +54,7 @@
 		pci1 = &pci1;
 		pci2 = &pci2;
 		pci3 = &pci3;
+		spi0 = &spi0;
 		usb0 = &usb0;
 		usb1 = &usb1;
 		dma0 = &dma0;
diff --git a/arch/powerpc/boot/dts/fsl/p5040si-post.dtsi b/arch/powerpc/boot/dts/fsl/p5040si-post.dtsi
index 6d21452..5417439 100644
--- a/arch/powerpc/boot/dts/fsl/p5040si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p5040si-post.dtsi
@@ -368,7 +368,7 @@
 	};
 
 /include/ "qoriq-espi-0.dtsi"
-	spi@110000 {
+	spi0: spi@110000 {
 		fsl,espi-num-chipselects = <4>;
 	};
 
diff --git a/arch/powerpc/boot/dts/fsl/p5040si-pre.dtsi b/arch/powerpc/boot/dts/fsl/p5040si-pre.dtsi
index b048a2b..028c11b 100644
--- a/arch/powerpc/boot/dts/fsl/p5040si-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p5040si-pre.dtsi
@@ -53,6 +53,7 @@
 		pci0 = &pci0;
 		pci1 = &pci1;
 		pci2 = &pci2;
+		spi0 = &spi0;
 		usb0 = &usb0;
 		usb1 = &usb1;
 		dma0 = &dma0;
diff --git a/arch/powerpc/boot/dts/fsl/t1023si-post.dtsi b/arch/powerpc/boot/dts/fsl/t1023si-post.dtsi
index df1f068..a14d400 100644
--- a/arch/powerpc/boot/dts/fsl/t1023si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t1023si-post.dtsi
@@ -284,7 +284,7 @@
 /include/ "elo3-dma-1.dtsi"
 
 /include/ "qoriq-espi-0.dtsi"
-	spi@110000 {
+	spi0: spi@110000 {
 		fsl,espi-num-chipselects = <4>;
 	};
 
diff --git a/arch/powerpc/boot/dts/fsl/t102xsi-pre.dtsi b/arch/powerpc/boot/dts/fsl/t102xsi-pre.dtsi
index 1f1a9f8..da656ae 100644
--- a/arch/powerpc/boot/dts/fsl/t102xsi-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t102xsi-pre.dtsi
@@ -54,6 +54,7 @@
 		pci0 = &pci0;
 		pci1 = &pci1;
 		pci2 = &pci2;
+		spi0 = &spi0;
 		usb0 = &usb0;
 		usb1 = &usb1;
 		sdhc = &sdhc;
diff --git a/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi b/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
index 9770d02..7871e1e 100644
--- a/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t1040si-post.dtsi
@@ -492,7 +492,7 @@
 /include/ "elo3-dma-0.dtsi"
 /include/ "elo3-dma-1.dtsi"
 /include/ "qoriq-espi-0.dtsi"
-	spi@110000 {
+	spi0: spi@110000 {
 		fsl,espi-num-chipselects = <4>;
 	};
 
diff --git a/arch/powerpc/boot/dts/fsl/t104xsi-pre.dtsi b/arch/powerpc/boot/dts/fsl/t104xsi-pre.dtsi
index bbb7025..d1368ab 100644
--- a/arch/powerpc/boot/dts/fsl/t104xsi-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t104xsi-pre.dtsi
@@ -53,6 +53,7 @@
 		pci1 = &pci1;
 		pci2 = &pci2;
 		pci3 = &pci3;
+		spi0 = &spi0;
 		usb0 = &usb0;
 		usb1 = &usb1;
 		sdhc = &sdhc;
diff --git a/arch/powerpc/boot/dts/fsl/t2081si-post.dtsi b/arch/powerpc/boot/dts/fsl/t2081si-post.dtsi
index 32c790a..3ea2adf 100644
--- a/arch/powerpc/boot/dts/fsl/t2081si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t2081si-post.dtsi
@@ -591,7 +591,7 @@
 	};
 
 /include/ "qoriq-espi-0.dtsi"
-	spi@110000 {
+	spi0: spi@110000 {
 		fsl,espi-num-chipselects = <4>;
 	};
 
diff --git a/arch/powerpc/boot/dts/fsl/t208xsi-pre.dtsi b/arch/powerpc/boot/dts/fsl/t208xsi-pre.dtsi
index e71ceb0..ec87a0e 100644
--- a/arch/powerpc/boot/dts/fsl/t208xsi-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t208xsi-pre.dtsi
@@ -55,6 +55,7 @@
 		pci1 = &pci1;
 		pci2 = &pci2;
 		pci3 = &pci3;
+		spi0 = &spi0;
 		usb0 = &usb0;
 		usb1 = &usb1;
 		dma0 = &dma0;
diff --git a/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi b/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
index d806360..978b16e 100644
--- a/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
@@ -1033,7 +1033,7 @@
 /include/ "elo3-dma-2.dtsi"
 
 /include/ "qoriq-espi-0.dtsi"
-	spi@110000 {
+	spi0: spi@110000 {
 		fsl,espi-num-chipselects = <4>;
 	};
 
diff --git a/arch/powerpc/boot/dts/fsl/t4240si-pre.dtsi b/arch/powerpc/boot/dts/fsl/t4240si-pre.dtsi
index 261a3abb..be56195 100644
--- a/arch/powerpc/boot/dts/fsl/t4240si-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t4240si-pre.dtsi
@@ -55,6 +55,7 @@
 		pci1 = &pci1;
 		pci2 = &pci2;
 		pci3 = &pci3;
+		spi0 = &spi0;
 		dma0 = &dma0;
 		dma1 = &dma1;
 		dma2 = &dma2;
-- 
2.1.0.27.g96db324

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

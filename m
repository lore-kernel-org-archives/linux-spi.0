From: <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 1/3] dt-bindings: ARM: Mediatek: Document devicetree bindings for spi bus
Date: Fri, 8 May 2015 16:55:41 +0800
Message-ID: <1431075343-7887-2-git-send-email-leilk.liu@mediatek.com>
References: <1431075343-7887-1-git-send-email-leilk.liu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>,
	Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>,
	Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>,
	Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>,
	Hongzhou Yang <hongzhou.yang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>,
	Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	<devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	<srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1431075343-7887-1-git-send-email-leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>

Signed-off-by: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
 .../devicetree/bindings/spi/spi-mt65xx.txt         | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-mt65xx.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-mt65xx.txt b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
new file mode 100644
index 0000000..04c28fd
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
@@ -0,0 +1,32 @@
+MTK SPI device
+
+Required properties:
+- compatible: should be one of the following.
+    - mediatek,mt8173-spi: for mt8173 platforms
+    - mediatek,mt8135-spi: for mt8135 platforms
+    - mediatek,mt6589-spi: for mt6589 platforms
+
+- reg: Address and length of the register set for the device
+
+- interrupts: Should contain spi interrupt
+
+- clock-names: tuple listing input clock names.
+	Required elements: "main"
+
+- clocks: phandles to input clocks.
+
+- pad-select: should specify spi pad used, only required for MT8173.
+	This value should be 0~3.
+
+Example:
+
+- SoC Specific Portion:
+spi: spi@1100a000 {
+	compatible = "mediatek,mt8173-spi";
+	reg = <0 0x1100a000 0 0x1000>;
+	interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_LOW>;
+	clocks = <&pericfg PERI_SPI0>;
+	clock-names = "main";
+	pad-select = <1>;
+	status = "disabled";
+};
-- 
1.8.1.1.dirty

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

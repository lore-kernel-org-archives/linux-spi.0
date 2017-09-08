From: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 1/3] dt-bindings: spi: spi-davinci: Update binding for 66AK2Gx pwr dm property
Date: Fri, 8 Sep 2017 15:46:36 -0500
Message-ID: <20170908204638.13149-2-fcooper@ti.com>
References: <20170908204638.13149-1-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
To: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>,
        <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170908204638.13149-1-fcooper-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Add pm-domains property which is required for 66AK2Gx. Also document 66AK2G
unique clocks property usage.

Signed-off-by: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
---
 Documentation/devicetree/bindings/spi/spi-davinci.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-davinci.txt b/Documentation/devicetree/bindings/spi/spi-davinci.txt
index f5916c9..1925277 100644
--- a/Documentation/devicetree/bindings/spi/spi-davinci.txt
+++ b/Documentation/devicetree/bindings/spi/spi-davinci.txt
@@ -24,6 +24,16 @@ Required properties:
 	based on a specific SoC configuration.
 - interrupts: interrupt number mapped to CPU.
 - clocks: spi clk phandle
+          For 66AK2G this property should be set per binding,
+          Documentation/devicetree/bindings/clock/ti,sci-clk.txt
+
+SoC-specific Required Properties:
+
+The following are mandatory properties for Keystone 2 66AK2G SoCs only:
+
+- power-domains:	Should contain a phandle to a PM domain provider node
+			and an args specifier containing the SPI device id
+			value. This property is as per the binding,
 
 Optional:
 - cs-gpios: gpio chip selects
-- 
2.9.4.dirty

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Aaron Brice <aaron.brice-vSOi0k5x9wFWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v3 2/3] devicetree: spi: fsl-dspi: Add cs-sck delays
Date: Fri,  3 Apr 2015 13:39:30 -0700
Message-ID: <1428093571-20407-3-git-send-email-aaron.brice@datasoft.com>
References: <1428093571-20407-1-git-send-email-aaron.brice@datasoft.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	stefan-XLVq0VzYD2Y@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1428093571-20407-1-git-send-email-aaron.brice-vSOi0k5x9wFWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Adding fsl,spi-cs-sck-delay and fsl,spi-sck-cs-delay properties to
support delays before and after starting the clock in a transfer.

Signed-off-by: Aaron Brice <aaron.brice-vSOi0k5x9wFWk0Htik3J/w@public.gmane.org>
---
 Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt b/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
index cbbe16e..70af78a 100644
--- a/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
+++ b/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
@@ -16,6 +16,12 @@ Optional property:
   in big endian mode, otherwise in native mode(same with CPU), for more
   detail please see: Documentation/devicetree/bindings/regmap/regmap.txt.
 
+Optional SPI slave node properties:
+- fsl,spi-cs-sck-delay: a delay in nanoseconds between activating chip
+  select and the start of clock signal, at the start of a transfer.
+- fsl,spi-sck-cs-delay: a delay in nanoseconds between stopping the clock
+  signal and deactivating chip select, at the end of a transfer.
+
 Example:
 
 dspi0@4002c000 {
@@ -43,6 +49,8 @@ dspi0@4002c000 {
 		reg = <0>;
 		linux,modalias = "m25p80";
 		modal = "at26df081a";
+		fsl,spi-cs-sck-delay = <100>;
+		fsl,spi-sck-cs-delay = <50>;
 	};
 };
 
-- 
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Alban Bedel <albeu-GANU6spQydw@public.gmane.org>
Subject: [PATCH] devicetree: Misc fix for the AR7100 SPI controller binding
Date: Thu,  7 May 2015 23:18:31 +0200
Message-ID: <1431033511-30220-1-git-send-email-albeu@free.fr>
References: <553A7F62.80108@cogentembedded.com>
Cc: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Gabor Juhos <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org,
	Alban Bedel <albeu-GANU6spQydw@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <553A7F62.80108-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Fix the clocks property documentation and use lower case for
hex values in the example.

Signed-off-by: Alban Bedel <albeu-GANU6spQydw@public.gmane.org>
---

This patch can be applied as is or as a fixup to the original patch:
"spi: spi-ath79: add binding documentation for the AR7100 SPI controller"
or I can resend the whole patch/serie if that's preferable.
---
 Documentation/devicetree/bindings/spi/spi-ath79.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-ath79.txt b/Documentation/devicetree/bindings/spi/spi-ath79.txt
index f1ad9c3..9c696fa 100644
--- a/Documentation/devicetree/bindings/spi/spi-ath79.txt
+++ b/Documentation/devicetree/bindings/spi/spi-ath79.txt
@@ -3,7 +3,7 @@ Binding for Qualcomm Atheros AR7xxx/AR9xxx SPI controller
 Required properties:
 - compatible: has to be "qca,<soc-type>-spi", "qca,ar7100-spi" as fallback.
 - reg: Base address and size of the controllers memory area
-- clocks: phandle to the AHB clock.
+- clocks: phandle of the AHB clock.
 - clock-names: has to be "ahb".
 - #address-cells: <1>, as required by generic SPI binding.
 - #size-cells: <0>, also as required by generic SPI binding.
@@ -12,9 +12,9 @@ Child nodes as per the generic SPI binding.
 
 Example:
 
-	spi@1F000000 {
+	spi@1f000000 {
 		compatible = "qca,ar9132-spi", "qca,ar7100-spi";
-		reg = <0x1F000000 0x10>;
+		reg = <0x1f000000 0x10>;
 
 		clocks = <&pll 2>;
 		clock-names = "ahb";
-- 
2.0.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

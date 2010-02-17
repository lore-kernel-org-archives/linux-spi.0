From: Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH] of: added documentation for spi chipselects, follow-up patch
Date: Wed, 17 Feb 2010 15:15:18 +0100
Message-ID: <20100217151518.42e0a5ba.eschwab@online.de>
References: <20100216193957.ccdffee2.eschwab@online.de>
	<20100216201459.GA17428@pengutronix.de>
	<20100217132322.76cea805.eschwab@online.de>
	<20100217134138.GC26125@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20100217134138.GC26125-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>

Improved comments and formatting of devicetree binding documentation 
for gpios used as chipselect. 

Signed-off-by: Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>
Reviewed-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:

> Hmm, as Grant merged the original patch already, it might be necessary to
> convert this into a follow-up patch. He will surely tell you. For both
> versions, you can add my
> 
> Reviewed-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

Ok, I understand - I have to get used to it...

diff -upr a/Documentation/powerpc/dts-bindings/fsl/spi.txt b/Documentation/powerpc/dts-bindings/fsl/spi.txt
--- a/Documentation/powerpc/dts-bindings/fsl/spi.txt
+++ b/Documentation/powerpc/dts-bindings/fsl/spi.txt
@@ -14,8 +14,8 @@ Required properties:
   services interrupts for this device.
 
 Optional properties:
-- gpios : specifies the gpio pins to be used for chipselects. 
-  The gpios will be referred to as reg=<index> in the SPI child nodes.
+- gpios : specifies the gpio pins to be used for chipselects.
+  The gpios will be referred to as reg = <index> in the SPI child nodes.
   If unspecified, a single SPI device without a chip select can be used.
 
 Example:
@@ -26,6 +26,6 @@ Example:
 		interrupts = <82 0>;
 		interrupt-parent = <700>;
 		mode = "cpu";
-		gpios = <&gpio 18 1	// device reg=<0>, low-active
-			 &gpio 19 1>;	// device reg=<1>, low-active
+		gpios = <&gpio 18 1	// device reg = <0>
+			 &gpio 19 1>;	// device reg = <1>
 	};

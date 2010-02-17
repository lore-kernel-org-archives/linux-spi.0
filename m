From: Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH V2] of: added documentation for spi chipselects
Date: Wed, 17 Feb 2010 13:23:22 +0100
Message-ID: <20100217132322.76cea805.eschwab@online.de>
References: <20100216193957.ccdffee2.eschwab@online.de>
	<20100216201459.GA17428@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Kumar Gala
	<galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20100216201459.GA17428-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
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

Added devicetree binding documentation for gpios used as chipselect. The
code to evaluate these is already present in spi_mpc8xxx.c.

Signed-off-by: Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>
---
diff -upr a/Documentation/powerpc/dts-bindings/fsl/spi.txt b/Documentation/powerpc/dts-bindings/fsl/spi.txt
--- a/Documentation/powerpc/dts-bindings/fsl/spi.txt
+++ b/Documentation/powerpc/dts-bindings/fsl/spi.txt
@@ -13,6 +13,11 @@ Required properties:
 - interrupt-parent : the phandle for the interrupt controller that
   services interrupts for this device.
 
+Optional properties:
+- gpios : specifies the gpio pins to be used for chipselects. 
+  The gpios will be referred to as reg = <index> in the SPI child nodes.
+  If unspecified, a single SPI device without a chip select can be used.
+
 Example:
 	spi@4c0 {
 		cell-index = <0>;
@@ -21,4 +26,6 @@ Example:
 		interrupts = <82 0>;
 		interrupt-parent = <700>;
 		mode = "cpu";
+		gpios = <&gpio 18 1	// device reg = <0>
+			 &gpio 19 1>;	// device reg = <1>
 	};

From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH v2 2/2] spi: dt-bindings: spi-controller: Fix spi-[rt]x-bus-width for slave mode
Date: Tue,  3 Mar 2020 10:45:22 +0100
Message-ID: <20200303094522.23180-3-geert+renesas@glider.be>
References: <20200303094522.23180-1-geert+renesas@glider.be>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Maxime Ripard <mripard-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200303094522.23180-1-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

The descriptions for the spi-rx-bus-width and spi-tx-bus-width
properties refer to "MISO" and "MOSI", which are not explained in the
document.  While these abbreviations are fairly common when talking
about SPI, and thus may not need an explanation, they are not entirely
correct in this context, as the SPI controller may be used in slave mode
instead of master mode.

Fix this by replacing them by "read transfers" resp. "write transfers",
like is done for the spi-rx-delay-us and spi-tx-delay-us properties.

Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
---
v2:
  - New.

This issue was present in the .txt version of the bindings, too, so
technically it needs
Fixes: a8830cb19cfea04e ("spi: Document DT bindings for SPI controllers in slave mode")
but of course it won't apply to that version.
---
 Documentation/devicetree/bindings/spi/spi-controller.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-controller.yaml b/Documentation/devicetree/bindings/spi/spi-controller.yaml
index 401d41a97562dc8d..a07819f4efeb9dfe 100644
--- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
@@ -126,7 +126,7 @@ patternProperties:
           - enum: [ 1, 2, 4, 8 ]
           - default: 1
         description:
-          Bus width to the SPI bus used for MISO.
+          Bus width to the SPI bus used for read transfers.
 
       spi-rx-delay-us:
         description:
@@ -138,7 +138,7 @@ patternProperties:
           - enum: [ 1, 2, 4, 8 ]
           - default: 1
         description:
-          Bus width to the SPI bus used for MOSI.
+          Bus width to the SPI bus used for write transfers.
 
       spi-tx-delay-us:
         description:
-- 
2.17.1

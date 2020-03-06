From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 1/2] spi: dt-bindings: spi-controller: Fix #address-cells for slave mode
Date: Fri,  6 Mar 2020 09:50:37 +0100
Message-ID: <20200306085038.8111-2-geert+renesas@glider.be>
References: <20200306085038.8111-1-geert+renesas@glider.be>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20200306085038.8111-1-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Currently, the DT bindings for an SPI controller specify that
"#address-cells" must be fixed to one.  However, that applies to an SPI
controller in master mode only.  When running in SPI slave mode,
"#address-cells" should not be specified.

Fix this making "#address-cells" mutually-exclusive with "spi-slave".

Fixes: 0a1b929356830257 ("spi: Add YAML schemas for the generic SPI options")
Reported-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - Make #address-cells mutually-exclusive with spi-slave,

v2:
  - Use "enum: [0, 1]" instead of min/max limit,
  - use "- spi-slave" instead of "[ spi-slave ]".
---
 Documentation/devicetree/bindings/spi/spi-controller.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-controller.yaml b/Documentation/devicetree/bindings/spi/spi-controller.yaml
index 1e0ca6ccf64bbd0a..0ebaf6677ac4f68d 100644
--- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
@@ -52,6 +52,12 @@ properties:
     description:
       The SPI controller acts as a slave, instead of a master.
 
+oneOf:
+  - required:
+      - "#address-cells"
+  - required:
+      - spi-slave
+
 patternProperties:
   "^slave$":
     type: object
-- 
2.17.1

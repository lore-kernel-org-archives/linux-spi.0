From: Yixun Lan <yixun.lan@amlogic.com>
Subject: [PATCH 1/3] dt-bindings: spicc: update compatible string for the Meson-AXG
Date: Tue, 28 Nov 2017 21:29:24 +0800
Message-ID: <20171128132926.19051-2-yixun.lan@amlogic.com>
References: <20171128132926.19051-1-yixun.lan@amlogic.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Carlo Caione <carlo@caione.org>,
        Yixun Lan <yixun.lan@amlogic.com>,
        Sunny Luo <sunny.luo@amlogic.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
To: Kevin Hilman <khilman@baylibre.com>, <devicetree@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171128132926.19051-1-yixun.lan@amlogic.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Sunny Luo <sunny.luo@amlogic.com>

Update the compatbile string to support Meson-AXG SoCs.

Signed-off-by: Sunny Luo <sunny.luo@amlogic.com>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 Documentation/devicetree/bindings/spi/spi-meson.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-meson.txt b/Documentation/devicetree/bindings/spi/spi-meson.txt
index 825c39cae74a..b7f5e86fed22 100644
--- a/Documentation/devicetree/bindings/spi/spi-meson.txt
+++ b/Documentation/devicetree/bindings/spi/spi-meson.txt
@@ -27,7 +27,9 @@ The Meson SPICC is generic SPI controller for general purpose Full-Duplex
 communications with dedicated 16 words RX/TX PIO FIFOs.
 
 Required properties:
- - compatible: should be "amlogic,meson-gx-spicc" on Amlogic GX SoCs.
+ - compatible: should be:
+	"amlogic,meson-gx-spicc" on Amlogic GX and compatible SoCs.
+	"amlogic,meson-axg-spicc" on Amlogic AXG and compatible SoCs
  - reg: physical base address and length of the controller registers
  - interrupts: The interrupt specifier
  - clock-names: Must contain "core"
-- 
2.15.0

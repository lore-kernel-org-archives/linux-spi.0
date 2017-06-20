From: Leilk Liu <leilk.liu@mediatek.com>
Subject: [PATCH 1/2] spi: mediatek: Add bindings for mediatek MT2712 soc platform
Date: Tue, 20 Jun 2017 16:21:06 +0800
Message-ID: <1497946867-25708-2-git-send-email-leilk.liu@mediatek.com>
References: <1497946867-25708-1-git-send-email-leilk.liu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        Leilk Liu <leilk.liu@mediatek.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1497946867-25708-1-git-send-email-leilk.liu@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This patch adds a DT binding documentation for the MT2712 soc.

Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
---
 .../devicetree/bindings/spi/spi-mt65xx.txt         |    1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-mt65xx.txt b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
index c0b1f01..e0318cf 100644
--- a/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
+++ b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
@@ -3,6 +3,7 @@ Binding for MTK SPI controller
 Required properties:
 - compatible: should be one of the following.
     - mediatek,mt2701-spi: for mt2701 platforms
+    - mediatek,mt2712-spi: for mt2712 platforms
     - mediatek,mt6589-spi: for mt6589 platforms
     - mediatek,mt7622-spi: for mt7622 platforms
     - mediatek,mt8135-spi: for mt8135 platforms
-- 
1.7.9.5

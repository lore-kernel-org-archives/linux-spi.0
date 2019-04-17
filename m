From: Mark Brown <broonie@kernel.org>
Subject: Applied "dt-bindings: spi: spi-mt65xx: add support for MT8516" to the spi tree
Date: Wed, 17 Apr 2019 17:42:16 +0100 (BST)
Message-ID: <20190417164216.ABE661128FCC@debutante.sirena.org.uk>
References: <1555490836-13382-1-git-send-email-leilk.liu@mediatek.com>
Cc: devicetree@vger.kernel.org, fparent@baylibre.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
To: Leilk Liu <leilk.liu@mediatek.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1555490836-13382-1-git-send-email-leilk.liu@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   dt-bindings: spi: spi-mt65xx: add support for MT8516

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.2

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From bee5c20b7323a7af027d1b4ba538137b518ad232 Mon Sep 17 00:00:00 2001
From: Leilk Liu <leilk.liu@mediatek.com>
Date: Wed, 17 Apr 2019 16:47:16 +0800
Subject: [PATCH] dt-bindings: spi: spi-mt65xx: add support for MT8516

Add binding documentation of spi-mt65xx for MT8516 SOC.

Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/spi/spi-mt65xx.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-mt65xx.txt b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
index 69c356767cf8..c0f6c8ecfa2e 100644
--- a/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
+++ b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
@@ -10,6 +10,7 @@ Required properties:
     - mediatek,mt8135-spi: for mt8135 platforms
     - mediatek,mt8173-spi: for mt8173 platforms
     - mediatek,mt8183-spi: for mt8183 platforms
+    - "mediatek,mt8516-spi", "mediatek,mt2712-spi": for mt8516 platforms
 
 - #address-cells: should be 1.
 
-- 
2.20.1

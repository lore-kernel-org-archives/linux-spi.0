From: Mark Brown <broonie@kernel.org>
Subject: Applied "dt-bindings: spi: update bindings for MT6765 SoC" to the spi
 tree
Date: Fri, 13 Sep 2019 10:42:21 +0100 (BST)
Message-ID: <20190913094221.B131BD0116A@fitzroy.sirena.org.uk>
References: <1568195731-3239-2-git-send-email-luhua.xu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 wsd_upstream@mediatek.com, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linux-spi@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org
To: luhua.xu <luhua.xu@mediatek.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1568195731-3239-2-git-send-email-luhua.xu@mediatek.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

The patch

   dt-bindings: spi: update bindings for MT6765 SoC

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.4

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

>From 7359d108d44b823d5da049ee12302125a08f2216 Mon Sep 17 00:00:00 2001
From: "luhua.xu" <luhua.xu@mediatek.com>
Date: Wed, 11 Sep 2019 05:55:29 -0400
Subject: [PATCH] dt-bindings: spi: update bindings for MT6765 SoC

Add a DT binding documentation for the MT6765 soc.

Signed-off-by: luhua.xu <luhua.xu@mediatek.com>
Link: https://lore.kernel.org/r/1568195731-3239-2-git-send-email-luhua.xu@mediatek.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/spi/spi-mt65xx.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-mt65xx.txt b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
index c0f6c8ecfa2e..3a8079eb18c8 100644
--- a/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
+++ b/Documentation/devicetree/bindings/spi/spi-mt65xx.txt
@@ -5,6 +5,7 @@ Required properties:
     - mediatek,mt2701-spi: for mt2701 platforms
     - mediatek,mt2712-spi: for mt2712 platforms
     - mediatek,mt6589-spi: for mt6589 platforms
+    - mediatek,mt6765-spi: for mt6765 platforms
     - mediatek,mt7622-spi: for mt7622 platforms
     - "mediatek,mt7629-spi", "mediatek,mt7622-spi": for mt7629 platforms
     - mediatek,mt8135-spi: for mt8135 platforms
-- 
2.20.1

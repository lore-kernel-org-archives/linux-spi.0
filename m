From: Leilk Liu <leilk.liu@mediatek.com>
Subject: [PATCH 2/2] spi: mediatek: add spi support for mt2712 IC
Date: Tue, 20 Jun 2017 16:21:07 +0800
Message-ID: <1497946867-25708-3-git-send-email-leilk.liu@mediatek.com>
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

this patch add support for mt2712 IC.

Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
---
 drivers/spi/spi-mt65xx.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index ec7755b..86bf456 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -105,6 +105,10 @@ struct mtk_spi {
 
 static const struct mtk_spi_compatible mtk_common_compat;
 
+static const struct mtk_spi_compatible mt2712_compat = {
+	.must_tx = true,
+};
+
 static const struct mtk_spi_compatible mt7622_compat = {
 	.must_tx = true,
 	.enhance_timing = true,
@@ -130,6 +134,9 @@ struct mtk_spi {
 	{ .compatible = "mediatek,mt2701-spi",
 		.data = (void *)&mtk_common_compat,
 	},
+	{ .compatible = "mediatek,mt2712-spi",
+		.data = (void *)&mt2712_compat,
+	},
 	{ .compatible = "mediatek,mt6589-spi",
 		.data = (void *)&mtk_common_compat,
 	},
-- 
1.7.9.5

From: Luhua Xu <luhua.xu@mediatek.com>
Subject: [PATCH 2/3] spi: mediatek: add spi support for mt6765 IC
Date: Wed, 11 Sep 2019 05:55:30 -0400
Message-ID: <1568195731-3239-3-git-send-email-luhua.xu@mediatek.com>
References: <1568195731-3239-1-git-send-email-luhua.xu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: devicetree@vger.kernel.org, wsd_upstream@mediatek.com,
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-mediatek@lists.infradead.org, "luhua.xu" <luhua.xu@mediatek.com>,
 linux-arm-kernel@lists.infradead.org
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, "Mark
 Rutland" <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1568195731-3239-1-git-send-email-luhua.xu@mediatek.com>
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

From: "luhua.xu" <luhua.xu@mediatek.com>

This patch add spi support for mt6765 IC.

Signed-off-by: luhua.xu <luhua.xu@mediatek.com>
---
 drivers/spi/spi-mt65xx.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 45d8a70..3c73b71 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -102,6 +102,12 @@ static const struct mtk_spi_compatible mt2712_compat = {
 	.must_tx = true,
 };
 
+static const struct mtk_spi_compatible mt6765_compat = {
+	.need_pad_sel = true,
+	.must_tx = true,
+	.enhance_timing = true,
+};
+
 static const struct mtk_spi_compatible mt7622_compat = {
 	.must_tx = true,
 	.enhance_timing = true,
@@ -137,6 +143,9 @@ static const struct of_device_id mtk_spi_of_match[] = {
 	{ .compatible = "mediatek,mt6589-spi",
 		.data = (void *)&mtk_common_compat,
 	},
+	{ .compatible = "mediatek,mt6765-spi",
+		.data = (void *)&mt6765_compat,
+	},
 	{ .compatible = "mediatek,mt7622-spi",
 		.data = (void *)&mt7622_compat,
 	},
-- 
2.6.4

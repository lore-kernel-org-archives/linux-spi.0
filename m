From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH] spi: meson: Constify struct regmap_config
Date: Mon, 05 Jan 2015 10:07:01 +0100
Message-ID: <1420448821-9942-1-git-send-email-k.kozlowski@samsung.com>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The regmap_config struct may be const because it is not modified by the
driver and regmap_init() accepts pointer to const.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/spi/spi-meson-spifc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-meson-spifc.c b/drivers/spi/spi-meson-spifc.c
index 1bbac0378bf7..5468fc70dbf8 100644
--- a/drivers/spi/spi-meson-spifc.c
+++ b/drivers/spi/spi-meson-spifc.c
@@ -85,7 +85,7 @@ struct meson_spifc {
 	struct device *dev;
 };
 
-static struct regmap_config spifc_regmap_config = {
+static const struct regmap_config spifc_regmap_config = {
 	.reg_bits = 32,
 	.val_bits = 32,
 	.reg_stride = 4,
-- 
1.9.1

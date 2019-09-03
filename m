From: Keiji Hayashibara <hayashibara.keiji@socionext.com>
Subject: [PATCH 1/3] spi: uniphier: fix wrong register overwrite
Date: Tue,  3 Sep 2019 14:30:59 +0900
Message-ID: <1567488661-11428-2-git-send-email-hayashibara.keiji@socionext.com>
References: <1567488661-11428-1-git-send-email-hayashibara.keiji@socionext.com>
Cc: masami.hiramatsu@linaro.org, jaswinder.singh@linaro.org,
        linux-kernel@vger.kernel.org, hayashibara.keiji@socionext.com
To: broonie@kernel.org, yamada.masahiro@socionext.com,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1567488661-11428-1-git-send-email-hayashibara.keiji@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

When it changes the spi mode, the register is overwritten incorrectly.
This commit fixes this register overwrite.

Signed-off-by: Keiji Hayashibara <hayashibara.keiji@socionext.com>
---
 drivers/spi/spi-uniphier.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-uniphier.c b/drivers/spi/spi-uniphier.c
index c1e6f32..e6ebbb1 100644
--- a/drivers/spi/spi-uniphier.c
+++ b/drivers/spi/spi-uniphier.c
@@ -214,6 +214,7 @@ static void uniphier_spi_setup_transfer(struct spi_device *spi,
 	if (!priv->is_save_param || priv->mode != spi->mode) {
 		uniphier_spi_set_mode(spi);
 		priv->mode = spi->mode;
+		priv->is_save_param = false;
 	}
 
 	if (!priv->is_save_param || priv->bits_per_word != t->bits_per_word) {
-- 
2.7.4

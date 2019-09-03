From: Keiji Hayashibara <hayashibara.keiji@socionext.com>
Subject: [PATCH 2/3] spi: uniphier: remove unnecessary code
Date: Tue,  3 Sep 2019 14:31:00 +0900
Message-ID: <1567488661-11428-3-git-send-email-hayashibara.keiji@socionext.com>
References: <1567488661-11428-1-git-send-email-hayashibara.keiji@socionext.com>
Cc: masami.hiramatsu@linaro.org, jaswinder.singh@linaro.org,
        linux-kernel@vger.kernel.org, hayashibara.keiji@socionext.com
To: broonie@kernel.org, yamada.masahiro@socionext.com,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1567488661-11428-1-git-send-email-hayashibara.keiji@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This commit removed if() because priv->is_save_param is always true.

Signed-off-by: Keiji Hayashibara <hayashibara.keiji@socionext.com>
---
 drivers/spi/spi-uniphier.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-uniphier.c b/drivers/spi/spi-uniphier.c
index e6ebbb1..d40ad93 100644
--- a/drivers/spi/spi-uniphier.c
+++ b/drivers/spi/spi-uniphier.c
@@ -227,8 +227,7 @@ static void uniphier_spi_setup_transfer(struct spi_device *spi,
 		priv->speed_hz = t->speed_hz;
 	}
 
-	if (!priv->is_save_param)
-		priv->is_save_param = true;
+	priv->is_save_param = true;
 
 	/* reset FIFOs */
 	val = SSI_FC_TXFFL | SSI_FC_RXFFL;
-- 
2.7.4

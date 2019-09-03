From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: uniphier: remove unnecessary code" to the spi tree
Date: Tue,  3 Sep 2019 12:57:49 +0100 (BST)
Message-ID: <20190903115749.11BF62742D3C@ypsilon.sirena.org.uk>
References: <1567488661-11428-3-git-send-email-hayashibara.keiji@socionext.com>
Cc: broonie@kernel.org, hayashibara.keiji@socionext.com,
        jaswinder.singh@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, masami.hiramatsu@linaro.org,
        yamada.masahiro@socionext.com
To: Keiji Hayashibara <hayashibara.keiji@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1567488661-11428-3-git-send-email-hayashibara.keiji@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: uniphier: remove unnecessary code

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

>From 151d0eafa4f59bbc7f8edfbefd5de2c97370d9b9 Mon Sep 17 00:00:00 2001
From: Keiji Hayashibara <hayashibara.keiji@socionext.com>
Date: Tue, 3 Sep 2019 14:31:00 +0900
Subject: [PATCH] spi: uniphier: remove unnecessary code

This commit removed if() because priv->is_save_param is always true.

Signed-off-by: Keiji Hayashibara <hayashibara.keiji@socionext.com>
Link: https://lore.kernel.org/r/1567488661-11428-3-git-send-email-hayashibara.keiji@socionext.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-uniphier.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-uniphier.c b/drivers/spi/spi-uniphier.c
index c1e6f3245557..226f8508bff2 100644
--- a/drivers/spi/spi-uniphier.c
+++ b/drivers/spi/spi-uniphier.c
@@ -226,8 +226,7 @@ static void uniphier_spi_setup_transfer(struct spi_device *spi,
 		priv->speed_hz = t->speed_hz;
 	}
 
-	if (!priv->is_save_param)
-		priv->is_save_param = true;
+	priv->is_save_param = true;
 
 	/* reset FIFOs */
 	val = SSI_FC_TXFFL | SSI_FC_RXFFL;
-- 
2.20.1

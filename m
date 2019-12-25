From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: uniphier: Change argument of irq functions to private structure" to the spi tree
Date: Wed, 25 Dec 2019 00:09:18 +0000 (GMT)
Message-ID: <applied-1577149107-30670-3-git-send-email-hayashi.kunihiko@socionext.com>
References: <1577149107-30670-3-git-send-email-hayashi.kunihiko@socionext.com>
Cc: Jassi Brar <jaswinder.singh@linaro.org>,
        Keiji Hayashibara <hayashibara.keiji@socionext.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1577149107-30670-3-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: uniphier: Change argument of irq functions to private structure

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.6

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

>From 9859db51387df8a7e8564a211158ff8bf263b0a8 Mon Sep 17 00:00:00 2001
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Date: Tue, 24 Dec 2019 09:58:24 +0900
Subject: [PATCH] spi: uniphier: Change argument of irq functions to private
 structure

This changes each argument of functions uniphier_irq_{enable,disable}()
to uniphier_spi_priv because these functions are used not only for
spi_device but also for the entire controller.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Link: https://lore.kernel.org/r/1577149107-30670-3-git-send-email-hayashi.kunihiko@socionext.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-uniphier.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-uniphier.c b/drivers/spi/spi-uniphier.c
index 47cde1864630..a44a1a5fb7b0 100644
--- a/drivers/spi/spi-uniphier.c
+++ b/drivers/spi/spi-uniphier.c
@@ -93,9 +93,9 @@ static inline unsigned int bytes_per_word(unsigned int bits)
 	return bits <= 8 ? 1 : (bits <= 16 ? 2 : 4);
 }
 
-static inline void uniphier_spi_irq_enable(struct spi_device *spi, u32 mask)
+static inline void uniphier_spi_irq_enable(struct uniphier_spi_priv *priv,
+					   u32 mask)
 {
-	struct uniphier_spi_priv *priv = spi_master_get_devdata(spi->master);
 	u32 val;
 
 	val = readl(priv->base + SSI_IE);
@@ -103,9 +103,9 @@ static inline void uniphier_spi_irq_enable(struct spi_device *spi, u32 mask)
 	writel(val, priv->base + SSI_IE);
 }
 
-static inline void uniphier_spi_irq_disable(struct spi_device *spi, u32 mask)
+static inline void uniphier_spi_irq_disable(struct uniphier_spi_priv *priv,
+					    u32 mask)
 {
-	struct uniphier_spi_priv *priv = spi_master_get_devdata(spi->master);
 	u32 val;
 
 	val = readl(priv->base + SSI_IE);
@@ -339,12 +339,12 @@ static int uniphier_spi_transfer_one_irq(struct spi_master *master,
 
 	uniphier_spi_fill_tx_fifo(priv);
 
-	uniphier_spi_irq_enable(spi, SSI_IE_RCIE | SSI_IE_RORIE);
+	uniphier_spi_irq_enable(priv, SSI_IE_RCIE | SSI_IE_RORIE);
 
 	time_left = wait_for_completion_timeout(&priv->xfer_done,
 					msecs_to_jiffies(SSI_TIMEOUT_MS));
 
-	uniphier_spi_irq_disable(spi, SSI_IE_RCIE | SSI_IE_RORIE);
+	uniphier_spi_irq_disable(priv, SSI_IE_RCIE | SSI_IE_RORIE);
 
 	if (!time_left) {
 		dev_err(dev, "transfer timeout.\n");
-- 
2.20.1

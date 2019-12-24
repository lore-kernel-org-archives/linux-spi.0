From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 2/5] spi: uniphier: Change argument of irq functions to private structure
Date: Tue, 24 Dec 2019 09:58:24 +0900
Message-ID: <1577149107-30670-3-git-send-email-hayashi.kunihiko@socionext.com>
References: <1577149107-30670-1-git-send-email-hayashi.kunihiko@socionext.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Keiji Hayashibara <hayashibara.keiji@socionext.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1577149107-30670-1-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This changes each argument of functions uniphier_irq_{enable,disable}()
to uniphier_spi_priv because these functions are used not only for
spi_device but also for the entire controller.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/spi/spi-uniphier.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-uniphier.c b/drivers/spi/spi-uniphier.c
index ce9b301..3859649 100644
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
@@ -346,12 +346,12 @@ static int uniphier_spi_transfer_one_irq(struct spi_master *master,
 
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
2.7.4

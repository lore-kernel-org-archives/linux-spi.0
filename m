From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: uniphier: Add handle_err callback function" to the spi tree
Date: Wed, 25 Dec 2019 00:09:18 +0000 (GMT)
Message-ID: <applied-1577149107-30670-4-git-send-email-hayashi.kunihiko@socionext.com>
References: <1577149107-30670-4-git-send-email-hayashi.kunihiko@socionext.com>
Cc: Jassi Brar <jaswinder.singh@linaro.org>,
        Keiji Hayashibara <hayashibara.keiji@socionext.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1577149107-30670-4-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: uniphier: Add handle_err callback function

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

>From 11299c5cd8868479e9acfc525ba3c2e882c7ba0c Mon Sep 17 00:00:00 2001
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Date: Tue, 24 Dec 2019 09:58:25 +0900
Subject: [PATCH] spi: uniphier: Add handle_err callback function

This adds master->handle_err() callback function to stop transfer due to
error. The function also resets FIFOs and disables interrupt.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Link: https://lore.kernel.org/r/1577149107-30670-4-git-send-email-hayashi.kunihiko@socionext.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-uniphier.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/spi/spi-uniphier.c b/drivers/spi/spi-uniphier.c
index a44a1a5fb7b0..0b255597fdcb 100644
--- a/drivers/spi/spi-uniphier.c
+++ b/drivers/spi/spi-uniphier.c
@@ -425,6 +425,22 @@ static int uniphier_spi_unprepare_transfer_hardware(struct spi_master *master)
 	return 0;
 }
 
+static void uniphier_spi_handle_err(struct spi_master *master,
+				    struct spi_message *msg)
+{
+	struct uniphier_spi_priv *priv = spi_master_get_devdata(master);
+	u32 val;
+
+	/* stop running spi transfer */
+	writel(0, priv->base + SSI_CTL);
+
+	/* reset FIFOs */
+	val = SSI_FC_TXFFL | SSI_FC_RXFFL;
+	writel(val, priv->base + SSI_FC);
+
+	uniphier_spi_irq_disable(priv, SSI_IE_RCIE | SSI_IE_RORIE);
+}
+
 static irqreturn_t uniphier_spi_handler(int irq, void *dev_id)
 {
 	struct uniphier_spi_priv *priv = dev_id;
@@ -531,6 +547,7 @@ static int uniphier_spi_probe(struct platform_device *pdev)
 				= uniphier_spi_prepare_transfer_hardware;
 	master->unprepare_transfer_hardware
 				= uniphier_spi_unprepare_transfer_hardware;
+	master->handle_err = uniphier_spi_handle_err;
 	master->num_chipselect = 1;
 
 	ret = devm_spi_register_master(&pdev->dev, master);
-- 
2.20.1

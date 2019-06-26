From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: uniphier: fix timeout error" to the spi tree
Date: Wed, 26 Jun 2019 12:32:58 +0100 (BST)
Message-ID: <20190626113258.D7724440049@finisterre.sirena.org.uk>
References: <1561509708-4175-2-git-send-email-hayashibara.keiji@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: masami.hiramatsu@linaro.org, hayashibara.keiji@socionext.com,
 yamada.masahiro@socionext.com, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org, jaswinder.singh@linaro.org,
 Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org
To: Keiji Hayashibara <hayashibara.keiji@socionext.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1561509708-4175-2-git-send-email-hayashibara.keiji@socionext.com>
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

   spi: uniphier: fix timeout error

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.2

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

>From e4671df0bfd67d4864de014fa1751d5e2a56c7a6 Mon Sep 17 00:00:00 2001
From: Keiji Hayashibara <hayashibara.keiji@socionext.com>
Date: Wed, 26 Jun 2019 09:41:47 +0900
Subject: [PATCH] spi: uniphier: fix timeout error

Timeout error was silently ignored.
This commit adds timeout error handling and modifies return type of
wait_for_completion_timeout().

Signed-off-by: Keiji Hayashibara <hayashibara.keiji@socionext.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-uniphier.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-uniphier.c b/drivers/spi/spi-uniphier.c
index 5a6137fe172d..c3c35c041ef1 100644
--- a/drivers/spi/spi-uniphier.c
+++ b/drivers/spi/spi-uniphier.c
@@ -328,7 +328,8 @@ static int uniphier_spi_transfer_one(struct spi_master *master,
 				     struct spi_transfer *t)
 {
 	struct uniphier_spi_priv *priv = spi_master_get_devdata(master);
-	int status;
+	struct device *dev = master->dev.parent;
+	unsigned long time_left;
 
 	uniphier_spi_setup_transfer(spi, t);
 
@@ -338,13 +339,15 @@ static int uniphier_spi_transfer_one(struct spi_master *master,
 
 	uniphier_spi_irq_enable(spi, SSI_IE_RCIE | SSI_IE_RORIE);
 
-	status = wait_for_completion_timeout(&priv->xfer_done,
-					     msecs_to_jiffies(SSI_TIMEOUT_MS));
+	time_left = wait_for_completion_timeout(&priv->xfer_done,
+					msecs_to_jiffies(SSI_TIMEOUT_MS));
 
 	uniphier_spi_irq_disable(spi, SSI_IE_RCIE | SSI_IE_RORIE);
 
-	if (status < 0)
-		return status;
+	if (!time_left) {
+		dev_err(dev, "transfer timeout.\n");
+		return -ETIMEDOUT;
+	}
 
 	return priv->error;
 }
-- 
2.20.1

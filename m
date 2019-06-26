From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: uniphier: fix zero-length transfer" to the spi tree
Date: Wed, 26 Jun 2019 12:32:58 +0100 (BST)
Message-ID: <20190626113258.BD290440046@finisterre.sirena.org.uk>
References: <1561509708-4175-3-git-send-email-hayashibara.keiji@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: masami.hiramatsu@linaro.org, hayashibara.keiji@socionext.com,
 yamada.masahiro@socionext.com, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org, jaswinder.singh@linaro.org,
 Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org
To: Keiji Hayashibara <hayashibara.keiji@socionext.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1561509708-4175-3-git-send-email-hayashibara.keiji@socionext.com>
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

   spi: uniphier: fix zero-length transfer

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

>From 2b947137f2b8f77474dfe77d68c52778bf6ae453 Mon Sep 17 00:00:00 2001
From: Keiji Hayashibara <hayashibara.keiji@socionext.com>
Date: Wed, 26 Jun 2019 09:41:48 +0900
Subject: [PATCH] spi: uniphier: fix zero-length transfer

The zero-length transfer results in timeout error because
the transfer doesn't start.
This commit modified to return success in this case.

Signed-off-by: Keiji Hayashibara <hayashibara.keiji@socionext.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-uniphier.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-uniphier.c b/drivers/spi/spi-uniphier.c
index c3c35c041ef1..b32c77df5d49 100644
--- a/drivers/spi/spi-uniphier.c
+++ b/drivers/spi/spi-uniphier.c
@@ -331,6 +331,10 @@ static int uniphier_spi_transfer_one(struct spi_master *master,
 	struct device *dev = master->dev.parent;
 	unsigned long time_left;
 
+	/* Terminate and return success for 0 byte length transfer */
+	if (!t->len)
+		return 0;
+
 	uniphier_spi_setup_transfer(spi, t);
 
 	reinit_completion(&priv->xfer_done);
-- 
2.20.1

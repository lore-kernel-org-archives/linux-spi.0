From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: add power control when set_cs" to the spi tree
Date: Thu, 31 Oct 2019 13:23:42 +0000 (GMT)
Message-ID: <20191031132342.100F1D020AA@fitzroy.sirena.org.uk>
References: <1572426234-30019-1-git-send-email-luhua.xu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: wsd_upstream@mediatek.com, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org
To: Luhua Xu <luhua.xu@mediatek.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1572426234-30019-1-git-send-email-luhua.xu@mediatek.com>
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

   spi: add power control when set_cs

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.5

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

>From d948e6ca189985495a21cd622c31e30e72b6b688 Mon Sep 17 00:00:00 2001
From: Luhua Xu <luhua.xu@mediatek.com>
Date: Wed, 30 Oct 2019 17:03:54 +0800
Subject: [PATCH] spi: add power control when set_cs

As to set_cs takes effect immediately, power spi
is needed when setup spi.

Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Luhua Xu <luhua.xu@mediatek.com>
Link: https://lore.kernel.org/r/1572426234-30019-1-git-send-email-luhua.xu@mediatek.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 5ba19ef809c2..294d0038eea6 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3261,7 +3261,20 @@ int spi_setup(struct spi_device *spi)
 	if (spi->controller->setup)
 		status = spi->controller->setup(spi);
 
-	spi_set_cs(spi, false);
+	if (spi->controller->auto_runtime_pm && spi->controller->set_cs) {
+		status = pm_runtime_get_sync(spi->controller->dev.parent);
+		if (status < 0) {
+			pm_runtime_put_noidle(spi->controller->dev.parent);
+			dev_err(&spi->controller->dev, "Failed to power device: %d\n",
+				status);
+			return status;
+		}
+		spi_set_cs(spi, false);
+		pm_runtime_mark_last_busy(spi->controller->dev.parent);
+		pm_runtime_put_autosuspend(spi->controller->dev.parent);
+	} else {
+		spi_set_cs(spi, false);
+	}
 
 	if (spi->rt && !spi->controller->rt) {
 		spi->controller->rt = true;
-- 
2.20.1

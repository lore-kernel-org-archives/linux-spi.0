From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: dw-pci: Use dev_get_drvdata" to the spi tree
Date: Wed, 24 Jul 2019 20:18:04 +0100 (BST)
Message-ID: <20190724191804.ADA792742BAC@ypsilon.sirena.org.uk>
References: <20190724122331.21856-1-hslester96@gmail.com>
Cc: "Cc:"@sirena.org.uk, "Cc:"@sirena.org.uk,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
To: Chuhong Yuan <hslester96@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190724122331.21856-1-hslester96@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: dw-pci: Use dev_get_drvdata

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

>From 2a3b6f7b02cd141c990c6f5aed41070b5b7f4a7d Mon Sep 17 00:00:00 2001
From: Chuhong Yuan <hslester96@gmail.com>
Date: Wed, 24 Jul 2019 20:23:31 +0800
Subject: [PATCH] spi: dw-pci: Use dev_get_drvdata

Instead of using to_pci_dev + pci_get_drvdata,
use dev_get_drvdata to make code simpler.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
Link: https://lore.kernel.org/r/20190724122331.21856-1-hslester96@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-dw-pci.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-dw-pci.c b/drivers/spi/spi-dw-pci.c
index 9651679ee7f7..c1e2401cace0 100644
--- a/drivers/spi/spi-dw-pci.c
+++ b/drivers/spi/spi-dw-pci.c
@@ -98,16 +98,14 @@ static void spi_pci_remove(struct pci_dev *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int spi_suspend(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct dw_spi *dws = pci_get_drvdata(pdev);
+	struct dw_spi *dws = dev_get_drvdata(dev);
 
 	return dw_spi_suspend_host(dws);
 }
 
 static int spi_resume(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct dw_spi *dws = pci_get_drvdata(pdev);
+	struct dw_spi *dws = dev_get_drvdata(dev);
 
 	return dw_spi_resume_host(dws);
 }
-- 
2.20.1

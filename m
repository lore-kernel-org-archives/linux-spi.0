From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: dw: Add basic runtime PM support" to the spi tree
Date: Tue,  1 Oct 2019 12:41:07 +0100 (BST)
Message-ID: <20191001114107.79E5727429C0@ypsilon.sirena.org.uk>
References: <1568793876-9009-4-git-send-email-gareth.williams.jx@renesas.com>
Cc: Gareth Williams <gareth.williams.jx@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
To: Phil Edworthy <phil.edworthy@renesas.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1568793876-9009-4-git-send-email-gareth.williams.jx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: dw: Add basic runtime PM support

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

>From 1e695983251029dc0b0fc516290077539df400ff Mon Sep 17 00:00:00 2001
From: Phil Edworthy <phil.edworthy@renesas.com>
Date: Wed, 18 Sep 2019 09:04:35 +0100
Subject: [PATCH] spi: dw: Add basic runtime PM support

Enable runtime PM so that the clock used to access the registers in the
peripheral is turned on using a clock domain.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
Signed-off-by: Gareth Williams <gareth.williams.jx@renesas.com>
Link: https://lore.kernel.org/r/1568793876-9009-4-git-send-email-gareth.williams.jx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-dw.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index 9a49e073e8b7..54ed6eb3e252 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/highmem.h>
 #include <linux/delay.h>
+#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
 
@@ -493,10 +494,13 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 	master->dev.of_node = dev->of_node;
 	master->dev.fwnode = dev->fwnode;
 	master->flags = SPI_MASTER_GPIO_SS;
+	master->auto_runtime_pm = true;
 
 	if (dws->set_cs)
 		master->set_cs = dws->set_cs;
 
+	pm_runtime_enable(dev);
+
 	/* Basic HW init */
 	spi_hw_init(dev, dws);
 
@@ -525,6 +529,7 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 	spi_enable_chip(dws, 0);
 	free_irq(dws->irq, master);
 err_free_master:
+	pm_runtime_disable(dev);
 	spi_controller_put(master);
 	return ret;
 }
@@ -539,6 +544,9 @@ void dw_spi_remove_host(struct dw_spi *dws)
 
 	spi_shutdown_chip(dws);
 
+	if (dws->master)
+		pm_runtime_disable(&dws->master->dev);
+
 	free_irq(dws->irq, dws->master);
 }
 EXPORT_SYMBOL_GPL(dw_spi_remove_host);
-- 
2.20.1

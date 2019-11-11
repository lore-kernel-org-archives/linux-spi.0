From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: nxp-fspi: Use devm API to fix missed unregistration of controller" to the spi tree
Date: Mon, 11 Nov 2019 19:49:08 +0000 (GMT)
Message-ID: <20191111194908.D98532742C8A@ypsilon.sirena.org.uk>
References: <20191109075517.29988-1-hslester96@gmail.com>
Cc: Ashish Kumar <ashish.kumar@nxp.com>, "Cc:"@sirena.co.uk,
        "Cc:"@sirena.co.uk, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>
To: Chuhong Yuan <hslester96@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191109075517.29988-1-hslester96@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: nxp-fspi: Use devm API to fix missed unregistration of controller

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

>From 69c23dbf5f695c219008257b3bd86cff63edbe0b Mon Sep 17 00:00:00 2001
From: Chuhong Yuan <hslester96@gmail.com>
Date: Sat, 9 Nov 2019 15:55:17 +0800
Subject: [PATCH] spi: nxp-fspi: Use devm API to fix missed unregistration of
 controller

This driver forgets to unregister controller when remove.
Use devm API to unregister it automatically to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
Link: https://lore.kernel.org/r/20191109075517.29988-1-hslester96@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-nxp-fspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 501b923f2c27..c36bb1bb464e 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -1027,7 +1027,7 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 
 	ctlr->dev.of_node = np;
 
-	ret = spi_register_controller(ctlr);
+	ret = devm_spi_register_controller(&pdev->dev, ctlr);
 	if (ret)
 		goto err_destroy_mutex;
 
-- 
2.20.1

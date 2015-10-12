From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: spi-coldfire-qspi: enable RuntimePM before registering to the core" to the spi tree
Date: Mon, 12 Oct 2015 17:59:36 +0100
Message-ID: <E1ZlgRk-00053J-5C@finisterre>
References: <1444383567-18113-4-git-send-email-wsa@the-dreams.de>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1444383567-18113-4-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: spi-coldfire-qspi: enable RuntimePM before registering to the core

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From f9b841af4c1c3c3b7ce3552ab5ee5d9c430e9c29 Mon Sep 17 00:00:00 2001
From: Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>
Date: Fri, 9 Oct 2015 10:39:27 +0100
Subject: [PATCH] spi: spi-coldfire-qspi: enable RuntimePM before registering
 to the core

The core may register clients attached to this master which may use
funtionality from the master. So, RuntimePM must be enabled before, otherwise
this will fail.

Signed-off-by: Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-coldfire-qspi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-coldfire-qspi.c b/drivers/spi/spi-coldfire-qspi.c
index 688956ff..23f6fff 100644
--- a/drivers/spi/spi-coldfire-qspi.c
+++ b/drivers/spi/spi-coldfire-qspi.c
@@ -420,19 +420,20 @@ static int mcfqspi_probe(struct platform_device *pdev)
 	master->auto_runtime_pm = true;
 
 	platform_set_drvdata(pdev, master);
+	pm_runtime_enable(&pdev->dev);
 
 	status = devm_spi_register_master(&pdev->dev, master);
 	if (status) {
 		dev_dbg(&pdev->dev, "spi_register_master failed\n");
 		goto fail2;
 	}
-	pm_runtime_enable(&pdev->dev);
 
 	dev_info(&pdev->dev, "Coldfire QSPI bus driver\n");
 
 	return 0;
 
 fail2:
+	pm_runtime_disable(&pdev->dev);
 	mcfqspi_cs_teardown(mcfqspi);
 fail1:
 	clk_disable(mcfqspi->clk);
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

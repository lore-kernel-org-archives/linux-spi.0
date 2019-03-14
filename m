From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: spi-fsl-qspi: use devm_spi_register_controller" to the spi tree
Date: Thu, 14 Mar 2019 15:54:47 +0000 (GMT)
Message-ID: <20190314155447.235511126E64@debutante.sirena.org.uk>
References: <20190312101203.14207-2-volker.haspel@linutronix.de>
Cc: John Ogness <john.ogness@linutronix.de>,
        Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        han.xu@nxp.com, volker.haspel@linutronix.de,
        john.ogness@linutronix.de, linux-spi@vger.kernel.org
To: Volker Haspel <volker.haspel@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190312101203.14207-2-volker.haspel@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: spi-fsl-qspi: use devm_spi_register_controller

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From 8fcb830a00f0980ffe38d223cdd9a4d2d24da476 Mon Sep 17 00:00:00 2001
From: Volker Haspel <volker.haspel@linutronix.de>
Date: Tue, 12 Mar 2019 11:12:03 +0100
Subject: [PATCH] spi: spi-fsl-qspi: use devm_spi_register_controller

The driver does not clearly unregister the spi controller.
Therefore calling an unbind and bind again will end up in a
Kernel crash.

The function devm_spi_register_controller will automatically
be unregister the SPI device.

Signed-off-by: Volker Haspel <volker.haspel@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-fsl-qspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
index 6a713f78a62e..41a49b93ca60 100644
--- a/drivers/spi/spi-fsl-qspi.c
+++ b/drivers/spi/spi-fsl-qspi.c
@@ -882,7 +882,7 @@ static int fsl_qspi_probe(struct platform_device *pdev)
 
 	ctlr->dev.of_node = np;
 
-	ret = spi_register_controller(ctlr);
+	ret = devm_spi_register_controller(dev, ctlr);
 	if (ret)
 		goto err_destroy_mutex;
 
-- 
2.20.1

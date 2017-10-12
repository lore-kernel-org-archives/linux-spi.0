From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: bcm-qspi: Fix use after free in bcm_qspi_probe() in error path" to the spi tree
Date: Thu, 12 Oct 2017 11:17:43 +0100
Message-ID: <E1e2aYh-0007gJ-Dz@debutante>
References: <20171011215922.20536-1-f.fainelli@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, kdasu.kdev@gmail.com,
        bcm-kernel-feedback-list@broadcom.com,
        Mark Brown <broonie@kernel.org>,
        "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
        linux-spi@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171011215922.20536-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: bcm-qspi: Fix use after free in bcm_qspi_probe() in error path

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

>From c0368e4db4a3e8a3dce40f3f621c06e14c560d79 Mon Sep 17 00:00:00 2001
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Wed, 11 Oct 2017 14:59:22 -0700
Subject: [PATCH] spi: bcm-qspi: Fix use after free in bcm_qspi_probe() in
 error path

There was an inversion in how the error path in bcm_qspi_probe() is done
which would make us trip over a KASAN use-after-free report. Turns out
that qspi->dev_ids does not get allocated until later in the probe
process. Fix this by introducing a new lable: qspi_resource_err which
takes care of cleaning up the SPI master instance.

Fixes: fa236a7ef240 ("spi: bcm-qspi: Add Broadcom MSPI driver")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/spi/spi-bcm-qspi.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index 6ef6c44f39f5..a172ab299e80 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -1250,7 +1250,7 @@ int bcm_qspi_probe(struct platform_device *pdev,
 			goto qspi_probe_err;
 		}
 	} else {
-		goto qspi_probe_err;
+		goto qspi_resource_err;
 	}
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "bspi");
@@ -1272,7 +1272,7 @@ int bcm_qspi_probe(struct platform_device *pdev,
 		qspi->base[CHIP_SELECT]  = devm_ioremap_resource(dev, res);
 		if (IS_ERR(qspi->base[CHIP_SELECT])) {
 			ret = PTR_ERR(qspi->base[CHIP_SELECT]);
-			goto qspi_probe_err;
+			goto qspi_resource_err;
 		}
 	}
 
@@ -1280,7 +1280,7 @@ int bcm_qspi_probe(struct platform_device *pdev,
 				GFP_KERNEL);
 	if (!qspi->dev_ids) {
 		ret = -ENOMEM;
-		goto qspi_probe_err;
+		goto qspi_resource_err;
 	}
 
 	for (val = 0; val < num_irqs; val++) {
@@ -1369,8 +1369,9 @@ int bcm_qspi_probe(struct platform_device *pdev,
 	bcm_qspi_hw_uninit(qspi);
 	clk_disable_unprepare(qspi->clk);
 qspi_probe_err:
-	spi_master_put(master);
 	kfree(qspi->dev_ids);
+qspi_resource_err:
+	spi_master_put(master);
 	return ret;
 }
 /* probe function to be called by SoC specific platform driver probe */
-- 
2.14.1

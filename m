From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: omap2-mcspi: remove redundant check for error status" to the spi tree
Date: Fri, 26 May 2017 12:42:18 +0100
Message-ID: <E1dEDdK-0000r7-Nf@debutante>
References: <20170525165134.18103-1-colin.king@canonical.com>
Cc: Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
To: Colin Ian King <colin.king@canonical.com>
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20170525165134.18103-1-colin.king@canonical.com>
Sender: kernel-janitors-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: omap2-mcspi: remove redundant check for error status

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

>From ad7449969d827965484306ad8cc56edc7e55687c Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Thu, 25 May 2017 17:51:34 +0100
Subject: [PATCH] spi: omap2-mcspi: remove redundant check for error status

The check to see if status is less than zero is actually redundant
as all previous places where it is -ve have already branched to the
exit paths, so it is never less than zero at the check.

Detected by CoverityScan, CID#1357119 ("Logically dead code")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-omap2-mcspi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 7275223dbcd4..e048268d8ba2 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -1412,9 +1412,6 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 		sprintf(mcspi->dma_channels[i].dma_tx_ch_name, "tx%d", i);
 	}
 
-	if (status < 0)
-		goto free_master;
-
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, SPI_AUTOSUSPEND_TIMEOUT);
 	pm_runtime_enable(&pdev->dev);
-- 
2.11.0


From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: tegra114: set master cleanup and also invoke it on probe error" to the spi tree
Date: Thu, 23 May 2019 14:49:06 +0100 (BST)
Message-ID: <20190523134906.A81C51126D25@debutante.sirena.org.uk>
References: <1558574945-19275-1-git-send-email-skomatineni@nvidia.com>
Cc: broonie@kernel.org, jonathanh@nvidia.com, ldewangan@nvidia.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-tegra@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        natechancellor@gmail.com, thierry.reding@gmail.com
To: Sowjanya Komatineni <skomatineni@nvidia.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1558574945-19275-1-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: tegra114: set master cleanup and also invoke it on probe error

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.3

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

>From 0e896f380b845d3fb889f27eb6026cd494bb3cd8 Mon Sep 17 00:00:00 2001
From: Sowjanya Komatineni <skomatineni@nvidia.com>
Date: Wed, 22 May 2019 18:29:04 -0700
Subject: [PATCH] spi: tegra114: set master cleanup and also invoke it on probe
 error

This patch sets master cleanup and also invokes tegra spi clean on
tegra spi probe failure to release tegra spi client data.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-tegra114.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 253a7f182fc9..15f9368fc0f8 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -966,6 +966,8 @@ static int tegra_spi_setup(struct spi_device *spi)
 	ret = pm_runtime_get_sync(tspi->dev);
 	if (ret < 0) {
 		dev_err(tspi->dev, "pm runtime failed, e = %d\n", ret);
+		if (cdata)
+			tegra_spi_cleanup(spi);
 		return ret;
 	}
 
@@ -1331,6 +1333,7 @@ static int tegra_spi_probe(struct platform_device *pdev)
 			    SPI_TX_DUAL | SPI_RX_DUAL | SPI_3WIRE;
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
 	master->setup = tegra_spi_setup;
+	master->cleanup = tegra_spi_cleanup;
 	master->transfer_one_message = tegra_spi_transfer_one_message;
 	master->set_cs_timing = tegra_spi_set_hw_cs_timing;
 	master->num_chipselect = MAX_CHIP_SELECT;
-- 
2.20.1

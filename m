From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: tegra114: add 3 wire transfer mode support" to the spi tree
Date: Mon,  8 Apr 2019 14:31:58 +0700 (+07)
Message-ID: <20190408073158.246DB441D3B@finisterre.ee.mobilebroadband>
References: <1554423259-26056-9-git-send-email-skomatineni@nvidia.com>
Cc: Mark Brown <broonie@kernel.org>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, talho@nvidia.com, skomatineni@nvidia.com,
        broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        kyarlagadda@nvidia.com, ldewangan@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org
To: Sowjanya Komatineni <skomatineni@nvidia.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1554423259-26056-9-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: tegra114: add 3 wire transfer mode support

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

>From 9d199231b000414e420a35912760f2d67e9c56d7 Mon Sep 17 00:00:00 2001
From: Sowjanya Komatineni <skomatineni@nvidia.com>
Date: Thu, 4 Apr 2019 17:14:08 -0700
Subject: [PATCH] spi: tegra114: add 3 wire transfer mode support

This patch adds 3 wire transfer support to SPI mode list along with
its implementation.

3 wire or Bi-directional mode uses only one serial data pin for the
transfer. SPI in master mode uses MOSI data line only and MISO data
line is not used.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-tegra114.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 1e749ce13029..751672b3bc16 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -754,6 +754,11 @@ static u32 tegra_spi_setup_transfer_one(struct spi_device *spi,
 		else
 			command1 &= ~SPI_LSBIT_FE;
 
+		if (spi->mode & SPI_3WIRE)
+			command1 |= SPI_BIDIROE;
+		else
+			command1 &= ~SPI_BIDIROE;
+
 		if (tspi->cs_control) {
 			if (tspi->cs_control != spi)
 				tegra_spi_writel(tspi, command1, SPI_COMMAND1);
@@ -1158,7 +1163,7 @@ static int tegra_spi_probe(struct platform_device *pdev)
 
 	/* the spi->mode bits understood by this driver: */
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST |
-			    SPI_TX_DUAL | SPI_RX_DUAL;
+			    SPI_TX_DUAL | SPI_RX_DUAL | SPI_3WIRE;
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
 	master->setup = tegra_spi_setup;
 	master->transfer_one_message = tegra_spi_transfer_one_message;
-- 
2.20.1

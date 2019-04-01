From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: tegra114: add SPI_LSB_FIRST support" to the spi tree
Date: Mon,  1 Apr 2019 09:54:12 +0100 (BST)
Message-ID: <20190401085412.D5F23440082@finisterre.ee.mobilebroadband>
References: <1553666207-11414-12-git-send-email-skomatineni@nvidia.com>
Cc: Mark Brown <broonie@kernel.org>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, talho@nvidia.com, skomatineni@nvidia.com,
        broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        kyarlagadda@nvidia.com, ldewangan@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org
To: Sowjanya Komatineni <skomatineni@nvidia.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1553666207-11414-12-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: tegra114: add SPI_LSB_FIRST support

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

>From 2b17a3c759e5e2ed3faafb69e243ec312e3bf0da Mon Sep 17 00:00:00 2001
From: Sowjanya Komatineni <skomatineni@nvidia.com>
Date: Tue, 26 Mar 2019 22:56:33 -0700
Subject: [PATCH] spi: tegra114: add SPI_LSB_FIRST support

Tegra SPI controller supports lsb first mode. Default is MSB bit first
and on selection of SPI_LSB_FIRST through SPI mode transmission happens
with LSB bit first.

This patch adds SPI_LSB_FIRST flag to mode_bits and also configures it
on request.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-tegra114.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 929358e3487a..0c52aeeb1d4f 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -696,6 +696,11 @@ static u32 tegra_spi_setup_transfer_one(struct spi_device *spi,
 		else if (req_mode == SPI_MODE_3)
 			command1 |= SPI_CONTROL_MODE_3;
 
+		if (spi->mode & SPI_LSB_FIRST)
+			command1 |= SPI_LSBIT_FE;
+		else
+			command1 &= ~SPI_LSBIT_FE;
+
 		if (tspi->cs_control) {
 			if (tspi->cs_control != spi)
 				tegra_spi_writel(tspi, command1, SPI_COMMAND1);
@@ -1047,7 +1052,7 @@ static int tegra_spi_probe(struct platform_device *pdev)
 		master->max_speed_hz = 25000000; /* 25MHz */
 
 	/* the spi->mode bits understood by this driver: */
-	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
+	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST;
 	master->setup = tegra_spi_setup;
 	master->transfer_one_message = tegra_spi_transfer_one_message;
 	master->num_chipselect = MAX_CHIP_SELECT;
-- 
2.20.1

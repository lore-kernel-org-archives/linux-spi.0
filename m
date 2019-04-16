From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: tegra114: fix PIO transfer" to the spi tree
Date: Tue, 16 Apr 2019 17:32:57 +0100 (BST)
Message-ID: <20190416163257.956F211281C6@debutante.sirena.org.uk>
References: <1555363834-32155-2-git-send-email-skomatineni@nvidia.com>
Cc: broonie@kernel.org, devicetree@vger.kernel.org,
        jonathanh@nvidia.com, kyarlagadda@nvidia.com, ldewangan@nvidia.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-tegra@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        mark.rutland@arm.com, robh+dt@kernel.org, skomatineni@nvidia.com,
        talho@nvidia.com, thierry.reding@gmail.com
To: Sowjanya Komatineni <skomatineni@nvidia.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1555363834-32155-2-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: tegra114: fix PIO transfer

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.1

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

>From 3f6e3f7843a6a1667ed890ca51a1388fc7bf3429 Mon Sep 17 00:00:00 2001
From: Sowjanya Komatineni <skomatineni@nvidia.com>
Date: Mon, 15 Apr 2019 14:30:26 -0700
Subject: [PATCH] spi: tegra114: fix PIO transfer

This patch fixes PIO mode transfer to use PIO bit in SPI_COMMAND1 register.
Current driver uses DMA_EN instead of PIO bit.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-tegra114.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index b57f10182fae..21e4fdad013f 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -641,8 +641,9 @@ static int tegra_spi_start_cpu_based_transfer(
 
 	tspi->is_curr_dma_xfer = false;
 
-	val |= SPI_DMA_EN;
-	tegra_spi_writel(tspi, val, SPI_DMA_CTL);
+	val = tspi->command1_reg;
+	val |= SPI_PIO;
+	tegra_spi_writel(tspi, val, SPI_COMMAND1);
 	return 0;
 }
 
-- 
2.20.1

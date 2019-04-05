From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: tegra114: avoid reset call in atomic context" to the spi tree
Date: Fri,  5 Apr 2019 10:26:57 +0700 (+07)
Message-ID: <20190405032657.E0F6B441D3B@finisterre.ee.mobilebroadband>
References: <1554423259-26056-4-git-send-email-skomatineni@nvidia.com>
Cc: Mark Brown <broonie@kernel.org>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, talho@nvidia.com, skomatineni@nvidia.com,
        broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        kyarlagadda@nvidia.com, ldewangan@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org
To: Sowjanya Komatineni <skomatineni@nvidia.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1554423259-26056-4-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: tegra114: avoid reset call in atomic context

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

>From a026525d4e45e3d9690bffd0b05d018ff5638b5a Mon Sep 17 00:00:00 2001
From: Sowjanya Komatineni <skomatineni@nvidia.com>
Date: Thu, 4 Apr 2019 17:14:03 -0700
Subject: [PATCH] spi: tegra114: avoid reset call in atomic context

This patch moves SPI controller reset out of spin lock.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-tegra114.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 8de002fc6943..b57f10182fae 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -967,11 +967,12 @@ static irqreturn_t handle_cpu_based_xfer(struct tegra_spi_data *tspi)
 		dev_err(tspi->dev, "CpuXfer 0x%08x:0x%08x\n",
 			tspi->command1_reg, tspi->dma_control_reg);
 		tegra_spi_flush_fifos(tspi);
+		complete(&tspi->xfer_completion);
+		spin_unlock_irqrestore(&tspi->lock, flags);
 		reset_control_assert(tspi->rst);
 		udelay(2);
 		reset_control_deassert(tspi->rst);
-		complete(&tspi->xfer_completion);
-		goto exit;
+		return IRQ_HANDLED;
 	}
 
 	if (tspi->cur_direction & DATA_DIR_RX)
@@ -1040,11 +1041,11 @@ static irqreturn_t handle_dma_based_xfer(struct tegra_spi_data *tspi)
 		dev_err(tspi->dev, "DmaXfer 0x%08x:0x%08x\n",
 			tspi->command1_reg, tspi->dma_control_reg);
 		tegra_spi_flush_fifos(tspi);
+		complete(&tspi->xfer_completion);
+		spin_unlock_irqrestore(&tspi->lock, flags);
 		reset_control_assert(tspi->rst);
 		udelay(2);
 		reset_control_deassert(tspi->rst);
-		complete(&tspi->xfer_completion);
-		spin_unlock_irqrestore(&tspi->lock, flags);
 		return IRQ_HANDLED;
 	}
 
-- 
2.20.1

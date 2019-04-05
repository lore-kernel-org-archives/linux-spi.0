From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: tegra114: dump SPI registers during timeout" to the spi tree
Date: Fri,  5 Apr 2019 10:26:54 +0700 (+07)
Message-ID: <20190405032654.ED4A8441D3D@finisterre.ee.mobilebroadband>
References: <1554423259-26056-5-git-send-email-skomatineni@nvidia.com>
Cc: Mark Brown <broonie@kernel.org>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, talho@nvidia.com, skomatineni@nvidia.com,
        broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        kyarlagadda@nvidia.com, ldewangan@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org
To: Sowjanya Komatineni <skomatineni@nvidia.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1554423259-26056-5-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: tegra114: dump SPI registers during timeout

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

>From a0253c8fa18129f423c22f175a83d81423e60715 Mon Sep 17 00:00:00 2001
From: Sowjanya Komatineni <skomatineni@nvidia.com>
Date: Thu, 4 Apr 2019 17:14:04 -0700
Subject: [PATCH] spi: tegra114: dump SPI registers during timeout

This patch dumps SPI registers on transfer error or timeout for debug
purpose.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-tegra114.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 8c33bf056196..99019f6d2d84 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -874,6 +874,20 @@ static void tegra_spi_transfer_end(struct spi_device *spi)
 	tegra_spi_writel(tspi, tspi->def_command1_reg, SPI_COMMAND1);
 }
 
+static void tegra_spi_dump_regs(struct tegra_spi_data *tspi)
+{
+	dev_dbg(tspi->dev, "============ SPI REGISTER DUMP ============\n");
+	dev_dbg(tspi->dev, "Command1:    0x%08x | Command2:    0x%08x\n",
+		tegra_spi_readl(tspi, SPI_COMMAND1),
+		tegra_spi_readl(tspi, SPI_COMMAND2));
+	dev_dbg(tspi->dev, "DMA_CTL:     0x%08x | DMA_BLK:     0x%08x\n",
+		tegra_spi_readl(tspi, SPI_DMA_CTL),
+		tegra_spi_readl(tspi, SPI_DMA_BLK));
+	dev_dbg(tspi->dev, "TRANS_STAT:  0x%08x | FIFO_STATUS: 0x%08x\n",
+		tegra_spi_readl(tspi, SPI_TRANS_STATUS),
+		tegra_spi_readl(tspi, SPI_FIFO_STATUS));
+}
+
 static int tegra_spi_transfer_one_message(struct spi_master *master,
 			struct spi_message *msg)
 {
@@ -920,6 +934,7 @@ static int tegra_spi_transfer_one_message(struct spi_master *master,
 			    (tspi->cur_direction & DATA_DIR_RX))
 				dmaengine_terminate_all(tspi->rx_dma_chan);
 			ret = -EIO;
+			tegra_spi_dump_regs(tspi);
 			tegra_spi_flush_fifos(tspi);
 			reset_control_assert(tspi->rst);
 			udelay(2);
@@ -930,6 +945,7 @@ static int tegra_spi_transfer_one_message(struct spi_master *master,
 		if (tspi->tx_status ||  tspi->rx_status) {
 			dev_err(tspi->dev, "Error in Transfer\n");
 			ret = -EIO;
+			tegra_spi_dump_regs(tspi);
 			goto complete_xfer;
 		}
 		msg->actual_length += xfer->len;
@@ -971,6 +987,7 @@ static irqreturn_t handle_cpu_based_xfer(struct tegra_spi_data *tspi)
 			tspi->status_reg);
 		dev_err(tspi->dev, "CpuXfer 0x%08x:0x%08x\n",
 			tspi->command1_reg, tspi->dma_control_reg);
+		tegra_spi_dump_regs(tspi);
 		tegra_spi_flush_fifos(tspi);
 		complete(&tspi->xfer_completion);
 		spin_unlock_irqrestore(&tspi->lock, flags);
@@ -1045,6 +1062,7 @@ static irqreturn_t handle_dma_based_xfer(struct tegra_spi_data *tspi)
 			tspi->status_reg);
 		dev_err(tspi->dev, "DmaXfer 0x%08x:0x%08x\n",
 			tspi->command1_reg, tspi->dma_control_reg);
+		tegra_spi_dump_regs(tspi);
 		tegra_spi_flush_fifos(tspi);
 		complete(&tspi->xfer_completion);
 		spin_unlock_irqrestore(&tspi->lock, flags);
-- 
2.20.1

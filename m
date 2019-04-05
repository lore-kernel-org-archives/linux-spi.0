From: Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V2 05/20] spi: tegra114: dump SPI registers during timeout
Date: Thu, 4 Apr 2019 17:14:04 -0700
Message-ID: <1554423259-26056-5-git-send-email-skomatineni@nvidia.com>
References: <1554423259-26056-1-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <ldewangan@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
To: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <talho@nvidia.com>, <skomatineni@nvidia.com>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <kyarlagadda@nvidia.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1554423259-26056-1-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This patch dumps SPI registers on transfer error or timeout for debug
purpose.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/spi/spi-tegra114.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index d928a2c92a3d..e0f20fad5df2 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -876,6 +876,20 @@ static void tegra_spi_transfer_end(struct spi_device *spi)
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
@@ -922,6 +936,7 @@ static int tegra_spi_transfer_one_message(struct spi_master *master,
 			    (tspi->cur_direction & DATA_DIR_RX))
 				dmaengine_terminate_all(tspi->rx_dma_chan);
 			ret = -EIO;
+			tegra_spi_dump_regs(tspi);
 			tegra_spi_flush_fifos(tspi);
 			reset_control_assert(tspi->rst);
 			udelay(2);
@@ -932,6 +947,7 @@ static int tegra_spi_transfer_one_message(struct spi_master *master,
 		if (tspi->tx_status ||  tspi->rx_status) {
 			dev_err(tspi->dev, "Error in Transfer\n");
 			ret = -EIO;
+			tegra_spi_dump_regs(tspi);
 			goto complete_xfer;
 		}
 		msg->actual_length += xfer->len;
@@ -973,6 +989,7 @@ static irqreturn_t handle_cpu_based_xfer(struct tegra_spi_data *tspi)
 			tspi->status_reg);
 		dev_err(tspi->dev, "CpuXfer 0x%08x:0x%08x\n",
 			tspi->command1_reg, tspi->dma_control_reg);
+		tegra_spi_dump_regs(tspi);
 		tegra_spi_flush_fifos(tspi);
 		complete(&tspi->xfer_completion);
 		spin_unlock_irqrestore(&tspi->lock, flags);
@@ -1047,6 +1064,7 @@ static irqreturn_t handle_dma_based_xfer(struct tegra_spi_data *tspi)
 			tspi->status_reg);
 		dev_err(tspi->dev, "DmaXfer 0x%08x:0x%08x\n",
 			tspi->command1_reg, tspi->dma_control_reg);
+		tegra_spi_dump_regs(tspi);
 		tegra_spi_flush_fifos(tspi);
 		complete(&tspi->xfer_completion);
 		spin_unlock_irqrestore(&tspi->lock, flags);
-- 
2.7.4

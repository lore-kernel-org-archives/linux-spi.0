From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: tegra114: flush fifos" to the spi tree
Date: Mon,  1 Apr 2019 09:54:34 +0100 (BST)
Message-ID: <20190401085434.F3EBF440082@finisterre.ee.mobilebroadband>
References: <1553666207-11414-7-git-send-email-skomatineni@nvidia.com>
Cc: Mark Brown <broonie@kernel.org>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, talho@nvidia.com, skomatineni@nvidia.com,
        broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        kyarlagadda@nvidia.com, ldewangan@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org
To: Sowjanya Komatineni <skomatineni@nvidia.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1553666207-11414-7-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: tegra114: flush fifos

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

>From c4fc9e5b28ff787e35137c2cc13316bb11d7657b Mon Sep 17 00:00:00 2001
From: Sowjanya Komatineni <skomatineni@nvidia.com>
Date: Tue, 26 Mar 2019 22:56:28 -0700
Subject: [PATCH] spi: tegra114: flush fifos

Fixes: Flush TX and RX FIFOs before start of new transfer and on FIFO
overflow or underrun errors.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-tegra114.c | 39 +++++++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index a6153b905d1a..28aa080a94ff 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -499,22 +499,37 @@ static int tegra_spi_start_rx_dma(struct tegra_spi_data *tspi, int len)
 	return 0;
 }
 
-static int tegra_spi_start_dma_based_transfer(
-		struct tegra_spi_data *tspi, struct spi_transfer *t)
+static int tegra_spi_flush_fifos(struct tegra_spi_data *tspi)
 {
-	u32 val;
-	unsigned int len;
-	int ret = 0;
+	unsigned long timeout = jiffies + HZ;
 	u32 status;
 
-	/* Make sure that Rx and Tx fifo are empty */
 	status = tegra_spi_readl(tspi, SPI_FIFO_STATUS);
 	if ((status & SPI_FIFO_EMPTY) != SPI_FIFO_EMPTY) {
-		dev_err(tspi->dev, "Rx/Tx fifo are not empty status 0x%08x\n",
-			(unsigned)status);
-		return -EIO;
+		status |= SPI_RX_FIFO_FLUSH | SPI_TX_FIFO_FLUSH;
+		tegra_spi_writel(tspi, status, SPI_FIFO_STATUS);
+		while ((status & SPI_FIFO_EMPTY) != SPI_FIFO_EMPTY) {
+			status = tegra_spi_readl(tspi, SPI_FIFO_STATUS);
+			if (time_after(jiffies, timeout)) {
+				dev_err(tspi->dev,
+					"timeout waiting for fifo flush\n");
+				return -EIO;
+			}
+
+			udelay(1);
+		}
 	}
 
+	return 0;
+}
+
+static int tegra_spi_start_dma_based_transfer(
+		struct tegra_spi_data *tspi, struct spi_transfer *t)
+{
+	u32 val;
+	unsigned int len;
+	int ret = 0;
+
 	val = SPI_DMA_BLK_SET(tspi->curr_dma_words - 1);
 	tegra_spi_writel(tspi, val, SPI_DMA_BLK);
 
@@ -779,6 +794,9 @@ static int tegra_spi_start_transfer_one(struct spi_device *spi,
 	dev_dbg(tspi->dev, "The def 0x%x and written 0x%x\n",
 		tspi->def_command1_reg, (unsigned)command1);
 
+	ret = tegra_spi_flush_fifos(tspi);
+	if (ret < 0)
+		return ret;
 	if (total_fifo_words > SPI_FIFO_DEPTH)
 		ret = tegra_spi_start_dma_based_transfer(tspi, t);
 	else
@@ -876,6 +894,7 @@ static int tegra_spi_transfer_one_message(struct spi_master *master,
 			    (tspi->cur_direction & DATA_DIR_RX))
 				dmaengine_terminate_all(tspi->rx_dma_chan);
 			ret = -EIO;
+			tegra_spi_flush_fifos(tspi);
 			reset_control_assert(tspi->rst);
 			udelay(2);
 			reset_control_deassert(tspi->rst);
@@ -929,6 +948,7 @@ static irqreturn_t handle_cpu_based_xfer(struct tegra_spi_data *tspi)
 			tspi->status_reg);
 		dev_err(tspi->dev, "CpuXfer 0x%08x:0x%08x\n",
 			tspi->command1_reg, tspi->dma_control_reg);
+		tegra_spi_flush_fifos(tspi);
 		reset_control_assert(tspi->rst);
 		udelay(2);
 		reset_control_deassert(tspi->rst);
@@ -1001,6 +1021,7 @@ static irqreturn_t handle_dma_based_xfer(struct tegra_spi_data *tspi)
 			tspi->status_reg);
 		dev_err(tspi->dev, "DmaXfer 0x%08x:0x%08x\n",
 			tspi->command1_reg, tspi->dma_control_reg);
+		tegra_spi_flush_fifos(tspi);
 		reset_control_assert(tspi->rst);
 		udelay(2);
 		reset_control_deassert(tspi->rst);
-- 
2.20.1

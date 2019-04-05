From: Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V2 04/20] spi: tegra114: avoid reset call in atomic context
Date: Thu, 4 Apr 2019 17:14:03 -0700
Message-ID: <1554423259-26056-4-git-send-email-skomatineni@nvidia.com>
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

This patch moves SPI controller reset out of spin lock.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/spi/spi-tegra114.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index c60e40cab0a0..d928a2c92a3d 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -974,11 +974,12 @@ static irqreturn_t handle_cpu_based_xfer(struct tegra_spi_data *tspi)
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
@@ -1047,11 +1048,11 @@ static irqreturn_t handle_dma_based_xfer(struct tegra_spi_data *tspi)
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
2.7.4

From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: tegra114: add dual mode support" to the spi tree
Date: Mon,  8 Apr 2019 14:32:06 +0700 (+07)
Message-ID: <20190408073206.BC75D441D3C@finisterre.ee.mobilebroadband>
References: <1554423259-26056-8-git-send-email-skomatineni@nvidia.com>
Cc: Mark Brown <broonie@kernel.org>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, talho@nvidia.com, skomatineni@nvidia.com,
        broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        kyarlagadda@nvidia.com, ldewangan@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org
To: Sowjanya Komatineni <skomatineni@nvidia.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1554423259-26056-8-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: tegra114: add dual mode support

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

>From 9877a347f2056f7aa4e770de9a20048ad288f545 Mon Sep 17 00:00:00 2001
From: Sowjanya Komatineni <skomatineni@nvidia.com>
Date: Thu, 4 Apr 2019 17:14:07 -0700
Subject: [PATCH] spi: tegra114: add dual mode support

This patch adds support for dual mode SPI transfer.

Dual mode uses both MOSI and MISO lines in parallel where the data
is interleaved on MOSI and MISO lines increasing the throughput.

Packet from Tx FIFO is transmitted on both MOSI and MISO lines and
packet to Rx FIFO is received from both MOSI and MISO lines. Even
bits are transmitted or received on the MOSI data line and odd bits
are transmitted or received on the MISO data line.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-tegra114.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 402799c7f6b7..1e749ce13029 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -786,6 +786,11 @@ static int tegra_spi_start_transfer_one(struct spi_device *spi,
 
 	total_fifo_words = tegra_spi_calculate_curr_xfer_param(spi, tspi, t);
 
+	if (t->rx_nbits == SPI_NBITS_DUAL || t->tx_nbits == SPI_NBITS_DUAL)
+		command1 |= SPI_BOTH_EN_BIT;
+	else
+		command1 &= ~SPI_BOTH_EN_BIT;
+
 	if (tspi->is_packed)
 		command1 |= SPI_PACKED;
 	else
@@ -1152,7 +1157,8 @@ static int tegra_spi_probe(struct platform_device *pdev)
 		master->max_speed_hz = 25000000; /* 25MHz */
 
 	/* the spi->mode bits understood by this driver: */
-	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST;
+	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST |
+			    SPI_TX_DUAL | SPI_RX_DUAL;
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
 	master->setup = tegra_spi_setup;
 	master->transfer_one_message = tegra_spi_transfer_one_message;
-- 
2.20.1

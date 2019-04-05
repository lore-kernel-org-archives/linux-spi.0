From: Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V2 08/20] spi: tegra114: add dual mode support
Date: Thu, 4 Apr 2019 17:14:07 -0700
Message-ID: <1554423259-26056-8-git-send-email-skomatineni@nvidia.com>
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

This patch adds support for dual mode SPI transfer.

Dual mode uses both MOSI and MISO lines in parallel where the data
is interleaved on MOSI and MISO lines increasing the throughput.

Packet from Tx FIFO is transmitted on both MOSI and MISO lines and
packet to Rx FIFO is received from both MOSI and MISO lines. Even
bits are transmitted or received on the MOSI data line and odd bits
are transmitted or received on the MISO data line.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/spi/spi-tegra114.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 58f5059b339f..239fb0c8c31f 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -787,6 +787,11 @@ static int tegra_spi_start_transfer_one(struct spi_device *spi,
 
 	total_fifo_words = tegra_spi_calculate_curr_xfer_param(spi, tspi, t);
 
+	if (t->rx_nbits == SPI_NBITS_DUAL || t->tx_nbits == SPI_NBITS_DUAL)
+		command1 |= SPI_BOTH_EN_BIT;
+	else
+		command1 &= ~SPI_BOTH_EN_BIT;
+
 	if (tspi->is_packed)
 		command1 |= SPI_PACKED;
 	else
@@ -1153,7 +1158,8 @@ static int tegra_spi_probe(struct platform_device *pdev)
 		master->max_speed_hz = 25000000; /* 25MHz */
 
 	/* the spi->mode bits understood by this driver: */
-	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST;
+	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST |
+			    SPI_TX_DUAL | SPI_RX_DUAL;
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
 	master->setup = tegra_spi_setup;
 	master->transfer_one_message = tegra_spi_transfer_one_message;
-- 
2.7.4

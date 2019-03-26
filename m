From: =?UTF-8?q?Randolph=20Maa=C3=9Fen?= <gaireg@gaireg.de>
Subject: [PATCH] spi: tegra20-slink: change chip select action order
Date: Tue, 26 Mar 2019 15:30:50 +0100
Message-ID: <20190326143050.26232-1-gaireg@gaireg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Laxman Dewangan <ldewangan@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
To: gaireg@gaireg.de
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

To transfer via SPI the tegra20-slink driver first sets the command
register, which contains the chip select value, and after that the
command2 register, which contains the chip select line. This leads to a
small spike in the chip selct 0 line between the set of the value and
the selection of the chip select line.

This commit changes the order of the register writes so that first the
chip select line is chosen and then the value is set, removing the
spike.

Signed-off-by: Randolph Maaßen <gaireg@gaireg.de>
---
 drivers/spi/spi-tegra20-slink.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
index 1427f343b39a..6d4679126213 100644
--- a/drivers/spi/spi-tegra20-slink.c
+++ b/drivers/spi/spi-tegra20-slink.c
@@ -717,9 +717,6 @@ static int tegra_slink_start_transfer_one(struct spi_device *spi,
 	command2 = tspi->command2_reg;
 	command2 &= ~(SLINK_RXEN | SLINK_TXEN);
 
-	tegra_slink_writel(tspi, command, SLINK_COMMAND);
-	tspi->command_reg = command;
-
 	tspi->cur_direction = 0;
 	if (t->rx_buf) {
 		command2 |= SLINK_RXEN;
@@ -729,9 +726,18 @@ static int tegra_slink_start_transfer_one(struct spi_device *spi,
 		command2 |= SLINK_TXEN;
 		tspi->cur_direction |= DATA_DIR_TX;
 	}
+
+	/*
+	 * Writing to the command2 register bevore the command register prevents
+	 * a spike in chip_select line 0. This selects the chip_select line
+	 * before changing the chip_select value.
+	 */
 	tegra_slink_writel(tspi, command2, SLINK_COMMAND2);
 	tspi->command2_reg = command2;
 
+	tegra_slink_writel(tspi, command, SLINK_COMMAND);
+	tspi->command_reg = command;
+
 	if (total_fifo_words > SLINK_FIFO_DEPTH)
 		ret = tegra_slink_start_dma_based_transfer(tspi, t);
 	else
-- 
2.11.0

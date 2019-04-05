From: Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V2 03/20] spi: tegra114: de-assert CS before SPI mode change
Date: Thu, 4 Apr 2019 17:14:02 -0700
Message-ID: <1554423259-26056-3-git-send-email-skomatineni@nvidia.com>
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

With SW CS, during the transfer completion CS is de-asserted by writing
default command1 register value to SPI_COMMAND1 register. With this both
mode and CS state are set at the same time and if current transfer mode
is different to default SPI mode and if mode change happens prior to CS
de-assert, clock polarity can change while CS is active before transfer
finishes.

This causes Slave to see spurious clock edges resulting in data mismatch.

This patch fixes this by de-asserting CS before writing SPI_COMMAND1 to
its default value so through out the transfer it will be in same SPI mode.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/spi/spi-tegra114.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 3042521c3785..c60e40cab0a0 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -863,6 +863,19 @@ static void tegra_spi_transfer_delay(int delay)
 	udelay(delay % 1000);
 }
 
+static void tegra_spi_transfer_end(struct spi_device *spi)
+{
+	struct tegra_spi_data *tspi = spi_master_get_devdata(spi->master);
+	int cs_val = (spi->mode & SPI_CS_HIGH) ? 0 : 1;
+
+	if (cs_val)
+		tspi->command1_reg |= SPI_CS_SW_VAL;
+	else
+		tspi->command1_reg &= ~SPI_CS_SW_VAL;
+	tegra_spi_writel(tspi, tspi->command1_reg, SPI_COMMAND1);
+	tegra_spi_writel(tspi, tspi->def_command1_reg, SPI_COMMAND1);
+}
+
 static int tegra_spi_transfer_one_message(struct spi_master *master,
 			struct spi_message *msg)
 {
@@ -925,8 +938,7 @@ static int tegra_spi_transfer_one_message(struct spi_master *master,
 
 complete_xfer:
 		if (ret < 0 || skip) {
-			tegra_spi_writel(tspi, tspi->def_command1_reg,
-					SPI_COMMAND1);
+			tegra_spi_transfer_end(spi);
 			tegra_spi_transfer_delay(xfer->delay_usecs);
 			goto exit;
 		} else if (list_is_last(&xfer->transfer_list,
@@ -934,13 +946,11 @@ static int tegra_spi_transfer_one_message(struct spi_master *master,
 			if (xfer->cs_change)
 				tspi->cs_control = spi;
 			else {
-				tegra_spi_writel(tspi, tspi->def_command1_reg,
-						SPI_COMMAND1);
+				tegra_spi_transfer_end(spi);
 				tegra_spi_transfer_delay(xfer->delay_usecs);
 			}
 		} else if (xfer->cs_change) {
-			tegra_spi_writel(tspi, tspi->def_command1_reg,
-					SPI_COMMAND1);
+			tegra_spi_transfer_end(spi);
 			tegra_spi_transfer_delay(xfer->delay_usecs);
 		}
 
-- 
2.7.4

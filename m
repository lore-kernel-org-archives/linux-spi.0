From: Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V1 24/26] spi: tegra114: de-assert CS before SPI mode is reset to its default
Date: Tue, 26 Mar 2019 22:56:45 -0700
Message-ID: <1553666207-11414-24-git-send-email-skomatineni@nvidia.com>
References: <1553666207-11414-1-git-send-email-skomatineni@nvidia.com>
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
In-Reply-To: <1553666207-11414-1-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

With SW CS, during transfer completion CS is de-asserted by writing the
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
 drivers/spi/spi-tegra114.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 9b216e9d6079..e1669ab3b0fe 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -1147,6 +1147,12 @@ static int tegra_spi_transfer_one_message(struct spi_master *master,
 		if (ret < 0 || skip) {
 			if (cstate->cs_gpio_valid)
 				gpio_set_value(spi->cs_gpio, cs_val);
+			if (cs_val && !tspi->use_hw_based_cs)
+				tspi->command1_reg |= SPI_CS_SW_VAL;
+			else
+				tspi->command1_reg &= ~SPI_CS_SW_VAL;
+			tegra_spi_writel(tspi, tspi->command1_reg,
+					 SPI_COMMAND1);
 			tegra_spi_writel(tspi, tspi->def_command1_reg,
 					SPI_COMMAND1);
 			tegra_spi_transfer_delay(xfer->delay_usecs);
@@ -1158,6 +1164,12 @@ static int tegra_spi_transfer_one_message(struct spi_master *master,
 			else {
 				if (cstate->cs_gpio_valid)
 					gpio_set_value(spi->cs_gpio, cs_val);
+				if (cs_val && !tspi->use_hw_based_cs)
+					tspi->command1_reg |= SPI_CS_SW_VAL;
+				else
+					tspi->command1_reg &= ~SPI_CS_SW_VAL;
+				tegra_spi_writel(tspi, tspi->command1_reg,
+						 SPI_COMMAND1);
 				tegra_spi_writel(tspi, tspi->def_command1_reg,
 						SPI_COMMAND1);
 				tegra_spi_transfer_delay(xfer->delay_usecs);
@@ -1165,6 +1177,12 @@ static int tegra_spi_transfer_one_message(struct spi_master *master,
 		} else if (xfer->cs_change) {
 			if (cstate->cs_gpio_valid)
 				gpio_set_value(spi->cs_gpio, cs_val);
+			if (cs_val && !tspi->use_hw_based_cs)
+				tspi->command1_reg |= SPI_CS_SW_VAL;
+			else
+				tspi->command1_reg &= ~SPI_CS_SW_VAL;
+			tegra_spi_writel(tspi, tspi->command1_reg,
+					 SPI_COMMAND1);
 			tegra_spi_writel(tspi, tspi->def_command1_reg,
 					SPI_COMMAND1);
 			tegra_spi_transfer_delay(xfer->delay_usecs);
-- 
2.7.4

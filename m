From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: tegra114: de-assert CS before SPI mode change" to the spi tree
Date: Fri,  5 Apr 2019 10:27:01 +0700 (+07)
Message-ID: <20190405032701.14731441D3C@finisterre.ee.mobilebroadband>
References: <1554423259-26056-3-git-send-email-skomatineni@nvidia.com>
Cc: Mark Brown <broonie@kernel.org>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, talho@nvidia.com, skomatineni@nvidia.com,
        broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        kyarlagadda@nvidia.com, ldewangan@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org
To: Sowjanya Komatineni <skomatineni@nvidia.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1554423259-26056-3-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: tegra114: de-assert CS before SPI mode change

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

>From f3e182c33e534f4caeb255a3ab927debc0d222aa Mon Sep 17 00:00:00 2001
From: Sowjanya Komatineni <skomatineni@nvidia.com>
Date: Thu, 4 Apr 2019 17:14:02 -0700
Subject: [PATCH] spi: tegra114: de-assert CS before SPI mode change

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
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-tegra114.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 09cfae3abce2..8de002fc6943 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -856,6 +856,19 @@ static void tegra_spi_transfer_delay(int delay)
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
@@ -918,8 +931,7 @@ static int tegra_spi_transfer_one_message(struct spi_master *master,
 
 complete_xfer:
 		if (ret < 0 || skip) {
-			tegra_spi_writel(tspi, tspi->def_command1_reg,
-					SPI_COMMAND1);
+			tegra_spi_transfer_end(spi);
 			tegra_spi_transfer_delay(xfer->delay_usecs);
 			goto exit;
 		} else if (list_is_last(&xfer->transfer_list,
@@ -927,13 +939,11 @@ static int tegra_spi_transfer_one_message(struct spi_master *master,
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
2.20.1

From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: tegra114: add support for hw based cs" to the spi tree
Date: Wed, 15 May 2019 12:18:24 +0100 (BST)
Message-ID: <20190515111824.1C34E1126D6D@debutante.sirena.org.uk>
References: <1557810235-16401-3-git-send-email-skomatineni@nvidia.com>
Cc: broonie@kernel.org, jonathanh@nvidia.com, ldewangan@nvidia.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-tegra@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        thierry.reding@gmail.com
To: Sowjanya Komatineni <skomatineni@nvidia.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1557810235-16401-3-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: tegra114: add support for hw based cs

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.3

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

>From 1bf9f3c9232d08651aa6990001e7b042c95303dc Mon Sep 17 00:00:00 2001
From: Sowjanya Komatineni <skomatineni@nvidia.com>
Date: Mon, 13 May 2019 22:03:53 -0700
Subject: [PATCH] spi: tegra114: add support for hw based cs

Tegra SPI controller supports both HW and SW based CS control
for SPI transfers.

This patch adds support for HW based CS control where CS is driven
to active state during the transfer and is driven inactive at the
end of the transfer directly by the HW.

This patch enables the use of HW based CS only for single transfers
without cs_change request.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-tegra114.c | 39 ++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index f47417dd9edb..0cb0932d32fd 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -193,6 +193,7 @@ struct tegra_spi_data {
 	unsigned				dma_buf_size;
 	unsigned				max_buf_size;
 	bool					is_curr_dma_xfer;
+	bool					use_hw_based_cs;
 
 	struct completion			rx_dma_complete;
 	struct completion			tx_dma_complete;
@@ -723,7 +724,9 @@ static void tegra_spi_deinit_dma_param(struct tegra_spi_data *tspi,
 }
 
 static u32 tegra_spi_setup_transfer_one(struct spi_device *spi,
-		struct spi_transfer *t, bool is_first_of_msg)
+					struct spi_transfer *t,
+					bool is_first_of_msg,
+					bool is_single_xfer)
 {
 	struct tegra_spi_data *tspi = spi_master_get_devdata(spi->master);
 	u32 speed = t->speed_hz;
@@ -780,11 +783,17 @@ static u32 tegra_spi_setup_transfer_one(struct spi_device *spi,
 		if (spi->cs_gpiod)
 			gpiod_set_value(spi->cs_gpiod, 1);
 
-		command1 |= SPI_CS_SW_HW;
-		if (spi->mode & SPI_CS_HIGH)
-			command1 |= SPI_CS_SW_VAL;
-		else
-			command1 &= ~SPI_CS_SW_VAL;
+		if (is_single_xfer && !(t->cs_change)) {
+			tspi->use_hw_based_cs = true;
+			command1 &= ~(SPI_CS_SW_HW | SPI_CS_SW_VAL);
+		} else {
+			tspi->use_hw_based_cs = false;
+			command1 |= SPI_CS_SW_HW;
+			if (spi->mode & SPI_CS_HIGH)
+				command1 |= SPI_CS_SW_VAL;
+			else
+				command1 &= ~SPI_CS_SW_VAL;
+		}
 
 		tegra_spi_writel(tspi, 0, SPI_COMMAND2);
 	} else {
@@ -905,11 +914,14 @@ static void tegra_spi_transfer_end(struct spi_device *spi)
 	if (spi->cs_gpiod)
 		gpiod_set_value(spi->cs_gpiod, 0);
 
-	if (cs_val)
-		tspi->command1_reg |= SPI_CS_SW_VAL;
-	else
-		tspi->command1_reg &= ~SPI_CS_SW_VAL;
-	tegra_spi_writel(tspi, tspi->command1_reg, SPI_COMMAND1);
+	if (!tspi->use_hw_based_cs) {
+		if (cs_val)
+			tspi->command1_reg |= SPI_CS_SW_VAL;
+		else
+			tspi->command1_reg &= ~SPI_CS_SW_VAL;
+		tegra_spi_writel(tspi, tspi->command1_reg, SPI_COMMAND1);
+	}
+
 	tegra_spi_writel(tspi, tspi->def_command1_reg, SPI_COMMAND1);
 }
 
@@ -936,16 +948,19 @@ static int tegra_spi_transfer_one_message(struct spi_master *master,
 	struct spi_device *spi = msg->spi;
 	int ret;
 	bool skip = false;
+	int single_xfer;
 
 	msg->status = 0;
 	msg->actual_length = 0;
 
+	single_xfer = list_is_singular(&msg->transfers);
 	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
 		u32 cmd1;
 
 		reinit_completion(&tspi->xfer_completion);
 
-		cmd1 = tegra_spi_setup_transfer_one(spi, xfer, is_first_msg);
+		cmd1 = tegra_spi_setup_transfer_one(spi, xfer, is_first_msg,
+						    single_xfer);
 
 		if (!xfer->len) {
 			ret = 0;
-- 
2.20.1

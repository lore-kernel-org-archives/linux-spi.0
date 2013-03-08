From: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: slink-tegra20: move runtime pm calls to transfer_one_message
Date: Fri, 8 Mar 2013 11:51:19 +0530
Message-ID: <1362723679-1155-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	<linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
To: <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

The prepare_transfer_hardware() is called in atomic context and
calling synchronous runtime pm calls can create scheduling deadlock.

Therefore, in place of calling runtime PM calls from prepare/unprepare
message transfer, calling this in transfer_one_message().

Signed-off-by: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-tegra20-slink.c |   25 ++++++++-----------------
 1 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
index b8698b3..a829563 100644
--- a/drivers/spi/spi-tegra20-slink.c
+++ b/drivers/spi/spi-tegra20-slink.c
@@ -858,21 +858,6 @@ static int tegra_slink_setup(struct spi_device *spi)
 	return 0;
 }
 
-static int tegra_slink_prepare_transfer(struct spi_master *master)
-{
-	struct tegra_slink_data *tspi = spi_master_get_devdata(master);
-
-	return pm_runtime_get_sync(tspi->dev);
-}
-
-static int tegra_slink_unprepare_transfer(struct spi_master *master)
-{
-	struct tegra_slink_data *tspi = spi_master_get_devdata(master);
-
-	pm_runtime_put(tspi->dev);
-	return 0;
-}
-
 static int tegra_slink_transfer_one_message(struct spi_master *master,
 			struct spi_message *msg)
 {
@@ -885,6 +870,12 @@ static int tegra_slink_transfer_one_message(struct spi_master *master,
 
 	msg->status = 0;
 	msg->actual_length = 0;
+	ret = pm_runtime_get_sync(tspi->dev);
+	if (ret < 0) {
+		dev_err(tspi->dev, "runtime get failed: %d\n", ret);
+		goto done;
+	}
+
 	single_xfer = list_is_singular(&msg->transfers);
 	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
 		INIT_COMPLETION(tspi->xfer_completion);
@@ -921,6 +912,8 @@ static int tegra_slink_transfer_one_message(struct spi_master *master,
 exit:
 	tegra_slink_writel(tspi, tspi->def_command_reg, SLINK_COMMAND);
 	tegra_slink_writel(tspi, tspi->def_command2_reg, SLINK_COMMAND2);
+	pm_runtime_put(tspi->dev);
+done:
 	msg->status = ret;
 	spi_finalize_current_message(master);
 	return ret;
@@ -1148,9 +1141,7 @@ static int tegra_slink_probe(struct platform_device *pdev)
 	/* the spi->mode bits understood by this driver: */
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
 	master->setup = tegra_slink_setup;
-	master->prepare_transfer_hardware = tegra_slink_prepare_transfer;
 	master->transfer_one_message = tegra_slink_transfer_one_message;
-	master->unprepare_transfer_hardware = tegra_slink_unprepare_transfer;
 	master->num_chipselect = MAX_CHIP_SELECT;
 	master->bus_num = -1;
 
-- 
1.7.1.1

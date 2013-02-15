From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: [PATCH 1/4] spi: tegra slink: remove redundant code
Date: Fri, 15 Feb 2013 15:03:47 -0700
Message-ID: <1360965830-19795-1-git-send-email-swarren@wwwdotorg.org>
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
	Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

There is no code to set spi->controller_data, and hence the HW CS logic
can never trigger. Remove the unused code.

Signed-off-by: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-tegra20-slink.c |   32 +-------------------------------
 1 file changed, 1 insertion(+), 31 deletions(-)

diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
index b8698b3..00f1b06 100644
--- a/drivers/spi/spi-tegra20-slink.c
+++ b/drivers/spi/spi-tegra20-slink.c
@@ -189,7 +189,6 @@ struct tegra_slink_data {
 	unsigned				dma_buf_size;
 	unsigned				max_buf_size;
 	bool					is_curr_dma_xfer;
-	bool					is_hw_based_cs;
 
 	struct completion			rx_dma_complete;
 	struct completion			tx_dma_complete;
@@ -720,7 +719,6 @@ static int tegra_slink_start_transfer_one(struct spi_device *spi,
 	u8 bits_per_word;
 	unsigned total_fifo_words;
 	int ret;
-	struct tegra_spi_device_controller_data *cdata = spi->controller_data;
 	unsigned long command;
 	unsigned long command2;
 
@@ -743,39 +741,11 @@ static int tegra_slink_start_transfer_one(struct spi_device *spi,
 
 		command = tspi->def_command_reg;
 		command |= SLINK_BIT_LENGTH(bits_per_word - 1);
+		command |= SLINK_CS_SW | SLINK_CS_VALUE;
 
 		command2 = tspi->def_command2_reg;
 		command2 |= SLINK_SS_EN_CS(spi->chip_select);
 
-		/* possibly use the hw based chip select */
-		tspi->is_hw_based_cs = false;
-		if (cdata && cdata->is_hw_based_cs && is_single_xfer &&
-			((tspi->curr_dma_words * tspi->bytes_per_word) ==
-						(t->len - tspi->cur_pos))) {
-			int setup_count;
-			int sts2;
-
-			setup_count = cdata->cs_setup_clk_count >> 1;
-			setup_count = max(setup_count, 3);
-			command2 |= SLINK_SS_SETUP(setup_count);
-			if (tspi->chip_data->cs_hold_time) {
-				int hold_count;
-
-				hold_count = cdata->cs_hold_clk_count;
-				hold_count = max(hold_count, 0xF);
-				sts2 = tegra_slink_readl(tspi, SLINK_STATUS2);
-				sts2 &= ~SLINK_SS_HOLD_TIME(0xF);
-				sts2 |= SLINK_SS_HOLD_TIME(hold_count);
-				tegra_slink_writel(tspi, sts2, SLINK_STATUS2);
-			}
-			tspi->is_hw_based_cs = true;
-		}
-
-		if (tspi->is_hw_based_cs)
-			command &= ~SLINK_CS_SW;
-		else
-			command |= SLINK_CS_SW | SLINK_CS_VALUE;
-
 		command &= ~SLINK_MODES;
 		if (spi->mode & SPI_CPHA)
 			command |= SLINK_CK_SDA;
-- 
1.7.10.4

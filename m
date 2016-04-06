From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH] spi: cadence: Fix some checkpatch warnings
Date: Wed, 6 Apr 2016 14:55:35 +0530
Message-ID: <1459934735-40434-1-git-send-email-shubhraj@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-kernel@vger.kernel.org>, <broonie@kernel.org>,
	Shubhrajyoti Datta <shubhraj@xilinx.com>
To: <linux-spi@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

No functional change.
Fixing some style related issues

CHECK: multiple assignments should be avoided
+	new_ctrl_reg = ctrl_reg = cdns_spi_read(xspi, CDNS_SPI_CR);

CHECK: Alignment should match open parenthesis
+static void cdns_spi_config_clock_freq(struct spi_device *spi,
+				  struct spi_transfer *transfer)

CHECK: Please use a blank line after function/struct/union/enum declarations
+}
+static int cdns_prepare_message(struct spi_master *master,

Signed-off-by: Shubhrajyoti Datta <shubhraj@xilinx.com>
---
 drivers/spi/spi-cadence.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index 07481e1..8a0bd62 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -209,7 +209,8 @@ static void cdns_spi_config_clock_mode(struct spi_device *spi)
 	struct cdns_spi *xspi = spi_master_get_devdata(spi->master);
 	u32 ctrl_reg, new_ctrl_reg;
 
-	new_ctrl_reg = ctrl_reg = cdns_spi_read(xspi, CDNS_SPI_CR);
+	new_ctrl_reg = cdns_spi_read(xspi, CDNS_SPI_CR);
+	ctrl_reg = new_ctrl_reg;
 
 	/* Set the SPI clock phase and clock polarity */
 	new_ctrl_reg &= ~(CDNS_SPI_CR_CPHA | CDNS_SPI_CR_CPOL);
@@ -246,7 +247,7 @@ static void cdns_spi_config_clock_mode(struct spi_device *spi)
  * controller.
  */
 static void cdns_spi_config_clock_freq(struct spi_device *spi,
-				  struct spi_transfer *transfer)
+				       struct spi_transfer *transfer)
 {
 	struct cdns_spi *xspi = spi_master_get_devdata(spi->master);
 	u32 ctrl_reg, baud_rate_val;
@@ -380,6 +381,7 @@ static irqreturn_t cdns_spi_irq(int irq, void *dev_id)
 
 	return status;
 }
+
 static int cdns_prepare_message(struct spi_master *master,
 				struct spi_message *msg)
 {
-- 
1.7.1

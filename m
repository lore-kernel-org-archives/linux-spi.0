From: xiao jin <jin.xiao@intel.com>
Subject: [PATCH] spi-pxa2xx.c: modify the chip selection timing when spi transfer
Date: Wed,  6 Mar 2019 11:05:19 +0800
Message-ID: <20190306030519.10746-1-jin.xiao@intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: "he, bo" <bo.he@intel.com>, xiao jin <jin.xiao@intel.com>,
        he@vger.kernel.org
To: jarkko.nikula@linux.intel.com, daniel@zonque.org,
        haojian.zhuang@gmail.com, robert.jarzmik@free.fr,
        broonie@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        yanmin.zhang@intel.com
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: "he, bo" <bo.he@intel.com>

We find spi can't work on board. More debug shows it's related
to the following patch that changed the chip selection assert and
deassert timing.

commit d5898e19c0d74cd41b9f5c8c8ea87e559c3fe0c1

    spi: pxa2xx: Use core message processing loop

    Convert the pump_transfers() transfer tasklet to transfer_one()
    hook the SPI core calls to process single transfer instead of
    handling message processing and chip select handling in the driver.
    This not only simplifies the driver but also brings transfer
    statistics from the core.

We modify the chip selection timeing action back to before the patch.
The spi on the board works.

Signed-off-by: xiao jin <jin.xiao@intel.com>
Signed-off-by: he, bo <bo.he@intel.com>
---
 drivers/spi/spi-pxa2xx.c | 41 ++++++++++++++--------------------------
 1 file changed, 14 insertions(+), 27 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index ec4b65100..0affa09da 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -340,11 +340,9 @@ static void lpss_ssp_setup(struct driver_data *drv_data)
 	}
 }
 
-static void lpss_ssp_select_cs(struct spi_device *spi,
+static void lpss_ssp_select_cs(struct driver_data *drv_data,
 			       const struct lpss_config *config)
 {
-	struct driver_data *drv_data =
-		spi_controller_get_devdata(spi->controller);
 	u32 value, cs;
 
 	if (!config->cs_sel_mask)
@@ -352,7 +350,7 @@ static void lpss_ssp_select_cs(struct spi_device *spi,
 
 	value = __lpss_ssp_read_priv(drv_data, config->reg_cs_ctrl);
 
-	cs = spi->chip_select;
+	cs = drv_data->master->cur_msg->spi->chip_select;
 	cs <<= config->cs_sel_shift;
 	if (cs != (value & config->cs_sel_mask)) {
 		/*
@@ -371,17 +369,15 @@ static void lpss_ssp_select_cs(struct spi_device *spi,
 	}
 }
 
-static void lpss_ssp_cs_control(struct spi_device *spi, bool enable)
+static void lpss_ssp_cs_control(struct driver_data *drv_data, bool enable)
 {
-	struct driver_data *drv_data =
-		spi_controller_get_devdata(spi->controller);
 	const struct lpss_config *config;
 	u32 value;
 
 	config = lpss_get_config(drv_data);
 
 	if (enable)
-		lpss_ssp_select_cs(spi, config);
+		lpss_ssp_select_cs(drv_data, config);
 
 	value = __lpss_ssp_read_priv(drv_data, config->reg_cs_ctrl);
 	if (enable)
@@ -391,11 +387,10 @@ static void lpss_ssp_cs_control(struct spi_device *spi, bool enable)
 	__lpss_ssp_write_priv(drv_data, config->reg_cs_ctrl, value);
 }
 
-static void cs_assert(struct spi_device *spi)
+static void cs_assert(struct driver_data *drv_data)
 {
-	struct chip_data *chip = spi_get_ctldata(spi);
-	struct driver_data *drv_data =
-		spi_controller_get_devdata(spi->controller);
+	struct chip_data *chip =
+		spi_get_ctldata(drv_data->master->cur_msg->spi);
 
 	if (drv_data->ssp_type == CE4100_SSP) {
 		pxa2xx_spi_write(drv_data, SSSR, chip->frm);
@@ -413,14 +408,13 @@ static void cs_assert(struct spi_device *spi)
 	}
 
 	if (is_lpss_ssp(drv_data))
-		lpss_ssp_cs_control(spi, true);
+		lpss_ssp_cs_control(drv_data, true);
 }
 
-static void cs_deassert(struct spi_device *spi)
+static void cs_deassert(struct driver_data *drv_data)
 {
-	struct chip_data *chip = spi_get_ctldata(spi);
-	struct driver_data *drv_data =
-		spi_controller_get_devdata(spi->controller);
+	struct chip_data *chip =
+		spi_get_ctldata(drv_data->master->cur_msg->spi);
 	unsigned long timeout;
 
 	if (drv_data->ssp_type == CE4100_SSP)
@@ -443,15 +437,7 @@ static void cs_deassert(struct spi_device *spi)
 	}
 
 	if (is_lpss_ssp(drv_data))
-		lpss_ssp_cs_control(spi, false);
-}
-
-static void pxa2xx_spi_set_cs(struct spi_device *spi, bool level)
-{
-	if (level)
-		cs_deassert(spi);
-	else
-		cs_assert(spi);
+		lpss_ssp_cs_control(drv_data, false);
 }
 
 int pxa2xx_spi_flush(struct driver_data *drv_data)
@@ -610,6 +596,7 @@ static void int_transfer_complete(struct driver_data *drv_data)
 	if (!pxa25x_ssp_comp(drv_data))
 		pxa2xx_spi_write(drv_data, SSTO, 0);
 
+	cs_deassert(drv_data);
 	spi_finalize_current_transfer(drv_data->master);
 }
 
@@ -1070,6 +1057,7 @@ static int pxa2xx_spi_transfer_one(struct spi_controller *master,
 			pxa2xx_spi_write(drv_data, SSTO, chip->timeout);
 	}
 
+	cs_assert(drv_data);
 	/*
 	 * Release the data by enabling service requests and interrupts,
 	 * without changing any mode bits
@@ -1563,7 +1551,6 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 	master->dma_alignment = DMA_ALIGNMENT;
 	master->cleanup = cleanup;
 	master->setup = setup;
-	master->set_cs = pxa2xx_spi_set_cs;
 	master->transfer_one = pxa2xx_spi_transfer_one;
 	master->handle_err = pxa2xx_spi_handle_err;
 	master->unprepare_transfer_hardware = pxa2xx_spi_unprepare_transfer;
-- 
2.20.1

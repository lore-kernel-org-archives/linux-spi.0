From: <tthayer@opensource.altera.com>
Subject: [PATCH] spi: dw: Enable Slave Select with GPIO Chip Select.
Date: Wed, 5 Oct 2016 16:38:58 -0500
Message-ID: <1475703538-5018-1-git-send-email-tthayer@opensource.altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <andriy.shevchenko@linux.intel.com>,
        <jarkko.nikula@linux.intel.com>, <jszhang@marvell.com>,
        <michael@smart-africa.com>, <kernel@mseidel.net>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <tthayer@opensource.altera.com>
To: <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Thor Thayer <tthayer@opensource.altera.com>

Currently in the GPIO CS case, the transfer is stalled. The DesignWare
IP datasheet points out that the slave must be selected (SER) before the
transfer can start [1]. The SPI framework selects the chip using either
1) the internal CS mechanism or 2) the GPIO CS, but not both.

This patch adds the Slave Select locally so that the transfer will
start and complete. The GPIO CS is taken care of earlier in the SPI
framework (spi_set_cs).

Tested On:
    Altera CycloneV development kit
    Compile tested for build errors on x86_64 (allyesconfigs)

[1] DesignWare dw_apb_ssi Databook, Version 3.20a (page 39)

Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
---
 drivers/spi/spi-dw.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index 27960e4..86e321d 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -296,6 +296,10 @@ static int dw_spi_transfer_one(struct spi_master *master,
 
 	spi_enable_chip(dws, 0);
 
+	/* Slave select required before transfer can begin. Force in gpio CS */
+	if (gpio_is_valid(spi->cs_gpio))
+		dw_spi_set_cs(spi, 0);
+
 	/* Handle per transfer options for bpw and speed */
 	if (transfer->speed_hz != dws->current_freq) {
 		if (transfer->speed_hz != chip->speed_hz) {
@@ -390,6 +394,10 @@ static void dw_spi_handle_err(struct spi_master *master,
 	if (dws->dma_mapped)
 		dws->dma_ops->dma_stop(dws);
 
+	/* Cleanup Slave Select in gpio CS case */
+	if (gpio_is_valid(msg->spi->cs_gpio))
+		dw_spi_set_cs(msg->spi, 1);
+
 	spi_reset_chip(dws);
 }
 
@@ -440,6 +448,10 @@ static void dw_spi_cleanup(struct spi_device *spi)
 {
 	struct chip_data *chip = spi_get_ctldata(spi);
 
+	/* Cleanup Slave Select in gpio CS case */
+	if (gpio_is_valid(spi->cs_gpio))
+		dw_spi_set_cs(spi, 1);
+
 	kfree(chip);
 	spi_set_ctldata(spi, NULL);
 }
-- 
1.7.9.5

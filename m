From: Vladimir Oltean <olteanv@gmail.com>
Subject: [RFC PATCH net-next 07/11] spi: spi-fsl-dspi: Add a debugging GPIO for monitoring latency
Date: Fri, 16 Aug 2019 03:44:45 +0300
Message-ID: <20190816004449.10100-8-olteanv@gmail.com>
References: <20190816004449.10100-1-olteanv@gmail.com>
Cc: linux-spi@vger.kernel.org, netdev@vger.kernel.org,
        Vladimir Oltean <olteanv@gmail.com>
To: h.feurstein@gmail.com, mlichvar@redhat.com,
        richardcochran@gmail.com, andrew@lunn.ch, f.fainelli@gmail.com,
        broonie@kernel.org
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190816004449.10100-1-olteanv@gmail.com>
Sender: netdev-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This is being used to monitor the time it takes to transmit individual
bytes over SPI to the slave device. It is used in conjunction with the
PTP system timestamp feature - only the byte that was requested to be
timestamped triggers a toggle of the GPIO pin.

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
---
 drivers/spi/spi-fsl-dspi.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 3fc266d8263a..f0838853392d 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -203,6 +203,7 @@ struct fsl_dspi {
 	wait_queue_head_t	waitq;
 	u32			waitflags;
 
+	struct gpio_desc	*debug_gpio;
 	struct fsl_dspi_dma	*dma;
 };
 
@@ -223,6 +224,15 @@ static u32 dspi_pop_tx(struct fsl_dspi *dspi)
 	return txdata;
 }
 
+void dspi_debug_gpio(struct fsl_dspi *dspi, bool enabled)
+{
+	if (IS_ERR(dspi->debug_gpio)) {
+		dev_err(&dspi->pdev->dev, "Bad debug GPIO!\n");
+		return;
+	}
+	gpiod_set_value_cansleep(dspi->debug_gpio, enabled);
+}
+
 static u32 dspi_pop_tx_pushr(struct fsl_dspi *dspi)
 {
 	u16 cmd = dspi->tx_cmd, data = dspi_pop_tx(dspi);
@@ -661,8 +671,11 @@ static int dspi_rxtx(struct fsl_dspi *dspi)
 	u16 spi_tcnt;
 	u32 spi_tcr;
 
-	if (dspi->take_snapshot)
+	if (dspi->take_snapshot) {
 		ptp_read_system_postts(dspi->ptp_sts);
+		if (dspi->ptp_sts)
+			dspi_debug_gpio(dspi, 0);
+	}
 
 	/* Get transfer counter (in number of SPI transfers). It was
 	 * reset to 0 when transfer(s) were started.
@@ -683,8 +696,11 @@ static int dspi_rxtx(struct fsl_dspi *dspi)
 
 	dspi->take_snapshot = (dspi->tx == dspi->ptp_sts_word);
 
-	if (dspi->take_snapshot)
+	if (dspi->take_snapshot) {
+		if (dspi->ptp_sts)
+			dspi_debug_gpio(dspi, 1);
 		ptp_read_system_prets(dspi->ptp_sts);
+	}
 
 	if (dspi->devtype_data->trans_mode == DSPI_EOQ_MODE)
 		dspi_eoq_write(dspi);
@@ -799,8 +815,11 @@ static int dspi_transfer_one_message(struct spi_master *master,
 
 		dspi->take_snapshot = (dspi->tx == dspi->ptp_sts_word);
 
-		if (dspi->take_snapshot)
+		if (dspi->take_snapshot) {
+			if (dspi->ptp_sts)
+				dspi_debug_gpio(dspi, 1);
 			ptp_read_system_prets(dspi->ptp_sts);
+		}
 
 		trans_mode = dspi->devtype_data->trans_mode;
 		switch (trans_mode) {
@@ -1126,6 +1145,11 @@ static int dspi_probe(struct platform_device *pdev)
 		}
 	}
 
+	dspi->debug_gpio = devm_gpiod_get(&pdev->dev, "debug",
+					  GPIOD_OUT_HIGH);
+
+	dspi_debug_gpio(dspi, 0);
+
 	dspi->clk = devm_clk_get(&pdev->dev, "dspi");
 	if (IS_ERR(dspi->clk)) {
 		ret = PTR_ERR(dspi->clk);
-- 
2.17.1

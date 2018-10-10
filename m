From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 08/11] spi: pxa2xx: Add slave mode support
Date: Wed, 10 Oct 2018 19:09:33 +0200
Message-ID: <20181010170936.316862-9-lkundrak@v3.sk>
References: <20181010170936.316862-1-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Cc: James Cameron <quozl@laptop.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Lubomir Rintel <lkundrak@v3.sk>
To: Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181010170936.316862-1-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Tested on an OLPC XO-1.75 machine, where the Embedded Controller happens
to be a SPI master.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/spi/spi-pxa2xx.c       | 81 +++++++++++++++++++++++++++++++---
 include/linux/spi/pxa2xx_spi.h |  1 +
 2 files changed, 75 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 58554c765a87..3848842d68fd 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -626,6 +626,11 @@ static irqreturn_t interrupt_transfer(struct driver_=
data *drv_data)
 		return IRQ_HANDLED;
 	}
=20
+	if (irq_status & SSSR_TUR) {
+		int_error_stop(drv_data, "interrupt_transfer: fifo underrun");
+		return IRQ_HANDLED;
+	}
+
 	if (irq_status & SSSR_TINT) {
 		pxa2xx_spi_write(drv_data, SSSR, SSSR_TINT);
 		if (drv_data->read(drv_data)) {
@@ -1071,6 +1076,11 @@ static int pxa2xx_spi_transfer_one(struct spi_cont=
roller *master,
 			pxa2xx_spi_write(drv_data, SSTO, chip->timeout);
 	}
=20
+	if (spi_controller_is_slave(master)) {
+		while (drv_data->write(drv_data))
+			;
+	}
+
 	/*
 	 * Release the data by enabling service requests and interrupts,
 	 * without changing any mode bits
@@ -1080,6 +1090,27 @@ static int pxa2xx_spi_transfer_one(struct spi_cont=
roller *master,
 	return 1;
 }
=20
+static int pxa2xx_spi_slave_abort(struct spi_master *master)
+{
+	struct driver_data *drv_data =3D spi_controller_get_devdata(master);
+
+	/* Stop and reset SSP */
+	write_SSSR_CS(drv_data, drv_data->clear_sr);
+	reset_sccr1(drv_data);
+	if (!pxa25x_ssp_comp(drv_data))
+		pxa2xx_spi_write(drv_data, SSTO, 0);
+	pxa2xx_spi_flush(drv_data);
+	pxa2xx_spi_write(drv_data, SSCR0,
+			 pxa2xx_spi_read(drv_data, SSCR0) & ~SSCR0_SSE);
+
+	dev_dbg(&drv_data->pdev->dev, "transfer aborted\n");
+
+	drv_data->master->cur_msg->status =3D -EINTR;
+	spi_finalize_current_transfer(drv_data->master);
+
+	return 0;
+}
+
 static void pxa2xx_spi_handle_err(struct spi_controller *master,
 				 struct spi_message *msg)
 {
@@ -1207,9 +1238,14 @@ static int setup(struct spi_device *spi)
 		rx_thres =3D config->rx_threshold;
 		break;
 	default:
-		tx_thres =3D TX_THRESH_DFLT;
 		tx_hi_thres =3D 0;
-		rx_thres =3D RX_THRESH_DFLT;
+		if (spi_controller_is_slave(drv_data->master)) {
+			tx_thres =3D 1;
+			rx_thres =3D 2;
+		} else {
+			tx_thres =3D TX_THRESH_DFLT;
+			rx_thres =3D RX_THRESH_DFLT;
+		}
 		break;
 	}
=20
@@ -1253,6 +1289,12 @@ static int setup(struct spi_device *spi)
 		if (chip_info->enable_loopback)
 			chip->cr1 =3D SSCR1_LBM;
 	}
+	if (spi_controller_is_slave(drv_data->master)) {
+		chip->cr1 |=3D SSCR1_SCFR;
+		chip->cr1 |=3D SSCR1_SCLKDIR;
+		chip->cr1 |=3D SSCR1_SFRMDIR;
+		chip->cr1 |=3D SSCR1_SPH;
+	}
=20
 	chip->lpss_rx_threshold =3D SSIRF_RxThresh(rx_thres);
 	chip->lpss_tx_threshold =3D SSITF_TxLoThresh(tx_thres)
@@ -1492,6 +1534,13 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev=
)
 	}
 #endif
=20
+#if CONFIG_OF
+	if (of_id) {
+		pdata->is_slave =3D of_property_read_bool(pdev->dev.of_node,
+								"spi-slave");
+	}
+#endif
+
 	ssp->clk =3D devm_clk_get(&pdev->dev, NULL);
 	ssp->irq =3D platform_get_irq(pdev, 0);
 	ssp->type =3D type;
@@ -1557,7 +1606,11 @@ static int pxa2xx_spi_probe(struct platform_device=
 *pdev)
 		return -ENODEV;
 	}
=20
-	master =3D spi_alloc_master(dev, sizeof(struct driver_data));
+	if (platform_info->is_slave)
+		master =3D spi_alloc_slave(dev, sizeof(struct driver_data));
+	else
+		master =3D spi_alloc_master(dev, sizeof(struct driver_data));
+
 	if (!master) {
 		dev_err(&pdev->dev, "cannot alloc spi_master\n");
 		pxa_ssp_free(ssp);
@@ -1579,6 +1632,7 @@ static int pxa2xx_spi_probe(struct platform_device =
*pdev)
 	master->setup =3D setup;
 	master->set_cs =3D pxa2xx_spi_set_cs;
 	master->transfer_one =3D pxa2xx_spi_transfer_one;
+	master->slave_abort =3D pxa2xx_spi_slave_abort;
 	master->handle_err =3D pxa2xx_spi_handle_err;
 	master->unprepare_transfer_hardware =3D pxa2xx_spi_unprepare_transfer;
 	master->fw_translate_cs =3D pxa2xx_spi_fw_translate_cs;
@@ -1608,7 +1662,8 @@ static int pxa2xx_spi_probe(struct platform_device =
*pdev)
 		drv_data->int_cr1 =3D SSCR1_TIE | SSCR1_RIE | SSCR1_TINTE;
 		drv_data->dma_cr1 =3D DEFAULT_DMA_CR1;
 		drv_data->clear_sr =3D SSSR_ROR | SSSR_TINT;
-		drv_data->mask_sr =3D SSSR_TINT | SSSR_RFS | SSSR_TFS | SSSR_ROR;
+		drv_data->mask_sr =3D SSSR_TINT | SSSR_RFS | SSSR_TFS
+						| SSSR_ROR | SSSR_TUR;
 	}
=20
 	status =3D request_irq(ssp->irq, ssp_int, IRQF_SHARED, dev_name(dev),
@@ -1656,10 +1711,22 @@ static int pxa2xx_spi_probe(struct platform_devic=
e *pdev)
 		pxa2xx_spi_write(drv_data, SSCR0, tmp);
 		break;
 	default:
-		tmp =3D SSCR1_RxTresh(RX_THRESH_DFLT) |
-		      SSCR1_TxTresh(TX_THRESH_DFLT);
+
+		if (spi_controller_is_slave(master)) {
+			tmp =3D SSCR1_SCFR |
+			      SSCR1_SCLKDIR |
+			      SSCR1_SFRMDIR |
+			      SSCR1_RxTresh(2) |
+			      SSCR1_TxTresh(1) |
+			      SSCR1_SPH;
+		} else {
+			tmp =3D SSCR1_RxTresh(RX_THRESH_DFLT) |
+			      SSCR1_TxTresh(TX_THRESH_DFLT);
+		}
 		pxa2xx_spi_write(drv_data, SSCR1, tmp);
-		tmp =3D SSCR0_SCR(2) | SSCR0_Motorola | SSCR0_DataSize(8);
+		tmp =3D SSCR0_Motorola | SSCR0_DataSize(8);
+		if (!spi_controller_is_slave(master))
+			tmp |=3D SSCR0_SCR(2);
 		pxa2xx_spi_write(drv_data, SSCR0, tmp);
 		break;
 	}
diff --git a/include/linux/spi/pxa2xx_spi.h b/include/linux/spi/pxa2xx_sp=
i.h
index 9ec4c147abbc..b0674e330ef6 100644
--- a/include/linux/spi/pxa2xx_spi.h
+++ b/include/linux/spi/pxa2xx_spi.h
@@ -25,6 +25,7 @@ struct dma_chan;
 struct pxa2xx_spi_master {
 	u16 num_chipselect;
 	u8 enable_dma;
+	bool is_slave;
=20
 	/* DMA engine specific config */
 	bool (*dma_filter)(struct dma_chan *chan, void *param);
--=20
2.19.0

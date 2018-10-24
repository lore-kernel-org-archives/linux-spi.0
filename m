From: Clark Wang <xiaoning.wang@nxp.com>
Subject: [PATCH V2 1/5] spi: lpspi: Add slave mode support for imx7ulp
Date: Wed, 24 Oct 2018 07:58:23 +0000
Message-ID: <20181024075617.19548-1-xiaoning.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Clark Wang <xiaoning.wang@nxp.com>
To: "broonie@kernel.org" <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Add SPI slave mode support for imx7ulp, in PIO mode.

Add "spi-slave" attribute in spi node of dts file to boot.

For now, slave has to send the message which is same as the length of
message master sent.

Wire connection:
GND, SCK, MISO(to MISO of slave), MOSI(to MOSI of slave), SCS

Signed-off-by: Xiaoning Wang <xiaoning.wang@nxp.com>
---
V2:
 - No changes.
---
 drivers/spi/spi-fsl-lpspi.c | 209 ++++++++++++++++++++++++------------
 1 file changed, 139 insertions(+), 70 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 51670976faa3..86cb38d98a39 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -3,6 +3,7 @@
 // Freescale i.MX7ULP LPSPI driver
 //
 // Copyright 2016 Freescale Semiconductor, Inc.
+// Copyright 2018 NXP
=20
 #include <linux/clk.h>
 #include <linux/completion.h>
@@ -54,6 +55,7 @@
 #define IER_RDIE	BIT(1)
 #define IER_TDIE	BIT(0)
 #define CFGR1_PCSCFG	BIT(27)
+#define CFGR1_PINCFG	(BIT(24)|BIT(25))
 #define CFGR1_PCSPOL	BIT(8)
 #define CFGR1_NOSTALL	BIT(3)
 #define CFGR1_MASTER	BIT(0)
@@ -79,6 +81,7 @@ struct fsl_lpspi_data {
 	struct device *dev;
 	void __iomem *base;
 	struct clk *clk;
+	bool is_slave;
=20
 	void *rx_buf;
 	const void *tx_buf;
@@ -86,11 +89,14 @@ struct fsl_lpspi_data {
 	void (*rx)(struct fsl_lpspi_data *);
=20
 	u32 remain;
+	u8 watermark;
 	u8 txfifosize;
 	u8 rxfifosize;
=20
 	struct lpspi_config config;
 	struct completion xfer_done;
+
+	bool slave_aborted;
 };
=20
 static const struct of_device_id fsl_lpspi_dt_ids[] =3D {
@@ -137,16 +143,18 @@ static void fsl_lpspi_intctrl(struct fsl_lpspi_data *=
fsl_lpspi,
 	writel(enable, fsl_lpspi->base + IMX7ULP_IER);
 }
=20
-static int lpspi_prepare_xfer_hardware(struct spi_master *master)
+static int lpspi_prepare_xfer_hardware(struct spi_controller *controller)
 {
-	struct fsl_lpspi_data *fsl_lpspi =3D spi_master_get_devdata(master);
+	struct fsl_lpspi_data *fsl_lpspi =3D
+				spi_controller_get_devdata(controller);
=20
 	return clk_prepare_enable(fsl_lpspi->clk);
 }
=20
-static int lpspi_unprepare_xfer_hardware(struct spi_master *master)
+static int lpspi_unprepare_xfer_hardware(struct spi_controller *controller=
)
 {
-	struct fsl_lpspi_data *fsl_lpspi =3D spi_master_get_devdata(master);
+	struct fsl_lpspi_data *fsl_lpspi =3D
+				spi_controller_get_devdata(controller);
=20
 	clk_disable_unprepare(fsl_lpspi->clk);
=20
@@ -202,22 +210,26 @@ static void fsl_lpspi_set_cmd(struct fsl_lpspi_data *=
fsl_lpspi,
 {
 	u32 temp =3D 0;
=20
-	temp |=3D fsl_lpspi->config.bpw - 1;
-	temp |=3D fsl_lpspi->config.prescale << 27;
-	temp |=3D (fsl_lpspi->config.mode & 0x3) << 30;
-	temp |=3D (fsl_lpspi->config.chip_select & 0x3) << 24;
-
-	/*
-	 * Set TCR_CONT will keep SS asserted after current transfer.
-	 * For the first transfer, clear TCR_CONTC to assert SS.
-	 * For subsequent transfer, set TCR_CONTC to keep SS asserted.
-	 */
-	temp |=3D TCR_CONT;
-	if (is_first_xfer)
-		temp &=3D ~TCR_CONTC;
-	else
-		temp |=3D TCR_CONTC;
-
+	if (!fsl_lpspi->is_slave) {
+		temp |=3D fsl_lpspi->config.bpw - 1;
+		temp |=3D fsl_lpspi->config.prescale << 27;
+		temp |=3D (fsl_lpspi->config.mode & 0x3) << 30;
+		temp |=3D (fsl_lpspi->config.chip_select & 0x3) << 24;
+
+		/*
+		 * Set TCR_CONT will keep SS asserted after current transfer.
+		 * For the first transfer, clear TCR_CONTC to assert SS.
+		 * For subsequent transfer, set TCR_CONTC to keep SS asserted.
+		 */
+		temp |=3D TCR_CONT;
+		if (is_first_xfer)
+			temp &=3D ~TCR_CONTC;
+		else
+			temp |=3D TCR_CONTC;
+	} else {
+		temp |=3D fsl_lpspi->config.bpw - 1;
+		temp |=3D (fsl_lpspi->config.mode & 0x3) << 30;
+	}
 	writel(temp, fsl_lpspi->base + IMX7ULP_TCR);
=20
 	dev_dbg(fsl_lpspi->dev, "TCR=3D0x%x\n", temp);
@@ -227,7 +239,7 @@ static void fsl_lpspi_set_watermark(struct fsl_lpspi_da=
ta *fsl_lpspi)
 {
 	u32 temp;
=20
-	temp =3D fsl_lpspi->txfifosize >> 1 | (fsl_lpspi->rxfifosize >> 1) << 16;
+	temp =3D fsl_lpspi->watermark >> 1 | (fsl_lpspi->watermark >> 1) << 16;
=20
 	writel(temp, fsl_lpspi->base + IMX7ULP_FCR);
=20
@@ -253,7 +265,8 @@ static int fsl_lpspi_set_bitrate(struct fsl_lpspi_data =
*fsl_lpspi)
 	if (prescale =3D=3D 8 && scldiv >=3D 256)
 		return -EINVAL;
=20
-	writel(scldiv, fsl_lpspi->base + IMX7ULP_CCR);
+	writel(scldiv | (scldiv << 8) | ((scldiv >> 1) << 16),
+					fsl_lpspi->base + IMX7ULP_CCR);
=20
 	dev_dbg(fsl_lpspi->dev, "perclk=3D%d, speed=3D%d, prescale =3D%d, scldiv=
=3D%d\n",
 		perclk_rate, config.speed_hz, prescale, scldiv);
@@ -270,13 +283,18 @@ static int fsl_lpspi_config(struct fsl_lpspi_data *fs=
l_lpspi)
 	writel(temp, fsl_lpspi->base + IMX7ULP_CR);
 	writel(0, fsl_lpspi->base + IMX7ULP_CR);
=20
-	ret =3D fsl_lpspi_set_bitrate(fsl_lpspi);
-	if (ret)
-		return ret;
+	if (!fsl_lpspi->is_slave) {
+		ret =3D fsl_lpspi_set_bitrate(fsl_lpspi);
+		if (ret)
+			return ret;
+	}
=20
 	fsl_lpspi_set_watermark(fsl_lpspi);
=20
-	temp =3D CFGR1_PCSCFG | CFGR1_MASTER;
+	if (!fsl_lpspi->is_slave)
+		temp =3D CFGR1_MASTER;
+	else
+		temp =3D CFGR1_PINCFG;
 	if (fsl_lpspi->config.mode & SPI_CS_HIGH)
 		temp |=3D CFGR1_PCSPOL;
 	writel(temp, fsl_lpspi->base + IMX7ULP_CFGR1);
@@ -291,7 +309,8 @@ static int fsl_lpspi_config(struct fsl_lpspi_data *fsl_=
lpspi)
 static void fsl_lpspi_setup_transfer(struct spi_device *spi,
 				     struct spi_transfer *t)
 {
-	struct fsl_lpspi_data *fsl_lpspi =3D spi_master_get_devdata(spi->master);
+	struct fsl_lpspi_data *fsl_lpspi =3D
+				spi_controller_get_devdata(spi->controller);
=20
 	fsl_lpspi->config.mode =3D spi->mode;
 	fsl_lpspi->config.bpw =3D t ? t->bits_per_word : spi->bits_per_word;
@@ -315,14 +334,51 @@ static void fsl_lpspi_setup_transfer(struct spi_devic=
e *spi,
 		fsl_lpspi->tx =3D fsl_lpspi_buf_tx_u32;
 	}
=20
+	if (t->len <=3D fsl_lpspi->txfifosize)
+		fsl_lpspi->watermark =3D t->len;
+	else
+		fsl_lpspi->watermark =3D fsl_lpspi->txfifosize;
+
 	fsl_lpspi_config(fsl_lpspi);
 }
=20
-static int fsl_lpspi_transfer_one(struct spi_master *master,
+static int fsl_lpspi_slave_abort(struct spi_controller *controller)
+{
+	struct fsl_lpspi_data *fsl_lpspi =3D
+				spi_controller_get_devdata(controller);
+
+	fsl_lpspi->slave_aborted =3D true;
+	complete(&fsl_lpspi->xfer_done);
+	return 0;
+}
+
+static int fsl_lpspi_wait_for_completion(struct spi_controller *controller=
)
+{
+	struct fsl_lpspi_data *fsl_lpspi =3D
+				spi_controller_get_devdata(controller);
+
+	if (fsl_lpspi->is_slave) {
+		if (wait_for_completion_interruptible(&fsl_lpspi->xfer_done) ||
+			fsl_lpspi->slave_aborted) {
+			dev_dbg(fsl_lpspi->dev, "interrupted\n");
+			return -EINTR;
+		}
+	} else {
+		if (!wait_for_completion_timeout(&fsl_lpspi->xfer_done, HZ)) {
+			dev_dbg(fsl_lpspi->dev, "wait for completion timeout\n");
+			return -ETIMEDOUT;
+		}
+	}
+
+	return 0;
+}
+
+static int fsl_lpspi_transfer_one(struct spi_controller *controller,
 				  struct spi_device *spi,
 				  struct spi_transfer *t)
 {
-	struct fsl_lpspi_data *fsl_lpspi =3D spi_master_get_devdata(master);
+	struct fsl_lpspi_data *fsl_lpspi =3D
+				spi_controller_get_devdata(controller);
 	int ret;
=20
 	fsl_lpspi->tx_buf =3D t->tx_buf;
@@ -330,13 +386,13 @@ static int fsl_lpspi_transfer_one(struct spi_master *=
master,
 	fsl_lpspi->remain =3D t->len;
=20
 	reinit_completion(&fsl_lpspi->xfer_done);
+	fsl_lpspi->slave_aborted =3D false;
+
 	fsl_lpspi_write_tx_fifo(fsl_lpspi);
=20
-	ret =3D wait_for_completion_timeout(&fsl_lpspi->xfer_done, HZ);
-	if (!ret) {
-		dev_dbg(fsl_lpspi->dev, "wait for completion timeout\n");
-		return -ETIMEDOUT;
-	}
+	ret =3D fsl_lpspi_wait_for_completion(controller);
+	if (ret)
+		return ret;
=20
 	ret =3D fsl_lpspi_txfifo_empty(fsl_lpspi);
 	if (ret)
@@ -347,10 +403,11 @@ static int fsl_lpspi_transfer_one(struct spi_master *=
master,
 	return 0;
 }
=20
-static int fsl_lpspi_transfer_one_msg(struct spi_master *master,
+static int fsl_lpspi_transfer_one_msg(struct spi_controller *controller,
 				      struct spi_message *msg)
 {
-	struct fsl_lpspi_data *fsl_lpspi =3D spi_master_get_devdata(master);
+	struct fsl_lpspi_data *fsl_lpspi =3D
+				spi_controller_get_devdata(controller);
 	struct spi_device *spi =3D msg->spi;
 	struct spi_transfer *xfer;
 	bool is_first_xfer =3D true;
@@ -366,7 +423,7 @@ static int fsl_lpspi_transfer_one_msg(struct spi_master=
 *master,
=20
 		is_first_xfer =3D false;
=20
-		ret =3D fsl_lpspi_transfer_one(master, spi, xfer);
+		ret =3D fsl_lpspi_transfer_one(controller, spi, xfer);
 		if (ret < 0)
 			goto complete;
=20
@@ -374,13 +431,15 @@ static int fsl_lpspi_transfer_one_msg(struct spi_mast=
er *master,
 	}
=20
 complete:
-	/* de-assert SS, then finalize current message */
-	temp =3D readl(fsl_lpspi->base + IMX7ULP_TCR);
-	temp &=3D ~TCR_CONTC;
-	writel(temp, fsl_lpspi->base + IMX7ULP_TCR);
+	if (!fsl_lpspi->is_slave) {
+		/* de-assert SS, then finalize current message */
+		temp =3D readl(fsl_lpspi->base + IMX7ULP_TCR);
+		temp &=3D ~TCR_CONTC;
+		writel(temp, fsl_lpspi->base + IMX7ULP_TCR);
+	}
=20
 	msg->status =3D ret;
-	spi_finalize_current_message(master);
+	spi_finalize_current_message(controller);
=20
 	return ret;
 }
@@ -410,30 +469,39 @@ static irqreturn_t fsl_lpspi_isr(int irq, void *dev_i=
d)
 static int fsl_lpspi_probe(struct platform_device *pdev)
 {
 	struct fsl_lpspi_data *fsl_lpspi;
-	struct spi_master *master;
+	struct spi_controller *controller;
 	struct resource *res;
 	int ret, irq;
 	u32 temp;
=20
-	master =3D spi_alloc_master(&pdev->dev, sizeof(struct fsl_lpspi_data));
-	if (!master)
+	if (of_property_read_bool((&pdev->dev)->of_node, "spi-slave"))
+		controller =3D spi_alloc_slave(&pdev->dev,
+					sizeof(struct fsl_lpspi_data));
+	else
+		controller =3D spi_alloc_master(&pdev->dev,
+					sizeof(struct fsl_lpspi_data));
+
+	if (!controller)
 		return -ENOMEM;
=20
-	platform_set_drvdata(pdev, master);
+	platform_set_drvdata(pdev, controller);
=20
-	master->bits_per_word_mask =3D SPI_BPW_RANGE_MASK(8, 32);
-	master->bus_num =3D pdev->id;
+	controller->bits_per_word_mask =3D SPI_BPW_RANGE_MASK(8, 32);
+	controller->bus_num =3D pdev->id;
=20
-	fsl_lpspi =3D spi_master_get_devdata(master);
+	fsl_lpspi =3D spi_controller_get_devdata(controller);
 	fsl_lpspi->dev =3D &pdev->dev;
-
-	master->transfer_one_message =3D fsl_lpspi_transfer_one_msg;
-	master->prepare_transfer_hardware =3D lpspi_prepare_xfer_hardware;
-	master->unprepare_transfer_hardware =3D lpspi_unprepare_xfer_hardware;
-	master->mode_bits =3D SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
-	master->flags =3D SPI_MASTER_MUST_RX | SPI_MASTER_MUST_TX;
-	master->dev.of_node =3D pdev->dev.of_node;
-	master->bus_num =3D pdev->id;
+	fsl_lpspi->is_slave =3D of_property_read_bool((&pdev->dev)->of_node,
+						    "spi-slave");
+
+	controller->transfer_one_message =3D fsl_lpspi_transfer_one_msg;
+	controller->prepare_transfer_hardware =3D lpspi_prepare_xfer_hardware;
+	controller->unprepare_transfer_hardware =3D lpspi_unprepare_xfer_hardware=
;
+	controller->mode_bits =3D SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
+	controller->flags =3D SPI_MASTER_MUST_RX | SPI_MASTER_MUST_TX;
+	controller->dev.of_node =3D pdev->dev.of_node;
+	controller->bus_num =3D pdev->id;
+	controller->slave_abort =3D fsl_lpspi_slave_abort;
=20
 	init_completion(&fsl_lpspi->xfer_done);
=20
@@ -441,32 +509,32 @@ static int fsl_lpspi_probe(struct platform_device *pd=
ev)
 	fsl_lpspi->base =3D devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(fsl_lpspi->base)) {
 		ret =3D PTR_ERR(fsl_lpspi->base);
-		goto out_master_put;
+		goto out_controller_put;
 	}
=20
 	irq =3D platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		ret =3D irq;
-		goto out_master_put;
+		goto out_controller_put;
 	}
=20
 	ret =3D devm_request_irq(&pdev->dev, irq, fsl_lpspi_isr, 0,
 			       dev_name(&pdev->dev), fsl_lpspi);
 	if (ret) {
 		dev_err(&pdev->dev, "can't get irq%d: %d\n", irq, ret);
-		goto out_master_put;
+		goto out_controller_put;
 	}
=20
 	fsl_lpspi->clk =3D devm_clk_get(&pdev->dev, "ipg");
 	if (IS_ERR(fsl_lpspi->clk)) {
 		ret =3D PTR_ERR(fsl_lpspi->clk);
-		goto out_master_put;
+		goto out_controller_put;
 	}
=20
 	ret =3D clk_prepare_enable(fsl_lpspi->clk);
 	if (ret) {
 		dev_err(&pdev->dev, "can't enable lpspi clock, ret=3D%d\n", ret);
-		goto out_master_put;
+		goto out_controller_put;
 	}
=20
 	temp =3D readl(fsl_lpspi->base + IMX7ULP_PARAM);
@@ -475,24 +543,25 @@ static int fsl_lpspi_probe(struct platform_device *pd=
ev)
=20
 	clk_disable_unprepare(fsl_lpspi->clk);
=20
-	ret =3D devm_spi_register_master(&pdev->dev, master);
+	ret =3D devm_spi_register_controller(&pdev->dev, controller);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "spi_register_master error.\n");
-		goto out_master_put;
+		dev_err(&pdev->dev, "spi_register_controller error.\n");
+		goto out_controller_put;
 	}
=20
 	return 0;
=20
-out_master_put:
-	spi_master_put(master);
+out_controller_put:
+	spi_controller_put(controller);
=20
 	return ret;
 }
=20
 static int fsl_lpspi_remove(struct platform_device *pdev)
 {
-	struct spi_master *master =3D platform_get_drvdata(pdev);
-	struct fsl_lpspi_data *fsl_lpspi =3D spi_master_get_devdata(master);
+	struct spi_controller *controller =3D platform_get_drvdata(pdev);
+	struct fsl_lpspi_data *fsl_lpspi =3D
+				spi_controller_get_devdata(controller);
=20
 	clk_disable_unprepare(fsl_lpspi->clk);
=20
@@ -509,6 +578,6 @@ static struct platform_driver fsl_lpspi_driver =3D {
 };
 module_platform_driver(fsl_lpspi_driver);
=20
-MODULE_DESCRIPTION("LPSPI Master Controller driver");
+MODULE_DESCRIPTION("LPSPI Controller driver");
 MODULE_AUTHOR("Gao Pan <pandy.gao@nxp.com>");
 MODULE_LICENSE("GPL");
--=20
2.17.1

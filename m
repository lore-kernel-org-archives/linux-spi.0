From: Clark Wang <xiaoning.wang@nxp.com>
Subject: [PATCH 8/8] spi: lpspi: add dma mode support
Date: Mon, 7 Jan 2019 07:47:49 +0000
Message-ID: <20190107074639.6336-9-xiaoning.wang@nxp.com>
References: <20190107074639.6336-1-xiaoning.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Clark Wang <xiaoning.wang@nxp.com>
To: "broonie@kernel.org" <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190107074639.6336-1-xiaoning.wang@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Add dma mode support for LPSPI. Any frame longer than half txfifosize will
be sent by dma mode.

For now, there are some notes:
1. The maximum transfer speed in master mode depends on the slave device,
   at least 40MHz on i.MX8 series (tested by spi-nor on 8qm-lpddr4-arm2
   base board);
2. The maximum transfer speed in slave mode is 15MHz(i.MX7ULP),
   22MHz(i.MX8 series).

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
---
 drivers/spi/spi-fsl-lpspi.c | 318 ++++++++++++++++++++++++++++++++++--
 1 file changed, 306 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 83e15366b739..85e4e36b71a3 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -8,6 +8,8 @@
 #include <linux/clk.h>
 #include <linux/completion.h>
 #include <linux/delay.h>
+#include <linux/dmaengine.h>
+#include <linux/dma-mapping.h>
 #include <linux/err.h>
 #include <linux/gpio.h>
 #include <linux/interrupt.h>
@@ -19,6 +21,7 @@
 #include <linux/of_device.h>
 #include <linux/of_gpio.h>
 #include <linux/pinctrl/consumer.h>
+#include <linux/platform_data/dma-imx.h>
 #include <linux/platform_data/spi-imx.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
@@ -31,6 +34,9 @@
=20
 #define FSL_LPSPI_RPM_TIMEOUT 50 /* 50ms */
=20
+/* The maximum bytes that edma can transfer once.*/
+#define FSL_LPSPI_MAX_EDMA_BYTES  ((1 << 15) - 1)
+
 #define LPSPI_CS_ACTIVE		1
 #define LPSPI_CS_INACTIVE	0
 #define LPSPI_CS_DELAY		100
@@ -68,6 +74,8 @@
 #define IER_FCIE	BIT(9)
 #define IER_RDIE	BIT(1)
 #define IER_TDIE	BIT(0)
+#define DER_RDDE	BIT(1)
+#define DER_TDDE	BIT(0)
 #define CFGR1_PCSCFG	BIT(27)
 #define CFGR1_PINCFG	(BIT(24)|BIT(25))
 #define CFGR1_PCSPOL	BIT(8)
@@ -95,6 +103,7 @@ struct lpspi_config {
 struct fsl_lpspi_data {
 	struct device *dev;
 	void __iomem *base;
+	unsigned long base_phys;
 	struct clk *clk_ipg;
 	struct clk *clk_per;
 	bool is_slave;
@@ -105,6 +114,8 @@ struct fsl_lpspi_data {
 	void (*tx)(struct fsl_lpspi_data *);
 	void (*rx)(struct fsl_lpspi_data *);
=20
+	u32 bytes_per_word;
+	u32 bits_per_word;
 	u32 remain;
 	u8 watermark;
 	u8 txfifosize;
@@ -115,6 +126,11 @@ struct fsl_lpspi_data {
=20
 	bool slave_aborted;
=20
+	/* DMA */
+	bool usedma;
+	struct completion dma_rx_completion;
+	struct completion dma_tx_completion;
+
 	int chipselect[4];
 };
=20
@@ -162,6 +178,35 @@ static void fsl_lpspi_intctrl(struct fsl_lpspi_data *f=
sl_lpspi,
 	writel(enable, fsl_lpspi->base + IMX7ULP_IER);
 }
=20
+static int fsl_lpspi_bytes_per_word(const int bpw)
+{
+	return DIV_ROUND_UP(bpw, BITS_PER_BYTE);
+}
+
+static bool fsl_lpspi_can_dma(struct spi_controller *controller,
+			      struct spi_device *spi,
+			      struct spi_transfer *transfer)
+{
+	struct fsl_lpspi_data *fsl_lpspi =3D
+				spi_controller_get_devdata(controller);
+	unsigned int bytes_per_word;
+
+	if (!controller->dma_rx)
+		return false;
+
+	if (fsl_lpspi->is_slave)
+		return false;
+
+	bytes_per_word =3D fsl_lpspi_bytes_per_word(transfer->bits_per_word);
+	if (bytes_per_word !=3D 1 && bytes_per_word !=3D 2 && bytes_per_word !=3D=
 4)
+		return false;
+
+	if (transfer->len < fsl_lpspi->txfifosize / 2)
+		return false;
+
+	return true;
+}
+
 static int lpspi_prepare_xfer_hardware(struct spi_controller *controller)
 {
 	struct fsl_lpspi_data *fsl_lpspi =3D
@@ -250,11 +295,13 @@ static void fsl_lpspi_set_cmd(struct fsl_lpspi_data *=
fsl_lpspi,
 		 * For the first transfer, clear TCR_CONTC to assert SS.
 		 * For subsequent transfer, set TCR_CONTC to keep SS asserted.
 		 */
-		temp |=3D TCR_CONT;
-		if (is_first_xfer)
-			temp &=3D ~TCR_CONTC;
-		else
-			temp |=3D TCR_CONTC;
+		if (!fsl_lpspi->usedma) {
+			temp |=3D TCR_CONT;
+			if (is_first_xfer)
+				temp &=3D ~TCR_CONTC;
+			else
+				temp |=3D TCR_CONTC;
+		}
 	}
 	writel(temp, fsl_lpspi->base + IMX7ULP_TCR);
=20
@@ -265,7 +312,11 @@ static void fsl_lpspi_set_watermark(struct fsl_lpspi_d=
ata *fsl_lpspi)
 {
 	u32 temp;
=20
-	temp =3D fsl_lpspi->watermark >> 1 | (fsl_lpspi->watermark >> 1) << 16;
+	if (!fsl_lpspi->usedma)
+		temp =3D fsl_lpspi->watermark >> 1 |
+		       (fsl_lpspi->watermark >> 1) << 16;
+	else
+		temp =3D fsl_lpspi->txfifosize >> 1;
=20
 	writel(temp, fsl_lpspi->base + IMX7ULP_FCR);
=20
@@ -301,12 +352,59 @@ static int fsl_lpspi_set_bitrate(struct fsl_lpspi_dat=
a *fsl_lpspi)
 	writel(scldiv | (scldiv << 8) | ((scldiv >> 1) << 16),
 					fsl_lpspi->base + IMX7ULP_CCR);
=20
-	dev_dbg(fsl_lpspi->dev, "perclk=3D%d, speed=3D%d, prescale =3D%d, scldiv=
=3D%d\n",
+	dev_dbg(fsl_lpspi->dev, "perclk=3D%d, speed=3D%d, prescale=3D%d, scldiv=
=3D%d\n",
 		perclk_rate, config.speed_hz, prescale, scldiv);
=20
 	return 0;
 }
=20
+static int fsl_lpspi_dma_configure(struct spi_controller *controller)
+{
+	int ret;
+	enum dma_slave_buswidth buswidth;
+	struct dma_slave_config rx =3D {}, tx =3D {};
+	struct fsl_lpspi_data *fsl_lpspi =3D
+				spi_controller_get_devdata(controller);
+
+	switch (fsl_lpspi_bytes_per_word(fsl_lpspi->bits_per_word)) {
+	case 4:
+		buswidth =3D DMA_SLAVE_BUSWIDTH_4_BYTES;
+		break;
+	case 2:
+		buswidth =3D DMA_SLAVE_BUSWIDTH_2_BYTES;
+		break;
+	case 1:
+		buswidth =3D DMA_SLAVE_BUSWIDTH_1_BYTE;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	tx.direction =3D DMA_MEM_TO_DEV;
+	tx.dst_addr =3D fsl_lpspi->base_phys + IMX7ULP_TDR;
+	tx.dst_addr_width =3D buswidth;
+	tx.dst_maxburst =3D 1;
+	ret =3D dmaengine_slave_config(controller->dma_tx, &tx);
+	if (ret) {
+		dev_err(fsl_lpspi->dev, "TX dma configuration failed with %d\n",
+			ret);
+		return ret;
+	}
+
+	rx.direction =3D DMA_DEV_TO_MEM;
+	rx.src_addr =3D fsl_lpspi->base_phys + IMX7ULP_RDR;
+	rx.src_addr_width =3D buswidth;
+	rx.src_maxburst =3D 1;
+	ret =3D dmaengine_slave_config(controller->dma_rx, &rx);
+	if (ret) {
+		dev_err(fsl_lpspi->dev, "RX dma configuration failed with %d\n",
+			ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 static int fsl_lpspi_config(struct fsl_lpspi_data *fsl_lpspi)
 {
 	u32 temp;
@@ -332,15 +430,22 @@ static int fsl_lpspi_config(struct fsl_lpspi_data *fs=
l_lpspi)
 	temp |=3D CR_RRF | CR_RTF | CR_MEN;
 	writel(temp, fsl_lpspi->base + IMX7ULP_CR);
=20
+	temp =3D 0;
+	if (fsl_lpspi->usedma)
+		temp =3D DER_TDDE | DER_RDDE;
+	writel(temp, fsl_lpspi->base + IMX7ULP_DER);
+
 	return 0;
 }
=20
-static int fsl_lpspi_setup_transfer(struct spi_device *spi,
+static int fsl_lpspi_setup_transfer(struct spi_controller *controller,
+				     struct spi_device *spi,
 				     struct spi_transfer *t)
 {
 	struct fsl_lpspi_data *fsl_lpspi =3D
 				spi_controller_get_devdata(spi->controller);
=20
+	fsl_lpspi->bits_per_word =3D t->bits_per_word;
 	fsl_lpspi->config.mode =3D spi->mode;
 	fsl_lpspi->config.bpw =3D t ? t->bits_per_word : spi->bits_per_word;
 	fsl_lpspi->config.speed_hz =3D t ? t->speed_hz : spi->max_speed_hz;
@@ -368,6 +473,11 @@ static int fsl_lpspi_setup_transfer(struct spi_device =
*spi,
 	else
 		fsl_lpspi->watermark =3D fsl_lpspi->txfifosize;
=20
+	if (fsl_lpspi_can_dma(controller, spi, t))
+		fsl_lpspi->usedma =3D 1;
+	else
+		fsl_lpspi->usedma =3D 0;
+
 	return fsl_lpspi_config(fsl_lpspi);
 }
=20
@@ -406,8 +516,10 @@ static int fsl_lpspi_reset(struct fsl_lpspi_data *fsl_=
lpspi)
 {
 	u32 temp;
=20
-	/* Disable all interrupt */
-	fsl_lpspi_intctrl(fsl_lpspi, 0);
+	if (!fsl_lpspi->usedma) {
+		/* Disable all interrupt */
+		fsl_lpspi_intctrl(fsl_lpspi, 0);
+	}
=20
 	/* W1C for all flags in SR */
 	temp =3D 0x3F << 8;
@@ -420,6 +532,128 @@ static int fsl_lpspi_reset(struct fsl_lpspi_data *fsl=
_lpspi)
 	return 0;
 }
=20
+static void fsl_lpspi_dma_rx_callback(void *cookie)
+{
+	struct fsl_lpspi_data *fsl_lpspi =3D (struct fsl_lpspi_data *)cookie;
+
+	complete(&fsl_lpspi->dma_rx_completion);
+}
+
+static void fsl_lpspi_dma_tx_callback(void *cookie)
+{
+	struct fsl_lpspi_data *fsl_lpspi =3D (struct fsl_lpspi_data *)cookie;
+
+	complete(&fsl_lpspi->dma_tx_completion);
+}
+
+static int fsl_lpspi_calculate_timeout(struct fsl_lpspi_data *fsl_lpspi,
+				       int size)
+{
+	unsigned long timeout =3D 0;
+
+	/* Time with actual data transfer and CS change delay related to HW */
+	timeout =3D (8 + 4) * size / fsl_lpspi->config.speed_hz;
+
+	/* Add extra second for scheduler related activities */
+	timeout +=3D 1;
+
+	/* Double calculated timeout */
+	return msecs_to_jiffies(2 * timeout * MSEC_PER_SEC);
+}
+
+static int fsl_lpspi_dma_transfer(struct spi_controller *controller,
+				struct fsl_lpspi_data *fsl_lpspi,
+				struct spi_transfer *transfer)
+{
+	struct dma_async_tx_descriptor *desc_tx, *desc_rx;
+	unsigned long transfer_timeout;
+	unsigned long timeout;
+	struct sg_table *tx =3D &transfer->tx_sg, *rx =3D &transfer->rx_sg;
+	int ret;
+
+	ret =3D fsl_lpspi_dma_configure(controller);
+	if (ret)
+		return ret;
+
+	desc_rx =3D dmaengine_prep_slave_sg(controller->dma_rx,
+				rx->sgl, rx->nents, DMA_DEV_TO_MEM,
+				DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (!desc_rx)
+		return -EINVAL;
+
+	desc_rx->callback =3D fsl_lpspi_dma_rx_callback;
+	desc_rx->callback_param =3D (void *)fsl_lpspi;
+	dmaengine_submit(desc_rx);
+	reinit_completion(&fsl_lpspi->dma_rx_completion);
+	dma_async_issue_pending(controller->dma_rx);
+
+	desc_tx =3D dmaengine_prep_slave_sg(controller->dma_tx,
+				tx->sgl, tx->nents, DMA_MEM_TO_DEV,
+				DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (!desc_tx) {
+		dmaengine_terminate_all(controller->dma_tx);
+		return -EINVAL;
+	}
+
+	desc_tx->callback =3D fsl_lpspi_dma_tx_callback;
+	desc_tx->callback_param =3D (void *)fsl_lpspi;
+	dmaengine_submit(desc_tx);
+	reinit_completion(&fsl_lpspi->dma_tx_completion);
+	dma_async_issue_pending(controller->dma_tx);
+
+	fsl_lpspi->slave_aborted =3D false;
+
+	if (!fsl_lpspi->is_slave) {
+		transfer_timeout =3D fsl_lpspi_calculate_timeout(fsl_lpspi,
+							       transfer->len);
+
+		/* Wait eDMA to finish the data transfer.*/
+		timeout =3D wait_for_completion_timeout(&fsl_lpspi->dma_tx_completion,
+						      transfer_timeout);
+		if (!timeout) {
+			dev_err(fsl_lpspi->dev, "I/O Error in DMA TX\n");
+			dmaengine_terminate_all(controller->dma_tx);
+			dmaengine_terminate_all(controller->dma_rx);
+			fsl_lpspi_reset(fsl_lpspi);
+			return -ETIMEDOUT;
+		}
+
+		timeout =3D wait_for_completion_timeout(&fsl_lpspi->dma_rx_completion,
+						      transfer_timeout);
+		if (!timeout) {
+			dev_err(fsl_lpspi->dev, "I/O Error in DMA RX\n");
+			dmaengine_terminate_all(controller->dma_tx);
+			dmaengine_terminate_all(controller->dma_rx);
+			fsl_lpspi_reset(fsl_lpspi);
+			return -ETIMEDOUT;
+		}
+	} else {
+		if (wait_for_completion_interruptible(&fsl_lpspi->dma_tx_completion) ||
+			fsl_lpspi->slave_aborted) {
+			dev_dbg(fsl_lpspi->dev,
+				"I/O Error in DMA TX interrupted\n");
+			dmaengine_terminate_all(controller->dma_tx);
+			dmaengine_terminate_all(controller->dma_rx);
+			fsl_lpspi_reset(fsl_lpspi);
+			return -EINTR;
+		}
+
+		if (wait_for_completion_interruptible(&fsl_lpspi->dma_rx_completion) ||
+			fsl_lpspi->slave_aborted) {
+			dev_dbg(fsl_lpspi->dev,
+				"I/O Error in DMA RX interrupted\n");
+			dmaengine_terminate_all(controller->dma_tx);
+			dmaengine_terminate_all(controller->dma_rx);
+			fsl_lpspi_reset(fsl_lpspi);
+			return -EINTR;
+		}
+	}
+
+	fsl_lpspi_reset(fsl_lpspi);
+
+	return 0;
+}
+
 static int fsl_lpspi_transfer_one(struct spi_controller *controller,
 				  struct spi_device *spi,
 				  struct spi_transfer *t)
@@ -446,6 +680,54 @@ static int fsl_lpspi_transfer_one(struct spi_controlle=
r *controller,
 	return 0;
 }
=20
+static void fsl_lpspi_dma_exit(struct spi_controller *controller)
+{
+	if (controller->dma_rx) {
+		dma_release_channel(controller->dma_rx);
+		controller->dma_rx =3D NULL;
+	}
+
+	if (controller->dma_tx) {
+		dma_release_channel(controller->dma_tx);
+		controller->dma_tx =3D NULL;
+	}
+}
+
+static int fsl_lpspi_dma_init(struct device *dev,
+			      struct fsl_lpspi_data *fsl_lpspi,
+			      struct spi_controller *controller)
+{
+	int ret;
+
+	/* Prepare for TX DMA: */
+	controller->dma_tx =3D dma_request_slave_channel_reason(dev, "tx");
+	if (IS_ERR(controller->dma_tx)) {
+		ret =3D PTR_ERR(controller->dma_tx);
+		dev_dbg(dev, "can't get the TX DMA channel, error %d!\n", ret);
+		controller->dma_tx =3D NULL;
+		goto err;
+	}
+
+	/* Prepare for RX DMA: */
+	controller->dma_rx =3D dma_request_slave_channel(dev, "rx");
+	if (IS_ERR(controller->dma_rx)) {
+		ret =3D PTR_ERR(controller->dma_rx);
+		dev_dbg(dev, "can't get the RX DMA channel, error %d\n", ret);
+		controller->dma_rx =3D NULL;
+		goto err;
+	}
+
+	init_completion(&fsl_lpspi->dma_rx_completion);
+	init_completion(&fsl_lpspi->dma_tx_completion);
+	controller->can_dma =3D fsl_lpspi_can_dma;
+	controller->max_dma_len =3D FSL_LPSPI_MAX_EDMA_BYTES;
+
+	return 0;
+err:
+	fsl_lpspi_dma_exit(controller);
+	return ret;
+}
+
 static int fsl_lpspi_setup(struct spi_device *spi)
 {
 	struct fsl_lpspi_data *fsl_lpspi =3D
@@ -483,7 +765,7 @@ static int fsl_lpspi_transfer_one_msg(struct spi_contro=
ller *controller,
 	msg->actual_length =3D 0;
=20
 	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
-		ret =3D fsl_lpspi_setup_transfer(spi, xfer);
+		ret =3D fsl_lpspi_setup_transfer(controller, spi, xfer);
 		if (ret < 0)
 			goto complete;
=20
@@ -491,7 +773,11 @@ static int fsl_lpspi_transfer_one_msg(struct spi_contr=
oller *controller,
=20
 		is_first_xfer =3D false;
=20
-		ret =3D fsl_lpspi_transfer_one(controller, spi, xfer);
+		if (fsl_lpspi->usedma)
+			ret =3D fsl_lpspi_dma_transfer(controller, fsl_lpspi,
+						     xfer);
+		else
+			ret =3D fsl_lpspi_transfer_one(controller, spi, xfer);
 		if (ret < 0)
 			goto complete;
=20
@@ -662,6 +948,7 @@ static int fsl_lpspi_probe(struct platform_device *pdev=
)
 		ret =3D PTR_ERR(fsl_lpspi->base);
 		goto out_controller_put;
 	}
+	fsl_lpspi->base_phys =3D res->start;
=20
 	irq =3D platform_get_irq(pdev, 0);
 	if (irq < 0) {
@@ -703,6 +990,13 @@ static int fsl_lpspi_probe(struct platform_device *pde=
v)
 	fsl_lpspi->txfifosize =3D 1 << (temp & 0x0f);
 	fsl_lpspi->rxfifosize =3D 1 << ((temp >> 8) & 0x0f);
=20
+	ret =3D fsl_lpspi_dma_init(&pdev->dev, fsl_lpspi, controller);
+	if (ret =3D=3D -EPROBE_DEFER)
+		goto out_controller_put;
+
+	if (ret < 0)
+		dev_err(&pdev->dev, "dma setup error %d, use pio\n", ret);
+
 	ret =3D devm_spi_register_controller(&pdev->dev, controller);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "spi_register_controller error.\n");
--=20
2.17.1

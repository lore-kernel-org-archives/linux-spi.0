From: Robin Gong <yibin.gong@nxp.com>
Subject: [PATCH v1 1/3] spi: imx: move wml setting to later than
 setup_transfer
Date: Wed, 10 Oct 2018 10:32:42 +0000
Message-ID: <1539196453-8704-2-git-send-email-yibin.gong@nxp.com>
References: <1539196453-8704-1-git-send-email-yibin.gong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: "maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
To: "broonie@kernel.org" <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539196453-8704-1-git-send-email-yibin.gong@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Current dynamic burst length is based on the whole transfer length,
that's ok if there is only one sg, but is not right in case multi sgs
in one transfer,because the tail data should be based on the last sg
length instead of the whole transfer length. Move wml setting for DMA
to the later place, thus, the next patch could get the right last sg
length for wml setting. This patch is a preparation one, no any
function change involved.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 drivers/spi/spi-imx.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 08dd3a3..e861157 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -63,6 +63,7 @@ struct spi_imx_devtype_data {
 	void (*trigger)(struct spi_imx_data *);
 	int (*rx_available)(struct spi_imx_data *);
 	void (*reset)(struct spi_imx_data *);
+	void (*setup_wml)(struct spi_imx_data *);
 	void (*disable)(struct spi_imx_data *);
 	bool has_dmamode;
 	bool has_slavemode;
@@ -583,6 +584,11 @@ static int mx51_ecspi_config(struct spi_device *spi)
 	else			/* SCLK is _very_ slow */
 		usleep_range(delay, delay + 10);
=20
+	return 0;
+}
+
+static void mx51_setup_wml(struct spi_imx_data *spi_imx)
+{
 	/*
 	 * Configure the DMA register: setup the watermark
 	 * and enable DMA request.
@@ -593,8 +599,6 @@ static int mx51_ecspi_config(struct spi_device *spi)
 		MX51_ECSPI_DMA_RXT_WML(spi_imx->wml) |
 		MX51_ECSPI_DMA_TEDEN | MX51_ECSPI_DMA_RXDEN |
 		MX51_ECSPI_DMA_RXTDEN, spi_imx->base + MX51_ECSPI_DMA);
-
-	return 0;
 }
=20
 static int mx51_ecspi_rx_available(struct spi_imx_data *spi_imx)
@@ -931,6 +935,7 @@ static struct spi_imx_devtype_data imx51_ecspi_devtype_=
data =3D {
 	.trigger =3D mx51_ecspi_trigger,
 	.rx_available =3D mx51_ecspi_rx_available,
 	.reset =3D mx51_ecspi_reset,
+	.setup_wml =3D mx51_setup_wml,
 	.fifo_size =3D 64,
 	.has_dmamode =3D true,
 	.dynamic_burst =3D true,
@@ -1138,7 +1143,6 @@ static int spi_imx_setupxfer(struct spi_device *spi,
 				 struct spi_transfer *t)
 {
 	struct spi_imx_data *spi_imx =3D spi_master_get_devdata(spi->master);
-	int ret;
=20
 	if (!t)
 		return 0;
@@ -1179,12 +1183,6 @@ static int spi_imx_setupxfer(struct spi_device *spi,
 	else
 		spi_imx->usedma =3D 0;
=20
-	if (spi_imx->usedma) {
-		ret =3D spi_imx_dma_configure(spi->master);
-		if (ret)
-			return ret;
-	}
-
 	if (is_imx53_ecspi(spi_imx) && spi_imx->slave_mode) {
 		spi_imx->rx =3D mx53_ecspi_rx_slave;
 		spi_imx->tx =3D mx53_ecspi_tx_slave;
@@ -1289,6 +1287,13 @@ static int spi_imx_dma_transfer(struct spi_imx_data =
*spi_imx,
 	unsigned long timeout;
 	struct spi_master *master =3D spi_imx->bitbang.master;
 	struct sg_table *tx =3D &transfer->tx_sg, *rx =3D &transfer->rx_sg;
+	int ret;
+
+	ret =3D spi_imx_dma_configure(master);
+	if (ret)
+		return ret;
+
+	spi_imx->devtype_data->setup_wml(spi_imx);
=20
 	/*
 	 * The TX DMA setup starts the transfer, so make sure RX is configured
--=20
2.7.4

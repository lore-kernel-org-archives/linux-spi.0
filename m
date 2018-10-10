From: Robin Gong <yibin.gong@nxp.com>
Subject: [PATCH v1 2/3] spi: imx: correct wml as the last sg length
Date: Wed, 10 Oct 2018 10:32:45 +0000
Message-ID: <1539196453-8704-3-git-send-email-yibin.gong@nxp.com>
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

Correct wml as the last rx sg length instead of the whole transfer
length. Otherwise, mtd_stresstest will be failed as below:

insmod mtd_stresstest.ko dev=3D0
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
mtd_stresstest: MTD device: 0
mtd_stresstest: not NAND flash, assume page size is 512 bytes.
mtd_stresstest: MTD device size 4194304, eraseblock size 65536, page size 5=
12, count of eraseblocks 64, pa0
mtd_stresstest: doing operations
mtd_stresstest: 0 operations done
mtd_test: mtd_read from 1ff532, size 880
mtd_test: mtd_read from 20c267, size 64998
spi_master spi0: I/O Error in DMA RX
m25p80 spi0.0: SPI transfer failed: -110
spi_master spi0: failed to transfer one message from queue
mtd_test: error: read failed at 0x20c267
mtd_stresstest: error -110 occurred
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
insmod: ERROR: could not insert module mtd_stresstest.ko: Connection timed =
out

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 drivers/spi/spi-imx.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index e861157..037abbb 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -217,7 +217,6 @@ static bool spi_imx_can_dma(struct spi_master *master, =
struct spi_device *spi,
 			 struct spi_transfer *transfer)
 {
 	struct spi_imx_data *spi_imx =3D spi_master_get_devdata(master);
-	unsigned int bytes_per_word, i;
=20
 	if (!master->dma_rx)
 		return false;
@@ -225,14 +224,6 @@ static bool spi_imx_can_dma(struct spi_master *master,=
 struct spi_device *spi,
 	if (spi_imx->slave_mode)
 		return false;
=20
-	bytes_per_word =3D spi_imx_bytes_per_word(transfer->bits_per_word);
-
-	for (i =3D spi_imx->devtype_data->fifo_size / 2; i > 0; i--) {
-		if (!(transfer->len % (i * bytes_per_word)))
-			break;
-	}
-
-	spi_imx->wml =3D i;
 	spi_imx->dynamic_burst =3D 0;
=20
 	return true;
@@ -594,7 +585,7 @@ static void mx51_setup_wml(struct spi_imx_data *spi_imx=
)
 	 * and enable DMA request.
 	 */
=20
-	writel(MX51_ECSPI_DMA_RX_WML(spi_imx->wml) |
+	writel(MX51_ECSPI_DMA_RX_WML(spi_imx->wml - 1) |
 		MX51_ECSPI_DMA_TX_WML(spi_imx->wml) |
 		MX51_ECSPI_DMA_RXT_WML(spi_imx->wml) |
 		MX51_ECSPI_DMA_TEDEN | MX51_ECSPI_DMA_RXDEN |
@@ -1287,12 +1278,30 @@ static int spi_imx_dma_transfer(struct spi_imx_data=
 *spi_imx,
 	unsigned long timeout;
 	struct spi_master *master =3D spi_imx->bitbang.master;
 	struct sg_table *tx =3D &transfer->tx_sg, *rx =3D &transfer->rx_sg;
+	struct scatterlist *last_sg =3D sg_last(rx->sgl, rx->nents);
+	unsigned int bytes_per_word, i;
 	int ret;
=20
+	/* Get the right burst length from the last sg to ensure no tail data */
+	bytes_per_word =3D spi_imx_bytes_per_word(transfer->bits_per_word);
+	for (i =3D spi_imx->devtype_data->fifo_size / 2; i > 0; i--) {
+		if (!(sg_dma_len(last_sg) % (i * bytes_per_word)))
+			break;
+	}
+	/* Use 1 as wml in case no available burst length got */
+	if (i =3D=3D 0)
+		i =3D 1;
+
+	spi_imx->wml =3D  i;
+
 	ret =3D spi_imx_dma_configure(master);
 	if (ret)
 		return ret;
=20
+	if (!spi_imx->devtype_data->setup_wml) {
+		dev_err(spi_imx->dev, "No setup_wml()?\n");
+		return -EINVAL;
+	}
 	spi_imx->devtype_data->setup_wml(spi_imx);
=20
 	/*
--=20
2.7.4

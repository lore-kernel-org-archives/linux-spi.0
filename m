From: Aurelien BOUIN <a.bouin@gmail.com>
Subject: [PATCH 3/4] spi: imx: Chose DMA bits per word transfered
Date: Thu, 12 Feb 2015 13:07:27 +0100
Message-ID: <1423742848-15369-3-git-send-email-a.bouin@gmail.com>
References: <1423742848-15369-1-git-send-email-a.bouin@gmail.com>
Cc: festevam@gmail.com, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Aurelien BOUIN <a.bouin@gmail.com>
To: broonie@kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1423742848-15369-1-git-send-email-a.bouin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This patch enable to give a parameter to device tree to set the number of bits per word the DMA uses in transfer
In device tree you can specify fsl,spi-dma-bits-per-word = <16>; in the ecspi section

Signed-off-by: Aurelien BOUIN <a.bouin@gmail.com>

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index f8400b2..9690d57 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -110,6 +110,7 @@ struct spi_imx_data {
 	u32 rxt_wml;
 	struct completion dma_rx_completion;
 	struct completion dma_tx_completion;
+	unsigned int dma_bits_per_word;
 
 	const struct spi_imx_devtype_data *devtype_data;
 	int chipselect[0];
@@ -825,6 +826,7 @@ static int spi_imx_sdma_init(struct device *dev, struct spi_imx_data *spi_imx,
 {
 	struct dma_slave_config slave_config = {};
 	int ret;
+	enum dma_slave_buswidth dsb_default = DMA_SLAVE_BUSWIDTH_1_BYTE;
 
 	/* use pio mode for i.mx6dl chip TKT238285 */
 	if (of_machine_is_compatible("fsl,imx6dl"))
@@ -837,10 +839,20 @@ static int spi_imx_sdma_init(struct device *dev, struct spi_imx_data *spi_imx,
 		ret = -EINVAL;
 		goto err;
 	}
-
+	switch (spi_imx->dma_bits_per_word) {
+	case 32:
+		dsb_default = DMA_SLAVE_BUSWIDTH_4_BYTES;
+		break;
+	case 16:
+		dsb_default = DMA_SLAVE_BUSWIDTH_2_BYTES;
+		break;
+	default:
+		dsb_default = DMA_SLAVE_BUSWIDTH_1_BYTE;
+		break;
+	}
 	slave_config.direction = DMA_MEM_TO_DEV;
 	slave_config.dst_addr = res->start + MXC_CSPITXDATA;
-	slave_config.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+	slave_config.dst_addr_width = dsb_default;
 	slave_config.dst_maxburst = spi_imx_get_fifosize(spi_imx) / 2;
 	ret = dmaengine_slave_config(master->dma_tx, &slave_config);
 	if (ret) {
@@ -858,7 +870,7 @@ static int spi_imx_sdma_init(struct device *dev, struct spi_imx_data *spi_imx,
 
 	slave_config.direction = DMA_DEV_TO_MEM;
 	slave_config.src_addr = res->start + MXC_CSPIRXDATA;
-	slave_config.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+	slave_config.src_addr_width = dsb_default;
 	slave_config.src_maxburst = spi_imx_get_fifosize(spi_imx) / 2;
 	ret = dmaengine_slave_config(master->dma_rx, &slave_config);
 	if (ret) {
@@ -1083,7 +1095,7 @@ static int spi_imx_probe(struct platform_device *pdev)
 	struct spi_master *master;
 	struct spi_imx_data *spi_imx;
 	struct resource *res;
-	int i, ret, num_cs;
+	int i, ret, num_cs, dma_bits_per_word = 8;
 
 	if (!np && !mxc_platform_info) {
 		dev_err(&pdev->dev, "can't get the platform data\n");
@@ -1138,6 +1150,11 @@ static int spi_imx_probe(struct platform_device *pdev)
 	spi_imx->bitbang.master->prepare_message = spi_imx_prepare_message;
 	spi_imx->bitbang.master->unprepare_message = spi_imx_unprepare_message;
 	spi_imx->bitbang.master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
+	if (of_property_read_u32(np, "fsl,spi-dma-bits-per-word",
+			&dma_bits_per_word))
+		spi_imx->dma_bits_per_word = dma_bits_per_word;
+	else
+		spi_imx->dma_bits_per_word = 8;
 
 	init_completion(&spi_imx->xfer_done);
 
-- 
1.9.1

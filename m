From: Priit Laes <plaes@plaes.org>
Subject: [PATCH 1/2] spi: sun4i: add DMA support
Date: Fri, 26 Feb 2016 07:56:56 +0200
Message-ID: <1456466217-6793-2-git-send-email-plaes@plaes.org>
References: <1456466217-6793-1-git-send-email-plaes@plaes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Emilio=20L=C3=B3pez?= <emilio@elopez.com.ar>,
	Michal Suchanek <hramrach@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	Chen-Yu Tsai <wens@csie.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456466217-6793-1-git-send-email-plaes@plaes.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

=46rom: Emilio L=C3=B3pez <emilio@elopez.com.ar>

This patch adds support for 64 byte or bigger transfers on the
sun4i SPI controller. Said transfers will be performed via DMA.

Signed-off-by: Emilio L=C3=B3pez <emilio@elopez.com.ar>
Tested-by: Michal Suchanek <hramrach@gmail.com>
Tested-by: Priit Laes <plaes@plaes.org>
---
 drivers/spi/spi-sun4i.c | 140 ++++++++++++++++++++++++++++++++++++++++=
+++-----
 1 file changed, 128 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
index 1ddd9e2..78141a6 100644
--- a/drivers/spi/spi-sun4i.c
+++ b/drivers/spi/spi-sun4i.c
@@ -14,6 +14,8 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/device.h>
+#include <linux/dmaengine.h>
+#include <linux/dma-mapping.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/module.h>
@@ -34,6 +36,7 @@
 #define SUN4I_CTL_CPHA				BIT(2)
 #define SUN4I_CTL_CPOL				BIT(3)
 #define SUN4I_CTL_CS_ACTIVE_LOW			BIT(4)
+#define SUN4I_CTL_DMAMC_DEDICATED		BIT(5)
 #define SUN4I_CTL_LMTF				BIT(6)
 #define SUN4I_CTL_TF_RST			BIT(8)
 #define SUN4I_CTL_RF_RST			BIT(9)
@@ -51,6 +54,8 @@
 #define SUN4I_INT_STA_REG		0x10
=20
 #define SUN4I_DMA_CTL_REG		0x14
+#define SUN4I_DMA_CTL_RF_READY			BIT(0)
+#define SUN4I_DMA_CTL_TF_NOT_FULL		BIT(10)
=20
 #define SUN4I_WAIT_REG			0x18
=20
@@ -130,6 +135,13 @@ static inline void sun4i_spi_fill_fifo(struct sun4=
i_spi *sspi, int len)
 	}
 }
=20
+static bool sun4i_spi_can_dma(struct spi_master *master,
+			      struct spi_device *spi,
+			      struct spi_transfer *tfr)
+{
+	return tfr->len >=3D SUN4I_FIFO_DEPTH;
+}
+
 static void sun4i_spi_set_cs(struct spi_device *spi, bool enable)
 {
 	struct sun4i_spi *sspi =3D spi_master_get_devdata(spi->master);
@@ -172,14 +184,11 @@ static int sun4i_spi_transfer_one(struct spi_mast=
er *master,
 				  struct spi_transfer *tfr)
 {
 	struct sun4i_spi *sspi =3D spi_master_get_devdata(master);
+	struct dma_async_tx_descriptor *desc_tx =3D NULL, *desc_rx =3D NULL;
 	unsigned int mclk_rate, div, timeout;
 	unsigned int tx_len =3D 0;
+	u32 reg, trigger =3D 0;
 	int ret =3D 0;
-	u32 reg;
-
-	/* We don't support transfer larger than the FIFO */
-	if (tfr->len > SUN4I_FIFO_DEPTH)
-		return -EINVAL;
=20
 	reinit_completion(&sspi->done);
 	sspi->tx_buf =3D tfr->tx_buf;
@@ -189,7 +198,6 @@ static int sun4i_spi_transfer_one(struct spi_master=
 *master,
 	/* Clear pending interrupts */
 	sun4i_spi_write(sspi, SUN4I_INT_STA_REG, ~0);
=20
-
 	reg =3D sun4i_spi_read(sspi, SUN4I_CTL_REG);
=20
 	/* Reset FIFOs */
@@ -269,12 +277,65 @@ static int sun4i_spi_transfer_one(struct spi_mast=
er *master,
 	sun4i_spi_write(sspi, SUN4I_BURST_CNT_REG, SUN4I_BURST_CNT(tfr->len))=
;
 	sun4i_spi_write(sspi, SUN4I_XMIT_CNT_REG, SUN4I_XMIT_CNT(tx_len));
=20
-	/* Fill the TX FIFO */
-	sun4i_spi_fill_fifo(sspi, SUN4I_FIFO_DEPTH);
-
 	/* Enable the interrupts */
 	sun4i_spi_write(sspi, SUN4I_INT_CTL_REG, SUN4I_INT_CTL_TC);
=20
+	if (sun4i_spi_can_dma(master, spi, tfr)) {
+		dev_dbg(&sspi->master->dev, "Using DMA mode for transfer\n");
+
+		if (sspi->tx_buf) {
+			desc_tx =3D dmaengine_prep_slave_sg(master->dma_tx,
+					tfr->tx_sg.sgl, tfr->tx_sg.nents,
+					DMA_TO_DEVICE,
+					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+			if (!desc_tx) {
+				dev_err(&sspi->master->dev,
+					"Couldn't prepare dma slave\n");
+				return -EIO;
+			}
+
+			trigger |=3D SUN4I_DMA_CTL_TF_NOT_FULL;
+
+			dmaengine_submit(desc_tx);
+			dma_async_issue_pending(master->dma_tx);
+
+		}
+
+		if (sspi->rx_buf) {
+			desc_rx =3D dmaengine_prep_slave_sg(master->dma_rx,
+					tfr->rx_sg.sgl, tfr->rx_sg.nents,
+					DMA_FROM_DEVICE,
+					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+			if (!desc_rx) {
+				dev_err(&sspi->master->dev,
+					"Couldn't prepare dma slave\n");
+				return -EIO;
+			}
+
+			trigger |=3D SUN4I_DMA_CTL_RF_READY;
+
+			dmaengine_submit(desc_rx);
+			dma_async_issue_pending(master->dma_rx);
+		}
+
+		/* Enable Dedicated DMA requests */
+		reg =3D sun4i_spi_read(sspi, SUN4I_CTL_REG);
+		reg |=3D SUN4I_CTL_DMAMC_DEDICATED;
+		sun4i_spi_write(sspi, SUN4I_CTL_REG, reg);
+		sun4i_spi_write(sspi, SUN4I_DMA_CTL_REG, trigger);
+	} else {
+		dev_dbg(&sspi->master->dev, "Using PIO mode for transfer\n");
+
+		/* Disable DMA requests */
+		reg =3D sun4i_spi_read(sspi, SUN4I_CTL_REG);
+		sun4i_spi_write(sspi, SUN4I_CTL_REG,
+				reg & ~SUN4I_CTL_DMAMC_DEDICATED);
+		sun4i_spi_write(sspi, SUN4I_DMA_CTL_REG, 0);
+
+		/* Fill the TX FIFO */
+		sun4i_spi_fill_fifo(sspi, SUN4I_FIFO_DEPTH);
+	}
+
 	/* Start the transfer */
 	reg =3D sun4i_spi_read(sspi, SUN4I_CTL_REG);
 	sun4i_spi_write(sspi, SUN4I_CTL_REG, reg | SUN4I_CTL_XCH);
@@ -286,7 +347,12 @@ static int sun4i_spi_transfer_one(struct spi_maste=
r *master,
 		goto out;
 	}
=20
-	sun4i_spi_drain_fifo(sspi, SUN4I_FIFO_DEPTH);
+	if (sun4i_spi_can_dma(master, spi, tfr) && desc_rx) {
+		/* The receive transfer should be the last one to finish */
+		dma_wait_for_async_tx(desc_rx);
+	} else {
+		sun4i_spi_drain_fifo(sspi, SUN4I_FIFO_DEPTH);
+	}
=20
 out:
 	sun4i_spi_write(sspi, SUN4I_INT_CTL_REG, 0);
@@ -351,6 +417,7 @@ static int sun4i_spi_runtime_suspend(struct device =
*dev)
=20
 static int sun4i_spi_probe(struct platform_device *pdev)
 {
+	struct dma_slave_config dma_sconfig;
 	struct spi_master *master;
 	struct sun4i_spi *sspi;
 	struct resource	*res;
@@ -386,7 +453,9 @@ static int sun4i_spi_probe(struct platform_device *=
pdev)
 		goto err_free_master;
 	}
=20
+	init_completion(&sspi->done);
 	sspi->master =3D master;
+	master->can_dma =3D sun4i_spi_can_dma;
 	master->set_cs =3D sun4i_spi_set_cs;
 	master->transfer_one =3D sun4i_spi_transfer_one;
 	master->num_chipselect =3D 4;
@@ -409,7 +478,45 @@ static int sun4i_spi_probe(struct platform_device =
*pdev)
 		goto err_free_master;
 	}
=20
-	init_completion(&sspi->done);
+	master->dma_tx =3D dma_request_slave_channel_reason(&pdev->dev, "tx")=
;
+	if (IS_ERR(master->dma_tx)) {
+		dev_err(&pdev->dev, "Unable to acquire DMA channel TX\n");
+		ret =3D PTR_ERR(master->dma_tx);
+		goto err_free_master;
+	}
+
+	dma_sconfig.direction =3D DMA_MEM_TO_DEV;
+	dma_sconfig.src_addr_width =3D DMA_SLAVE_BUSWIDTH_1_BYTE;
+	dma_sconfig.dst_addr_width =3D DMA_SLAVE_BUSWIDTH_1_BYTE;
+	dma_sconfig.dst_addr =3D res->start + SUN4I_TXDATA_REG;
+	dma_sconfig.src_maxburst =3D 1;
+	dma_sconfig.dst_maxburst =3D 1;
+
+	ret =3D dmaengine_slave_config(master->dma_tx, &dma_sconfig);
+	if (ret) {
+		dev_err(&pdev->dev, "Unable to configure TX DMA slave\n");
+		goto err_tx_dma_release;
+	}
+
+	master->dma_rx =3D dma_request_slave_channel_reason(&pdev->dev, "rx")=
;
+	if (IS_ERR(master->dma_rx)) {
+		dev_err(&pdev->dev, "Unable to acquire DMA channel RX\n");
+		ret =3D PTR_ERR(master->dma_rx);
+		goto err_tx_dma_release;
+	}
+
+	dma_sconfig.direction =3D DMA_DEV_TO_MEM;
+	dma_sconfig.src_addr_width =3D DMA_SLAVE_BUSWIDTH_1_BYTE;
+	dma_sconfig.dst_addr_width =3D DMA_SLAVE_BUSWIDTH_1_BYTE;
+	dma_sconfig.src_addr =3D res->start + SUN4I_RXDATA_REG;
+	dma_sconfig.src_maxburst =3D 1;
+	dma_sconfig.dst_maxburst =3D 1;
+
+	ret =3D dmaengine_slave_config(master->dma_rx, &dma_sconfig);
+	if (ret) {
+		dev_err(&pdev->dev, "Unable to configure RX DMA slave\n");
+		goto err_rx_dma_release;
+	}
=20
 	/*
 	 * This wake-up/shutdown pattern is to be able to have the
@@ -418,7 +525,7 @@ static int sun4i_spi_probe(struct platform_device *=
pdev)
 	ret =3D sun4i_spi_runtime_resume(&pdev->dev);
 	if (ret) {
 		dev_err(&pdev->dev, "Couldn't resume the device\n");
-		goto err_free_master;
+		goto err_rx_dma_release;
 	}
=20
 	pm_runtime_set_active(&pdev->dev);
@@ -436,6 +543,10 @@ static int sun4i_spi_probe(struct platform_device =
*pdev)
 err_pm_disable:
 	pm_runtime_disable(&pdev->dev);
 	sun4i_spi_runtime_suspend(&pdev->dev);
+err_rx_dma_release:
+	dma_release_channel(master->dma_rx);
+err_tx_dma_release:
+	dma_release_channel(master->dma_tx);
 err_free_master:
 	spi_master_put(master);
 	return ret;
@@ -443,8 +554,13 @@ err_free_master:
=20
 static int sun4i_spi_remove(struct platform_device *pdev)
 {
+	struct spi_master *master =3D platform_get_drvdata(pdev);
+
 	pm_runtime_disable(&pdev->dev);
=20
+	dma_release_channel(master->dma_rx);
+	dma_release_channel(master->dma_tx);
+
 	return 0;
 }
=20
--=20
2.7.2

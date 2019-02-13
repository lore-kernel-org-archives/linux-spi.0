From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH v2 3/3] spi: sprd: spi: sprd: Add DMA mode support
Date: Wed, 13 Feb 2019 15:36:11 +0800
Message-ID: <3f9d23d4b250c5046f8c3411606aa9ffe807edd8.1550043082.git.baolin.wang@linaro.org>
References: <11e55b5f9b0d83649a5b81c7e3fdb667cd3ddc5b.1550043082.git.baolin.wang@linaro.org>
Cc: orsonzhai@gmail.com, zhang.lyra@gmail.com, lanqing.liu@unisoc.com,
        baolin.wang@linaro.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To: broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <11e55b5f9b0d83649a5b81c7e3fdb667cd3ddc5b.1550043082.git.baolin.wang@linaro.org>
In-Reply-To: <11e55b5f9b0d83649a5b81c7e3fdb667cd3ddc5b.1550043082.git.baolin.wang@linaro.org>
References: <11e55b5f9b0d83649a5b81c7e3fdb667cd3ddc5b.1550043082.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Lanqing Liu <lanqing.liu@unisoc.com>

Add DMA mode support for the Spreadtrum SPI controller, and we will enable
SPI interrupt to help to complete the SPI transfer work in DMA mode.

Signed-off-by: Lanqing Liu <lanqing.liu@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
Changes from v1:
 - Implement the can_dma() ops.
 - Remove DMA slave id configuration.
 - Optimize the SPI irq enable/disable.
---
 drivers/spi/spi-sprd.c |  293 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 290 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-sprd.c b/drivers/spi/spi-sprd.c
index d1ddeee..0c04a1d 100644
--- a/drivers/spi/spi-sprd.c
+++ b/drivers/spi/spi-sprd.c
@@ -2,6 +2,9 @@
 // Copyright (C) 2018 Spreadtrum Communications Inc.
 
 #include <linux/clk.h>
+#include <linux/dmaengine.h>
+#include <linux/dma-mapping.h>
+#include <linux/dma/sprd-dma.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
@@ -9,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/of_dma.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/spi/spi.h>
@@ -128,9 +132,25 @@
 #define SPRD_SPI_DEFAULT_SOURCE		26000000
 #define SPRD_SPI_MAX_SPEED_HZ		48000000
 #define SPRD_SPI_AUTOSUSPEND_DELAY	100
+#define SPRD_SPI_DMA_STEP		8
+
+enum sprd_spi_dma_channel {
+	SPI_RX,
+	SPI_TX,
+	SPI_MAX,
+};
+
+struct sprd_spi_dma {
+	bool enable;
+	struct dma_chan *dma_chan[SPI_MAX];
+	enum dma_slave_buswidth width;
+	u32 fragmens_len;
+	u32 rx_len;
+};
 
 struct sprd_spi {
 	void __iomem *base;
+	phys_addr_t phy_base;
 	struct device *dev;
 	struct clk *clk;
 	int irq;
@@ -142,6 +162,7 @@ struct sprd_spi {
 	u32 hw_speed_hz;
 	u32 len;
 	int status;
+	struct sprd_spi_dma dma;
 	struct completion xfer_completion;
 	const void *tx_buf;
 	void *rx_buf;
@@ -433,6 +454,208 @@ static int sprd_spi_txrx_bufs(struct spi_device *sdev, struct spi_transfer *t)
 	return ret;
 }
 
+static void sprd_spi_irq_enable(struct sprd_spi *ss)
+{
+	u32 val;
+
+	/* Clear interrupt status before enabling interrupt. */
+	writel_relaxed(SPRD_SPI_TX_END_CLR | SPRD_SPI_RX_END_CLR,
+		ss->base + SPRD_SPI_INT_CLR);
+	/* Enable SPI interrupt only in DMA mode. */
+	val = readl_relaxed(ss->base + SPRD_SPI_INT_EN);
+	writel_relaxed(val | SPRD_SPI_TX_END_INT_EN |
+		       SPRD_SPI_RX_END_INT_EN,
+		       ss->base + SPRD_SPI_INT_EN);
+}
+
+static void sprd_spi_irq_disable(struct sprd_spi *ss)
+{
+	writel_relaxed(0, ss->base + SPRD_SPI_INT_EN);
+}
+
+static void sprd_spi_dma_enable(struct sprd_spi *ss, bool enable)
+{
+	u32 val = readl_relaxed(ss->base + SPRD_SPI_CTL2);
+
+	if (enable)
+		val |= SPRD_SPI_DMA_EN;
+	else
+		val &= ~SPRD_SPI_DMA_EN;
+
+	writel_relaxed(val, ss->base + SPRD_SPI_CTL2);
+}
+
+static int sprd_spi_dma_submit(struct dma_chan *dma_chan,
+			       struct dma_slave_config *c,
+			       struct sg_table *sg,
+			       enum dma_transfer_direction dir)
+{
+	struct dma_async_tx_descriptor *desc;
+	dma_cookie_t cookie;
+	unsigned long flags;
+	int ret;
+
+	ret = dmaengine_slave_config(dma_chan, c);
+	if (ret < 0)
+		return ret;
+
+	flags = SPRD_DMA_FLAGS(SPRD_DMA_CHN_MODE_NONE, SPRD_DMA_NO_TRG,
+			       SPRD_DMA_FRAG_REQ, SPRD_DMA_TRANS_INT);
+	desc = dmaengine_prep_slave_sg(dma_chan, sg->sgl, sg->nents, dir, flags);
+	if (!desc)
+		return  -ENODEV;
+
+	cookie = dmaengine_submit(desc);
+	if (dma_submit_error(cookie))
+		return dma_submit_error(cookie);
+
+	dma_async_issue_pending(dma_chan);
+
+	return 0;
+}
+
+static int sprd_spi_dma_rx_config(struct sprd_spi *ss, struct spi_transfer *t)
+{
+	struct dma_chan *dma_chan = ss->dma.dma_chan[SPI_RX];
+	struct dma_slave_config config = {
+		.src_addr = ss->phy_base,
+		.src_addr_width = ss->dma.width,
+		.dst_addr_width = ss->dma.width,
+		.dst_maxburst = ss->dma.fragmens_len,
+	};
+	int ret;
+
+	ret = sprd_spi_dma_submit(dma_chan, &config, &t->rx_sg, DMA_DEV_TO_MEM);
+	if (ret)
+		return ret;
+
+	return ss->dma.rx_len;
+}
+
+static int sprd_spi_dma_tx_config(struct sprd_spi *ss, struct spi_transfer *t)
+{
+	struct dma_chan *dma_chan = ss->dma.dma_chan[SPI_TX];
+	struct dma_slave_config config = {
+		.dst_addr = ss->phy_base,
+		.src_addr_width = ss->dma.width,
+		.dst_addr_width = ss->dma.width,
+		.src_maxburst = ss->dma.fragmens_len,
+	};
+	int ret;
+
+	ret = sprd_spi_dma_submit(dma_chan, &config, &t->tx_sg, DMA_MEM_TO_DEV);
+	if (ret)
+		return ret;
+
+	return t->len;
+}
+
+static int sprd_spi_dma_request(struct sprd_spi *ss)
+{
+	ss->dma.dma_chan[SPI_RX] = dma_request_chan(ss->dev, "rx_chn");
+	if (IS_ERR_OR_NULL(ss->dma.dma_chan[SPI_RX])) {
+		if (PTR_ERR(ss->dma.dma_chan[SPI_RX]) == -EPROBE_DEFER)
+			return PTR_ERR(ss->dma.dma_chan[SPI_RX]);
+
+		dev_err(ss->dev, "request RX DMA channel failed!\n");
+		return PTR_ERR(ss->dma.dma_chan[SPI_RX]);
+	}
+
+	ss->dma.dma_chan[SPI_TX]  = dma_request_chan(ss->dev, "tx_chn");
+	if (IS_ERR_OR_NULL(ss->dma.dma_chan[SPI_TX])) {
+		if (PTR_ERR(ss->dma.dma_chan[SPI_TX]) == -EPROBE_DEFER)
+			return PTR_ERR(ss->dma.dma_chan[SPI_TX]);
+
+		dev_err(ss->dev, "request TX DMA channel failed!\n");
+		dma_release_channel(ss->dma.dma_chan[SPI_RX]);
+		return PTR_ERR(ss->dma.dma_chan[SPI_TX]);
+	}
+
+	return 0;
+}
+
+static void sprd_spi_dma_release(struct sprd_spi *ss)
+{
+	if (ss->dma.dma_chan[SPI_RX])
+		dma_release_channel(ss->dma.dma_chan[SPI_RX]);
+
+	if (ss->dma.dma_chan[SPI_TX])
+		dma_release_channel(ss->dma.dma_chan[SPI_TX]);
+}
+
+static int sprd_spi_dma_txrx_bufs(struct spi_device *sdev,
+				  struct spi_transfer *t)
+{
+	struct sprd_spi *ss = spi_master_get_devdata(sdev->master);
+	u32 trans_len = ss->trans_len;
+	int ret, write_size = 0;
+
+	reinit_completion(&ss->xfer_completion);
+	sprd_spi_irq_enable(ss);
+	if (ss->trans_mode & SPRD_SPI_TX_MODE) {
+		write_size = sprd_spi_dma_tx_config(ss, t);
+		sprd_spi_set_tx_length(ss, trans_len);
+
+		/*
+		 * For our 3 wires mode or dual TX line mode, we need
+		 * to request the controller to transfer.
+		 */
+		if (ss->hw_mode & SPI_3WIRE || ss->hw_mode & SPI_TX_DUAL)
+			sprd_spi_tx_req(ss);
+	} else {
+		sprd_spi_set_rx_length(ss, trans_len);
+
+		/*
+		 * For our 3 wires mode or dual TX line mode, we need
+		 * to request the controller to read.
+		 */
+		if (ss->hw_mode & SPI_3WIRE || ss->hw_mode & SPI_TX_DUAL)
+			sprd_spi_rx_req(ss);
+		else
+			write_size = ss->write_bufs(ss, trans_len);
+	}
+
+	if (write_size < 0) {
+		ret = write_size;
+		dev_err(ss->dev, "failed to write, ret = %d\n", ret);
+		goto trans_complete;
+	}
+
+	if (ss->trans_mode & SPRD_SPI_RX_MODE) {
+		/*
+		 * Set up the DMA receive data length, which must be an
+		 * integral multiple of fragment length. But when the length
+		 * of received data is less than fragment length, DMA can be
+		 * configured to receive data according to the actual length
+		 * of received data.
+		 */
+		ss->dma.rx_len = t->len > ss->dma.fragmens_len ?
+			(t->len - t->len % ss->dma.fragmens_len) :
+			 t->len;
+		ret = sprd_spi_dma_rx_config(ss, t);
+		if (ret < 0) {
+			dev_err(&sdev->dev,
+				"failed to configure rx DMA, ret = %d\n", ret);
+			goto trans_complete;
+		}
+	}
+
+	sprd_spi_dma_enable(ss, true);
+	wait_for_completion(&(ss->xfer_completion));
+
+	if (ss->trans_mode & SPRD_SPI_TX_MODE)
+		ret = write_size;
+	else
+		ret = ss->dma.rx_len;
+
+trans_complete:
+	sprd_spi_dma_enable(ss, false);
+	sprd_spi_enter_idle(ss);
+	sprd_spi_irq_disable(ss);
+
+	return ret;
+}
+
 static void sprd_spi_set_speed(struct sprd_spi *ss, u32 speed_hz)
 {
 	/*
@@ -518,16 +741,22 @@ static int sprd_spi_setup_transfer(struct spi_device *sdev,
 		ss->trans_len = t->len;
 		ss->read_bufs = sprd_spi_read_bufs_u8;
 		ss->write_bufs = sprd_spi_write_bufs_u8;
+		ss->dma.width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+		ss->dma.fragmens_len = SPRD_SPI_DMA_STEP;
 		break;
 	case 16:
 		ss->trans_len = t->len >> 1;
 		ss->read_bufs = sprd_spi_read_bufs_u16;
 		ss->write_bufs = sprd_spi_write_bufs_u16;
+		ss->dma.width = DMA_SLAVE_BUSWIDTH_2_BYTES;
+		ss->dma.fragmens_len = SPRD_SPI_DMA_STEP << 1;
 		break;
 	case 32:
 		ss->trans_len = t->len >> 2;
 		ss->read_bufs = sprd_spi_read_bufs_u32;
 		ss->write_bufs = sprd_spi_write_bufs_u32;
+		ss->dma.width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+		ss->dma.fragmens_len = SPRD_SPI_DMA_STEP << 2;
 		break;
 	default:
 		return -EINVAL;
@@ -565,7 +794,11 @@ static int sprd_spi_transfer_one(struct spi_controller *sctlr,
 	if (ret)
 		goto setup_err;
 
-	ret = sprd_spi_txrx_bufs(sdev, t);
+	if (sctlr->can_dma(sctlr, sdev, t))
+		ret = sprd_spi_dma_txrx_bufs(sdev, t);
+	else
+		ret = sprd_spi_txrx_bufs(sdev, t);
+
 	if (ret == t->len)
 		ret = 0;
 	else if (ret >= 0)
@@ -592,6 +825,11 @@ static irqreturn_t sprd_spi_handle_irq(int irq, void *data)
 
 	if (val & SPRD_SPI_MASK_RX_END) {
 		writel_relaxed(SPRD_SPI_RX_END_CLR, ss->base + SPRD_SPI_INT_CLR);
+		if (ss->dma.rx_len < ss->len) {
+			ss->rx_buf += ss->dma.rx_len;
+			ss->dma.rx_len +=
+				ss->read_bufs(ss, ss->len - ss->dma.rx_len);
+		}
 		complete(&ss->xfer_completion);
 
 		return IRQ_HANDLED;
@@ -649,6 +887,35 @@ static int sprd_spi_clk_init(struct platform_device *pdev, struct sprd_spi *ss)
 	return 0;
 }
 
+static bool sprd_spi_can_dma(struct spi_controller *sctlr,
+			     struct spi_device *spi, struct spi_transfer *t)
+{
+	struct sprd_spi *ss = spi_controller_get_devdata(sctlr);
+
+	return ss->dma.enable && (t->len > SPRD_SPI_FIFO_SIZE);
+}
+
+static int sprd_spi_dma_init(struct platform_device *pdev, struct sprd_spi *ss)
+{
+	int ret;
+
+	ret = sprd_spi_dma_request(ss);
+	if (ret) {
+		if (ret == -EPROBE_DEFER)
+			return ret;
+
+		dev_warn(&pdev->dev,
+			 "failed to request dma, enter no dma mode, ret = %d\n",
+			 ret);
+
+		return 0;
+	}
+
+	ss->dma.enable = true;
+
+	return 0;
+}
+
 static int sprd_spi_probe(struct platform_device *pdev)
 {
 	struct spi_controller *sctlr;
@@ -669,12 +936,14 @@ static int sprd_spi_probe(struct platform_device *pdev)
 		goto free_controller;
 	}
 
+	ss->phy_base = res->start;
 	ss->dev = &pdev->dev;
 	sctlr->dev.of_node = pdev->dev.of_node;
 	sctlr->mode_bits = SPI_CPOL | SPI_CPHA | SPI_3WIRE | SPI_TX_DUAL;
 	sctlr->bus_num = pdev->id;
 	sctlr->set_cs = sprd_spi_chipselect;
 	sctlr->transfer_one = sprd_spi_transfer_one;
+	sctlr->can_dma = sprd_spi_can_dma;
 	sctlr->auto_runtime_pm = true;
 	sctlr->max_speed_hz = min_t(u32, ss->src_clk >> 1,
 				    SPRD_SPI_MAX_SPEED_HZ);
@@ -689,10 +958,14 @@ static int sprd_spi_probe(struct platform_device *pdev)
 	if (ret)
 		goto free_controller;
 
-	ret = clk_prepare_enable(ss->clk);
+	ret = sprd_spi_dma_init(pdev, ss);
 	if (ret)
 		goto free_controller;
 
+	ret = clk_prepare_enable(ss->clk);
+	if (ret)
+		goto release_dma;
+
 	ret = pm_runtime_set_active(&pdev->dev);
 	if (ret < 0)
 		goto disable_clk;
@@ -721,6 +994,8 @@ static int sprd_spi_probe(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 disable_clk:
 	clk_disable_unprepare(ss->clk);
+release_dma:
+	sprd_spi_dma_release(ss);
 free_controller:
 	spi_controller_put(sctlr);
 
@@ -741,6 +1016,8 @@ static int sprd_spi_remove(struct platform_device *pdev)
 
 	spi_controller_suspend(sctlr);
 
+	if (ss->dma.enable)
+		sprd_spi_dma_release(ss);
 	clk_disable_unprepare(ss->clk);
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
@@ -753,6 +1030,9 @@ static int __maybe_unused sprd_spi_runtime_suspend(struct device *dev)
 	struct spi_controller *sctlr = dev_get_drvdata(dev);
 	struct sprd_spi *ss = spi_controller_get_devdata(sctlr);
 
+	if (ss->dma.enable)
+		sprd_spi_dma_release(ss);
+
 	clk_disable_unprepare(ss->clk);
 
 	return 0;
@@ -768,7 +1048,14 @@ static int __maybe_unused sprd_spi_runtime_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	return 0;
+	if (!ss->dma.enable)
+		return 0;
+
+	ret = sprd_spi_dma_request(ss);
+	if (ret)
+		clk_disable_unprepare(ss->clk);
+
+	return ret;
 }
 
 static const struct dev_pm_ops sprd_spi_pm_ops = {
-- 
1.7.9.5

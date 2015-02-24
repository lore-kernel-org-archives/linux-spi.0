From: Stanimir Varbanov <stanimir.varbanov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v2] spi: qup: Add DMA capabilities
Date: Tue, 24 Feb 2015 15:00:03 +0200
Message-ID: <1424782803-13103-1-git-send-email-stanimir.varbanov@linaro.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Andy Gross <agross-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Sagar Dharia <sdharia-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Daniel Sneddon <dsneddon-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Stanimir Varbanov <stanimir.varbanov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Andy Gross <agross-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>

This patch adds DMA capabilities to the spi-qup driver.  If DMA channels are
present, the QUP will use DMA instead of block mode for transfers to/from SPI
peripherals for transactions larger than the length of a block.

Signed-off-by: Andy Gross <agross-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Signed-off-by: Stanimir Varbanov <stanimir.varbanov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---

This is reworked version with comments addressed
 - use SPI core DMA mapping code
 - implemented .can_dma callback
 - use dmaengine api's to account deferred_probe

First version can be found at [1].

[1] https://lkml.org/lkml/2014/6/26/481

regards,
Stan

 .../devicetree/bindings/spi/qcom,spi-qup.txt       |    8 +
 drivers/spi/spi-qup.c                              |  300 +++++++++++++++++++-
 2 files changed, 293 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-qup.txt b/Documentation/devicetree/bindings/spi/qcom,spi-qup.txt
index e2c88df..a0357c7 100644
--- a/Documentation/devicetree/bindings/spi/qcom,spi-qup.txt
+++ b/Documentation/devicetree/bindings/spi/qcom,spi-qup.txt
@@ -33,6 +33,11 @@ Optional properties:
 		nodes.  If unspecified, a single SPI device without a chip
 		select can be used.
 
+- dmas:         Two DMA channel specifiers following the convention outlined
+                in bindings/dma/dma.txt
+- dma-names:    Names for the dma channels, if present. There must be at
+                least one channel named "tx" for transmit and named "rx" for
+                receive.
 
 SPI slave nodes must be children of the SPI master node and can contain
 properties described in Documentation/devicetree/bindings/spi/spi-bus.txt
@@ -51,6 +56,9 @@ Example:
 		clocks = <&gcc GCC_BLSP2_QUP2_SPI_APPS_CLK>, <&gcc GCC_BLSP2_AHB_CLK>;
 		clock-names = "core", "iface";
 
+		dmas = <&blsp1_bam 13>, <&blsp2_bam 12>;
+		dma-names = "rx", "tx";
+
 		pinctrl-names = "default";
 		pinctrl-0 = <&spi8_default>;
 
diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index e7fb5a0..386ae69 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -22,6 +22,8 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/spi/spi.h>
+#include <linux/dmaengine.h>
+#include <linux/dma-mapping.h>
 
 #define QUP_CONFIG			0x0000
 #define QUP_STATE			0x0004
@@ -116,6 +118,8 @@
 
 #define SPI_NUM_CHIPSELECTS		4
 
+#define SPI_MAX_DMA_XFER		(SZ_64K - 64)
+
 /* high speed mode is when bus rate is greater then 26MHz */
 #define SPI_HS_MIN_RATE			26000000
 #define SPI_MAX_RATE			50000000
@@ -143,6 +147,11 @@ struct spi_qup {
 	int			tx_bytes;
 	int			rx_bytes;
 	int			qup_v1;
+
+	int			dma_available;
+	struct dma_slave_config	rx_conf;
+	struct dma_slave_config	tx_conf;
+	atomic_t		dma_outstanding;
 };
 
 
@@ -198,6 +207,16 @@ static int spi_qup_set_state(struct spi_qup *controller, u32 state)
 	return 0;
 }
 
+static int spi_qup_get_word_sz(struct spi_transfer *xfer)
+{
+	if (xfer->bits_per_word <= 8)
+		return 1;
+
+	if (xfer->bits_per_word <= 16)
+		return 2;
+
+	return 4;
+}
 
 static void spi_qup_fifo_read(struct spi_qup *controller,
 			    struct spi_transfer *xfer)
@@ -266,6 +285,101 @@ static void spi_qup_fifo_write(struct spi_qup *controller,
 	}
 }
 
+static void spi_qup_dma_done(void *data)
+{
+	struct spi_qup *qup = data;
+
+	if (atomic_dec_and_test(&qup->dma_outstanding))
+		complete(&qup->done);
+}
+
+static int spi_qup_prep_sg(struct spi_master *master, struct spi_transfer *xfer,
+			   enum dma_transfer_direction dir)
+{
+	struct spi_qup *qup = spi_master_get_devdata(master);
+	unsigned long flags = DMA_PREP_INTERRUPT | DMA_PREP_FENCE;
+	struct dma_async_tx_descriptor *desc;
+	struct scatterlist *sgl;
+	dma_cookie_t cookie;
+	unsigned int nents;
+	struct dma_chan *chan;
+	int ret;
+
+	if (dir == DMA_MEM_TO_DEV) {
+		chan = master->dma_tx;
+		nents = xfer->tx_sg.nents;
+		sgl = xfer->tx_sg.sgl;
+	} else {
+		chan = master->dma_rx;
+		nents = xfer->rx_sg.nents;
+		sgl = xfer->rx_sg.sgl;
+	}
+
+	desc = dmaengine_prep_slave_sg(chan, sgl, nents, dir, flags);
+	if (!desc)
+		return -EINVAL;
+
+	desc->callback = spi_qup_dma_done;
+	desc->callback_param = qup;
+
+	cookie = dmaengine_submit(desc);
+	ret = dma_submit_error(cookie);
+	if (ret)
+		return ret;
+
+	atomic_inc(&qup->dma_outstanding);
+
+	return 0;
+}
+
+static int spi_qup_do_dma(struct spi_master *master, struct spi_transfer *xfer)
+{
+	struct spi_qup *qup = spi_master_get_devdata(master);
+	int ret;
+
+	atomic_set(&qup->dma_outstanding, 0);
+
+	reinit_completion(&qup->done);
+
+	if (xfer->rx_buf) {
+		ret = spi_qup_prep_sg(master, xfer, DMA_DEV_TO_MEM);
+		if (ret)
+			return ret;
+
+		dma_async_issue_pending(master->dma_rx);
+	}
+
+	if (xfer->tx_buf) {
+		ret = spi_qup_prep_sg(master, xfer, DMA_MEM_TO_DEV);
+		if (ret)
+			goto err_rx;
+
+		dma_async_issue_pending(master->dma_tx);
+	}
+
+	ret = spi_qup_set_state(qup, QUP_STATE_RUN);
+	if (ret) {
+		dev_warn(qup->dev, "cannot set RUN state\n");
+		goto err_tx;
+	}
+
+	if (!wait_for_completion_timeout(&qup->done, msecs_to_jiffies(1000))) {
+		ret = -ETIMEDOUT;
+		goto err_tx;
+	}
+
+	return 0;
+
+err_tx:
+	if (xfer->tx_buf)
+		dmaengine_terminate_all(master->dma_tx);
+err_rx:
+	if (xfer->rx_buf)
+		dmaengine_terminate_all(master->dma_rx);
+
+	return ret;
+}
+
 static irqreturn_t spi_qup_qup_irq(int irq, void *dev_id)
 {
 	struct spi_qup *controller = dev_id;
@@ -315,11 +429,13 @@ static irqreturn_t spi_qup_qup_irq(int irq, void *dev_id)
 		error = -EIO;
 	}
 
-	if (opflags & QUP_OP_IN_SERVICE_FLAG)
-		spi_qup_fifo_read(controller, xfer);
+	if (!controller->dma_available) {
+		if (opflags & QUP_OP_IN_SERVICE_FLAG)
+			spi_qup_fifo_read(controller, xfer);
 
-	if (opflags & QUP_OP_OUT_SERVICE_FLAG)
-		spi_qup_fifo_write(controller, xfer);
+		if (opflags & QUP_OP_OUT_SERVICE_FLAG)
+			spi_qup_fifo_write(controller, xfer);
+	}
 
 	spin_lock_irqsave(&controller->lock, flags);
 	controller->error = error;
@@ -358,12 +474,7 @@ static int spi_qup_io_config(struct spi_device *spi, struct spi_transfer *xfer)
 		return -EIO;
 	}
 
-	w_size = 4;
-	if (xfer->bits_per_word <= 8)
-		w_size = 1;
-	else if (xfer->bits_per_word <= 16)
-		w_size = 2;
-
+	w_size = spi_qup_get_word_sz(xfer);
 	n_words = xfer->len / w_size;
 	controller->w_size = w_size;
 
@@ -374,19 +485,46 @@ static int spi_qup_io_config(struct spi_device *spi, struct spi_transfer *xfer)
 		/* must be zero for FIFO */
 		writel_relaxed(0, controller->base + QUP_MX_INPUT_CNT);
 		writel_relaxed(0, controller->base + QUP_MX_OUTPUT_CNT);
-	} else {
+	} else if (!controller->dma_available) {
 		mode = QUP_IO_M_MODE_BLOCK;
 		writel_relaxed(n_words, controller->base + QUP_MX_INPUT_CNT);
 		writel_relaxed(n_words, controller->base + QUP_MX_OUTPUT_CNT);
 		/* must be zero for BLOCK and BAM */
 		writel_relaxed(0, controller->base + QUP_MX_READ_CNT);
 		writel_relaxed(0, controller->base + QUP_MX_WRITE_CNT);
+	} else {
+		mode = QUP_IO_M_MODE_BAM;
+		writel_relaxed(0, controller->base + QUP_MX_READ_CNT);
+		writel_relaxed(0, controller->base + QUP_MX_WRITE_CNT);
+
+		if (!controller->qup_v1) {
+			void __iomem *input_cnt;
+
+			input_cnt = controller->base + QUP_MX_INPUT_CNT;
+			/*
+			 * for DMA transfers, both QUP_MX_INPUT_CNT and
+			 * QUP_MX_OUTPUT_CNT must be zero to all cases but one.
+			 * That case is a non-balanced transfer when there is
+			 * only a rx_buf.
+			 */
+			if (xfer->tx_buf)
+				writel_relaxed(0, input_cnt);
+			else
+				writel_relaxed(n_words, input_cnt);
+
+			writel_relaxed(0, controller->base + QUP_MX_OUTPUT_CNT);
+		}
 	}
 
 	iomode = readl_relaxed(controller->base + QUP_IO_M_MODES);
 	/* Set input and output transfer mode */
 	iomode &= ~(QUP_IO_M_INPUT_MODE_MASK | QUP_IO_M_OUTPUT_MODE_MASK);
-	iomode &= ~(QUP_IO_M_PACK_EN | QUP_IO_M_UNPACK_EN);
+
+	if (!controller->dma_available)
+		iomode &= ~(QUP_IO_M_PACK_EN | QUP_IO_M_UNPACK_EN);
+	else
+		iomode |= QUP_IO_M_PACK_EN | QUP_IO_M_UNPACK_EN;
+
 	iomode |= (mode << QUP_IO_M_OUTPUT_MODE_MASK_SHIFT);
 	iomode |= (mode << QUP_IO_M_INPUT_MODE_MASK_SHIFT);
 
@@ -419,11 +557,31 @@ static int spi_qup_io_config(struct spi_device *spi, struct spi_transfer *xfer)
 	config &= ~(QUP_CONFIG_NO_INPUT | QUP_CONFIG_NO_OUTPUT | QUP_CONFIG_N);
 	config |= xfer->bits_per_word - 1;
 	config |= QUP_CONFIG_SPI_MODE;
+
+	if (controller->dma_available) {
+		if (!xfer->tx_buf)
+			config |= QUP_CONFIG_NO_OUTPUT;
+		if (!xfer->rx_buf)
+			config |= QUP_CONFIG_NO_INPUT;
+	}
+
 	writel_relaxed(config, controller->base + QUP_CONFIG);
 
 	/* only write to OPERATIONAL_MASK when register is present */
-	if (!controller->qup_v1)
-		writel_relaxed(0, controller->base + QUP_OPERATIONAL_MASK);
+	if (!controller->qup_v1) {
+		u32 mask = 0;
+
+		/*
+		 * mask INPUT and OUTPUT service flags to prevent IRQs on FIFO
+		 * status change in BAM mode
+		 */
+
+		if (mode == QUP_IO_M_MODE_BAM)
+			mask = QUP_OP_IN_SERVICE_FLAG | QUP_OP_OUT_SERVICE_FLAG;
+
+		writel_relaxed(mask, controller->base + QUP_OPERATIONAL_MASK);
+	}
+
 	return 0;
 }
 
@@ -452,6 +610,11 @@ static int spi_qup_transfer_one(struct spi_master *master,
 	controller->tx_bytes = 0;
 	spin_unlock_irqrestore(&controller->lock, flags);
 
+	if (controller->dma_available) {
+		ret = spi_qup_do_dma(master, xfer);
+		goto exit;
+	}
+
 	if (spi_qup_set_state(controller, QUP_STATE_RUN)) {
 		dev_warn(controller->dev, "cannot set RUN state\n");
 		goto exit;
@@ -471,6 +634,7 @@ static int spi_qup_transfer_one(struct spi_master *master,
 
 	if (!wait_for_completion_timeout(&controller->done, timeout))
 		ret = -ETIMEDOUT;
+
 exit:
 	spi_qup_set_state(controller, QUP_STATE_RESET);
 	spin_lock_irqsave(&controller->lock, flags);
@@ -478,6 +642,100 @@ exit:
 	if (!ret)
 		ret = controller->error;
 	spin_unlock_irqrestore(&controller->lock, flags);
+
+	return ret;
+}
+
+static bool spi_qup_can_dma(struct spi_master *master, struct spi_device *spi,
+			    struct spi_transfer *xfer)
+{
+	struct spi_qup *qup = spi_master_get_devdata(master);
+	size_t dma_align = dma_get_cache_alignment();
+	int n_words, w_size;
+
+	qup->dma_available = 0;
+
+	if (xfer->rx_buf && xfer->len % qup->in_blk_sz)
+		return false;
+
+	if (xfer->tx_buf && xfer->len % qup->out_blk_sz)
+		return false;
+
+	if (IS_ERR_OR_NULL(master->dma_rx) || IS_ERR_OR_NULL(master->dma_tx))
+		return false;
+
+	if (!IS_ALIGNED((size_t)xfer->tx_buf, dma_align) ||
+	    !IS_ALIGNED((size_t)xfer->rx_buf, dma_align))
+		return false;
+
+	w_size = spi_qup_get_word_sz(xfer);
+	n_words = xfer->len / w_size;
+
+	/* will use fifo mode */
+	if (n_words <= (qup->in_fifo_sz / sizeof(u32)))
+		return false;
+
+	qup->dma_available = 1;
+
+	return true;
+}
+
+static void spi_qup_release_dma(struct spi_master *master)
+{
+	if (!IS_ERR_OR_NULL(master->dma_rx))
+		dma_release_channel(master->dma_rx);
+	if (!IS_ERR_OR_NULL(master->dma_tx))
+		dma_release_channel(master->dma_tx);
+}
+
+static int spi_qup_init_dma(struct spi_master *master, resource_size_t base)
+{
+	struct spi_qup *spi = spi_master_get_devdata(master);
+	struct dma_slave_config *rx_conf = &spi->rx_conf,
+				*tx_conf = &spi->tx_conf;
+	struct device *dev = spi->dev;
+	int ret;
+
+	/* allocate dma resources, if available */
+	master->dma_rx = dma_request_slave_channel_reason(dev, "rx");
+	if (IS_ERR(master->dma_rx))
+		return PTR_ERR(master->dma_rx);
+
+	master->dma_tx = dma_request_slave_channel_reason(dev, "tx");
+	if (IS_ERR(master->dma_tx)) {
+		ret = PTR_ERR(master->dma_tx);
+		goto err_tx;
+	}
+
+	/* set DMA parameters */
+	rx_conf->direction = DMA_DEV_TO_MEM;
+	rx_conf->device_fc = 1;
+	rx_conf->src_addr = base + QUP_INPUT_FIFO;
+	rx_conf->src_maxburst = spi->in_blk_sz;
+
+	tx_conf->direction = DMA_MEM_TO_DEV;
+	tx_conf->device_fc = 1;
+	tx_conf->dst_addr = base + QUP_OUTPUT_FIFO;
+	tx_conf->dst_maxburst = spi->out_blk_sz;
+
+	ret = dmaengine_slave_config(master->dma_rx, rx_conf);
+	if (ret) {
+		dev_err(dev, "failed to configure RX channel\n");
+		goto err;
+	}
+
+	ret = dmaengine_slave_config(master->dma_tx, tx_conf);
+	if (ret) {
+		dev_err(dev, "failed to configure TX channel\n");
+		goto err;
+	}
+
+	return 0;
+
+err:
+	dma_release_channel(master->dma_tx);
+err_tx:
+	dma_release_channel(master->dma_rx);
 	return ret;
 }
 
@@ -553,6 +811,8 @@ static int spi_qup_probe(struct platform_device *pdev)
 	master->transfer_one = spi_qup_transfer_one;
 	master->dev.of_node = pdev->dev.of_node;
 	master->auto_runtime_pm = true;
+	master->dma_alignment = dma_get_cache_alignment();
+	master->max_dma_len = SPI_MAX_DMA_XFER;
 
 	platform_set_drvdata(pdev, master);
 
@@ -621,10 +881,16 @@ static int spi_qup_probe(struct platform_device *pdev)
 	writel_relaxed(0, base + SPI_CONFIG);
 	writel_relaxed(SPI_IO_C_NO_TRI_STATE, base + SPI_IO_CONTROL);
 
+	ret = spi_qup_init_dma(master, res->start);
+	if (ret == -EPROBE_DEFER)
+		goto error;
+	else if (!ret)
+		master->can_dma = spi_qup_can_dma;
+
 	ret = devm_request_irq(dev, irq, spi_qup_qup_irq,
 			       IRQF_TRIGGER_HIGH, pdev->name, controller);
 	if (ret)
-		goto error;
+		goto error_dma;
 
 	pm_runtime_set_autosuspend_delay(dev, MSEC_PER_SEC);
 	pm_runtime_use_autosuspend(dev);
@@ -639,6 +905,8 @@ static int spi_qup_probe(struct platform_device *pdev)
 
 disable_pm:
 	pm_runtime_disable(&pdev->dev);
+error_dma:
+	spi_qup_release_dma(master);
 error:
 	clk_disable_unprepare(cclk);
 	clk_disable_unprepare(iclk);
@@ -730,6 +998,8 @@ static int spi_qup_remove(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	spi_qup_release_dma(master);
+
 	clk_disable_unprepare(controller->cclk);
 	clk_disable_unprepare(controller->iclk);
 
-- 
1.7.0.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

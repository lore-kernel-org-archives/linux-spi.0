From: Stanimir Varbanov <stanimir.varbanov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v4] spi: qup: Add DMA capabilities
Date: Wed,  4 Mar 2015 12:02:05 +0200
Message-ID: <1425463325-25805-1-git-send-email-stanimir.varbanov@linaro.org>
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

v3 -> v4
 - correct error path when setting to reset state fails

Third version can be found at https://lkml.org/lkml/2015/2/27/369
v2 -> v3
 - now using one dma done callback on rx channel if bidirectional transfer
   and on tx channel if only transmit transfer
 - rearranged the spi_qup_transfer_one() in order to reuse wait for
   completion and completion init code
 - move dma init function early in .probe to avoid controller reset if
   probe deffer
 - add function to get controller mode
   
Second version can be found at https://lkml.org/lkml/2015/2/24/316

--------------------------------------------------------------------------------
v1 -> v2
This is reworked version with comments addressed
 - use SPI core DMA mapping code
 - implemented .can_dma callback
 - use dmaengine api's to account deferred_probe

First version can be found at https://lkml.org/lkml/2014/6/26/481

regards,
Stan

 .../devicetree/bindings/spi/qcom,spi-qup.txt       |    8 +
 drivers/spi/spi-qup.c                              |  336 ++++++++++++++++++--
 2 files changed, 312 insertions(+), 32 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-qup.txt b/Documentation/devicetree/bindings/spi/qcom,spi-qup.txt
index e2c88df..5c09077 100644
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
 
+		dmas = <&blsp1_bam 13>, <&blsp1_bam 12>;
+		dma-names = "rx", "tx";
+
 		pinctrl-names = "default";
 		pinctrl-0 = <&spi8_default>;
 
diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index ff9cdbd..4b5fc4d 100644
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
@@ -140,9 +144,14 @@ struct spi_qup {
 	struct completion	done;
 	int			error;
 	int			w_size;	/* bytes per SPI word */
+	int			n_words;
 	int			tx_bytes;
 	int			rx_bytes;
 	int			qup_v1;
+
+	int			use_dma;
+	struct dma_slave_config	rx_conf;
+	struct dma_slave_config	tx_conf;
 };
 
 
@@ -198,7 +207,6 @@ static int spi_qup_set_state(struct spi_qup *controller, u32 state)
 	return 0;
 }
 
-
 static void spi_qup_fifo_read(struct spi_qup *controller,
 			    struct spi_transfer *xfer)
 {
@@ -266,6 +274,107 @@ static void spi_qup_fifo_write(struct spi_qup *controller,
 	}
 }
 
+static void spi_qup_dma_done(void *data)
+{
+	struct spi_qup *qup = data;
+
+	complete(&qup->done);
+}
+
+static int spi_qup_prep_sg(struct spi_master *master, struct spi_transfer *xfer,
+			   enum dma_transfer_direction dir,
+			   dma_async_tx_callback callback)
+{
+	struct spi_qup *qup = spi_master_get_devdata(master);
+	unsigned long flags = DMA_PREP_INTERRUPT | DMA_PREP_FENCE;
+	struct dma_async_tx_descriptor *desc;
+	struct scatterlist *sgl;
+	struct dma_chan *chan;
+	dma_cookie_t cookie;
+	unsigned int nents;
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
+	desc->callback = callback;
+	desc->callback_param = qup;
+
+	cookie = dmaengine_submit(desc);
+
+	return dma_submit_error(cookie);
+}
+
+static void spi_qup_dma_terminate(struct spi_master *master,
+				  struct spi_transfer *xfer)
+{
+	if (xfer->tx_buf)
+		dmaengine_terminate_all(master->dma_tx);
+	if (xfer->rx_buf)
+		dmaengine_terminate_all(master->dma_rx);
+}
+
+static int spi_qup_do_dma(struct spi_master *master, struct spi_transfer *xfer)
+{
+	dma_async_tx_callback rx_done = NULL, tx_done = NULL;
+	int ret;
+
+	if (xfer->rx_buf)
+		rx_done = spi_qup_dma_done;
+	else if (xfer->tx_buf)
+		tx_done = spi_qup_dma_done;
+
+	if (xfer->rx_buf) {
+		ret = spi_qup_prep_sg(master, xfer, DMA_DEV_TO_MEM, rx_done);
+		if (ret)
+			return ret;
+
+		dma_async_issue_pending(master->dma_rx);
+	}
+
+	if (xfer->tx_buf) {
+		ret = spi_qup_prep_sg(master, xfer, DMA_MEM_TO_DEV, tx_done);
+		if (ret)
+			return ret;
+
+		dma_async_issue_pending(master->dma_tx);
+	}
+
+	return 0;
+}
+
+static int spi_qup_do_pio(struct spi_master *master, struct spi_transfer *xfer)
+{
+	struct spi_qup *qup = spi_master_get_devdata(master);
+	int ret;
+
+	ret = spi_qup_set_state(qup, QUP_STATE_RUN);
+	if (ret) {
+		dev_warn(qup->dev, "cannot set RUN state\n");
+		return ret;
+	}
+
+	ret = spi_qup_set_state(qup, QUP_STATE_PAUSE);
+	if (ret) {
+		dev_warn(qup->dev, "cannot set PAUSE state\n");
+		return ret;
+	}
+
+	spi_qup_fifo_write(qup, xfer);
+
+	return 0;
+}
+
 static irqreturn_t spi_qup_qup_irq(int irq, void *dev_id)
 {
 	struct spi_qup *controller = dev_id;
@@ -315,11 +424,13 @@ static irqreturn_t spi_qup_qup_irq(int irq, void *dev_id)
 		error = -EIO;
 	}
 
-	if (opflags & QUP_OP_IN_SERVICE_FLAG)
-		spi_qup_fifo_read(controller, xfer);
+	if (!controller->use_dma) {
+		if (opflags & QUP_OP_IN_SERVICE_FLAG)
+			spi_qup_fifo_read(controller, xfer);
 
-	if (opflags & QUP_OP_OUT_SERVICE_FLAG)
-		spi_qup_fifo_write(controller, xfer);
+		if (opflags & QUP_OP_OUT_SERVICE_FLAG)
+			spi_qup_fifo_write(controller, xfer);
+	}
 
 	spin_lock_irqsave(&controller->lock, flags);
 	controller->error = error;
@@ -332,13 +443,35 @@ static irqreturn_t spi_qup_qup_irq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static u32
+spi_qup_get_mode(struct spi_master *master, struct spi_transfer *xfer)
+{
+	struct spi_qup *qup = spi_master_get_devdata(master);
+	u32 mode;
+
+	qup->w_size = 4;
+
+	if (xfer->bits_per_word <= 8)
+		qup->w_size = 1;
+	else if (xfer->bits_per_word <= 16)
+		qup->w_size = 2;
+
+	qup->n_words = xfer->len / qup->w_size;
+
+	if (qup->n_words <= (qup->in_fifo_sz / sizeof(u32)))
+		mode = QUP_IO_M_MODE_FIFO;
+	else
+		mode = QUP_IO_M_MODE_BLOCK;
+
+	return mode;
+}
 
 /* set clock freq ... bits per word */
 static int spi_qup_io_config(struct spi_device *spi, struct spi_transfer *xfer)
 {
 	struct spi_qup *controller = spi_master_get_devdata(spi->master);
 	u32 config, iomode, mode, control;
-	int ret, n_words, w_size;
+	int ret, n_words;
 
 	if (spi->mode & SPI_LOOP && xfer->len > controller->in_fifo_sz) {
 		dev_err(controller->dev, "too big size for loopback %d > %d\n",
@@ -358,35 +491,54 @@ static int spi_qup_io_config(struct spi_device *spi, struct spi_transfer *xfer)
 		return -EIO;
 	}
 
-	w_size = 4;
-	if (xfer->bits_per_word <= 8)
-		w_size = 1;
-	else if (xfer->bits_per_word <= 16)
-		w_size = 2;
-
-	n_words = xfer->len / w_size;
-	controller->w_size = w_size;
+	mode = spi_qup_get_mode(spi->master, xfer);
+	n_words = controller->n_words;
 
-	if (n_words <= (controller->in_fifo_sz / sizeof(u32))) {
-		mode = QUP_IO_M_MODE_FIFO;
+	if (mode == QUP_IO_M_MODE_FIFO) {
 		writel_relaxed(n_words, controller->base + QUP_MX_READ_CNT);
 		writel_relaxed(n_words, controller->base + QUP_MX_WRITE_CNT);
 		/* must be zero for FIFO */
 		writel_relaxed(0, controller->base + QUP_MX_INPUT_CNT);
 		writel_relaxed(0, controller->base + QUP_MX_OUTPUT_CNT);
-	} else {
-		mode = QUP_IO_M_MODE_BLOCK;
+	} else if (!controller->use_dma) {
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
+	if (!controller->use_dma)
+		iomode &= ~(QUP_IO_M_PACK_EN | QUP_IO_M_UNPACK_EN);
+	else
+		iomode |= QUP_IO_M_PACK_EN | QUP_IO_M_UNPACK_EN;
+
 	iomode |= (mode << QUP_IO_M_OUTPUT_MODE_MASK_SHIFT);
 	iomode |= (mode << QUP_IO_M_INPUT_MODE_MASK_SHIFT);
 
@@ -428,11 +580,31 @@ static int spi_qup_io_config(struct spi_device *spi, struct spi_transfer *xfer)
 	config &= ~(QUP_CONFIG_NO_INPUT | QUP_CONFIG_NO_OUTPUT | QUP_CONFIG_N);
 	config |= xfer->bits_per_word - 1;
 	config |= QUP_CONFIG_SPI_MODE;
+
+	if (controller->use_dma) {
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
 
@@ -461,17 +633,13 @@ static int spi_qup_transfer_one(struct spi_master *master,
 	controller->tx_bytes = 0;
 	spin_unlock_irqrestore(&controller->lock, flags);
 
-	if (spi_qup_set_state(controller, QUP_STATE_RUN)) {
-		dev_warn(controller->dev, "cannot set RUN state\n");
-		goto exit;
-	}
+	if (controller->use_dma)
+		ret = spi_qup_do_dma(master, xfer);
+	else
+		ret = spi_qup_do_pio(master, xfer);
 
-	if (spi_qup_set_state(controller, QUP_STATE_PAUSE)) {
-		dev_warn(controller->dev, "cannot set PAUSE state\n");
+	if (ret)
 		goto exit;
-	}
-
-	spi_qup_fifo_write(controller, xfer);
 
 	if (spi_qup_set_state(controller, QUP_STATE_RUN)) {
 		dev_warn(controller->dev, "cannot set EXECUTE state\n");
@@ -480,6 +648,7 @@ static int spi_qup_transfer_one(struct spi_master *master,
 
 	if (!wait_for_completion_timeout(&controller->done, timeout))
 		ret = -ETIMEDOUT;
+
 exit:
 	spi_qup_set_state(controller, QUP_STATE_RESET);
 	spin_lock_irqsave(&controller->lock, flags);
@@ -487,6 +656,97 @@ exit:
 	if (!ret)
 		ret = controller->error;
 	spin_unlock_irqrestore(&controller->lock, flags);
+
+	if (ret && controller->use_dma)
+		spi_qup_dma_terminate(master, xfer);
+
+	return ret;
+}
+
+static bool spi_qup_can_dma(struct spi_master *master, struct spi_device *spi,
+			    struct spi_transfer *xfer)
+{
+	struct spi_qup *qup = spi_master_get_devdata(master);
+	size_t dma_align = dma_get_cache_alignment();
+	u32 mode;
+
+	qup->use_dma = 0;
+
+	if (xfer->rx_buf && (xfer->len % qup->in_blk_sz ||
+	    IS_ERR_OR_NULL(master->dma_rx) ||
+	    !IS_ALIGNED((size_t)xfer->rx_buf, dma_align)))
+		return false;
+
+	if (xfer->tx_buf && (xfer->len % qup->out_blk_sz ||
+	    IS_ERR_OR_NULL(master->dma_tx) ||
+	    !IS_ALIGNED((size_t)xfer->tx_buf, dma_align)))
+		return false;
+
+	mode = spi_qup_get_mode(master, xfer);
+	if (mode == QUP_IO_M_MODE_FIFO)
+		return false;
+
+	qup->use_dma = 1;
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
 
@@ -562,6 +822,8 @@ static int spi_qup_probe(struct platform_device *pdev)
 	master->transfer_one = spi_qup_transfer_one;
 	master->dev.of_node = pdev->dev.of_node;
 	master->auto_runtime_pm = true;
+	master->dma_alignment = dma_get_cache_alignment();
+	master->max_dma_len = SPI_MAX_DMA_XFER;
 
 	platform_set_drvdata(pdev, master);
 
@@ -573,6 +835,12 @@ static int spi_qup_probe(struct platform_device *pdev)
 	controller->cclk = cclk;
 	controller->irq = irq;
 
+	ret = spi_qup_init_dma(master, res->start);
+	if (ret == -EPROBE_DEFER)
+		goto error;
+	else if (!ret)
+		master->can_dma = spi_qup_can_dma;
+
 	/* set v1 flag if device is version 1 */
 	if (of_device_is_compatible(dev->of_node, "qcom,spi-qup-v1.1.1"))
 		controller->qup_v1 = 1;
@@ -609,7 +877,7 @@ static int spi_qup_probe(struct platform_device *pdev)
 	ret = spi_qup_set_state(controller, QUP_STATE_RESET);
 	if (ret) {
 		dev_err(dev, "cannot set RESET state\n");
-		goto error;
+		goto error_dma;
 	}
 
 	writel_relaxed(0, base + QUP_OPERATIONAL);
@@ -633,7 +901,7 @@ static int spi_qup_probe(struct platform_device *pdev)
 	ret = devm_request_irq(dev, irq, spi_qup_qup_irq,
 			       IRQF_TRIGGER_HIGH, pdev->name, controller);
 	if (ret)
-		goto error;
+		goto error_dma;
 
 	pm_runtime_set_autosuspend_delay(dev, MSEC_PER_SEC);
 	pm_runtime_use_autosuspend(dev);
@@ -648,6 +916,8 @@ static int spi_qup_probe(struct platform_device *pdev)
 
 disable_pm:
 	pm_runtime_disable(&pdev->dev);
+error_dma:
+	spi_qup_release_dma(master);
 error:
 	clk_disable_unprepare(cclk);
 	clk_disable_unprepare(iclk);
@@ -739,6 +1009,8 @@ static int spi_qup_remove(struct platform_device *pdev)
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

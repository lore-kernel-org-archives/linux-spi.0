Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795427128;
	b=xFhb4VDo+50pFEpOeMF74LGBhnxM2Z/wFguqQ/sCPUm5nuS4JJlLONTJzqqr43jsuBWJ
	 mDawKipyTFzVXZn7r5nhCZu5r3y4EDB2f5D2jeOOHjRfOjRm9G1HudSigD1SNs7W7/klt
	 j9nZzOEjVJagc+MR7ZduW6Xf4kai8EaSeicVqp4sl3jjWgfWuFs68qaPjqe3iY2MufsCC
	 Yv454il+fNG0q+iYaAA/APtnoRIVvEVhPVQavfsXMNkkF6ZyYdE/cbwkc03+YHrSjok3b
	 wlQdNnpjqgmxxZhJh19PorKgyn1MWs/bHrjVUUHG8873uiUlkWQ6S17o2G/povHdzPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795427128;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-Coremail-Antispam;
	bh=04LTo/N7kvHWwaH9AByReE0yE4F1QebvQm+fDjH2v8E=;
	b=h3jjgaVIddZWY1yZgyw22qCBOso5ZGn3nbrKDumP8OWAwICx1lm++b92BAHanKZiI6+Z
	 l61kLXMkFFA5PSSd3plcErITT9pJPQjrHcpOfe1xNmhAoX1lf6dL/Gt6YRGdZ8vEWFT3w
	 bRkleqcZ0eNcnwmPqCmm6QdJSMzOqQLzY5O+pbbkmPz2v40ALI/ddigoTdv3ta+SO9xs7
	 yBFD/cvi70NWgTDcozx/3ELyCWhAjvE+P12uZn5a4V1fRi4IbEoZm7CtgQnreFjFkONVd
	 wpfbkedKJdbRDvTc+xZ+NFRkwq2aAHhbRFDwRDPZwCBecs6DppaDZ3LgCCs0N32jW4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D19606A31E;
	Mon, 23 Nov 2026 09:45:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5D19606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.66])
	by gateway (Coremail) with SMTP id _____8BxuLU2CwRrKjEiAA--.4053S3;
	Mon, 23 Nov 2026 17:45:26 +0800 (CST)
Received: from kernelserver (unknown [223.64.69.66])
	by front1 (Coremail) with SMTP id qMiowJCxPs80CwRrgNo2AA--.43474S2;
	Mon, 23 Nov 2026 17:45:25 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yinbo Zhu <zhuyinbo@loongson.cn>,
	Mark Brown <broonie@kernel.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	loongarch@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-spi@vger.kernel.org,
	Bingxiong Li <libingxiong@loongson.cn>,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH 4/5] spi: loongson-io: Add DMA support to SPI-IO driver
Date: Mon, 23 Nov 2026 17:45:16 +0800
Message-ID: <c97601131ad439f6648e5c8d5a624a2588479728.1795425389.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1795425389.git.zhoubinbin@loongson.cn>
References: <cover.1795425389.git.zhoubinbin@loongson.cn>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxPs80CwRrgNo2AA--.43474S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAgEACGsDrv8JcgAAsJ
X-Coremail-Antispam: 1Uk129KBj9fXoW3KFWrWFyxZrWfKFWkAF47Awc_yoW8Cw48Ko
	WfXF95Xw40gw10ga4jqr48trW7XF1rurs8ArZ3Cw1kGa4jya48try2gw47uw1rXF1ayFy3
	Za9agFWxGF4IqF1kl-sFpf9Il3svdjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8wcxFpf
	9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
	UjIYCTnIWjp_UUUY87kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
	8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
	0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280
	aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28Icx
	kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
	xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42
	IY6xIIjxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY
	6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aV
	CY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8l38UUUUUU==

Request optional "tx" and "rx" DMA channels. Their absence is
non-fatal and leaves the driver in interrupt-only mode so probe
does not fail when DMA providers are not yet available.

DMA is enabled for transfers that meet all of: four-byte
alignment, length at or above the runtime-tunable dma_threshold,
and both TX and RX buffers present.

Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/spi/spi-loongson-io.c | 399 +++++++++++++++++++++++++++++++++-
 1 file changed, 388 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-loongson-io.c b/drivers/spi/spi-loongson-io.c
index e273c9f4a943..c153e483ab41 100644
--- a/drivers/spi/spi-loongson-io.c
+++ b/drivers/spi/spi-loongson-io.c
@@ -7,6 +7,8 @@
 #include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/completion.h>
+#include <linux/dmaengine.h>
+#include <linux/dma-mapping.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -14,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
+#include <linux/scatterlist.h>
 #include <linux/string.h>
 
 /* Loongson SPI-IO Controller registers */
@@ -42,11 +45,20 @@
 
 /* Bitfields of LOONGSON_SPI_IO_CR2_REG */
 #define LOONGSON_SPI_IO_CR2_RXFTHLV		GENMASK(1, 0)
+#define LOONGSON_SPI_IO_CR2_RXDMAEN		BIT(7)
 #define LOONGSON_SPI_IO_CR2_TXFTHLV		GENMASK(9, 8)
+#define LOONGSON_SPI_IO_CR2_TXDMAEN		BIT(15)
+
+#define LOONGSON_SPI_IO_CR2_DMAEN_MASK		(LOONGSON_SPI_IO_CR2_RXDMAEN | \
+						 LOONGSON_SPI_IO_CR2_TXDMAEN)
+
+#define LOONGSON_SPI_IO_CR2_MAX_FTHLV		FIELD_MAX(LOONGSON_SPI_IO_CR2_RXFTHLV)
 
 /* Bitfields of LOONGSON_SPI_IO_CR3_REG */
 #define LOONGSON_SPI_IO_CR3_TSIZE		GENMASK(15, 0)
 
+#define LOONGSON_SPI_IO_MAX_FRAMES		(FIELD_MAX(LOONGSON_SPI_IO_CR3_TSIZE) + 1)
+
 /* Bitfields of LOONGSON_SPI_IO_CR4_REG */
 #define LOONGSON_SPI_IO_CR4_CTSIZE		GENMASK(15, 0)
 
@@ -118,10 +130,12 @@
  * enum xfer_mode - Loongson SPI transfer mode
  * @XFER_IDLE: no transfer is in progress
  * @XFER_INTERRUPT: interrupt-driven batch transfer
+ * @XFER_DMA: DMA-driven transfer
  */
 enum xfer_mode {
 	XFER_IDLE,
 	XFER_INTERRUPT,
+	XFER_DMA,
 };
 
 /**
@@ -141,6 +155,10 @@ enum xfer_mode {
  * @xfer_ret: result of the current transfer
  * @batch_size: number of bytes in the current interrupt batch
  * @xfer_completion: completion signaled when the current transfer finishes
+ * @dma_tx: DMA channel for TX
+ * @dma_rx: DMA channel for RX
+ * @use_dma: true if both DMA channels are available
+ * @phys_base: physical base address used for DMA slave configuration
  * @xfer_mode: current transfer mode
  */
 struct loongson_spi_priv {
@@ -160,9 +178,19 @@ struct loongson_spi_priv {
 	int			xfer_ret;
 	u32			batch_size;
 	struct completion	xfer_completion;
+
+	struct dma_chan		*dma_tx;
+	struct dma_chan		*dma_rx;
+	bool			use_dma;
+	phys_addr_t		phys_base;
 	enum xfer_mode		xfer_mode;
 };
 
+/* Module parameter: DMA threshold (bytes), adjustable at runtime */
+static unsigned int dma_threshold = 1024;
+module_param(dma_threshold, uint, 0644);
+MODULE_PARM_DESC(dma_threshold, "Minimum transfer length to use DMA (default 1024)");
+
 static void loongson_spi_writel(struct loongson_spi_priv *priv, u32 reg, u32 data)
 {
 	writel(data, priv->base + reg);
@@ -264,11 +292,59 @@ static unsigned long loongson_spi_io_timeout(struct loongson_spi_priv *priv,
 	return msecs_to_jiffies(max_t(u64, msec * 2, 1000));
 }
 
-static void loongson_spi_io_set_thresh(struct loongson_spi_priv *priv)
+static void loongson_spi_io_set_thresh(struct loongson_spi_priv *priv, bool dma)
 {
+	u32 val = 0;
+
+	if (dma)
+		val = FIELD_PREP(LOONGSON_SPI_IO_CR2_RXFTHLV, LOONGSON_SPI_IO_CR2_MAX_FTHLV) |
+		      FIELD_PREP(LOONGSON_SPI_IO_CR2_TXFTHLV, LOONGSON_SPI_IO_CR2_MAX_FTHLV);
+
 	loongson_spi_update_bits(priv, LOONGSON_SPI_IO_CR2_REG,
 				 LOONGSON_SPI_IO_CR2_RXFTHLV |
-				 LOONGSON_SPI_IO_CR2_TXFTHLV, 0);
+				 LOONGSON_SPI_IO_CR2_TXFTHLV, val);
+}
+
+/**
+ * loongson_spi_io_dma_drain_rx() - Drain RX FIFO residue after DMA
+ * @priv: controller private data
+ * @xfer: completed SPI transfer
+ *
+ * DMA can leave a tail shorter than its request threshold in the RX FIFO.
+ * Both DMA channels must already be quiescent. Synchronize the RX mapping,
+ * append the residue to the receive buffer, then return mapping ownership
+ * to the device. Residue from a dummy RX buffer is discarded by SPI core.
+ */
+static void loongson_spi_io_dma_drain_rx(struct loongson_spi_priv *priv,
+					 struct spi_transfer *xfer)
+{
+	struct device *rx_dev = dmaengine_get_dma_device(priv->dma_rx);
+	u32 rxflv = FIELD_GET(LOONGSON_SPI_IO_SR2_RXFLV,
+			      loongson_spi_readl(priv, LOONGSON_SPI_IO_SR2_REG));
+	u8 frame_bytes = priv->frame_bytes;
+	u8 *dst = NULL;
+	u32 data;
+
+	if (!rxflv)
+		return;
+
+	if (xfer->rx_buf && rxflv <= xfer->len)
+		dst = (u8 *)xfer->rx_buf + xfer->len - rxflv;
+
+	/* SPI core skips cache sync while transfer_one() is running. */
+	dma_sync_sgtable_for_cpu(rx_dev, &xfer->rx_sg, DMA_FROM_DEVICE);
+	loongson_spi_io_set_thresh(priv, false);
+
+	while (rxflv) {
+		data = loongson_spi_io_read_dr(priv);
+		if (dst) {
+			memcpy(dst, &data, frame_bytes);
+			dst += frame_bytes;
+		}
+		rxflv -= frame_bytes;
+	}
+
+	dma_sync_sgtable_for_device(rx_dev, &xfer->rx_sg, DMA_FROM_DEVICE);
 }
 
 /**
@@ -423,6 +499,42 @@ static int loongson_spi_io_setup(struct spi_device *spi)
 	return 0;
 }
 
+/**
+ * loongson_spi_can_dma() - Check whether a transfer can use DMA
+ * @ctrl: SPI controller
+ * @spi: SPI target device
+ * @xfer: SPI transfer to check
+ *
+ * DMA requires both channels, a four-byte-aligned length and a transfer at
+ * least as large as dma_threshold. Three-wire transfers use interrupt mode
+ * because the DMA path requires both TX and RX scatterlists.
+ *
+ * Return: true when DMA is supported for @xfer.
+ */
+static bool loongson_spi_can_dma(struct spi_controller *ctrl, struct spi_device *spi,
+				 struct spi_transfer *xfer)
+{
+	struct loongson_spi_priv *priv = spi_controller_get_devdata(ctrl);
+
+	if (!priv->use_dma)
+		return false;
+
+	/* The DMA path requires both TX and RX scatterlists. */
+	if (spi->mode & SPI_3WIRE)
+		return false;
+
+	if (xfer->len < dma_threshold)
+		return false;
+
+	if (!xfer->tx_buf && !xfer->rx_buf)
+		return false;
+
+	if (xfer->len % 4)
+		return false;
+
+	return true;
+}
+
 /**
  * loongson_spi_io_start_batch() - Start one interrupt-driven FIFO batch
  * @priv: controller private data
@@ -464,14 +576,191 @@ static int loongson_spi_io_start_batch(struct loongson_spi_priv *priv)
 	return batch_size;
 }
 
+/**
+ * loongson_spi_dma_config_and_submit() - Prepare RX and TX slave DMA
+ * @priv: controller private data
+ * @xfer: SPI transfer with scatterlists mapped by SPI core
+ *
+ * Configure both DMA channels for the shared data register and submit RX
+ * before TX. Descriptors remain pending until the caller issues them.
+ *
+ * Return: 0 on success, or a negative error code on configuration,
+ * preparation or submission failure.
+ */
+static int loongson_spi_dma_config_and_submit(struct loongson_spi_priv *priv,
+					      struct spi_transfer *xfer)
+{
+	struct dma_async_tx_descriptor *tx_desc, *rx_desc;
+	struct dma_slave_config tx_cfg = {0}, rx_cfg = {0};
+	struct device *dev = priv->dev;
+	int ret;
+
+	tx_cfg.direction = DMA_MEM_TO_DEV;
+	tx_cfg.dst_addr = priv->phys_base + LOONGSON_SPI_IO_DR_REG;
+	tx_cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	tx_cfg.dst_maxburst = 1;
+
+	ret = dmaengine_slave_config(priv->dma_tx, &tx_cfg);
+	if (ret) {
+		dev_err(dev, "TX DMA config failed: %d", ret);
+		return ret;
+	}
+
+	rx_cfg.direction = DMA_DEV_TO_MEM;
+	rx_cfg.src_addr = priv->phys_base + LOONGSON_SPI_IO_DR_REG;
+	rx_cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	rx_cfg.src_maxburst = 1;
+
+	ret = dmaengine_slave_config(priv->dma_rx, &rx_cfg);
+	if (ret) {
+		dev_err(dev, "RX DMA config failed: %d", ret);
+		return ret;
+	}
+
+	rx_desc = dmaengine_prep_slave_sg(priv->dma_rx, xfer->rx_sg.sgl,
+					  xfer->rx_sg.nents, DMA_DEV_TO_MEM,
+					  DMA_CTRL_ACK);
+	if (!rx_desc) {
+		dev_err(dev, "RX DMA prep_slave_sg failed");
+		return -EINVAL;
+	}
+
+	ret = dma_submit_error(dmaengine_submit(rx_desc));
+	if (ret) {
+		dev_err(dev, "RX DMA submit failed");
+		return ret;
+	}
+
+	tx_desc = dmaengine_prep_slave_sg(priv->dma_tx, xfer->tx_sg.sgl,
+					  xfer->tx_sg.nents, DMA_MEM_TO_DEV,
+					  DMA_CTRL_ACK);
+	if (!tx_desc) {
+		dev_err(dev, "TX DMA prep_slave_sg failed");
+		return -EINVAL;
+	}
+
+	ret = dma_submit_error(dmaengine_submit(tx_desc));
+	if (ret) {
+		dev_err(dev, "TX DMA submit failed");
+		return ret;
+	}
+
+	return 0;
+}
+
+/**
+ * loongson_spi_dma_wait_eot() - Wait for the current DMA chunk to finish
+ * @priv: controller private data
+ * @xfer: SPI transfer used to calculate the timeout
+ *
+ * Return: 0 after EOT, %-ETIMEDOUT if EOT does not arrive, or the error
+ * recorded by the IRQ handler.
+ */
+static int loongson_spi_dma_wait_eot(struct loongson_spi_priv *priv,
+				     struct spi_transfer *xfer)
+{
+	if (!wait_for_completion_timeout(&priv->xfer_completion,
+					 loongson_spi_io_timeout(priv, xfer))) {
+		dev_err(priv->dev, "DMA transfer timeout (no EOT)");
+		return -ETIMEDOUT;
+	}
+
+	return priv->xfer_ret;
+}
+
+/**
+ * loongson_spi_dma_transfer() - Run one DMA-driven SPI transfer
+ * @priv: controller private data
+ * @xfer: SPI transfer with TX and RX scatterlists
+ * @bus_started: set to true once CSTART has been written
+ *
+ * One pair of DMA descriptors covers the complete transfer. The SPI engine
+ * is restarted in chunks of at most %LOONGSON_SPI_IO_MAX_FRAMES because its
+ * transfer-count register is 16 bits wide. RX is issued before TX.
+ *
+ * All exits disable and synchronize both DMA channels. A successful transfer
+ * then drains the RX FIFO residue. @bus_started tells the caller whether a
+ * failure can safely retry the transfer in interrupt mode: once it is true,
+ * retrying would duplicate bus traffic and is therefore not allowed.
+ *
+ * Return: 0 on success, or a negative error code.
+ */
+static int loongson_spi_dma_transfer(struct loongson_spi_priv *priv,
+				     struct spi_transfer *xfer,
+				     bool *bus_started)
+{
+	u32 frames = xfer->len / priv->frame_bytes;
+	u32 done, chunk_frames;
+	int ret;
+
+	*bus_started = false;
+
+	ret = loongson_spi_dma_config_and_submit(priv, xfer);
+	if (ret)
+		goto out_stop;
+
+	priv->xfer_ret = 0;
+	priv->xfer_mode = XFER_DMA;
+
+	loongson_spi_update_bits(priv, LOONGSON_SPI_IO_CR1_REG,
+				 LOONGSON_SPI_IO_CR1_AUTOSUS,
+				 LOONGSON_SPI_IO_CR1_AUTOSUS);
+
+	/* RX must be ready before TX can start filling the controller FIFO. */
+	dma_async_issue_pending(priv->dma_rx);
+	dma_async_issue_pending(priv->dma_tx);
+
+	loongson_spi_update_bits(priv, LOONGSON_SPI_IO_CR2_REG,
+				 LOONGSON_SPI_IO_CR2_DMAEN_MASK,
+				 LOONGSON_SPI_IO_CR2_DMAEN_MASK);
+
+	for (done = 0; done < frames; done += chunk_frames) {
+		chunk_frames = min_t(u32, frames - done,
+				     LOONGSON_SPI_IO_MAX_FRAMES);
+
+		priv->xfer_ret = 0;
+		reinit_completion(&priv->xfer_completion);
+		loongson_spi_writel(priv, LOONGSON_SPI_IO_CR3_REG,
+				    chunk_frames - 1);
+		loongson_spi_writel(priv, LOONGSON_SPI_IO_CR4_REG, 0);
+		loongson_spi_writel(priv, LOONGSON_SPI_IO_SR1_REG,
+				    LOONGSON_SPI_IO_SR1_EOT);
+
+		*bus_started = true;
+		loongson_spi_update_bits(priv, LOONGSON_SPI_IO_CR1_REG,
+					 LOONGSON_SPI_IO_CR1_CSTART,
+					 LOONGSON_SPI_IO_CR1_CSTART);
+
+		ret = loongson_spi_dma_wait_eot(priv, xfer);
+		if (ret)
+			break;
+	}
+
+out_stop:
+	loongson_spi_update_bits(priv, LOONGSON_SPI_IO_CR1_REG,
+				 LOONGSON_SPI_IO_CR1_CSTART, 0);
+	loongson_spi_update_bits(priv, LOONGSON_SPI_IO_CR2_REG,
+				 LOONGSON_SPI_IO_CR2_DMAEN_MASK, 0);
+	priv->xfer_mode = XFER_IDLE;
+
+	/* Quiesce DMA before letting the CPU handle the RX FIFO residue. */
+	dmaengine_terminate_sync(priv->dma_tx);
+	dmaengine_terminate_sync(priv->dma_rx);
+
+	if (!ret && *bus_started)
+		loongson_spi_io_dma_drain_rx(priv, xfer);
+
+	return ret;
+}
+
 /**
  * loongson_spi_io_irq_handler() - Handle SPI error and end-of-transfer IRQs
  * @irq: interrupt number
  * @dev_id: controller private data
  *
  * In interrupt mode, consume the current RX batch and start the next one.
- * Controller errors disable further interrupts and complete the wait with an
- * error status.
+ * In DMA mode, stop the engine and wake the chunk waiter. Controller errors
+ * disable further interrupts and complete the wait with an error status.
  *
  * Return: %IRQ_HANDLED for a recognized error or EOT, otherwise %IRQ_NONE.
  */
@@ -497,6 +786,12 @@ static irqreturn_t loongson_spi_io_irq_handler(int irq, void *dev_id)
 	loongson_spi_writel(priv, LOONGSON_SPI_IO_SR1_REG, LOONGSON_SPI_IO_SR1_EOT);
 
 	switch (priv->xfer_mode) {
+	case XFER_DMA:
+		loongson_spi_update_bits(priv, LOONGSON_SPI_IO_CR1_REG,
+					 LOONGSON_SPI_IO_CR1_CSTART, 0);
+		priv->xfer_ret = 0;
+		complete(&priv->xfer_completion);
+		break;
 	case XFER_INTERRUPT:
 		for (unsigned int i = 0; i < priv->batch_size;
 		     i += priv->frame_bytes) {
@@ -534,8 +829,10 @@ static irqreturn_t loongson_spi_io_irq_handler(int irq, void *dev_id)
  * @spi: SPI target device
  * @xfer: transfer to execute
  *
- * Apply clock, mode and pin-direction state before running interrupt-driven
- * FIFO batches.
+ * Apply clock, mode and pin-direction state before selecting DMA or
+ * interrupt-driven FIFO batches. DMA setup failures may fall back to
+ * interrupt mode only while the bus has not started; runtime DMA failures
+ * are returned to SPI core without replaying the transfer.
  *
  * Return: 0 on success, or a negative error code.
  */
@@ -543,6 +840,8 @@ static int loongson_spi_io_transfer_one(struct spi_controller *ctrl, struct spi_
 					struct spi_transfer *xfer)
 {
 	struct loongson_spi_priv *priv = spi_controller_get_devdata(spi->controller);
+	bool bus_started = false;
+	bool use_dma;
 	int ret;
 
 	loongson_spi_io_update_state(spi, xfer);
@@ -563,7 +862,27 @@ static int loongson_spi_io_transfer_one(struct spi_controller *ctrl, struct spi_
 	loongson_spi_writel(priv, LOONGSON_SPI_IO_SR1_REG,
 			    LOONGSON_SPI_IO_SR1_EOT | LOONGSON_SPI_IO_SR1_ERR_MASK);
 
-	loongson_spi_io_set_thresh(priv);
+	use_dma = ctrl->can_dma && ctrl->can_dma(ctrl, spi, xfer);
+	loongson_spi_io_set_thresh(priv, use_dma);
+
+	if (use_dma) {
+		loongson_spi_update_bits(priv, LOONGSON_SPI_IO_SR1_REG,
+					 LOONGSON_SPI_IO_SR1_EOT,
+					 LOONGSON_SPI_IO_SR1_EOT);
+		loongson_spi_update_bits(priv, LOONGSON_SPI_IO_IER_REG,
+					 LOONGSON_SPI_IO_IER_EOTIE,
+					 LOONGSON_SPI_IO_IER_EOTIE);
+		ret = loongson_spi_dma_transfer(priv, xfer, &bus_started);
+		if (!ret)
+			return 0;
+		if (bus_started) {
+			dev_err(&spi->dev, "DMA transfer failed: %d", ret);
+			return ret;
+		}
+
+		dev_dbg(&spi->dev, "DMA setup failed (%d), using interrupt mode", ret);
+		loongson_spi_io_set_thresh(priv, false);
+	}
 
 	priv->tx_buf = xfer->tx_buf;
 	priv->rx_buf = xfer->rx_buf;
@@ -622,8 +941,8 @@ static void loongson_spi_io_reginit(struct loongson_spi_priv *priv)
  * @ctrl: SPI controller
  * @msg: failed SPI message
  *
- * Stop the engine, discard stale RX FIFO data, clear status and software
- * transfer state, then restore the basic configuration.
+ * Stop the engine and DMA channels, discard stale RX FIFO data, clear
+ * status and software transfer state, then restore the basic configuration.
  */
 static void loongson_spi_io_handle_err(struct spi_controller *ctrl,
 				       struct spi_message *msg)
@@ -635,8 +954,15 @@ static void loongson_spi_io_handle_err(struct spi_controller *ctrl,
 
 	loongson_spi_update_bits(priv, LOONGSON_SPI_IO_CR1_REG,
 				 LOONGSON_SPI_IO_CR1_START_MASK, 0);
+	loongson_spi_update_bits(priv, LOONGSON_SPI_IO_CR2_REG,
+				 LOONGSON_SPI_IO_CR2_DMAEN_MASK, 0);
 
-	loongson_spi_io_set_thresh(priv);
+	loongson_spi_io_set_thresh(priv, false);
+
+	if (priv->use_dma) {
+		dmaengine_terminate_sync(priv->dma_tx);
+		dmaengine_terminate_sync(priv->dma_rx);
+	}
 
 	while (FIELD_GET(LOONGSON_SPI_IO_SR2_RXFLV,
 			 loongson_spi_readl(priv, LOONGSON_SPI_IO_SR2_REG)))
@@ -656,11 +982,40 @@ static void loongson_spi_io_handle_err(struct spi_controller *ctrl,
 	loongson_spi_io_reginit(priv);
 }
 
+/**
+ * loongson_spi_io_request_dma_chan() - Request an optional DMA channel
+ * @dev: controller device
+ * @name: DMA channel name, either "tx" or "rx"
+ *
+ * Absence of either channel is non-fatal and selects interrupt-only mode.
+ * Probe deferral is preserved so the DMA provider can be probed later.
+ *
+ * Return: a DMA channel on success, NULL when unavailable, or an ERR_PTR
+ * containing %-EPROBE_DEFER.
+ */
+static struct dma_chan *loongson_spi_io_request_dma_chan(struct device *dev,
+							 const char *name)
+{
+	struct dma_chan *chan = devm_dma_request_chan(dev, name);
+
+	if (IS_ERR(chan)) {
+		int ret = PTR_ERR(chan);
+
+		if (ret == -EPROBE_DEFER)
+			return chan;
+		dev_info(dev, "%s DMA unavailable with %d, using interrupt mode", name, ret);
+		return NULL;
+	}
+
+	return chan;
+}
+
 static int loongson_spi_io_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct loongson_spi_priv *priv;
 	struct spi_controller *host;
+	struct resource *res;
 	struct clk *clk;
 	int ret;
 
@@ -679,13 +1034,15 @@ static int loongson_spi_io_probe(struct platform_device *pdev)
 
 	priv = spi_controller_get_devdata(host);
 
-	priv->base = devm_platform_ioremap_resource(pdev, 0);
+	priv->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
 
 	priv->controller = host;
+	priv->phys_base = res->start;
 	priv->dev = dev;
 	priv->xfer_mode = XFER_IDLE;
+	priv->use_dma = false;
 	priv->batch_size = 0;
 
 	init_completion(&priv->xfer_completion);
@@ -702,6 +1059,26 @@ static int loongson_spi_io_probe(struct platform_device *pdev)
 	host->min_speed_hz = (u32)min_t(u64, DIV_ROUND_UP_ULL(priv->clk_rate, 255),
 					U32_MAX);
 
+	priv->dma_tx = loongson_spi_io_request_dma_chan(dev, "tx");
+	if (IS_ERR(priv->dma_tx))
+		return PTR_ERR(priv->dma_tx);
+
+	priv->dma_rx = loongson_spi_io_request_dma_chan(dev, "rx");
+	if (IS_ERR(priv->dma_rx))
+		return PTR_ERR(priv->dma_rx);
+
+	if (priv->dma_tx && priv->dma_rx) {
+		priv->use_dma = true;
+		/* Let SPI core provide and map dummy buffers for full-duplex DMA. */
+		host->flags |= SPI_CONTROLLER_MUST_RX | SPI_CONTROLLER_MUST_TX;
+		host->dma_tx = priv->dma_tx;
+		host->dma_rx = priv->dma_rx;
+		host->can_dma = loongson_spi_can_dma;
+		dev_info(dev, "DMA channels acquired");
+	} else {
+		dev_info(dev, "DMA unavailable, using interrupt mode only");
+	}
+
 	priv->irq = platform_get_irq(pdev, 0);
 	if (priv->irq < 0)
 		return dev_err_probe(dev, priv->irq, "no IRQ resource");
-- 
2.52.0


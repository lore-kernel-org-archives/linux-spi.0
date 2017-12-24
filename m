From: Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>
Subject: [PATCH 3/3] mtd: atmel-quadspi: add support of DMA memcpy()
Date: Sun, 24 Dec 2017 05:36:06 +0100
Message-ID: <9546f3b76cb5333de1977bf463e92a995a2d974f.1514087323.git.cyrille.pitchen@wedev4u.fr>
References: <cover.1514087323.git.cyrille.pitchen@wedev4u.fr>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        robh@kernel.org, devicetree@vger.kernel.org,
        nicolas.ferre@microchip.com, radu.pirea@microchip.com,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>
To: computersforpeace@gmail.com, dwmw2@infradead.org, richard@nod.at,
        boris.brezillon@free-electrons.com, marek.vasut@gmail.com,
        linux-mtd@lists.infradead.org, broonie@kernel.org, vigneshr@ti.com,
        linux@armlinux.org.uk
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1514087323.git.cyrille.pitchen@wedev4u.fr>
In-Reply-To: <cover.1514087323.git.cyrille.pitchen@wedev4u.fr>
References: <cover.1514087323.git.cyrille.pitchen@wedev4u.fr>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This patch takes advantage of the new bounce buffer helper from the
spi-nor framework to add support of memcpy() operations using the DMA
controller.

Since the number of DMA channels is limited and to avoid changing how
those DMA channels are used in existing boards, this new DMA memcpy()
feature is enabled only if the "dmacap,memcpy" boolean property is set in
the device-tree.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>
---
 drivers/mtd/spi-nor/atmel-quadspi.c | 132 +++++++++++++++++++++++++++++++++++-
 1 file changed, 129 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/spi-nor/atmel-quadspi.c b/drivers/mtd/spi-nor/atmel-quadspi.c
index 6c5708bacad8..5443e4dba416 100644
--- a/drivers/mtd/spi-nor/atmel-quadspi.c
+++ b/drivers/mtd/spi-nor/atmel-quadspi.c
@@ -22,6 +22,8 @@
 
 #include <linux/kernel.h>
 #include <linux/clk.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/delay.h>
@@ -36,6 +38,8 @@
 #include <linux/io.h>
 #include <linux/gpio.h>
 
+#define QSPI_DMA_THRESHOLD	32
+
 /* QSPI register offsets */
 #define QSPI_CR      0x0000  /* Control Register */
 #define QSPI_MR      0x0004  /* Mode Register */
@@ -161,6 +165,11 @@ struct atmel_qspi {
 	struct spi_nor		nor;
 	u32			clk_rate;
 	struct completion	cmd_completion;
+
+	/* DMA transfers */
+	struct dma_chan		*chan;
+	dma_addr_t		dma_mem;
+	struct completion	transfer_complete;
 };
 
 struct atmel_qspi_command {
@@ -197,11 +206,96 @@ static inline void qspi_writel(struct atmel_qspi *aq, u32 reg, u32 value)
 	writel_relaxed(value, aq->regs + reg);
 }
 
+static void atmel_qspi_dma_callback(void *param)
+{
+	struct atmel_qspi *aq = param;
+
+	complete(&aq->transfer_complete);
+}
+
+static int atmel_qspi_run_dma_transfer(struct atmel_qspi *aq,
+				       const struct atmel_qspi_command *cmd)
+{
+	struct device *dev = &aq->pdev->dev;
+	enum dma_data_direction dir;
+	struct dma_async_tx_descriptor *desc;
+	dma_addr_t src, dst, dma_addr;
+	dma_cookie_t cookie;
+	u32 offset;
+	void *ptr;
+	int err = 0;
+
+	if (cmd->tx_buf) {
+		ptr = (void *)cmd->tx_buf;
+		dir = DMA_TO_DEVICE;
+	} else if (cmd->rx_buf) {
+		ptr = cmd->rx_buf;
+		dir = DMA_FROM_DEVICE;
+	} else {
+		return -EINVAL;
+	}
+
+	dma_addr = dma_map_single(dev, ptr, cmd->buf_len, dir);
+	if (dma_mapping_error(dev, dma_addr))
+		return -ENOMEM;
+
+	offset = cmd->enable.bits.address ? cmd->address : 0;
+	if (cmd->tx_buf) {
+		dst = aq->dma_mem + offset;
+		src = dma_addr;
+	} else {
+		dst = dma_addr;
+		src = aq->dma_mem + offset;
+	}
+
+	desc = dmaengine_prep_dma_memcpy(aq->chan, dst, src, cmd->buf_len,
+					 DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
+	if (!desc) {
+		err = -ENOMEM;
+		goto unmap;
+	}
+
+	reinit_completion(&aq->transfer_complete);
+	desc->callback = atmel_qspi_dma_callback;
+	desc->callback_param = aq;
+
+	cookie = dmaengine_submit(desc);
+	err = dma_submit_error(cookie);
+	if (err) {
+		err = -EIO;
+		goto unmap;
+	}
+
+	dma_async_issue_pending(aq->chan);
+	err = wait_for_completion_timeout(&aq->transfer_complete,
+					  msecs_to_jiffies(cmd->buf_len));
+	if (err <= 0) {
+		dmaengine_terminate_sync(aq->chan);
+		err = -ETIMEDOUT;
+		goto unmap;
+	}
+
+	err = 0;
+
+ unmap:
+	dma_unmap_single(dev, dma_addr, cmd->buf_len, dir);
+	return err;
+}
+
 static int atmel_qspi_run_transfer(struct atmel_qspi *aq,
 				   const struct atmel_qspi_command *cmd)
 {
 	void __iomem *ahb_mem;
 
+	/* Try DMA transfer first. */
+	if (aq->chan && cmd->buf_len >= QSPI_DMA_THRESHOLD) {
+		int err = atmel_qspi_run_dma_transfer(aq, cmd);
+
+		/* If the DMA transfer has started, stop here. */
+		if (err != -ENOMEM)
+			return err;
+	}
+
 	/* Then fallback to a PIO transfer (memcpy() DOES NOT work!) */
 	ahb_mem = aq->mem;
 	if (cmd->enable.bits.address)
@@ -604,7 +698,7 @@ static irqreturn_t atmel_qspi_interrupt(int irq, void *dev_id)
 
 static int atmel_qspi_probe(struct platform_device *pdev)
 {
-	const struct spi_nor_hwcaps hwcaps = {
+	struct spi_nor_hwcaps hwcaps = {
 		.mask = SNOR_HWCAPS_READ |
 			SNOR_HWCAPS_READ_FAST |
 			SNOR_HWCAPS_READ_1_1_2 |
@@ -657,19 +751,44 @@ static int atmel_qspi_probe(struct platform_device *pdev)
 		goto exit;
 	}
 
+	aq->dma_mem = (dma_addr_t)res->start;
+
+	/* Reserve a DMA channel for memcpy(), only if requested */
+	if (of_property_read_bool(np, "dmacap,memcpy")) {
+		dma_cap_mask_t mask;
+
+		dma_cap_zero(mask);
+		dma_cap_set(DMA_MEMCPY, mask);
+
+		aq->chan = dma_request_chan_by_mask(&mask);
+		if (IS_ERR(aq->chan)) {
+			if (PTR_ERR(aq->chan) == -EPROBE_DEFER) {
+				err = -EPROBE_DEFER;
+				goto exit;
+			}
+			dev_warn(&pdev->dev, "no available DMA channel\n");
+			aq->chan = NULL;
+		} else {
+			hwcaps.mask |= SNOR_HWCAPS_RD_BOUNCE |
+				       SNOR_HWCAPS_WR_BOUNCE;
+		}
+	}
+
+	init_completion(&aq->transfer_complete);
+
 	/* Get the peripheral clock */
 	aq->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(aq->clk)) {
 		dev_err(&pdev->dev, "missing peripheral clock\n");
 		err = PTR_ERR(aq->clk);
-		goto exit;
+		goto release_dma_chan;
 	}
 
 	/* Enable the peripheral clock */
 	err = clk_prepare_enable(aq->clk);
 	if (err) {
 		dev_err(&pdev->dev, "failed to enable the peripheral clock\n");
-		goto exit;
+		goto release_dma_chan;
 	}
 
 	/* Request the IRQ */
@@ -721,6 +840,9 @@ static int atmel_qspi_probe(struct platform_device *pdev)
 
 disable_clk:
 	clk_disable_unprepare(aq->clk);
+release_dma_chan:
+	if (aq->chan)
+		dma_release_channel(aq->chan);
 exit:
 	of_node_put(child);
 
@@ -734,6 +856,10 @@ static int atmel_qspi_remove(struct platform_device *pdev)
 	mtd_device_unregister(&aq->nor.mtd);
 	qspi_writel(aq, QSPI_CR, QSPI_CR_QSPIDIS);
 	clk_disable_unprepare(aq->clk);
+
+	if (aq->chan)
+		dma_release_channel(aq->chan);
+
 	return 0;
 }
 
-- 
2.11.0

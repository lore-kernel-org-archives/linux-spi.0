From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 1/2] SPI: spi_sh_msiof: implement DMA support
Date: Fri, 2 Sep 2011 17:13:31 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1109021712180.4731@axis700.grange>
References: <Pine.LNX.4.64.1109021706480.4731@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-sh@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>
To: spi-devel-general@lists.sourceforge.net
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1109021706480.4731@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Use the sh_dma dmaengine driver to support DMA on MSIOF.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/spi/spi-sh-msiof.c   |  393 ++++++++++++++++++++++++++++++++++++++---
 include/linux/spi/sh_msiof.h |    2 +
 2 files changed, 366 insertions(+), 29 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index e00d94b..8622b32 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -13,14 +13,18 @@
 #include <linux/clk.h>
 #include <linux/completion.h>
 #include <linux/delay.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
 #include <linux/err.h>
 #include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/mm.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/sh_dma.h>
 
 #include <linux/spi/sh_msiof.h>
 #include <linux/spi/spi.h>
@@ -28,6 +32,13 @@
 
 #include <asm/unaligned.h>
 
+struct sh_msiof_dma {
+	struct sh_dmae_slave dma_slave;
+	struct dma_chan	*chan;
+	struct sg_table	sg;
+	struct dma_async_tx_descriptor *desc;
+};
+
 struct sh_msiof_spi_priv {
 	struct spi_bitbang bitbang; /* must be first for spi_bitbang.c */
 	void __iomem *mapbase;
@@ -38,6 +49,10 @@ struct sh_msiof_spi_priv {
 	unsigned long flags;
 	int tx_fifo_size;
 	int rx_fifo_size;
+	struct sh_msiof_dma dma_tx;
+	struct sh_msiof_dma dma_rx;
+	struct completion dma_done;
+	struct page *dummypage;
 };
 
 #define TMDR1	0x00
@@ -64,8 +79,12 @@ struct sh_msiof_spi_priv {
 #define CTR_TXE   (1 << 9)
 #define CTR_RXE   (1 << 8)
 
-#define STR_TEOF  (1 << 23)
-#define STR_REOF  (1 << 7)
+#define IER_TDMA  (1 << 31)
+#define IER_TDREQ (1 << 28)
+#define IER_TEOF  (1 << 23)
+#define IER_RDMA  (1 << 15)
+#define IER_RDREQ (1 << 12)
+#define IER_REOF  (1 << 7)
 
 static u32 sh_msiof_read(struct sh_msiof_spi_priv *p, int reg_offs)
 {
@@ -208,8 +227,6 @@ static void sh_msiof_spi_set_mode_regs(struct sh_msiof_spi_priv *p,
 
 	if (rx_buf)
 		sh_msiof_write(p, RMDR2, dr2);
-
-	sh_msiof_write(p, IER, STR_TEOF | STR_REOF);
 }
 
 static void sh_msiof_reset_str(struct sh_msiof_spi_priv *p)
@@ -401,9 +418,9 @@ static void sh_msiof_spi_chipselect(struct spi_device *spi, int is_on)
 
 	/* chip select is active low unless SPI_CS_HIGH is set */
 	if (spi->mode & SPI_CS_HIGH)
-		value = (is_on == BITBANG_CS_ACTIVE) ? 1 : 0;
+		value = is_on == BITBANG_CS_ACTIVE;
 	else
-		value = (is_on == BITBANG_CS_ACTIVE) ? 0 : 1;
+		value = is_on != BITBANG_CS_ACTIVE;
 
 	if (is_on == BITBANG_CS_ACTIVE) {
 		if (!test_and_set_bit(0, &p->flags)) {
@@ -429,6 +446,36 @@ static void sh_msiof_spi_chipselect(struct spi_device *spi, int is_on)
 	}
 }
 
+static int sh_msiof_spi_start(struct sh_msiof_spi_priv *p, void *rx_buf)
+{
+	/* setup clock and rx/tx signals */
+	int ret = sh_msiof_modify_ctr_wait(p, 0, CTR_TSCKE);
+	if (rx_buf && !ret)
+		ret = sh_msiof_modify_ctr_wait(p, 0, CTR_RXE);
+	if (!ret)
+		ret = sh_msiof_modify_ctr_wait(p, 0, CTR_TXE);
+
+	/* start by setting frame bit */
+	if (!ret)
+		ret = sh_msiof_modify_ctr_wait(p, 0, CTR_TFSE);
+
+	return ret;
+}
+
+static int sh_msiof_spi_stop(struct sh_msiof_spi_priv *p, void *rx_buf)
+{
+	/* shut down frame, tx/tx and clock signals */
+	int ret = sh_msiof_modify_ctr_wait(p, CTR_TFSE, 0);
+	if (!ret)
+		ret = sh_msiof_modify_ctr_wait(p, CTR_TXE, 0);
+	if (rx_buf && !ret)
+		ret = sh_msiof_modify_ctr_wait(p, CTR_RXE, 0);
+	if (!ret)
+		ret = sh_msiof_modify_ctr_wait(p, CTR_TSCKE, 0);
+
+	return ret;
+}
+
 static int sh_msiof_spi_txrx_once(struct sh_msiof_spi_priv *p,
 				  void (*tx_fifo)(struct sh_msiof_spi_priv *,
 						  const void *, int, int),
@@ -456,16 +503,11 @@ static int sh_msiof_spi_txrx_once(struct sh_msiof_spi_priv *p,
 	if (tx_buf)
 		tx_fifo(p, tx_buf, words, fifo_shift);
 
-	/* setup clock and rx/tx signals */
-	ret = sh_msiof_modify_ctr_wait(p, 0, CTR_TSCKE);
-	if (rx_buf)
-		ret = ret ? ret : sh_msiof_modify_ctr_wait(p, 0, CTR_RXE);
-	ret = ret ? ret : sh_msiof_modify_ctr_wait(p, 0, CTR_TXE);
-
-	/* start by setting frame bit */
 	INIT_COMPLETION(p->done);
-	ret = ret ? ret : sh_msiof_modify_ctr_wait(p, 0, CTR_TFSE);
-	if (ret) {
+	sh_msiof_write(p, IER, IER_TEOF | IER_REOF);
+
+	ret = sh_msiof_spi_start(p, rx_buf);
+	if (ret < 0) {
 		dev_err(&p->pdev->dev, "failed to start hardware\n");
 		goto err;
 	}
@@ -480,13 +522,8 @@ static int sh_msiof_spi_txrx_once(struct sh_msiof_spi_priv *p,
 	/* clear status bits */
 	sh_msiof_reset_str(p);
 
-	/* shut down frame, tx/tx and clock signals */
-	ret = sh_msiof_modify_ctr_wait(p, CTR_TFSE, 0);
-	ret = ret ? ret : sh_msiof_modify_ctr_wait(p, CTR_TXE, 0);
-	if (rx_buf)
-		ret = ret ? ret : sh_msiof_modify_ctr_wait(p, CTR_RXE, 0);
-	ret = ret ? ret : sh_msiof_modify_ctr_wait(p, CTR_TSCKE, 0);
-	if (ret) {
+	ret = sh_msiof_spi_stop(p, rx_buf);
+	if (ret < 0) {
 		dev_err(&p->pdev->dev, "failed to shut down hardware\n");
 		goto err;
 	}
@@ -498,6 +535,220 @@ static int sh_msiof_spi_txrx_once(struct sh_msiof_spi_priv *p,
 	return ret;
 }
 
+static void sh_msiof_setup_sg(struct sh_msiof_spi_priv *p,
+			      const void *buffer,
+			      unsigned int length,
+			      struct sg_table *sgtab)
+{
+	struct scatterlist *sg;
+	int bytesleft = length;
+	const void *bufp = buffer;
+	int mapbytes;
+	int i;
+
+	if (buffer) {
+		for_each_sg(sgtab->sgl, sg, sgtab->nents, i) {
+			/*
+			 * If there are fewer bytes left than what fits
+			 * in the current page (plus page alignment offset)
+			 * we just feed in this, else we stuff in as much
+			 * as we can.
+			 */
+			if (bytesleft < (PAGE_SIZE - offset_in_page(bufp)))
+				mapbytes = bytesleft;
+			else
+				mapbytes = PAGE_SIZE - offset_in_page(bufp);
+			sg_set_page(sg, virt_to_page(bufp),
+				    mapbytes, offset_in_page(bufp));
+			bytesleft -= mapbytes;
+			bufp += mapbytes;
+		}
+	} else {
+		/* Map the dummy buffer on every page */
+		for_each_sg(sgtab->sgl, sg, sgtab->nents, i) {
+			if (bytesleft < PAGE_SIZE)
+				mapbytes = bytesleft;
+			else
+				mapbytes = PAGE_SIZE;
+			sg_set_page(sg, p->dummypage, mapbytes, 0);
+			bytesleft -= mapbytes;
+		}
+	}
+	BUG_ON(bytesleft);
+}
+
+static int sh_msiof_spi_setup_xfer_dma(struct sh_msiof_spi_priv *p, struct sh_msiof_dma *dma,
+				       const void *buffer, size_t len, enum dma_data_direction dir)
+{
+	int ret, sglen;
+	unsigned int pages;
+	unsigned long flags = DMA_CTRL_ACK;
+
+	/* Create sglists for the transfers */
+	pages = (PAGE_ALIGN(len) >> PAGE_SHIFT);
+
+	ret = sg_alloc_table(&dma->sg, pages, GFP_KERNEL);
+	if (ret < 0)
+		return ret;
+
+	sh_msiof_setup_sg(p, buffer, len, &dma->sg);
+
+	/* Map DMA buffers */
+	sglen = dma_map_sg(&p->pdev->dev, dma->sg.sgl,
+			   dma->sg.orig_nents, dir);
+	if (sglen < 0) {
+		ret = sglen;
+		goto emapsg;
+	} else if (!sglen) {
+		ret = -EINVAL;
+		goto emapsg;
+	}
+
+	if (dir == DMA_FROM_DEVICE)
+		flags |= DMA_PREP_INTERRUPT;
+
+	dma->desc = dma->chan->device->device_prep_slave_sg(dma->chan,
+					dma->sg.sgl, sglen, dir, flags);
+	if (!dma->desc) {
+		ret = -ENOMEM;
+		goto edmaprep;
+	}
+
+	dma->sg.nents = sglen;
+
+	return 0;
+
+edmaprep:
+	dma_unmap_sg(&p->pdev->dev, dma->sg.sgl, sglen, dir);
+emapsg:
+	sg_free_table(&dma->sg);
+
+	return ret;
+}
+
+static void sh_msiof_spi_free_xfer_dma(struct sh_msiof_spi_priv *p, struct sh_msiof_dma *dma,
+				       enum dma_data_direction dir)
+{
+	dma_unmap_sg(&p->pdev->dev, dma->sg.sgl, dma->sg.nents, dir);
+	sg_free_table(&dma->sg);
+}
+
+static void sh_msiof_spi_dma_callback(void *arg)
+{
+	struct sh_msiof_spi_priv *p = arg;
+
+	dma_sync_sg_for_device(&p->pdev->dev, p->dma_rx.sg.sgl,
+			       p->dma_rx.sg.nents, DMA_FROM_DEVICE);
+
+	sh_msiof_spi_free_xfer_dma(p, &p->dma_rx, DMA_FROM_DEVICE);
+	sh_msiof_spi_free_xfer_dma(p, &p->dma_tx, DMA_TO_DEVICE);
+
+	complete(&p->dma_done);
+}
+
+static int sh_msiof_spi_txrx_dma_single(struct sh_msiof_spi_priv *p, int bits,
+					const void *tx_buf, const void *rx_buf, size_t len)
+{
+	int ret, cookie, words;
+
+	if (bits <= 8)
+		words = len;
+	else if (bits <= 16)
+		words = len >> 1;
+	else
+		words = len >> 2;
+
+	ret = sh_msiof_spi_setup_xfer_dma(p, &p->dma_tx, tx_buf, len, DMA_TO_DEVICE);
+	if (ret < 0)
+		return ret;
+
+	dma_sync_sg_for_device(&p->pdev->dev, p->dma_tx.sg.sgl,
+			       p->dma_tx.sg.nents, DMA_TO_DEVICE);
+
+	ret = sh_msiof_spi_setup_xfer_dma(p, &p->dma_rx, rx_buf, len, DMA_FROM_DEVICE);
+	if (ret < 0)
+		goto esdmarx;
+
+	/* Put the callback on the RX transfer only, that should finish last */
+	p->dma_rx.desc->callback = sh_msiof_spi_dma_callback;
+	p->dma_rx.desc->callback_param = p;
+
+	/* Submit and fire RX and TX with TX last so we're ready to read! */
+	cookie = p->dma_rx.desc->tx_submit(p->dma_rx.desc);
+	if (dma_submit_error(cookie)) {
+		ret = cookie;
+		goto esubmitrx;
+	}
+	p->dma_rx.chan->device->device_issue_pending(p->dma_rx.chan);
+
+	/* setup msiof transfer mode registers */
+	sh_msiof_spi_set_mode_regs(p, tx_buf, p->dummypage, bits, words);
+
+	cookie = p->dma_tx.desc->tx_submit(p->dma_tx.desc);
+	if (dma_submit_error(cookie)) {
+		ret = cookie;
+		goto esubmittx;
+	}
+	p->dma_tx.chan->device->device_issue_pending(p->dma_tx.chan);
+
+	INIT_COMPLETION(p->dma_done);
+	sh_msiof_write(p, IER, IER_RDREQ | IER_TDREQ | IER_RDMA | IER_TDMA);
+
+	/* As long as there's something to send, we'll also be receiving. */
+	ret = sh_msiof_spi_start(p, p->dummypage);
+	if (ret < 0) {
+		dev_err(&p->pdev->dev, "failed to start hardware: %d\n", ret);
+		goto espistart;
+	}
+
+	wait_for_completion(&p->dma_done);
+
+	/* clear status bits */
+	sh_msiof_reset_str(p);
+
+	ret = sh_msiof_spi_stop(p, p->dummypage);
+	if (ret < 0) {
+		dev_err(&p->pdev->dev, "failed to stop hardware: %d\n", ret);
+		goto espistop;
+	}
+
+	return len;
+
+espistop:
+espistart:
+	dmaengine_device_control(p->dma_tx.chan, DMA_TERMINATE_ALL, 0);
+esubmittx:
+	dmaengine_device_control(p->dma_rx.chan, DMA_TERMINATE_ALL, 0);
+esubmitrx:
+	sh_msiof_spi_free_xfer_dma(p, &p->dma_rx, DMA_FROM_DEVICE);
+esdmarx:
+	sh_msiof_spi_free_xfer_dma(p, &p->dma_tx, DMA_TO_DEVICE);
+
+	return ret;
+}
+
+static int sh_msiof_spi_txrx_dma(struct sh_msiof_spi_priv *p, struct spi_transfer *t, int bits)
+{
+	int i, ret = 0;
+	size_t left = t->len;
+	off_t offs = 0;
+
+	/* Up to 256 words per group, we only use a single group */
+	for (i = 0; i < (t->len + 255) / 256; i++) {
+		const void *rx_buf = t->rx_buf ? t->rx_buf + offs : NULL;
+		const void *tx_buf = t->tx_buf ? t->tx_buf + offs : NULL;
+
+		ret = sh_msiof_spi_txrx_dma_single(p, bits, tx_buf, rx_buf,
+						   min_t(size_t, left, 256));
+		if (ret < 0)
+			return ret;
+		left -= ret;
+		offs += ret;
+	}
+
+	return ret <= 0 ? ret : t->len;
+}
+
 static int sh_msiof_spi_txrx(struct spi_device *spi, struct spi_transfer *t)
 {
 	struct sh_msiof_spi_priv *p = spi_master_get_devdata(spi->master);
@@ -512,6 +763,19 @@ static int sh_msiof_spi_txrx(struct spi_device *spi, struct spi_transfer *t)
 
 	bits = sh_msiof_spi_bits(spi, t);
 
+	/* setup clocks (clock already enabled in chipselect()) */
+	sh_msiof_spi_set_clk_regs(p, clk_get_rate(p->clk),
+				  sh_msiof_spi_hz(spi, t));
+
+	if (p->dma_rx.chan && p->dma_tx.chan && t->len > 15 &&
+	    !(t->len & 3) && !((int)t->rx_buf & 3) && !((int)t->tx_buf & 3)) {
+		int ret = sh_msiof_spi_txrx_dma(p, t, bits);
+		if (ret < 0)
+			dev_warn(&spi->dev, "fall back to PIO: %d\n", ret);
+		else
+			return ret;
+	}
+
 	if (bits <= 8 && t->len > 15 && !(t->len & 3)) {
 		bits = 32;
 		swab = true;
@@ -559,10 +823,6 @@ static int sh_msiof_spi_txrx(struct spi_device *spi, struct spi_transfer *t)
 			rx_fifo = sh_msiof_spi_read_fifo_32;
 	}
 
-	/* setup clocks (clock already enabled in chipselect()) */
-	sh_msiof_spi_set_clk_regs(p, clk_get_rate(p->clk),
-				  sh_msiof_spi_hz(spi, t));
-
 	/* transfer in fifo sized chunks */
 	words = t->len / bytes_per_word;
 	bytes_done = 0;
@@ -591,6 +851,78 @@ static u32 sh_msiof_spi_txrx_word(struct spi_device *spi, unsigned nsecs,
 	return 0;
 }
 
+static bool sh_msiof_filter(struct dma_chan *chan, void *arg)
+{
+	dev_dbg(chan->device->dev, "%s: slave data %p\n", __func__, arg);
+	chan->private = arg;
+	return true;
+}
+
+static void sh_msiof_request_dma(struct sh_msiof_spi_priv *p)
+{
+	struct sh_dmae_slave *tx = &p->dma_tx.dma_slave,
+		*rx = &p->dma_rx.dma_slave;
+	dma_cap_mask_t mask;
+
+	tx->slave_id = p->info->slave_id_tx;
+	rx->slave_id = p->info->slave_id_rx;
+
+	/* We can only either use DMA for both Tx and Rx or not use it at all */
+	if (tx->slave_id <= 0 || rx->slave_id <= 0)
+		return;
+
+	dev_warn(&p->pdev->dev, "Experimental DMA support enabled.\n");
+
+	p->dummypage = alloc_page(GFP_KERNEL);
+	if (!p->dummypage)
+		return;
+
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_SLAVE, mask);
+
+	p->dma_tx.chan = dma_request_channel(mask, sh_msiof_filter, tx);
+	dev_dbg(&p->pdev->dev, "%s: TX: got channel %p\n", __func__,
+		p->dma_tx.chan);
+
+	if (!p->dma_tx.chan)
+		goto echantx;
+
+	p->dma_rx.chan = dma_request_channel(mask, sh_msiof_filter, rx);
+	dev_dbg(&p->pdev->dev, "%s: RX: got channel %p\n", __func__,
+		p->dma_rx.chan);
+
+	if (!p->dma_rx.chan)
+		goto echanrx;
+
+	init_completion(&p->dma_done);
+
+	return;
+
+echanrx:
+	dma_release_channel(p->dma_tx.chan);
+	p->dma_tx.chan = NULL;
+echantx:
+	__free_pages(p->dummypage, 0);
+}
+
+static void sh_msiof_release_dma(struct sh_msiof_spi_priv *p)
+{
+	/* Descriptors are freed automatically */
+	if (p->dma_tx.chan) {
+		struct dma_chan *chan = p->dma_tx.chan;
+		p->dma_tx.chan = NULL;
+		dma_release_channel(chan);
+	}
+	if (p->dma_rx.chan) {
+		struct dma_chan *chan = p->dma_rx.chan;
+		p->dma_rx.chan = NULL;
+		dma_release_channel(chan);
+	}
+
+	if (p->dummypage)
+		__free_pages(p->dummypage, 0);
+}
+
 static int sh_msiof_spi_probe(struct platform_device *pdev)
 {
 	struct resource	*r;
@@ -645,6 +977,8 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
 	p->pdev = pdev;
 	pm_runtime_enable(&pdev->dev);
 
+	sh_msiof_request_dma(p);
+
 	/* The standard version of MSIOF use 64 word FIFOs */
 	p->tx_fifo_size = 64;
 	p->rx_fifo_size = 64;
@@ -656,8 +990,8 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
 		p->rx_fifo_size = p->info->rx_fifo_override;
 
 	/* init master and bitbang code */
-	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
-	master->mode_bits |= SPI_LSB_FIRST | SPI_3WIRE;
+	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH |
+		SPI_LSB_FIRST | SPI_3WIRE;
 	master->flags = 0;
 	master->bus_num = pdev->id;
 	master->num_chipselect = p->info->num_chipselect;
@@ -677,6 +1011,7 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
 	if (ret == 0)
 		return 0;
 
+	sh_msiof_release_dma(p);
 	pm_runtime_disable(&pdev->dev);
  err3:
 	iounmap(p->mapbase);
@@ -695,11 +1030,11 @@ static int sh_msiof_spi_remove(struct platform_device *pdev)
 
 	ret = spi_bitbang_stop(&p->bitbang);
 	if (!ret) {
+		sh_msiof_release_dma(p);
 		pm_runtime_disable(&pdev->dev);
 		free_irq(platform_get_irq(pdev, 0), p);
 		iounmap(p->mapbase);
 		clk_put(p->clk);
-		spi_master_put(p->bitbang.master);
 	}
 	return ret;
 }
diff --git a/include/linux/spi/sh_msiof.h b/include/linux/spi/sh_msiof.h
index 2e8db3d..69c0f6e 100644
--- a/include/linux/spi/sh_msiof.h
+++ b/include/linux/spi/sh_msiof.h
@@ -5,6 +5,8 @@ struct sh_msiof_spi_info {
 	int tx_fifo_override;
 	int rx_fifo_override;
 	u16 num_chipselect;
+	unsigned int slave_id_tx;
+	unsigned int slave_id_rx;
 };
 
 #endif /* __SPI_SH_MSIOF_H__ */
-- 
1.7.2.5


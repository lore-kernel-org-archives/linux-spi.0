From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 41/49] spi: davinci: let DMA operation be specified on
	per-device basis
Date: Wed, 17 Nov 2010 16:14:13 +0530
Message-ID: <1289990661-30126-42-git-send-email-nsekhar@ti.com>
References: <1289990661-30126-1-git-send-email-nsekhar@ti.com>
	<1289990661-30126-2-git-send-email-nsekhar@ti.com>
	<1289990661-30126-3-git-send-email-nsekhar@ti.com>
	<1289990661-30126-4-git-send-email-nsekhar@ti.com>
	<1289990661-30126-5-git-send-email-nsekhar@ti.com>
	<1289990661-30126-6-git-send-email-nsekhar@ti.com>
	<1289990661-30126-7-git-send-email-nsekhar@ti.com>
	<1289990661-30126-8-git-send-email-nsekhar@ti.com>
	<1289990661-30126-9-git-send-email-nsekhar@ti.com>
	<1289990661-30126-10-git-send-email-nsekhar@ti.com>
	<1289990661-30126-11-git-send-email-nsekhar@ti.com>
	<1289990661-30126-12-git-send-email-nsekhar@ti.com>
	<1289990661-30126-13-git-send-email-nsekhar@ti.com>
	<1289990661-30126-14-git-send-email-nsekhar@ti.com>
	<1289990661-30126-15-git-send-email-nsekhar@ti.com>
	<1289990661-30126-16-git-send-email-nsekhar@ti.com>
	<1289990661-30126-17-git-send-email-nsekhar@ti.com>
	<1289990661-30126-18-git-send-email-nsekhar@ti.com>
	<1289990661-30126-19-git-send-email-nsekhar@ti.com>
	<1289990661-30126-20-git-send-email-nsekhar@ti.com>
	<1289990661-30126-21-git-send-email-nsekhar@ti.com>
	<1289990661-30126-22-git-send-email-nsekhar@ti.com>
	<1289990661-30126-23-git-send-email-nsekhar@ti.com>
	<1289990661-30126-24-git-send-email-nsekhar@ti.com>
	<1289990661-30126-25-git-send-email-nsekhar@ti.com>
	<1289990661-30126-26-git-send-email-nsekhar@ti.com>
	<1289990661-30126-27-git-send-email-nsekhar@ti.com>
	<1289990661-30126-28-git-send-email-nsekhar@ti.com>
	<1289990661-30126-29-git-send-email-nsekhar@ti.com>
	<1289990661-30126-30-git-send-email-nsekhar@ti.com>
	<1289990661-30126-31-git-send-email-nsekhar@ti.com>
	<1289990661-30126-32-git-send-email-nsekhar@ti.com>
	<1289990661-30126-33-git-send-email-nsekhar@ti.com>
	<1289990661-30126-34-git-send-email-nsekhar@ti.com>
	<1289990661-30126-35-git-send-email-nsekhar@ti.com>
	<1289990661-30126-36-git-send-email-nsekhar@ti.com>
	<1289990661-30126-37-git-send-email-nsekhar@ti.com>
	<1289990661-30126-38-git-send-email-nsekhar@ti.com>
	<1289990661-30126-39-git-send-email-nsekhar@ti.com>
	<1289990661-30126-40-git-send-email-nsekhar@ti.com>
	<1289990661-30126-41-git-send-email-nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
        davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org,
        David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1289990661-30126-41-git-send-email-nsekhar-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Brian Niebuhr <bniebuhr-JaPwekKOx1yaMJb+Lgu22Q@public.gmane.org>

Let DMA operation be specified on a per-device basis instead
of selecting it once during probe.

A side effect of this is the need to combine the PIO and DMA buffer
txrx_bufs routine. This is good since they anyway share some common
functionality.

Signed-off-by: Brian Niebuhr <bniebuhr-JaPwekKOx1yaMJb+Lgu22Q@public.gmane.org>
Tested-By: Michael Williamson <michael.williamson-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>
Signed-off-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-davinci/include/mach/spi.h |    1 +
 drivers/spi/davinci_spi.c                |  342 ++++++++++++++----------------
 2 files changed, 156 insertions(+), 187 deletions(-)

diff --git a/arch/arm/mach-davinci/include/mach/spi.h b/arch/arm/mach-davinci/include/mach/spi.h
index f7586a0..b3ab7d0 100644
--- a/arch/arm/mach-davinci/include/mach/spi.h
+++ b/arch/arm/mach-davinci/include/mach/spi.h
@@ -41,6 +41,7 @@ struct davinci_spi_config {
 	u8	parity_enable;
 #define SPI_IO_TYPE_INTR	0
 #define SPI_IO_TYPE_POLL	1
+#define SPI_IO_TYPE_DMA		2
 	u8	io_type;
 	u8	timer_disable;
 	u8	c2tdelay;
diff --git a/drivers/spi/davinci_spi.c b/drivers/spi/davinci_spi.c
index 6094e3a..5fe2980 100644
--- a/drivers/spi/davinci_spi.c
+++ b/drivers/spi/davinci_spi.c
@@ -500,6 +500,25 @@ out:
 	return errors;
 }
 
+static void davinci_spi_dma_callback(unsigned lch, u16 status, void *data)
+{
+	struct davinci_spi *davinci_spi = data;
+	struct davinci_spi_dma *davinci_spi_dma = &davinci_spi->dma_channels;
+
+	edma_stop(lch);
+
+	if (status == DMA_COMPLETE) {
+		if (lch == davinci_spi_dma->dma_rx_channel)
+			davinci_spi->rcount = 0;
+		if (lch == davinci_spi_dma->dma_tx_channel)
+			davinci_spi->wcount = 0;
+	}
+
+	if ((!davinci_spi->wcount && !davinci_spi->rcount) ||
+	    (status != DMA_COMPLETE))
+		complete(&davinci_spi->done);
+}
+
 /**
  * davinci_spi_bufs - functions which will handle transfer data
  * @spi: spi device on which data transfer to be done
@@ -509,25 +528,30 @@ out:
  * of SPI controller and then wait until the completion will be marked
  * by the IRQ Handler.
  */
-static int davinci_spi_bufs_pio(struct spi_device *spi, struct spi_transfer *t)
+static int davinci_spi_bufs(struct spi_device *spi, struct spi_transfer *t)
 {
 	struct davinci_spi *davinci_spi;
-	int ret;
+	int data_type, ret;
 	u32 tx_data, data1_reg_val;
 	u32 errors = 0;
 	struct davinci_spi_config *spicfg;
 	struct davinci_spi_platform_data *pdata;
+	unsigned uninitialized_var(rx_buf_count);
+	struct device *sdev;
 
 	davinci_spi = spi_master_get_devdata(spi->master);
 	pdata = davinci_spi->pdata;
 	spicfg = (struct davinci_spi_config *)spi->controller_data;
 	if (!spicfg)
 		spicfg = &davinci_spi_default_cfg;
+	sdev = davinci_spi->bitbang.master->dev.parent;
+
+	/* convert len to words based on bits_per_word */
+	data_type = davinci_spi->bytes_per_word[spi->chip_select];
 
 	davinci_spi->tx = t->tx_buf;
 	davinci_spi->rx = t->rx_buf;
-	davinci_spi->wcount = t->len /
-				davinci_spi->bytes_per_word[spi->chip_select];
+	davinci_spi->wcount = t->len / data_type;
 	davinci_spi->rcount = davinci_spi->wcount;
 
 	data1_reg_val = ioread32(davinci_spi->base + SPIDAT1);
@@ -535,20 +559,117 @@ static int davinci_spi_bufs_pio(struct spi_device *spi, struct spi_transfer *t)
 	/* Enable SPI */
 	set_io_bits(davinci_spi->base + SPIGCR1, SPIGCR1_SPIENA_MASK);
 
-	if (spicfg->io_type == SPI_IO_TYPE_INTR) {
+	INIT_COMPLETION(davinci_spi->done);
+
+	if (spicfg->io_type == SPI_IO_TYPE_INTR)
 		set_io_bits(davinci_spi->base + SPIINT, SPIINT_MASKINT);
-		INIT_COMPLETION(davinci_spi->done);
-	}
 
-	/* start the transfer */
-	davinci_spi->wcount--;
-	tx_data = davinci_spi->get_tx(davinci_spi);
-	data1_reg_val &= 0xFFFF0000;
-	data1_reg_val |= tx_data & 0xFFFF;
-	iowrite32(data1_reg_val, davinci_spi->base + SPIDAT1);
+	if (spicfg->io_type != SPI_IO_TYPE_DMA) {
+		/* start the transfer */
+		davinci_spi->wcount--;
+		tx_data = davinci_spi->get_tx(davinci_spi);
+		data1_reg_val &= 0xFFFF0000;
+		data1_reg_val |= tx_data & 0xFFFF;
+		iowrite32(data1_reg_val, davinci_spi->base + SPIDAT1);
+	} else {
+		struct davinci_spi_dma *davinci_spi_dma;
+		unsigned long tx_reg, rx_reg;
+		struct edmacc_param param;
+		void *rx_buf;
+
+		davinci_spi_dma = &davinci_spi->dma_channels;
+
+		tx_reg = (unsigned long)davinci_spi->pbase + SPIDAT1;
+		rx_reg = (unsigned long)davinci_spi->pbase + SPIBUF;
+
+		/*
+		 * Transmit DMA setup
+		 *
+		 * If there is transmit data, map the transmit buffer, set it
+		 * as the source of data and set the source B index to data
+		 * size. If there is no transmit data, set the transmit register
+		 * as the source of data, and set the source B index to zero.
+		 *
+		 * The destination is always the transmit register itself. And
+		 * the destination never increments.
+		 */
+
+		if (t->tx_buf) {
+			t->tx_dma = dma_map_single(&spi->dev, (void *)t->tx_buf,
+					davinci_spi->wcount, DMA_TO_DEVICE);
+			if (dma_mapping_error(&spi->dev, t->tx_dma)) {
+				dev_dbg(sdev, "Unable to DMA map %d bytes"
+						"TX buffer\n",
+						davinci_spi->wcount);
+				return -ENOMEM;
+			}
+		}
+
+		param.opt = TCINTEN | EDMA_TCC(davinci_spi_dma->dma_tx_channel);
+		param.src = t->tx_buf ? t->tx_dma : tx_reg;
+		param.a_b_cnt = davinci_spi->wcount << 16 | data_type;
+		param.dst = tx_reg;
+		param.src_dst_bidx = t->tx_buf ? data_type : 0;
+		param.link_bcntrld = 0xffff;
+		param.src_dst_cidx = 0;
+		param.ccnt = 1;
+		edma_write_slot(davinci_spi_dma->dma_tx_channel, &param);
+		edma_link(davinci_spi_dma->dma_tx_channel,
+				davinci_spi_dma->dummy_param_slot);
+
+		/*
+		 * Receive DMA setup
+		 *
+		 * If there is receive buffer, use it to receive data. If there
+		 * is none provided, use a temporary receive buffer. Set the
+		 * destination B index to 0 so effectively only one byte is used
+		 * in the temporary buffer (address does not increment).
+		 *
+		 * The source of receive data is the receive data register. The
+		 * source address never increments.
+		 */
+
+		if (t->rx_buf) {
+			rx_buf = t->rx_buf;
+			rx_buf_count = davinci_spi->rcount;
+		} else {
+			rx_buf = davinci_spi->rx_tmp_buf;
+			rx_buf_count = sizeof(davinci_spi->rx_tmp_buf);
+		}
+
+		t->rx_dma = dma_map_single(&spi->dev, rx_buf, rx_buf_count,
+							DMA_FROM_DEVICE);
+		if (dma_mapping_error(&spi->dev, t->rx_dma)) {
+			dev_dbg(sdev, "Couldn't DMA map a %d bytes RX buffer\n",
+								rx_buf_count);
+			if (t->tx_buf)
+				dma_unmap_single(NULL, t->tx_dma,
+						davinci_spi->wcount,
+						DMA_TO_DEVICE);
+			return -ENOMEM;
+		}
+
+		param.opt = TCINTEN | EDMA_TCC(davinci_spi_dma->dma_rx_channel);
+		param.src = rx_reg;
+		param.a_b_cnt = davinci_spi->rcount << 16 | data_type;
+		param.dst = t->rx_dma;
+		param.src_dst_bidx = (t->rx_buf ? data_type : 0) << 16;
+		param.link_bcntrld = 0xffff;
+		param.src_dst_cidx = 0;
+		param.ccnt = 1;
+		edma_write_slot(davinci_spi_dma->dma_rx_channel, &param);
+
+		if (pdata->cshold_bug)
+			iowrite16(data1_reg_val >> 16,
+					davinci_spi->base + SPIDAT1 + 2);
+
+		edma_start(davinci_spi_dma->dma_rx_channel);
+		edma_start(davinci_spi_dma->dma_tx_channel);
+		set_io_bits(davinci_spi->base + SPIINT, SPIINT_DMA_REQ_EN);
+	}
 
 	/* Wait for the transfer to complete */
-	if (spicfg->io_type == SPI_IO_TYPE_INTR) {
+	if (spicfg->io_type != SPI_IO_TYPE_POLL) {
 		wait_for_completion_interruptible(&(davinci_spi->done));
 	} else {
 		while (davinci_spi->rcount > 0 || davinci_spi->wcount > 0) {
@@ -560,6 +681,17 @@ static int davinci_spi_bufs_pio(struct spi_device *spi, struct spi_transfer *t)
 	}
 
 	clear_io_bits(davinci_spi->base + SPIINT, SPIINT_MASKALL);
+	if (spicfg->io_type == SPI_IO_TYPE_DMA) {
+
+		if (t->tx_buf)
+			dma_unmap_single(NULL, t->tx_dma, davinci_spi->wcount,
+								DMA_TO_DEVICE);
+
+		dma_unmap_single(NULL, t->rx_dma, rx_buf_count,
+							DMA_FROM_DEVICE);
+
+		clear_io_bits(davinci_spi->base + SPIINT, SPIINT_DMA_REQ_EN);
+	}
 
 	/*
 	 * Check for bit error, desync error,parity error,timeout error and
@@ -572,6 +704,11 @@ static int davinci_spi_bufs_pio(struct spi_device *spi, struct spi_transfer *t)
 		return ret;
 	}
 
+	if (davinci_spi->rcount != 0 || davinci_spi->wcount != 0) {
+		dev_err(sdev, "SPI data transfer error\n");
+		return -EIO;
+	}
+
 	return t->len;
 }
 
@@ -601,174 +738,6 @@ static irqreturn_t davinci_spi_irq(s32 irq, void *context_data)
 	return IRQ_HANDLED;
 }
 
-static void davinci_spi_dma_callback(unsigned lch, u16 status, void *data)
-{
-	struct davinci_spi *davinci_spi = data;
-	struct davinci_spi_dma *davinci_spi_dma = &davinci_spi->dma_channels;
-
-	edma_stop(lch);
-
-	if (status == DMA_COMPLETE) {
-		if (lch == davinci_spi_dma->dma_rx_channel)
-			davinci_spi->rcount = 0;
-		if (lch == davinci_spi_dma->dma_tx_channel)
-			davinci_spi->wcount = 0;
-	}
-
-	if ((!davinci_spi->wcount && !davinci_spi->rcount) ||
-	    (status != DMA_COMPLETE))
-		complete(&davinci_spi->done);
-}
-
-static int davinci_spi_bufs_dma(struct spi_device *spi, struct spi_transfer *t)
-{
-	struct davinci_spi *davinci_spi;
-	int int_status = 0;
-	unsigned rx_buf_count;
-	struct davinci_spi_dma *davinci_spi_dma;
-	int data_type, ret;
-	unsigned long tx_reg, rx_reg;
-	struct davinci_spi_platform_data *pdata;
-	void *rx_buf;
-	struct device *sdev;
-	struct edmacc_param param;
-
-	davinci_spi = spi_master_get_devdata(spi->master);
-	pdata = davinci_spi->pdata;
-	sdev = davinci_spi->bitbang.master->dev.parent;
-
-	davinci_spi_dma = &davinci_spi->dma_channels;
-
-	/* convert len to words based on bits_per_word */
-	data_type = davinci_spi->bytes_per_word[spi->chip_select];
-
-	tx_reg = (unsigned long)davinci_spi->pbase + SPIDAT1;
-	rx_reg = (unsigned long)davinci_spi->pbase + SPIBUF;
-
-	davinci_spi->tx = t->tx_buf;
-	davinci_spi->rx = t->rx_buf;
-	davinci_spi->wcount = t->len / data_type;
-	davinci_spi->rcount = davinci_spi->wcount;
-
-	INIT_COMPLETION(davinci_spi->done);
-
-	/* disable all interrupts for dma transfers */
-	clear_io_bits(davinci_spi->base + SPIINT, SPIINT_MASKALL);
-	/* Enable SPI */
-	set_io_bits(davinci_spi->base + SPIGCR1, SPIGCR1_SPIENA_MASK);
-
-	/*
-	 * Transmit DMA setup
-	 *
-	 * If there is transmit data, map the transmit buffer, set it as the
-	 * source of data and set the source B index to data size.
-	 * If there is no transmit data, set the transmit register as the
-	 * source of data, and set the source B index to zero.
-	 *
-	 * The destination is always the transmit register itself. And the
-	 * destination never increments.
-	 */
-
-	if (t->tx_buf) {
-		t->tx_dma = dma_map_single(&spi->dev, (void *)t->tx_buf,
-					davinci_spi->wcount, DMA_TO_DEVICE);
-		if (dma_mapping_error(&spi->dev, t->tx_dma)) {
-			dev_dbg(sdev, "Unable to DMA map %d bytes TX buffer\n",
-							davinci_spi->wcount);
-			return -ENOMEM;
-		}
-	}
-
-	param.opt = TCINTEN | EDMA_TCC(davinci_spi_dma->dma_tx_channel);
-	param.src = t->tx_buf ? t->tx_dma : tx_reg;
-	param.a_b_cnt = davinci_spi->wcount << 16 | data_type;
-	param.dst = tx_reg;
-	param.src_dst_bidx = t->tx_buf ? data_type : 0;
-	param.link_bcntrld = 0xffff;
-	param.src_dst_cidx = 0;
-	param.ccnt = 1;
-	edma_write_slot(davinci_spi_dma->dma_tx_channel, &param);
-	edma_link(davinci_spi_dma->dma_tx_channel,
-			davinci_spi_dma->dummy_param_slot);
-
-	/*
-	 * Receive DMA setup
-	 *
-	 * If there is receive buffer, use it to receive data. If there
-	 * is none provided, use a temporary receive buffer. Set the
-	 * destination B index to 0 so effectively only one byte is used
-	 * in the temporary buffer (address does not increment).
-	 *
-	 * The source of receive data is the receive data register. The
-	 * source address never increments.
-	 */
-
-	if (t->rx_buf) {
-		rx_buf = t->rx_buf;
-		rx_buf_count = davinci_spi->rcount;
-	} else {
-		rx_buf = davinci_spi->rx_tmp_buf;
-		rx_buf_count = sizeof(davinci_spi->rx_tmp_buf);
-	}
-
-	t->rx_dma = dma_map_single(&spi->dev, rx_buf, rx_buf_count,
-							DMA_FROM_DEVICE);
-	if (dma_mapping_error(&spi->dev, t->rx_dma)) {
-		dev_dbg(sdev, "Couldn't DMA map a %d bytes RX buffer\n",
-								rx_buf_count);
-		if (t->tx_buf)
-			dma_unmap_single(NULL, t->tx_dma, davinci_spi->wcount,
-								DMA_TO_DEVICE);
-		return -ENOMEM;
-	}
-
-	param.opt = TCINTEN | EDMA_TCC(davinci_spi_dma->dma_rx_channel);
-	param.src = rx_reg;
-	param.a_b_cnt = davinci_spi->rcount << 16 | data_type;
-	param.dst = t->rx_dma;
-	param.src_dst_bidx = (t->rx_buf ? data_type : 0) << 16;
-	param.link_bcntrld = 0xffff;
-	param.src_dst_cidx = 0;
-	param.ccnt = 1;
-	edma_write_slot(davinci_spi_dma->dma_rx_channel, &param);
-
-	if (pdata->cshold_bug) {
-		u16 spidat1 = ioread16(davinci_spi->base + SPIDAT1 + 2);
-		iowrite16(spidat1, davinci_spi->base + SPIDAT1 + 2);
-	}
-
-	edma_start(davinci_spi_dma->dma_rx_channel);
-	edma_start(davinci_spi_dma->dma_tx_channel);
-	set_io_bits(davinci_spi->base + SPIINT, SPIINT_DMA_REQ_EN);
-
-	wait_for_completion_interruptible(&davinci_spi->done);
-
-	if (t->tx_buf)
-		dma_unmap_single(NULL, t->tx_dma, davinci_spi->wcount,
-								DMA_TO_DEVICE);
-
-	dma_unmap_single(NULL, t->rx_dma, rx_buf_count, DMA_FROM_DEVICE);
-
-	clear_io_bits(davinci_spi->base + SPIINT, SPIINT_DMA_REQ_EN);
-
-	/*
-	 * Check for bit error, desync error,parity error,timeout error and
-	 * receive overflow errors
-	 */
-	int_status = ioread32(davinci_spi->base + SPIFLG);
-
-	ret = davinci_spi_check_error(davinci_spi, int_status);
-	if (ret != 0)
-		return ret;
-
-	if (davinci_spi->rcount != 0 || davinci_spi->wcount != 0) {
-		dev_err(sdev, "SPI data transfer error\n");
-		return -EIO;
-	}
-
-	return t->len;
-}
-
 static int davinci_spi_request_dma(struct davinci_spi *davinci_spi)
 {
 	int r;
@@ -918,7 +887,7 @@ static int davinci_spi_probe(struct platform_device *pdev)
 	if (r)
 		dma_eventq = r->start;
 
-	davinci_spi->bitbang.txrx_bufs = davinci_spi_bufs_pio;
+	davinci_spi->bitbang.txrx_bufs = davinci_spi_bufs;
 	if (dma_rx_chan != SPI_NO_RESOURCE &&
 	    dma_tx_chan != SPI_NO_RESOURCE &&
 	    dma_eventq != SPI_NO_RESOURCE) {
@@ -930,10 +899,9 @@ static int davinci_spi_probe(struct platform_device *pdev)
 		if (ret)
 			goto free_clk;
 
-		davinci_spi->bitbang.txrx_bufs = davinci_spi_bufs_dma;
-		dev_info(&pdev->dev, "DaVinci SPI driver in EDMA mode\n"
-				"Using RX channel = %d , TX channel = %d and "
-				"event queue = %d", dma_rx_chan, dma_tx_chan,
+		dev_info(&pdev->dev, "DMA: supported\n");
+		dev_info(&pdev->dev, "DMA: RX channel: %d, TX channel: %d, "
+				"event queue: %d\n", dma_rx_chan, dma_tx_chan,
 				dma_eventq);
 	}
 
-- 
1.7.3.2

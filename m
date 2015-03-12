From: <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
Subject: [PATCHv5] spi: dw-spi: Convert 16bit accesses to 32bit accesses
Date: Thu, 12 Mar 2015 14:19:31 -0500
Message-ID: <1426187971-8794-2-git-send-email-tthayer@opensource.altera.com>
References: <1426187971-8794-1-git-send-email-tthayer@opensource.altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <jkosina-AlSwsSmVLrQ@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>, <tthayer.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	<axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>, <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>,
	<andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	<galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	<swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, <hartleys-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>,
	<wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, <s.trumtrar-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	<Julia.Lawall-L2FTfq7BK8M@public.gmane.org>
To: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	<dinguyen-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1426187971-8794-1-git-send-email-tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Thor Thayer <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>

Altera's Arria10 SoC interconnect requires a 32-bit write for APB
peripherals. The current spi-dw driver uses 16-bit accesses in
some locations. This patch converts all the 16-bit reads and
writes to 32-bit reads and writes.

Additional Documentation to Support this Change:
The DW_apb_ssi databook states:
"All registers in the DW_apb_ssi are addressed at 32-bit boundaries
to remain consistent with the AHB bus. Where the physical size of
any register is less than 32-bits wide, the upper unused bits of
the 32-bit boundary are reserved. Writing to these bits has no
effect; reading from these bits returns 0." [1]

[1] Section 6.1 of dw_apb_ssi.pdf (version 3.22a)

Request for test with platforms using the DesignWare SPI IP.

Tested On:
Altera CycloneV development kit
Altera Arria10 development kit
Compile tested for build errors on x86_64 (allyesconfigs)

Signed-off-by: Thor Thayer <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
Reviewed-and-tested-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
r1: Use function pointers to select 16b or 32b accesses.

r2: Use 32b version of function pointers for 16b reads and
writes.

r3: Instead of function pointer solution, convert 16b reads
and writes to 32b reads and writes.

r4: Leave existing 16-bit types alone. Only change functions.

r5: Change functions to 32-bit in spi-dw-mid.c.
---
 drivers/spi/spi-dw-mid.c |   10 +++++-----
 drivers/spi/spi-dw.c     |   24 ++++++++++++------------
 drivers/spi/spi-dw.h     |   10 ----------
 3 files changed, 17 insertions(+), 27 deletions(-)

diff --git a/drivers/spi/spi-dw-mid.c b/drivers/spi/spi-dw-mid.c
index d4109f6..bb1052e 100644
--- a/drivers/spi/spi-dw-mid.c
+++ b/drivers/spi/spi-dw-mid.c
@@ -98,12 +98,12 @@ static void mid_spi_dma_exit(struct dw_spi *dws)
 
 static irqreturn_t dma_transfer(struct dw_spi *dws)
 {
-	u16 irq_status = dw_readw(dws, DW_SPI_ISR);
+	u16 irq_status = dw_readl(dws, DW_SPI_ISR);
 
 	if (!irq_status)
 		return IRQ_NONE;
 
-	dw_readw(dws, DW_SPI_ICR);
+	dw_readl(dws, DW_SPI_ICR);
 	spi_reset_chip(dws);
 
 	dev_err(&dws->master->dev, "%s: FIFO overrun/underrun\n", __func__);
@@ -228,14 +228,14 @@ static int mid_spi_dma_setup(struct dw_spi *dws, struct spi_transfer *xfer)
 {
 	u16 dma_ctrl = 0;
 
-	dw_writew(dws, DW_SPI_DMARDLR, 0xf);
-	dw_writew(dws, DW_SPI_DMATDLR, 0x10);
+	dw_writel(dws, DW_SPI_DMARDLR, 0xf);
+	dw_writel(dws, DW_SPI_DMATDLR, 0x10);
 
 	if (xfer->tx_buf)
 		dma_ctrl |= SPI_DMA_TDMAE;
 	if (xfer->rx_buf)
 		dma_ctrl |= SPI_DMA_RDMAE;
-	dw_writew(dws, DW_SPI_DMACR, dma_ctrl);
+	dw_writel(dws, DW_SPI_DMACR, dma_ctrl);
 
 	/* Set the interrupt mask */
 	spi_umask_intr(dws, SPI_INT_TXOI | SPI_INT_RXUI | SPI_INT_RXOI);
diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index 0f01069..cafac22 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -157,7 +157,7 @@ static inline u32 tx_max(struct dw_spi *dws)
 	u32 tx_left, tx_room, rxtx_gap;
 
 	tx_left = (dws->tx_end - dws->tx) / dws->n_bytes;
-	tx_room = dws->fifo_len - dw_readw(dws, DW_SPI_TXFLR);
+	tx_room = dws->fifo_len - dw_readl(dws, DW_SPI_TXFLR);
 
 	/*
 	 * Another concern is about the tx/rx mismatch, we
@@ -178,7 +178,7 @@ static inline u32 rx_max(struct dw_spi *dws)
 {
 	u32 rx_left = (dws->rx_end - dws->rx) / dws->n_bytes;
 
-	return min_t(u32, rx_left, dw_readw(dws, DW_SPI_RXFLR));
+	return min_t(u32, rx_left, dw_readl(dws, DW_SPI_RXFLR));
 }
 
 static void dw_writer(struct dw_spi *dws)
@@ -194,7 +194,7 @@ static void dw_writer(struct dw_spi *dws)
 			else
 				txw = *(u16 *)(dws->tx);
 		}
-		dw_writew(dws, DW_SPI_DR, txw);
+		dw_writel(dws, DW_SPI_DR, txw);
 		dws->tx += dws->n_bytes;
 	}
 }
@@ -205,7 +205,7 @@ static void dw_reader(struct dw_spi *dws)
 	u16 rxw;
 
 	while (max--) {
-		rxw = dw_readw(dws, DW_SPI_DR);
+		rxw = dw_readl(dws, DW_SPI_DR);
 		/* Care rx only if the transfer's original "rx" is not null */
 		if (dws->rx_end - dws->len) {
 			if (dws->n_bytes == 1)
@@ -228,11 +228,11 @@ static void int_error_stop(struct dw_spi *dws, const char *msg)
 
 static irqreturn_t interrupt_transfer(struct dw_spi *dws)
 {
-	u16 irq_status = dw_readw(dws, DW_SPI_ISR);
+	u16 irq_status = dw_readl(dws, DW_SPI_ISR);
 
 	/* Error handling */
 	if (irq_status & (SPI_INT_TXOI | SPI_INT_RXOI | SPI_INT_RXUI)) {
-		dw_readw(dws, DW_SPI_ICR);
+		dw_readl(dws, DW_SPI_ICR);
 		int_error_stop(dws, "interrupt_transfer: fifo overrun/underrun");
 		return IRQ_HANDLED;
 	}
@@ -257,7 +257,7 @@ static irqreturn_t dw_spi_irq(int irq, void *dev_id)
 {
 	struct spi_master *master = dev_id;
 	struct dw_spi *dws = spi_master_get_devdata(master);
-	u16 irq_status = dw_readw(dws, DW_SPI_ISR) & 0x3f;
+	u16 irq_status = dw_readl(dws, DW_SPI_ISR) & 0x3f;
 
 	if (!irq_status)
 		return IRQ_NONE;
@@ -354,7 +354,7 @@ static int dw_spi_transfer_one(struct spi_master *master,
 		cr0 |= (chip->tmode << SPI_TMOD_OFFSET);
 	}
 
-	dw_writew(dws, DW_SPI_CTRL0, cr0);
+	dw_writel(dws, DW_SPI_CTRL0, cr0);
 
 	/* Check if current transfer is a DMA transaction */
 	if (master->can_dma && master->can_dma(master, spi, transfer))
@@ -375,7 +375,7 @@ static int dw_spi_transfer_one(struct spi_master *master,
 		}
 	} else if (!chip->poll_mode) {
 		txlevel = min_t(u16, dws->fifo_len / 2, dws->len / dws->n_bytes);
-		dw_writew(dws, DW_SPI_TXFLTR, txlevel);
+		dw_writel(dws, DW_SPI_TXFLTR, txlevel);
 
 		/* Set the interrupt mask */
 		imask |= SPI_INT_TXEI | SPI_INT_TXOI |
@@ -499,11 +499,11 @@ static void spi_hw_init(struct device *dev, struct dw_spi *dws)
 		u32 fifo;
 
 		for (fifo = 1; fifo < 256; fifo++) {
-			dw_writew(dws, DW_SPI_TXFLTR, fifo);
-			if (fifo != dw_readw(dws, DW_SPI_TXFLTR))
+			dw_writel(dws, DW_SPI_TXFLTR, fifo);
+			if (fifo != dw_readl(dws, DW_SPI_TXFLTR))
 				break;
 		}
-		dw_writew(dws, DW_SPI_TXFLTR, 0);
+		dw_writel(dws, DW_SPI_TXFLTR, 0);
 
 		dws->fifo_len = (fifo == 1) ? 0 : fifo;
 		dev_dbg(dev, "Detected FIFO size: %u bytes\n", dws->fifo_len);
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index 41f77e2..6c91391 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -150,16 +150,6 @@ static inline void dw_writel(struct dw_spi *dws, u32 offset, u32 val)
 	__raw_writel(val, dws->regs + offset);
 }
 
-static inline u16 dw_readw(struct dw_spi *dws, u32 offset)
-{
-	return __raw_readw(dws->regs + offset);
-}
-
-static inline void dw_writew(struct dw_spi *dws, u32 offset, u16 val)
-{
-	__raw_writew(val, dws->regs + offset);
-}
-
 static inline void spi_enable_chip(struct dw_spi *dws, int enable)
 {
 	dw_writel(dws, DW_SPI_SSIENR, (enable ? 1 : 0));
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

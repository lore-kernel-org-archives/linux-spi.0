From: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 3/3] spi: dw_spi: refine the IRQ mode
	working flow
Date: Tue, 19 Jan 2010 11:20:33 +0800
Message-ID: <20100119112033.74a0f5be@feng-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spi-devel-list <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, David Brownell
	<dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

>From e1a3ba6f5605e7d0ae568b3d747b5ff03f7e202c Mon Sep 17 00:00:00 2001
From: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Date: Tue, 19 Jan 2010 10:22:45 +0800
Subject: [PATCH 3/3] spi: dw_spi: refine the IRQ mode working flow

Now dw_spi core fully supports 3 transfer modes: pure polling,
DMA and IRQ mode. IRQ mode will use the FIFO half empty as
the IRQ trigger, so each interface driver need set the fifo_len,
so that core driver can handle it properly

Signed-off-by: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/dw_spi.c       |   64 ++++++++++++++++++++++++++-----------------
 drivers/spi/dw_spi_pci.c   |    1 +
 include/linux/spi/dw_spi.h |    1 +
 3 files changed, 41 insertions(+), 25 deletions(-)

diff --git a/drivers/spi/dw_spi.c b/drivers/spi/dw_spi.c
index 521d680..1bb709b 100644
--- a/drivers/spi/dw_spi.c
+++ b/drivers/spi/dw_spi.c
@@ -358,6 +358,8 @@ static void transfer_complete(struct dw_spi *dws)
 static irqreturn_t interrupt_transfer(struct dw_spi *dws)
 {
 	u16 irq_status, irq_mask = 0x3f;
+	u32 int_level = dws->fifo_len / 2;
+	u32 left;
 
 	irq_status = dw_readw(dws, isr) & irq_mask;
 	/* Error handling */
@@ -369,22 +371,23 @@ static irqreturn_t interrupt_transfer(struct dw_spi *dws)
 		return IRQ_HANDLED;
 	}
 
-	/* INT comes from tx */
-	if (dws->tx && (irq_status & SPI_INT_TXEI)) {
-		while (dws->tx < dws->tx_end)
+	if (irq_status & SPI_INT_TXEI) {
+		spi_mask_intr(dws, SPI_INT_TXEI);
+
+		left = (dws->tx_end - dws->tx) / dws->n_bytes;
+		left = (left > int_level) ? int_level : left;
+
+		while (left--)
 			dws->write(dws);
+		dws->read(dws);
 
-		if (dws->tx == dws->tx_end) {
-			spi_mask_intr(dws, SPI_INT_TXEI);
+		/* Re-enable the IRQ if there is still data left to tx */
+		if (dws->tx_end > dws->tx)
+			spi_umask_intr(dws, SPI_INT_TXEI);
+		else
 			transfer_complete(dws);
-		}
 	}
 
-	/* INT comes from rx */
-	if (dws->rx && (irq_status & SPI_INT_RXFI)) {
-		if (dws->read(dws))
-			transfer_complete(dws);
-	}
 	return IRQ_HANDLED;
 }
 
@@ -428,6 +431,7 @@ static void pump_transfers(unsigned long data)
 	u8 bits = 0;
 	u8 imask = 0;
 	u8 cs_change = 0;
+	u16 txint_level = 0;
 	u16 clk_div = 0;
 	u32 speed = 0;
 	u32 cr0 = 0;
@@ -438,6 +442,9 @@ static void pump_transfers(unsigned long data)
 	chip = dws->cur_chip;
 	spi = message->spi;
 
+	if (unlikely(!chip->clk_div))
+		chip->clk_div = dws->max_freq / chip->speed_hz;
+
 	if (message->state == ERROR_STATE) {
 		message->status = -EIO;
 		goto early_exit;
@@ -492,7 +499,7 @@ static void pump_transfers(unsigned long data)
 
 			/* clk_div doesn't support odd number */
 			clk_div = dws->max_freq / speed;
-			clk_div = (clk_div >> 1) << 1;
+			clk_div = (clk_div + 1) & 0xfffe;
 
 			chip->speed_hz = speed;
 			chip->clk_div = clk_div;
@@ -535,11 +542,16 @@ static void pump_transfers(unsigned long data)
 	/* Check if current transfer is a DMA transaction */
 	dws->dma_mapped = map_dma_buffers(dws);
 
+	/*
+	 * Interrupt mode
+	 * we only need set the TXEI IRQ, as TX/RX always happen syncronizely
+	 */
 	if (!dws->dma_mapped && !chip->poll_mode) {
-		if (dws->rx)
-			imask |= SPI_INT_RXFI;
-		if (dws->tx)
-			imask |= SPI_INT_TXEI;
+		int templen = dws->len / dws->n_bytes;
+		txint_level = dws->fifo_len / 2;
+		txint_level = (templen > txint_level) ? txint_level : templen;
+
+		imask |= SPI_INT_TXEI;
 		dws->transfer_handler = interrupt_transfer;
 	}
 
@@ -549,21 +561,23 @@ static void pump_transfers(unsigned long data)
 	 *	2. clk_div is changed
 	 *	3. control value changes
 	 */
-	if (dw_readw(dws, ctrl0) != cr0 || cs_change || clk_div) {
+	if (dw_readw(dws, ctrl0) != cr0 || cs_change || clk_div || imask) {
 		spi_enable_chip(dws, 0);
 
 		if (dw_readw(dws, ctrl0) != cr0)
 			dw_writew(dws, ctrl0, cr0);
 
+		spi_set_clk(dws, clk_div ? clk_div : chip->clk_div);
+		spi_chip_sel(dws, spi->chip_select);
+
 		/* Set the interrupt mask, for poll mode just diable all int */
 		spi_mask_intr(dws, 0xff);
-		if (!chip->poll_mode)
+		if (imask)
 			spi_umask_intr(dws, imask);
+		if (txint_level)
+			dw_writew(dws, txfltr, txint_level);
 
-		spi_set_clk(dws, clk_div ? clk_div : chip->clk_div);
-		spi_chip_sel(dws, spi->chip_select);
 		spi_enable_chip(dws, 1);
-
 		if (cs_change)
 			dws->prev_chip = chip;
 	}
@@ -712,11 +726,11 @@ static int dw_spi_setup(struct spi_device *spi)
 	}
 	chip->bits_per_word = spi->bits_per_word;
 
+	if (!spi->max_speed_hz) {
+		dev_err(&spi->dev, "No max speed HZ parameter\n");
+		return -EINVAL;
+	}
 	chip->speed_hz = spi->max_speed_hz;
-	if (chip->speed_hz)
-		chip->clk_div = 25000000 / chip->speed_hz;
-	else
-		chip->clk_div = 8;	/* default value */
 
 	chip->tmode = 0; /* Tx & Rx */
 	/* Default SPI mode is SCPOL = 0, SCPH = 0 */
diff --git a/drivers/spi/dw_spi_pci.c b/drivers/spi/dw_spi_pci.c
index 7980f14..1f0735f 100644
--- a/drivers/spi/dw_spi_pci.c
+++ b/drivers/spi/dw_spi_pci.c
@@ -73,6 +73,7 @@ static int __devinit spi_pci_probe(struct pci_dev *pdev,
 	dws->num_cs = 4;
 	dws->max_freq = 25000000;	/* for Moorestwon */
 	dws->irq = pdev->irq;
+	dws->fifo_len = 40;		/* FIFO has 40 words buffer */
 
 	ret = dw_spi_add_host(dws);
 	if (ret)
diff --git a/include/linux/spi/dw_spi.h b/include/linux/spi/dw_spi.h
index 51b3e77..1a127a3 100644
--- a/include/linux/spi/dw_spi.h
+++ b/include/linux/spi/dw_spi.h
@@ -90,6 +90,7 @@ struct dw_spi {
 	unsigned long		paddr;
 	u32			iolen;
 	int			irq;
+	u32			fifo_len;	/* depth of the FIFO buffer */
 	u32			max_freq;	/* max bus freq supported */
 
 	u16			bus_num;
-- 
1.6.0.4

------------------------------------------------------------------------------
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Conference
attendees to learn about information security's most important issues through
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev

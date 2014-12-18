From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 5/5] spi: pxa2xx: Cleanup register access macros
Date: Thu, 18 Dec 2014 15:04:23 +0200
Message-ID: <1418907863-11116-5-git-send-email-jarkko.nikula@linux.intel.com>
References: <1418907863-11116-1-git-send-email-jarkko.nikula@linux.intel.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1418907863-11116-1-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Currently SSP registers are accessed by having an own read and write macros
for each register. For instance read_SSSR(iobase) and write_SSSR(iobase).

In my opinion this hurts readability and requires new macros to be defined
for each new added register. Let's define and use instead common
pxa2xx_spi_read() and pxa2xx_spi_write() accessors.

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-pxa2xx-dma.c    |  17 ++--
 drivers/spi/spi-pxa2xx-pxadma.c |  25 +++---
 drivers/spi/spi-pxa2xx.c        | 183 ++++++++++++++++++----------------------
 drivers/spi/spi-pxa2xx.h        |  34 +++-----
 4 files changed, 117 insertions(+), 142 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx-dma.c b/drivers/spi/spi-pxa2xx-dma.c
index 62a9297e96ac..66a173939be8 100644
--- a/drivers/spi/spi-pxa2xx-dma.c
+++ b/drivers/spi/spi-pxa2xx-dma.c
@@ -111,23 +111,24 @@ static void pxa2xx_spi_dma_transfer_complete(struct driver_data *drv_data,
 	 * by using ->dma_running.
 	 */
 	if (atomic_dec_and_test(&drv_data->dma_running)) {
-		void __iomem *reg = drv_data->ioaddr;
-
 		/*
 		 * If the other CPU is still handling the ROR interrupt we
 		 * might not know about the error yet. So we re-check the
 		 * ROR bit here before we clear the status register.
 		 */
 		if (!error) {
-			u32 status = read_SSSR(reg) & drv_data->mask_sr;
+			u32 status = pxa2xx_spi_read(drv_data, SSSR)
+				     & drv_data->mask_sr;
 			error = status & SSSR_ROR;
 		}
 
 		/* Clear status & disable interrupts */
-		write_SSCR1(read_SSCR1(reg) & ~drv_data->dma_cr1, reg);
+		pxa2xx_spi_write(drv_data, SSCR1,
+				 pxa2xx_spi_read(drv_data, SSCR1)
+				 & ~drv_data->dma_cr1);
 		write_SSSR_CS(drv_data, drv_data->clear_sr);
 		if (!pxa25x_ssp_comp(drv_data))
-			write_SSTO(0, reg);
+			pxa2xx_spi_write(drv_data, SSTO, 0);
 
 		if (!error) {
 			pxa2xx_spi_unmap_dma_buffers(drv_data);
@@ -139,7 +140,9 @@ static void pxa2xx_spi_dma_transfer_complete(struct driver_data *drv_data,
 			msg->state = pxa2xx_spi_next_transfer(drv_data);
 		} else {
 			/* In case we got an error we disable the SSP now */
-			write_SSCR0(read_SSCR0(reg) & ~SSCR0_SSE, reg);
+			pxa2xx_spi_write(drv_data, SSCR0,
+					 pxa2xx_spi_read(drv_data, SSCR0)
+					 & ~SSCR0_SSE);
 
 			msg->state = ERROR_STATE;
 		}
@@ -247,7 +250,7 @@ irqreturn_t pxa2xx_spi_dma_transfer(struct driver_data *drv_data)
 {
 	u32 status;
 
-	status = read_SSSR(drv_data->ioaddr) & drv_data->mask_sr;
+	status = pxa2xx_spi_read(drv_data, SSSR) & drv_data->mask_sr;
 	if (status & SSSR_ROR) {
 		dev_err(&drv_data->pdev->dev, "FIFO overrun\n");
 
diff --git a/drivers/spi/spi-pxa2xx-pxadma.c b/drivers/spi/spi-pxa2xx-pxadma.c
index aaa5fc6b465e..6c82d496b58e 100644
--- a/drivers/spi/spi-pxa2xx-pxadma.c
+++ b/drivers/spi/spi-pxa2xx-pxadma.c
@@ -122,7 +122,7 @@ static int wait_ssp_rx_stall(struct driver_data *drv_data)
 {
 	unsigned long limit = loops_per_jiffy << 1;
 
-	while ((read_SSSR(drv_data->ioaddr) & SSSR_BSY) && --limit)
+	while ((pxa2xx_spi_read(drv_data, SSSR) & SSSR_BSY) && --limit)
 		cpu_relax();
 
 	return limit;
@@ -141,17 +141,18 @@ static int wait_dma_channel_stop(int channel)
 static void pxa2xx_spi_dma_error_stop(struct driver_data *drv_data,
 				      const char *msg)
 {
-	void __iomem *reg = drv_data->ioaddr;
-
 	/* Stop and reset */
 	DCSR(drv_data->rx_channel) = RESET_DMA_CHANNEL;
 	DCSR(drv_data->tx_channel) = RESET_DMA_CHANNEL;
 	write_SSSR_CS(drv_data, drv_data->clear_sr);
-	write_SSCR1(read_SSCR1(reg) & ~drv_data->dma_cr1, reg);
+	pxa2xx_spi_write(drv_data, SSCR1,
+			 pxa2xx_spi_read(drv_data, SSCR1)
+			 & ~drv_data->dma_cr1);
 	if (!pxa25x_ssp_comp(drv_data))
-		write_SSTO(0, reg);
+		pxa2xx_spi_write(drv_data, SSTO, 0);
 	pxa2xx_spi_flush(drv_data);
-	write_SSCR0(read_SSCR0(reg) & ~SSCR0_SSE, reg);
+	pxa2xx_spi_write(drv_data, SSCR0,
+			 pxa2xx_spi_read(drv_data, SSCR0) & ~SSCR0_SSE);
 
 	pxa2xx_spi_unmap_dma_buffers(drv_data);
 
@@ -163,11 +164,12 @@ static void pxa2xx_spi_dma_error_stop(struct driver_data *drv_data,
 
 static void pxa2xx_spi_dma_transfer_complete(struct driver_data *drv_data)
 {
-	void __iomem *reg = drv_data->ioaddr;
 	struct spi_message *msg = drv_data->cur_msg;
 
 	/* Clear and disable interrupts on SSP and DMA channels*/
-	write_SSCR1(read_SSCR1(reg) & ~drv_data->dma_cr1, reg);
+	pxa2xx_spi_write(drv_data, SSCR1,
+			 pxa2xx_spi_read(drv_data, SSCR1)
+			 & ~drv_data->dma_cr1);
 	write_SSSR_CS(drv_data, drv_data->clear_sr);
 	DCSR(drv_data->tx_channel) = RESET_DMA_CHANNEL;
 	DCSR(drv_data->rx_channel) = RESET_DMA_CHANNEL;
@@ -240,9 +242,8 @@ void pxa2xx_spi_dma_handler(int channel, void *data)
 irqreturn_t pxa2xx_spi_dma_transfer(struct driver_data *drv_data)
 {
 	u32 irq_status;
-	void __iomem *reg = drv_data->ioaddr;
 
-	irq_status = read_SSSR(reg) & drv_data->mask_sr;
+	irq_status = pxa2xx_spi_read(drv_data, SSSR) & drv_data->mask_sr;
 	if (irq_status & SSSR_ROR) {
 		pxa2xx_spi_dma_error_stop(drv_data,
 					  "dma_transfer: fifo overrun");
@@ -252,7 +253,7 @@ irqreturn_t pxa2xx_spi_dma_transfer(struct driver_data *drv_data)
 	/* Check for false positive timeout */
 	if ((irq_status & SSSR_TINT)
 		&& (DCSR(drv_data->tx_channel) & DCSR_RUN)) {
-		write_SSSR(SSSR_TINT, reg);
+		pxa2xx_spi_write(drv_data, SSSR, SSSR_TINT);
 		return IRQ_HANDLED;
 	}
 
@@ -261,7 +262,7 @@ irqreturn_t pxa2xx_spi_dma_transfer(struct driver_data *drv_data)
 		/* Clear and disable timeout interrupt, do the rest in
 		 * dma_transfer_complete */
 		if (!pxa25x_ssp_comp(drv_data))
-			write_SSTO(0, reg);
+			pxa2xx_spi_write(drv_data, SSTO, 0);
 
 		/* finish this transfer, start the next */
 		pxa2xx_spi_dma_transfer_complete(drv_data);
diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 3e4ab91df649..abbacccb45e2 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -160,7 +160,6 @@ pxa2xx_spi_get_rx_default_thre(const struct driver_data *drv_data)
 
 static bool pxa2xx_spi_txfifo_full(const struct driver_data *drv_data)
 {
-	void __iomem *reg = drv_data->ioaddr;
 	u32 mask;
 
 	switch (drv_data->ssp_type) {
@@ -172,7 +171,7 @@ static bool pxa2xx_spi_txfifo_full(const struct driver_data *drv_data)
 		break;
 	}
 
-	return (read_SSSR(reg) & mask) == mask;
+	return (pxa2xx_spi_read(drv_data, SSSR) & mask) == mask;
 }
 
 static void pxa2xx_spi_clear_rx_thre(const struct driver_data *drv_data,
@@ -312,7 +311,7 @@ static void cs_assert(struct driver_data *drv_data)
 	struct chip_data *chip = drv_data->cur_chip;
 
 	if (drv_data->ssp_type == CE4100_SSP) {
-		write_SSSR(drv_data->cur_chip->frm, drv_data->ioaddr);
+		pxa2xx_spi_write(drv_data, SSSR, drv_data->cur_chip->frm);
 		return;
 	}
 
@@ -355,13 +354,10 @@ int pxa2xx_spi_flush(struct driver_data *drv_data)
 {
 	unsigned long limit = loops_per_jiffy << 1;
 
-	void __iomem *reg = drv_data->ioaddr;
-
 	do {
-		while (read_SSSR(reg) & SSSR_RNE) {
-			read_SSDR(reg);
-		}
-	} while ((read_SSSR(reg) & SSSR_BSY) && --limit);
+		while (pxa2xx_spi_read(drv_data, SSSR) & SSSR_RNE)
+			pxa2xx_spi_read(drv_data, SSDR);
+	} while ((pxa2xx_spi_read(drv_data, SSSR) & SSSR_BSY) && --limit);
 	write_SSSR_CS(drv_data, SSSR_ROR);
 
 	return limit;
@@ -369,14 +365,13 @@ int pxa2xx_spi_flush(struct driver_data *drv_data)
 
 static int null_writer(struct driver_data *drv_data)
 {
-	void __iomem *reg = drv_data->ioaddr;
 	u8 n_bytes = drv_data->n_bytes;
 
 	if (pxa2xx_spi_txfifo_full(drv_data)
 		|| (drv_data->tx == drv_data->tx_end))
 		return 0;
 
-	write_SSDR(0, reg);
+	pxa2xx_spi_write(drv_data, SSDR, 0);
 	drv_data->tx += n_bytes;
 
 	return 1;
@@ -384,12 +379,11 @@ static int null_writer(struct driver_data *drv_data)
 
 static int null_reader(struct driver_data *drv_data)
 {
-	void __iomem *reg = drv_data->ioaddr;
 	u8 n_bytes = drv_data->n_bytes;
 
-	while ((read_SSSR(reg) & SSSR_RNE)
-		&& (drv_data->rx < drv_data->rx_end)) {
-		read_SSDR(reg);
+	while ((pxa2xx_spi_read(drv_data, SSSR) & SSSR_RNE)
+	       && (drv_data->rx < drv_data->rx_end)) {
+		pxa2xx_spi_read(drv_data, SSDR);
 		drv_data->rx += n_bytes;
 	}
 
@@ -398,13 +392,11 @@ static int null_reader(struct driver_data *drv_data)
 
 static int u8_writer(struct driver_data *drv_data)
 {
-	void __iomem *reg = drv_data->ioaddr;
-
 	if (pxa2xx_spi_txfifo_full(drv_data)
 		|| (drv_data->tx == drv_data->tx_end))
 		return 0;
 
-	write_SSDR(*(u8 *)(drv_data->tx), reg);
+	pxa2xx_spi_write(drv_data, SSDR, *(u8 *)(drv_data->tx));
 	++drv_data->tx;
 
 	return 1;
@@ -412,11 +404,9 @@ static int u8_writer(struct driver_data *drv_data)
 
 static int u8_reader(struct driver_data *drv_data)
 {
-	void __iomem *reg = drv_data->ioaddr;
-
-	while ((read_SSSR(reg) & SSSR_RNE)
-		&& (drv_data->rx < drv_data->rx_end)) {
-		*(u8 *)(drv_data->rx) = read_SSDR(reg);
+	while ((pxa2xx_spi_read(drv_data, SSSR) & SSSR_RNE)
+	       && (drv_data->rx < drv_data->rx_end)) {
+		*(u8 *)(drv_data->rx) = pxa2xx_spi_read(drv_data, SSDR);
 		++drv_data->rx;
 	}
 
@@ -425,13 +415,11 @@ static int u8_reader(struct driver_data *drv_data)
 
 static int u16_writer(struct driver_data *drv_data)
 {
-	void __iomem *reg = drv_data->ioaddr;
-
 	if (pxa2xx_spi_txfifo_full(drv_data)
 		|| (drv_data->tx == drv_data->tx_end))
 		return 0;
 
-	write_SSDR(*(u16 *)(drv_data->tx), reg);
+	pxa2xx_spi_write(drv_data, SSDR, *(u16 *)(drv_data->tx));
 	drv_data->tx += 2;
 
 	return 1;
@@ -439,11 +427,9 @@ static int u16_writer(struct driver_data *drv_data)
 
 static int u16_reader(struct driver_data *drv_data)
 {
-	void __iomem *reg = drv_data->ioaddr;
-
-	while ((read_SSSR(reg) & SSSR_RNE)
-		&& (drv_data->rx < drv_data->rx_end)) {
-		*(u16 *)(drv_data->rx) = read_SSDR(reg);
+	while ((pxa2xx_spi_read(drv_data, SSSR) & SSSR_RNE)
+	       && (drv_data->rx < drv_data->rx_end)) {
+		*(u16 *)(drv_data->rx) = pxa2xx_spi_read(drv_data, SSDR);
 		drv_data->rx += 2;
 	}
 
@@ -452,13 +438,11 @@ static int u16_reader(struct driver_data *drv_data)
 
 static int u32_writer(struct driver_data *drv_data)
 {
-	void __iomem *reg = drv_data->ioaddr;
-
 	if (pxa2xx_spi_txfifo_full(drv_data)
 		|| (drv_data->tx == drv_data->tx_end))
 		return 0;
 
-	write_SSDR(*(u32 *)(drv_data->tx), reg);
+	pxa2xx_spi_write(drv_data, SSDR, *(u32 *)(drv_data->tx));
 	drv_data->tx += 4;
 
 	return 1;
@@ -466,11 +450,9 @@ static int u32_writer(struct driver_data *drv_data)
 
 static int u32_reader(struct driver_data *drv_data)
 {
-	void __iomem *reg = drv_data->ioaddr;
-
-	while ((read_SSSR(reg) & SSSR_RNE)
-		&& (drv_data->rx < drv_data->rx_end)) {
-		*(u32 *)(drv_data->rx) = read_SSDR(reg);
+	while ((pxa2xx_spi_read(drv_data, SSSR) & SSSR_RNE)
+	       && (drv_data->rx < drv_data->rx_end)) {
+		*(u32 *)(drv_data->rx) = pxa2xx_spi_read(drv_data, SSDR);
 		drv_data->rx += 4;
 	}
 
@@ -546,27 +528,25 @@ static void giveback(struct driver_data *drv_data)
 
 static void reset_sccr1(struct driver_data *drv_data)
 {
-	void __iomem *reg = drv_data->ioaddr;
 	struct chip_data *chip = drv_data->cur_chip;
 	u32 sccr1_reg;
 
-	sccr1_reg = read_SSCR1(reg) & ~drv_data->int_cr1;
+	sccr1_reg = pxa2xx_spi_read(drv_data, SSCR1) & ~drv_data->int_cr1;
 	sccr1_reg &= ~SSCR1_RFT;
 	sccr1_reg |= chip->threshold;
-	write_SSCR1(sccr1_reg, reg);
+	pxa2xx_spi_write(drv_data, SSCR1, sccr1_reg);
 }
 
 static void int_error_stop(struct driver_data *drv_data, const char* msg)
 {
-	void __iomem *reg = drv_data->ioaddr;
-
 	/* Stop and reset SSP */
 	write_SSSR_CS(drv_data, drv_data->clear_sr);
 	reset_sccr1(drv_data);
 	if (!pxa25x_ssp_comp(drv_data))
-		write_SSTO(0, reg);
+		pxa2xx_spi_write(drv_data, SSTO, 0);
 	pxa2xx_spi_flush(drv_data);
-	write_SSCR0(read_SSCR0(reg) & ~SSCR0_SSE, reg);
+	pxa2xx_spi_write(drv_data, SSCR0,
+			 pxa2xx_spi_read(drv_data, SSCR0) & ~SSCR0_SSE);
 
 	dev_err(&drv_data->pdev->dev, "%s\n", msg);
 
@@ -576,13 +556,11 @@ static void int_error_stop(struct driver_data *drv_data, const char* msg)
 
 static void int_transfer_complete(struct driver_data *drv_data)
 {
-	void __iomem *reg = drv_data->ioaddr;
-
 	/* Stop SSP */
 	write_SSSR_CS(drv_data, drv_data->clear_sr);
 	reset_sccr1(drv_data);
 	if (!pxa25x_ssp_comp(drv_data))
-		write_SSTO(0, reg);
+		pxa2xx_spi_write(drv_data, SSTO, 0);
 
 	/* Update total byte transferred return count actual bytes read */
 	drv_data->cur_msg->actual_length += drv_data->len -
@@ -601,12 +579,10 @@ static void int_transfer_complete(struct driver_data *drv_data)
 
 static irqreturn_t interrupt_transfer(struct driver_data *drv_data)
 {
-	void __iomem *reg = drv_data->ioaddr;
-
-	u32 irq_mask = (read_SSCR1(reg) & SSCR1_TIE) ?
-			drv_data->mask_sr : drv_data->mask_sr & ~SSSR_TFS;
+	u32 irq_mask = (pxa2xx_spi_read(drv_data, SSCR1) & SSCR1_TIE) ?
+		       drv_data->mask_sr : drv_data->mask_sr & ~SSSR_TFS;
 
-	u32 irq_status = read_SSSR(reg) & irq_mask;
+	u32 irq_status = pxa2xx_spi_read(drv_data, SSSR) & irq_mask;
 
 	if (irq_status & SSSR_ROR) {
 		int_error_stop(drv_data, "interrupt_transfer: fifo overrun");
@@ -614,7 +590,7 @@ static irqreturn_t interrupt_transfer(struct driver_data *drv_data)
 	}
 
 	if (irq_status & SSSR_TINT) {
-		write_SSSR(SSSR_TINT, reg);
+		pxa2xx_spi_write(drv_data, SSSR, SSSR_TINT);
 		if (drv_data->read(drv_data)) {
 			int_transfer_complete(drv_data);
 			return IRQ_HANDLED;
@@ -638,7 +614,7 @@ static irqreturn_t interrupt_transfer(struct driver_data *drv_data)
 		u32 bytes_left;
 		u32 sccr1_reg;
 
-		sccr1_reg = read_SSCR1(reg);
+		sccr1_reg = pxa2xx_spi_read(drv_data, SSCR1);
 		sccr1_reg &= ~SSCR1_TIE;
 
 		/*
@@ -664,7 +640,7 @@ static irqreturn_t interrupt_transfer(struct driver_data *drv_data)
 
 			pxa2xx_spi_set_rx_thre(drv_data, &sccr1_reg, rx_thre);
 		}
-		write_SSCR1(sccr1_reg, reg);
+		pxa2xx_spi_write(drv_data, SSCR1, sccr1_reg);
 	}
 
 	/* We did something */
@@ -674,7 +650,6 @@ static irqreturn_t interrupt_transfer(struct driver_data *drv_data)
 static irqreturn_t ssp_int(int irq, void *dev_id)
 {
 	struct driver_data *drv_data = dev_id;
-	void __iomem *reg = drv_data->ioaddr;
 	u32 sccr1_reg;
 	u32 mask = drv_data->mask_sr;
 	u32 status;
@@ -694,11 +669,11 @@ static irqreturn_t ssp_int(int irq, void *dev_id)
 	 * are all set to one. That means that the device is already
 	 * powered off.
 	 */
-	status = read_SSSR(reg);
+	status = pxa2xx_spi_read(drv_data, SSSR);
 	if (status == ~0)
 		return IRQ_NONE;
 
-	sccr1_reg = read_SSCR1(reg);
+	sccr1_reg = pxa2xx_spi_read(drv_data, SSCR1);
 
 	/* Ignore possible writes if we don't need to write */
 	if (!(sccr1_reg & SSCR1_TIE))
@@ -709,10 +684,14 @@ static irqreturn_t ssp_int(int irq, void *dev_id)
 
 	if (!drv_data->cur_msg) {
 
-		write_SSCR0(read_SSCR0(reg) & ~SSCR0_SSE, reg);
-		write_SSCR1(read_SSCR1(reg) & ~drv_data->int_cr1, reg);
+		pxa2xx_spi_write(drv_data, SSCR0,
+				 pxa2xx_spi_read(drv_data, SSCR0)
+				 & ~SSCR0_SSE);
+		pxa2xx_spi_write(drv_data, SSCR1,
+				 pxa2xx_spi_read(drv_data, SSCR1)
+				 & ~drv_data->int_cr1);
 		if (!pxa25x_ssp_comp(drv_data))
-			write_SSTO(0, reg);
+			pxa2xx_spi_write(drv_data, SSTO, 0);
 		write_SSSR_CS(drv_data, drv_data->clear_sr);
 
 		dev_err(&drv_data->pdev->dev,
@@ -781,7 +760,6 @@ static void pump_transfers(unsigned long data)
 	struct spi_transfer *transfer = NULL;
 	struct spi_transfer *previous = NULL;
 	struct chip_data *chip = NULL;
-	void __iomem *reg = drv_data->ioaddr;
 	u32 clk_div = 0;
 	u8 bits = 0;
 	u32 speed = 0;
@@ -925,7 +903,7 @@ static void pump_transfers(unsigned long data)
 
 		/* Clear status and start DMA engine */
 		cr1 = chip->cr1 | dma_thresh | drv_data->dma_cr1;
-		write_SSSR(drv_data->clear_sr, reg);
+		pxa2xx_spi_write(drv_data, SSSR, drv_data->clear_sr);
 
 		pxa2xx_spi_dma_start(drv_data);
 	} else {
@@ -938,39 +916,43 @@ static void pump_transfers(unsigned long data)
 	}
 
 	if (is_lpss_ssp(drv_data)) {
-		if ((read_SSIRF(reg) & 0xff) != chip->lpss_rx_threshold)
-			write_SSIRF(chip->lpss_rx_threshold, reg);
-		if ((read_SSITF(reg) & 0xffff) != chip->lpss_tx_threshold)
-			write_SSITF(chip->lpss_tx_threshold, reg);
+		if ((pxa2xx_spi_read(drv_data, SSIRF) & 0xff)
+		    != chip->lpss_rx_threshold)
+			pxa2xx_spi_write(drv_data, SSIRF,
+					 chip->lpss_rx_threshold);
+		if ((pxa2xx_spi_read(drv_data, SSITF) & 0xffff)
+		    != chip->lpss_tx_threshold)
+			pxa2xx_spi_write(drv_data, SSITF,
+					 chip->lpss_tx_threshold);
 	}
 
 	if (is_quark_x1000_ssp(drv_data) &&
-	    (read_DDS_RATE(reg) != chip->dds_rate))
-		write_DDS_RATE(chip->dds_rate, reg);
+	    (pxa2xx_spi_read(drv_data, DDS_RATE) != chip->dds_rate))
+		pxa2xx_spi_write(drv_data, DDS_RATE, chip->dds_rate);
 
 	/* see if we need to reload the config registers */
-	if ((read_SSCR0(reg) != cr0) ||
-	    (read_SSCR1(reg) & change_mask) != (cr1 & change_mask)) {
-
+	if ((pxa2xx_spi_read(drv_data, SSCR0) != cr0)
+	    || (pxa2xx_spi_read(drv_data, SSCR1) & change_mask)
+	    != (cr1 & change_mask)) {
 		/* stop the SSP, and update the other bits */
-		write_SSCR0(cr0 & ~SSCR0_SSE, reg);
+		pxa2xx_spi_write(drv_data, SSCR0, cr0 & ~SSCR0_SSE);
 		if (!pxa25x_ssp_comp(drv_data))
-			write_SSTO(chip->timeout, reg);
+			pxa2xx_spi_write(drv_data, SSTO, chip->timeout);
 		/* first set CR1 without interrupt and service enables */
-		write_SSCR1(cr1 & change_mask, reg);
+		pxa2xx_spi_write(drv_data, SSCR1, cr1 & change_mask);
 		/* restart the SSP */
-		write_SSCR0(cr0, reg);
+		pxa2xx_spi_write(drv_data, SSCR0, cr0);
 
 	} else {
 		if (!pxa25x_ssp_comp(drv_data))
-			write_SSTO(chip->timeout, reg);
+			pxa2xx_spi_write(drv_data, SSTO, chip->timeout);
 	}
 
 	cs_assert(drv_data);
 
 	/* after chip select, release the data by enabling service
 	 * requests and interrupts, without changing any mode bits */
-	write_SSCR1(cr1, reg);
+	pxa2xx_spi_write(drv_data, SSCR1, cr1);
 }
 
 static int pxa2xx_spi_transfer_one_message(struct spi_master *master,
@@ -999,8 +981,8 @@ static int pxa2xx_spi_unprepare_transfer(struct spi_master *master)
 	struct driver_data *drv_data = spi_master_get_devdata(master);
 
 	/* Disable the SSP now */
-	write_SSCR0(read_SSCR0(drv_data->ioaddr) & ~SSCR0_SSE,
-		    drv_data->ioaddr);
+	pxa2xx_spi_write(drv_data, SSCR0,
+			 pxa2xx_spi_read(drv_data, SSCR0) & ~SSCR0_SSE);
 
 	return 0;
 }
@@ -1283,6 +1265,7 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 	struct driver_data *drv_data;
 	struct ssp_device *ssp;
 	int status;
+	u32 tmp;
 
 	platform_info = dev_get_platdata(dev);
 	if (!platform_info) {
@@ -1380,36 +1363,32 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 	drv_data->max_clk_rate = clk_get_rate(ssp->clk);
 
 	/* Load default SSP configuration */
-	write_SSCR0(0, drv_data->ioaddr);
+	pxa2xx_spi_write(drv_data, SSCR0, 0);
 	switch (drv_data->ssp_type) {
 	case QUARK_X1000_SSP:
-		write_SSCR1(QUARK_X1000_SSCR1_RxTresh(
-					RX_THRESH_QUARK_X1000_DFLT) |
-			    QUARK_X1000_SSCR1_TxTresh(
-					TX_THRESH_QUARK_X1000_DFLT),
-			    drv_data->ioaddr);
+		tmp = QUARK_X1000_SSCR1_RxTresh(RX_THRESH_QUARK_X1000_DFLT)
+		      | QUARK_X1000_SSCR1_TxTresh(TX_THRESH_QUARK_X1000_DFLT);
+		pxa2xx_spi_write(drv_data, SSCR1, tmp);
 
 		/* using the Motorola SPI protocol and use 8 bit frame */
-		write_SSCR0(QUARK_X1000_SSCR0_Motorola
-			    | QUARK_X1000_SSCR0_DataSize(8),
-			    drv_data->ioaddr);
+		pxa2xx_spi_write(drv_data, SSCR0,
+				 QUARK_X1000_SSCR0_Motorola
+				 | QUARK_X1000_SSCR0_DataSize(8));
 		break;
 	default:
-		write_SSCR1(SSCR1_RxTresh(RX_THRESH_DFLT) |
-			    SSCR1_TxTresh(TX_THRESH_DFLT),
-			    drv_data->ioaddr);
-		write_SSCR0(SSCR0_SCR(2)
-			    | SSCR0_Motorola
-			    | SSCR0_DataSize(8),
-			    drv_data->ioaddr);
+		tmp = SSCR1_RxTresh(RX_THRESH_DFLT) |
+		      SSCR1_TxTresh(TX_THRESH_DFLT);
+		pxa2xx_spi_write(drv_data, SSCR1, tmp);
+		tmp = SSCR0_SCR(2) | SSCR0_Motorola | SSCR0_DataSize(8);
+		pxa2xx_spi_write(drv_data, SSCR0, tmp);
 		break;
 	}
 
 	if (!pxa25x_ssp_comp(drv_data))
-		write_SSTO(0, drv_data->ioaddr);
+		pxa2xx_spi_write(drv_data, SSTO, 0);
 
 	if (!is_quark_x1000_ssp(drv_data))
-		write_SSPSP(0, drv_data->ioaddr);
+		pxa2xx_spi_write(drv_data, SSPSP, 0);
 
 	if (is_lpss_ssp(drv_data))
 		lpss_ssp_setup(drv_data);
@@ -1455,7 +1434,7 @@ static int pxa2xx_spi_remove(struct platform_device *pdev)
 	pm_runtime_get_sync(&pdev->dev);
 
 	/* Disable the SSP at the peripheral and SOC level */
-	write_SSCR0(0, drv_data->ioaddr);
+	pxa2xx_spi_write(drv_data, SSCR0, 0);
 	clk_disable_unprepare(ssp->clk);
 
 	/* Release DMA */
@@ -1492,7 +1471,7 @@ static int pxa2xx_spi_suspend(struct device *dev)
 	status = spi_master_suspend(drv_data->master);
 	if (status != 0)
 		return status;
-	write_SSCR0(0, drv_data->ioaddr);
+	pxa2xx_spi_write(drv_data, SSCR0, 0);
 
 	if (!pm_runtime_suspended(dev))
 		clk_disable_unprepare(ssp->clk);
diff --git a/drivers/spi/spi-pxa2xx.h b/drivers/spi/spi-pxa2xx.h
index 6bec59c90cd4..85a58c906869 100644
--- a/drivers/spi/spi-pxa2xx.h
+++ b/drivers/spi/spi-pxa2xx.h
@@ -115,23 +115,17 @@ struct chip_data {
 	void (*cs_control)(u32 command);
 };
 
-#define DEFINE_SSP_REG(reg, off) \
-static inline u32 read_##reg(void const __iomem *p) \
-{ return __raw_readl(p + (off)); } \
-\
-static inline void write_##reg(u32 v, void __iomem *p) \
-{ __raw_writel(v, p + (off)); }
-
-DEFINE_SSP_REG(SSCR0, 0x00)
-DEFINE_SSP_REG(SSCR1, 0x04)
-DEFINE_SSP_REG(SSSR, 0x08)
-DEFINE_SSP_REG(SSITR, 0x0c)
-DEFINE_SSP_REG(SSDR, 0x10)
-DEFINE_SSP_REG(DDS_RATE, 0x28)  /* DDS Clock Rate */
-DEFINE_SSP_REG(SSTO, 0x28)
-DEFINE_SSP_REG(SSPSP, 0x2c)
-DEFINE_SSP_REG(SSITF, SSITF)
-DEFINE_SSP_REG(SSIRF, SSIRF)
+static inline u32 pxa2xx_spi_read(const struct driver_data *drv_data,
+				  unsigned reg)
+{
+	return __raw_readl(drv_data->ioaddr + reg);
+}
+
+static  inline void pxa2xx_spi_write(const struct driver_data *drv_data,
+				     unsigned reg, u32 val)
+{
+	__raw_writel(val, drv_data->ioaddr + reg);
+}
 
 #define START_STATE ((void *)0)
 #define RUNNING_STATE ((void *)1)
@@ -155,13 +149,11 @@ static inline int pxa25x_ssp_comp(struct driver_data *drv_data)
 
 static inline void write_SSSR_CS(struct driver_data *drv_data, u32 val)
 {
-	void __iomem *reg = drv_data->ioaddr;
-
 	if (drv_data->ssp_type == CE4100_SSP ||
 	    drv_data->ssp_type == QUARK_X1000_SSP)
-		val |= read_SSSR(reg) & SSSR_ALT_FRM_MASK;
+		val |= pxa2xx_spi_read(drv_data, SSSR) & SSSR_ALT_FRM_MASK;
 
-	write_SSSR(val, reg);
+	pxa2xx_spi_write(drv_data, SSSR, val);
 }
 
 extern int pxa2xx_spi_flush(struct driver_data *drv_data);
-- 
2.1.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

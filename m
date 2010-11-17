From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 25/49] spi: davinci: remove non-useful interrupt mode support
Date: Wed, 17 Nov 2010 16:13:57 +0530
Message-ID: <1289990661-30126-26-git-send-email-nsekhar@ti.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
        davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org,
        David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1289990661-30126-25-git-send-email-nsekhar-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Brian Niebuhr <bniebuhr-JaPwekKOx1yaMJb+Lgu22Q@public.gmane.org>

The interrupt mode support as it stands is another version
of poll mode. Even when interrupt mode is selected, the code
tight loops on interrupt status register, rendering it totally
useless. A completion variable is initialized, but never used.

Remove this fake interrupt mode since users can anyway use
poll mode with no functional difference. A usefully implemented
interrupt mode support can be added later.

Signed-off-by: Brian Niebuhr <bniebuhr-JaPwekKOx1yaMJb+Lgu22Q@public.gmane.org>
Tested-By: Michael Williamson <michael.williamson-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>
Signed-off-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-davinci/dm355.c            |    1 -
 arch/arm/mach-davinci/dm365.c            |    1 -
 arch/arm/mach-davinci/include/mach/spi.h |    2 -
 drivers/spi/davinci_spi.c                |  126 +++++-------------------------
 4 files changed, 19 insertions(+), 111 deletions(-)

diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index a6d9b72..e311f29 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -413,7 +413,6 @@ static struct davinci_spi_platform_data dm355_spi0_pdata = {
 	.version 	= SPI_VERSION_1,
 	.num_chipselect = 2,
 	.clk_internal	= 1,
-	.poll_mode	= 1,	/* 0 -> interrupt mode 1-> polling mode */
 };
 static struct platform_device dm355_spi0_device = {
 	.name = "spi_davinci",
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 80dd159..1e5012e 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -626,7 +626,6 @@ static struct davinci_spi_platform_data dm365_spi0_pdata = {
 	.version 	= SPI_VERSION_1,
 	.num_chipselect = 2,
 	.clk_internal	= 1,
-	.poll_mode	= 1,	/* 0 -> interrupt mode 1-> polling mode */
 };
 
 static struct resource dm365_spi0_resources[] = {
diff --git a/arch/arm/mach-davinci/include/mach/spi.h b/arch/arm/mach-davinci/include/mach/spi.h
index 483b055..e68afe2 100644
--- a/arch/arm/mach-davinci/include/mach/spi.h
+++ b/arch/arm/mach-davinci/include/mach/spi.h
@@ -30,8 +30,6 @@ struct davinci_spi_platform_data {
 	u8	version;
 	u8	num_chipselect;
 	u8	clk_internal;
-	u8	intr_level;
-	u8	poll_mode;
 	u8	use_dma;
 	u8	*chip_sel;
 };
diff --git a/drivers/spi/davinci_spi.c b/drivers/spi/davinci_spi.c
index 54d06f4..198f062 100644
--- a/drivers/spi/davinci_spi.c
+++ b/drivers/spi/davinci_spi.c
@@ -59,8 +59,6 @@
 #define SPIPC0_SPIENA_MASK	BIT(8)		/* nREADY */
 
 #define SPIINT_MASKALL		0x0101035F
-#define SPI_INTLVL_1		0x000001FFu
-#define SPI_INTLVL_0		0x00000000u
 
 /* SPIDAT1 (upper 16 bit defines) */
 #define SPIDAT1_CSHOLD_MASK	BIT(12)
@@ -92,14 +90,8 @@
 #define SPIFLG_DESYNC_MASK		BIT(3)
 #define SPIFLG_BITERR_MASK		BIT(4)
 #define SPIFLG_OVRRUN_MASK		BIT(6)
-#define SPIFLG_RX_INTR_MASK		BIT(8)
-#define SPIFLG_TX_INTR_MASK		BIT(9)
 #define SPIFLG_BUF_INIT_ACTIVE_MASK	BIT(24)
 
-#define SPIINT_BITERR_INTR	BIT(4)
-#define SPIINT_OVRRUN_INTR	BIT(6)
-#define SPIINT_RX_INTR		BIT(8)
-#define SPIINT_TX_INTR		BIT(9)
 #define SPIINT_DMA_REQ_EN	BIT(16)
 
 /* SPI Controller registers */
@@ -136,8 +128,6 @@ struct davinci_spi {
 	resource_size_t		pbase;
 	void __iomem		*base;
 	size_t			region_size;
-	u32			irq;
-	struct completion	done;
 
 	const void		*tx;
 	void			*rx;
@@ -611,7 +601,7 @@ static int davinci_spi_check_error(struct davinci_spi *davinci_spi,
 static int davinci_spi_bufs_pio(struct spi_device *spi, struct spi_transfer *t)
 {
 	struct davinci_spi *davinci_spi;
-	int int_status, count, ret;
+	int status, count, ret;
 	u8 conv;
 	u32 tx_data, data1_reg_val;
 	u32 buf_val, flg_val;
@@ -627,8 +617,6 @@ static int davinci_spi_bufs_pio(struct spi_device *spi, struct spi_transfer *t)
 	conv = davinci_spi->bytes_per_word[spi->chip_select];
 	data1_reg_val = ioread32(davinci_spi->base + SPIDAT1);
 
-	INIT_COMPLETION(davinci_spi->done);
-
 	ret = davinci_spi_bufs_prep(spi, davinci_spi);
 	if (ret)
 		return ret;
@@ -638,9 +626,10 @@ static int davinci_spi_bufs_pio(struct spi_device *spi, struct spi_transfer *t)
 
 	count = t->len / conv;
 
+	clear_io_bits(davinci_spi->base + SPIINT, SPIINT_MASKALL);
+
 	/* Determine the command to execute READ or WRITE */
 	if (t->tx_buf) {
-		clear_io_bits(davinci_spi->base + SPIINT, SPIINT_MASKALL);
 
 		while (1) {
 			tx_data = davinci_spi->get_tx(davinci_spi);
@@ -668,45 +657,25 @@ static int davinci_spi_bufs_pio(struct spi_device *spi, struct spi_transfer *t)
 				break;
 		}
 	} else {
-		if (pdata->poll_mode) {
-			while (1) {
-				/* keeps the serial clock going */
-				if ((ioread32(davinci_spi->base + SPIBUF)
-						& SPIBUF_TXFULL_MASK) == 0)
-					iowrite32(data1_reg_val,
-						davinci_spi->base + SPIDAT1);
+		while (1) {
+			/* keeps the serial clock going */
+			if ((ioread32(davinci_spi->base + SPIBUF)
+					& SPIBUF_TXFULL_MASK) == 0)
+				iowrite32(data1_reg_val,
+					davinci_spi->base + SPIDAT1);
 
 				while (ioread32(davinci_spi->base + SPIBUF) &
-						SPIBUF_RXEMPTY_MASK)
+							SPIBUF_RXEMPTY_MASK)
 					cpu_relax();
 
-				flg_val = ioread32(davinci_spi->base + SPIFLG);
-				buf_val = ioread32(davinci_spi->base + SPIBUF);
-
-				davinci_spi->get_rx(buf_val, davinci_spi);
-
-				count--;
-				if (count <= 0)
-					break;
-			}
-		} else {	/* Receive in Interrupt mode */
-			int i;
-
-			for (i = 0; i < count; i++) {
-				set_io_bits(davinci_spi->base + SPIINT,
-						SPIINT_BITERR_INTR
-						| SPIINT_OVRRUN_INTR
-						| SPIINT_RX_INTR);
+			flg_val = ioread32(davinci_spi->base + SPIFLG);
+			buf_val = ioread32(davinci_spi->base + SPIBUF);
 
-				iowrite32(data1_reg_val,
-						davinci_spi->base + SPIDAT1);
+			davinci_spi->get_rx(buf_val, davinci_spi);
 
-				while (ioread32(davinci_spi->base + SPIINT) &
-						SPIINT_RX_INTR)
-					cpu_relax();
-			}
-			iowrite32((data1_reg_val & 0x0ffcffff),
-					davinci_spi->base + SPIDAT1);
+			count--;
+			if (count <= 0)
+				break;
 		}
 	}
 
@@ -714,9 +683,9 @@ static int davinci_spi_bufs_pio(struct spi_device *spi, struct spi_transfer *t)
 	 * Check for bit error, desync error,parity error,timeout error and
 	 * receive overflow errors
 	 */
-	int_status = ioread32(davinci_spi->base + SPIFLG);
+	status = ioread32(davinci_spi->base + SPIFLG);
 
-	ret = davinci_spi_check_error(davinci_spi, int_status);
+	ret = davinci_spi_check_error(davinci_spi, status);
 	if (ret != 0)
 		return ret;
 
@@ -854,38 +823,6 @@ static int davinci_spi_bufs_dma(struct spi_device *spi, struct spi_transfer *t)
 }
 
 /**
- * davinci_spi_irq - IRQ handler for DaVinci SPI
- * @irq: IRQ number for this SPI Master
- * @context_data: structure for SPI Master controller davinci_spi
- */
-static irqreturn_t davinci_spi_irq(s32 irq, void *context_data)
-{
-	struct davinci_spi *davinci_spi = context_data;
-	u32 int_status, rx_data = 0;
-	irqreturn_t ret = IRQ_NONE;
-
-	int_status = ioread32(davinci_spi->base + SPIFLG);
-
-	while ((int_status & SPIFLG_RX_INTR_MASK)) {
-		if (likely(int_status & SPIFLG_RX_INTR_MASK)) {
-			ret = IRQ_HANDLED;
-
-			rx_data = ioread32(davinci_spi->base + SPIBUF);
-			davinci_spi->get_rx(rx_data, davinci_spi);
-
-			/* Disable Receive Interrupt */
-			iowrite32(~(SPIINT_RX_INTR | SPIINT_TX_INTR),
-					davinci_spi->base + SPIINT);
-		} else
-			(void)davinci_spi_check_error(davinci_spi, int_status);
-
-		int_status = ioread32(davinci_spi->base + SPIFLG);
-	}
-
-	return ret;
-}
-
-/**
  * davinci_spi_probe - probe function for SPI Master Controller
  * @pdev: platform_device structure which contains plateform specific data
  */
@@ -943,22 +880,11 @@ static int davinci_spi_probe(struct platform_device *pdev)
 		goto release_region;
 	}
 
-	davinci_spi->irq = platform_get_irq(pdev, 0);
-	if (davinci_spi->irq <= 0) {
-		ret = -EINVAL;
-		goto unmap_io;
-	}
-
-	ret = request_irq(davinci_spi->irq, davinci_spi_irq, IRQF_DISABLED,
-			  dev_name(&pdev->dev), davinci_spi);
-	if (ret)
-		goto unmap_io;
-
 	/* Allocate tmp_buf for tx_buf */
 	davinci_spi->tmp_buf = kzalloc(SPI_BUFSIZ, GFP_KERNEL);
 	if (davinci_spi->tmp_buf == NULL) {
 		ret = -ENOMEM;
-		goto irq_free;
+		goto unmap_io;
 	}
 
 	davinci_spi->bitbang.master = spi_master_get(master);
@@ -1034,8 +960,6 @@ static int davinci_spi_probe(struct platform_device *pdev)
 	davinci_spi->get_rx = davinci_spi_rx_buf_u8;
 	davinci_spi->get_tx = davinci_spi_tx_buf_u8;
 
-	init_completion(&davinci_spi->done);
-
 	/* Reset In/OUT SPI module */
 	iowrite32(0, davinci_spi->base + SPIGCR0);
 	udelay(100);
@@ -1062,21 +986,12 @@ static int davinci_spi_probe(struct platform_device *pdev)
 	/* master mode default */
 	set_io_bits(davinci_spi->base + SPIGCR1, SPIGCR1_MASTER_MASK);
 
-	if (davinci_spi->pdata->intr_level)
-		iowrite32(SPI_INTLVL_1, davinci_spi->base + SPILVL);
-	else
-		iowrite32(SPI_INTLVL_0, davinci_spi->base + SPILVL);
-
 	ret = spi_bitbang_start(&davinci_spi->bitbang);
 	if (ret)
 		goto free_clk;
 
 	dev_info(&pdev->dev, "Controller at 0x%p\n", davinci_spi->base);
 
-	if (!pdata->poll_mode)
-		dev_info(&pdev->dev, "Operating in interrupt mode"
-			" using IRQ %d\n", davinci_spi->irq);
-
 	return ret;
 
 free_clk:
@@ -1086,8 +1001,6 @@ put_master:
 	spi_master_put(master);
 free_tmp_buf:
 	kfree(davinci_spi->tmp_buf);
-irq_free:
-	free_irq(davinci_spi->irq, davinci_spi);
 unmap_io:
 	iounmap(davinci_spi->base);
 release_region:
@@ -1121,7 +1034,6 @@ static int __exit davinci_spi_remove(struct platform_device *pdev)
 	clk_put(davinci_spi->clk);
 	spi_master_put(master);
 	kfree(davinci_spi->tmp_buf);
-	free_irq(davinci_spi->irq, davinci_spi);
 	iounmap(davinci_spi->base);
 	release_mem_region(davinci_spi->pbase, davinci_spi->region_size);
 
-- 
1.7.3.2

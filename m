From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 27/49] spi: davinci: add support for interrupt mode
Date: Wed, 17 Nov 2010 16:13:59 +0530
Message-ID: <1289990661-30126-28-git-send-email-nsekhar@ti.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
        davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org,
        David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1289990661-30126-27-git-send-email-nsekhar-l0cyMroinI0@public.gmane.org>
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

Add support for SPI interrupt mode operation.

Define a per chip-select "io type" variable which
specifies if the transfers on this chip-select should
happen in interrupt mode or polled mode.

Introduce a new function davinci_spi_process_events()
to help consolidate the code between interrupt mode
processing and polled mode processing.

Signed-off-by: Brian Niebuhr <bniebuhr-JaPwekKOx1yaMJb+Lgu22Q@public.gmane.org>
Tested-By: Michael Williamson <michael.williamson-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>
Signed-off-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-davinci/include/mach/spi.h |    4 +
 drivers/spi/davinci_spi.c                |  145 +++++++++++++++++++++++------
 2 files changed, 119 insertions(+), 30 deletions(-)

diff --git a/arch/arm/mach-davinci/include/mach/spi.h b/arch/arm/mach-davinci/include/mach/spi.h
index e68afe2..ab45b89 100644
--- a/arch/arm/mach-davinci/include/mach/spi.h
+++ b/arch/arm/mach-davinci/include/mach/spi.h
@@ -30,6 +30,7 @@ struct davinci_spi_platform_data {
 	u8	version;
 	u8	num_chipselect;
 	u8	clk_internal;
+	u8	intr_line;
 	u8	use_dma;
 	u8	*chip_sel;
 };
@@ -38,6 +39,9 @@ struct davinci_spi_config {
 	u8	wdelay;
 	u8	odd_parity;
 	u8	parity_enable;
+#define SPI_IO_TYPE_INTR	0
+#define SPI_IO_TYPE_POLL	1
+	u8	io_type;
 	u8	timer_disable;
 	u8	c2tdelay;
 	u8	t2cdelay;
diff --git a/drivers/spi/davinci_spi.c b/drivers/spi/davinci_spi.c
index cd37697..45cc1a7 100644
--- a/drivers/spi/davinci_spi.c
+++ b/drivers/spi/davinci_spi.c
@@ -59,6 +59,9 @@
 #define SPIPC0_SPIENA_MASK	BIT(8)		/* nREADY */
 
 #define SPIINT_MASKALL		0x0101035F
+#define SPIINT_MASKINT		0x0000015F
+#define SPI_INTLVL_1		0x000001FF
+#define SPI_INTLVL_0		0x00000000
 
 /* SPIDAT1 (upper 16 bit defines) */
 #define SPIDAT1_CSHOLD_MASK	BIT(12)
@@ -132,10 +135,14 @@ struct davinci_spi {
 	resource_size_t		pbase;
 	void __iomem		*base;
 	size_t			region_size;
+	u32			irq;
+	struct completion	done;
 
 	const void		*tx;
 	void			*rx;
 	u8			*tmp_buf;
+	int			rcount;
+	int			wcount;
 	struct davinci_spi_dma	*dma_channels;
 	struct davinci_spi_platform_data *pdata;
 
@@ -594,6 +601,43 @@ static int davinci_spi_check_error(struct davinci_spi *davinci_spi,
 }
 
 /**
+ * davinci_spi_process_events - check for and handle any SPI controller events
+ * @davinci_spi: the controller data
+ *
+ * This function will check the SPIFLG register and handle any events that are
+ * detected there
+ */
+static int davinci_spi_process_events(struct davinci_spi *davinci_spi)
+{
+	u32 buf, status, errors = 0, data1_reg_val;
+
+	buf = ioread32(davinci_spi->base + SPIBUF);
+
+	if (davinci_spi->rcount > 0 && !(buf & SPIBUF_RXEMPTY_MASK)) {
+		davinci_spi->get_rx(buf & 0xFFFF, davinci_spi);
+		davinci_spi->rcount--;
+	}
+
+	status = ioread32(davinci_spi->base + SPIFLG);
+
+	if (unlikely(status & SPIFLG_ERROR_MASK)) {
+		errors = status & SPIFLG_ERROR_MASK;
+		goto out;
+	}
+
+	if (davinci_spi->wcount > 0 && !(buf & SPIBUF_TXFULL_MASK)) {
+		data1_reg_val = ioread32(davinci_spi->base + SPIDAT1);
+		davinci_spi->wcount--;
+		data1_reg_val &= ~0xFFFF;
+		data1_reg_val |= 0xFFFF & davinci_spi->get_tx(davinci_spi);
+		iowrite32(data1_reg_val, davinci_spi->base + SPIDAT1);
+	}
+
+out:
+	return errors;
+}
+
+/**
  * davinci_spi_bufs - functions which will handle transfer data
  * @spi: spi device on which data transfer to be done
  * @t: spi transfer in which transfer info is filled
@@ -606,18 +650,22 @@ static int davinci_spi_bufs_pio(struct spi_device *spi, struct spi_transfer *t)
 {
 	struct davinci_spi *davinci_spi;
 	int ret;
-	int rcount, wcount;
 	u32 tx_data, data1_reg_val;
 	u32 errors = 0;
+	struct davinci_spi_config *spicfg;
 	struct davinci_spi_platform_data *pdata;
 
 	davinci_spi = spi_master_get_devdata(spi->master);
 	pdata = davinci_spi->pdata;
+	spicfg = (struct davinci_spi_config *)spi->controller_data;
+	if (!spicfg)
+		spicfg = &davinci_spi_default_cfg;
 
 	davinci_spi->tx = t->tx_buf;
 	davinci_spi->rx = t->rx_buf;
-	wcount = t->len / davinci_spi->bytes_per_word[spi->chip_select];
-	rcount = wcount;
+	davinci_spi->wcount = t->len /
+				davinci_spi->bytes_per_word[spi->chip_select];
+	davinci_spi->rcount = davinci_spi->wcount;
 
 	ret = davinci_spi_bufs_prep(spi, davinci_spi);
 	if (ret)
@@ -628,42 +676,32 @@ static int davinci_spi_bufs_pio(struct spi_device *spi, struct spi_transfer *t)
 	/* Enable SPI */
 	set_io_bits(davinci_spi->base + SPIGCR1, SPIGCR1_SPIENA_MASK);
 
-	clear_io_bits(davinci_spi->base + SPIINT, SPIINT_MASKALL);
+	if (spicfg->io_type == SPI_IO_TYPE_INTR) {
+		set_io_bits(davinci_spi->base + SPIINT, SPIINT_MASKINT);
+		INIT_COMPLETION(davinci_spi->done);
+	}
 
 	/* start the transfer */
-	wcount--;
+	davinci_spi->wcount--;
 	tx_data = davinci_spi->get_tx(davinci_spi);
 	data1_reg_val &= 0xFFFF0000;
 	data1_reg_val |= tx_data & 0xFFFF;
 	iowrite32(data1_reg_val, davinci_spi->base + SPIDAT1);
 
-	while (rcount > 0 || wcount > 0) {
-
-		u32 buf, status;
-
-		buf = ioread32(davinci_spi->base + SPIBUF);
-
-		if (!(buf & SPIBUF_RXEMPTY_MASK)) {
-			davinci_spi->get_rx(buf & 0xFFFF, davinci_spi);
-			rcount--;
-		}
-
-		status = ioread32(davinci_spi->base + SPIFLG);
-
-		if (unlikely(status & SPIFLG_ERROR_MASK)) {
-			errors = status & SPIFLG_ERROR_MASK;
-			break;
-		}
-
-		if (wcount > 0 && !(buf & SPIBUF_TXFULL_MASK)) {
-			wcount--;
-			tx_data = davinci_spi->get_tx(davinci_spi);
-			data1_reg_val &= ~0xFFFF;
-			data1_reg_val |= 0xFFFF & tx_data;
-			iowrite32(data1_reg_val, davinci_spi->base + SPIDAT1);
+	/* Wait for the transfer to complete */
+	if (spicfg->io_type == SPI_IO_TYPE_INTR) {
+		wait_for_completion_interruptible(&(davinci_spi->done));
+	} else {
+		while (davinci_spi->rcount > 0 || davinci_spi->wcount > 0) {
+			errors = davinci_spi_process_events(davinci_spi);
+			if (errors)
+				break;
+			cpu_relax();
 		}
 	}
 
+	clear_io_bits(davinci_spi->base + SPIINT, SPIINT_MASKALL);
+
 	/*
 	 * Check for bit error, desync error,parity error,timeout error and
 	 * receive overflow errors
@@ -678,6 +716,32 @@ static int davinci_spi_bufs_pio(struct spi_device *spi, struct spi_transfer *t)
 	return t->len;
 }
 
+/**
+ * davinci_spi_irq - Interrupt handler for SPI Master Controller
+ * @irq: IRQ number for this SPI Master
+ * @context_data: structure for SPI Master controller davinci_spi
+ *
+ * ISR will determine that interrupt arrives either for READ or WRITE command.
+ * According to command it will do the appropriate action. It will check
+ * transfer length and if it is not zero then dispatch transfer command again.
+ * If transfer length is zero then it will indicate the COMPLETION so that
+ * davinci_spi_bufs function can go ahead.
+ */
+static irqreturn_t davinci_spi_irq(s32 irq, void *context_data)
+{
+	struct davinci_spi *davinci_spi = context_data;
+	int status;
+
+	status = davinci_spi_process_events(davinci_spi);
+	if (unlikely(status != 0))
+		clear_io_bits(davinci_spi->base + SPIINT, SPIINT_MASKINT);
+
+	if ((!davinci_spi->rcount && !davinci_spi->wcount) || status)
+		complete(&davinci_spi->done);
+
+	return IRQ_HANDLED;
+}
+
 static int davinci_spi_bufs_dma(struct spi_device *spi, struct spi_transfer *t)
 {
 	struct davinci_spi *davinci_spi;
@@ -866,11 +930,22 @@ static int davinci_spi_probe(struct platform_device *pdev)
 		goto release_region;
 	}
 
+	davinci_spi->irq = platform_get_irq(pdev, 0);
+	if (davinci_spi->irq <= 0) {
+		ret = -EINVAL;
+		goto unmap_io;
+	}
+
+	ret = request_irq(davinci_spi->irq, davinci_spi_irq, 0,
+					dev_name(&pdev->dev), davinci_spi);
+	if (ret)
+		goto unmap_io;
+
 	/* Allocate tmp_buf for tx_buf */
 	davinci_spi->tmp_buf = kzalloc(SPI_BUFSIZ, GFP_KERNEL);
 	if (davinci_spi->tmp_buf == NULL) {
 		ret = -ENOMEM;
-		goto unmap_io;
+		goto irq_free;
 	}
 
 	davinci_spi->bitbang.master = spi_master_get(master);
@@ -946,6 +1021,8 @@ static int davinci_spi_probe(struct platform_device *pdev)
 	davinci_spi->get_rx = davinci_spi_rx_buf_u8;
 	davinci_spi->get_tx = davinci_spi_tx_buf_u8;
 
+	init_completion(&davinci_spi->done);
+
 	/* Reset In/OUT SPI module */
 	iowrite32(0, davinci_spi->base + SPIGCR0);
 	udelay(100);
@@ -967,6 +1044,11 @@ static int davinci_spi_probe(struct platform_device *pdev)
 		clear_io_bits(davinci_spi->base + SPIGCR1,
 				SPIGCR1_CLKMOD_MASK);
 
+	if (pdata->intr_line)
+		iowrite32(SPI_INTLVL_1, davinci_spi->base + SPILVL);
+	else
+		iowrite32(SPI_INTLVL_0, davinci_spi->base + SPILVL);
+
 	iowrite32(CS_DEFAULT, davinci_spi->base + SPIDEF);
 
 	/* master mode default */
@@ -987,6 +1069,8 @@ put_master:
 	spi_master_put(master);
 free_tmp_buf:
 	kfree(davinci_spi->tmp_buf);
+irq_free:
+	free_irq(davinci_spi->irq, davinci_spi);
 unmap_io:
 	iounmap(davinci_spi->base);
 release_region:
@@ -1020,6 +1104,7 @@ static int __exit davinci_spi_remove(struct platform_device *pdev)
 	clk_put(davinci_spi->clk);
 	spi_master_put(master);
 	kfree(davinci_spi->tmp_buf);
+	free_irq(davinci_spi->irq, davinci_spi);
 	iounmap(davinci_spi->base);
 	release_mem_region(davinci_spi->pbase, davinci_spi->region_size);
 
-- 
1.7.3.2

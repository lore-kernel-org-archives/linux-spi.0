From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 29/49] spi: davinci: remove unnecessary function
	davinci_spi_bufs_prep()
Date: Wed, 17 Nov 2010 16:14:01 +0530
Message-ID: <1289990661-30126-30-git-send-email-nsekhar@ti.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
        davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org,
        David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1289990661-30126-29-git-send-email-nsekhar-l0cyMroinI0@public.gmane.org>
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

The function davinci_spi_bufs_prep() is doing stuff that
davinci_spi_setup() is doing. Eliminate it and move the work
to davinci_spi_setup()

Signed-off-by: Brian Niebuhr <bniebuhr-JaPwekKOx1yaMJb+Lgu22Q@public.gmane.org>
Tested-By: Michael Williamson <michael.williamson-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>
Signed-off-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
---
 drivers/spi/davinci_spi.c |   64 ++++++++++++++------------------------------
 1 files changed, 21 insertions(+), 43 deletions(-)

diff --git a/drivers/spi/davinci_spi.c b/drivers/spi/davinci_spi.c
index 6f279c5..05b6145 100644
--- a/drivers/spi/davinci_spi.c
+++ b/drivers/spi/davinci_spi.c
@@ -482,13 +482,33 @@ static int davinci_spi_setup(struct spi_device *spi)
 	int retval;
 	struct davinci_spi *davinci_spi;
 	struct davinci_spi_dma *davinci_spi_dma;
+	struct davinci_spi_platform_data *pdata;
 
 	davinci_spi = spi_master_get_devdata(spi->master);
+	pdata = davinci_spi->pdata;
 
 	/* if bits per word length is zero then set it default 8 */
 	if (!spi->bits_per_word)
 		spi->bits_per_word = 8;
 
+	if (!(spi->mode & SPI_NO_CS)) {
+		if ((pdata->chip_sel == NULL) ||
+		    (pdata->chip_sel[spi->chip_select] == SPI_INTERN_CS))
+			set_io_bits(davinci_spi->base + SPIPC0,
+					1 << spi->chip_select);
+
+	}
+
+	if (spi->mode & SPI_READY)
+		set_io_bits(davinci_spi->base + SPIPC0, SPIPC0_SPIENA_MASK);
+
+	if (spi->mode & SPI_LOOP)
+		set_io_bits(davinci_spi->base + SPIGCR1,
+				SPIGCR1_LOOPBACK_MASK);
+	else
+		clear_io_bits(davinci_spi->base + SPIGCR1,
+				SPIGCR1_LOOPBACK_MASK);
+
 	if (use_dma && davinci_spi->dma_channels) {
 		davinci_spi_dma = &davinci_spi->dma_channels[spi->chip_select];
 
@@ -523,40 +543,6 @@ static void davinci_spi_cleanup(struct spi_device *spi)
 	}
 }
 
-static int davinci_spi_bufs_prep(struct spi_device *spi,
-				 struct davinci_spi *davinci_spi)
-{
-	struct davinci_spi_platform_data *pdata;
-	int op_mode = 0;
-
-	/*
-	 * REVISIT  unless devices disagree about SPI_LOOP or
-	 * SPI_READY (SPI_NO_CS only allows one device!), this
-	 * should not need to be done before each message...
-	 * optimize for both flags staying cleared.
-	 */
-
-	if (!(spi->mode & SPI_NO_CS)) {
-		pdata = davinci_spi->pdata;
-		if (!pdata->chip_sel ||
-		     pdata->chip_sel[spi->chip_select] == SPI_INTERN_CS)
-			op_mode |= 1 << spi->chip_select;
-	}
-	if (spi->mode & SPI_READY)
-		op_mode |= SPIPC0_SPIENA_MASK;
-
-	iowrite32(op_mode, davinci_spi->base + SPIPC0);
-
-	if (spi->mode & SPI_LOOP)
-		set_io_bits(davinci_spi->base + SPIGCR1,
-				SPIGCR1_LOOPBACK_MASK);
-	else
-		clear_io_bits(davinci_spi->base + SPIGCR1,
-				SPIGCR1_LOOPBACK_MASK);
-
-	return 0;
-}
-
 static int davinci_spi_check_error(struct davinci_spi *davinci_spi,
 				   int int_status)
 {
@@ -664,10 +650,6 @@ static int davinci_spi_bufs_pio(struct spi_device *spi, struct spi_transfer *t)
 				davinci_spi->bytes_per_word[spi->chip_select];
 	davinci_spi->rcount = davinci_spi->wcount;
 
-	ret = davinci_spi_bufs_prep(spi, davinci_spi);
-	if (ret)
-		return ret;
-
 	data1_reg_val = ioread32(davinci_spi->base + SPIDAT1);
 
 	/* Enable SPI */
@@ -769,10 +751,6 @@ static int davinci_spi_bufs_dma(struct spi_device *spi, struct spi_transfer *t)
 	init_completion(&davinci_spi_dma->dma_rx_completion);
 	init_completion(&davinci_spi_dma->dma_tx_completion);
 
-	ret = davinci_spi_bufs_prep(spi, davinci_spi);
-	if (ret)
-		return ret;
-
 	count = t->len / data_type;	/* the number of elements */
 
 	/* disable all interrupts for dma transfers */
@@ -1026,7 +1004,7 @@ static int davinci_spi_probe(struct platform_device *pdev)
 	udelay(100);
 	iowrite32(1, davinci_spi->base + SPIGCR0);
 
-	/* Set up SPIPC0.  CS and ENA init is done in davinci_spi_bufs_prep */
+	/* Set up SPIPC0.  CS and ENA init is done in davinci_spi_setup */
 	spipc0 = SPIPC0_DIFUN_MASK | SPIPC0_DOFUN_MASK | SPIPC0_CLKFUN_MASK;
 	iowrite32(spipc0, davinci_spi->base + SPIPC0);
 
-- 
1.7.3.2

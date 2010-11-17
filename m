From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 32/49] spi: davinci: always start transmit DMA
Date: Wed, 17 Nov 2010 16:14:04 +0530
Message-ID: <1289990661-30126-33-git-send-email-nsekhar@ti.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
        davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org,
        David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1289990661-30126-32-git-send-email-nsekhar-l0cyMroinI0@public.gmane.org>
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

Due to the full duplex nature of the SPI bus, the SPI master
on DaVinci needs transmit to be active even if the tranfer is
only meant to collect receive data.

The current code achieves this by using a temporary zeroed buffer
to provide DMA data in case the transfer does not have a transmit
buffer provided.

However, the transmit DMA is started only if transmit buffer is
provided rendering the temporary buffer unused. Instead the code
relies on a write to SPIDAT1 register to trigger transmit operation.
This however only sends two bytes of data.

Fix this by starting transmit DMA always.

This changes exposes a bug on DM355 where the CSHOLD bit in
SPIDAT1 needs to be written to in between transfers. Handle
that by introducing a "cshold_bug" platform data which is
set to true for DM355.

Signed-off-by: Brian Niebuhr <bniebuhr-JaPwekKOx1yaMJb+Lgu22Q@public.gmane.org>
Tested-By: Michael Williamson <michael.williamson-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>
Signed-off-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-davinci/dm355.c            |    1 +
 arch/arm/mach-davinci/include/mach/spi.h |    1 +
 drivers/spi/davinci_spi.c                |   22 +++++++++-------------
 3 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index e311f29..27ee870 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -413,6 +413,7 @@ static struct davinci_spi_platform_data dm355_spi0_pdata = {
 	.version 	= SPI_VERSION_1,
 	.num_chipselect = 2,
 	.clk_internal	= 1,
+	.cshold_bug	= true,
 };
 static struct platform_device dm355_spi0_device = {
 	.name = "spi_davinci",
diff --git a/arch/arm/mach-davinci/include/mach/spi.h b/arch/arm/mach-davinci/include/mach/spi.h
index ab45b89..68db6d5 100644
--- a/arch/arm/mach-davinci/include/mach/spi.h
+++ b/arch/arm/mach-davinci/include/mach/spi.h
@@ -33,6 +33,7 @@ struct davinci_spi_platform_data {
 	u8	intr_line;
 	u8	use_dma;
 	u8	*chip_sel;
+	bool	cshold_bug;
 };
 
 struct davinci_spi_config {
diff --git a/drivers/spi/davinci_spi.c b/drivers/spi/davinci_spi.c
index 4aa5221..a5f03dd 100644
--- a/drivers/spi/davinci_spi.c
+++ b/drivers/spi/davinci_spi.c
@@ -719,13 +719,14 @@ static int davinci_spi_bufs_dma(struct spi_device *spi, struct spi_transfer *t)
 	struct davinci_spi *davinci_spi;
 	int int_status = 0;
 	int count, temp_count;
-	u32 data1_reg_val;
 	struct davinci_spi_dma *davinci_spi_dma;
 	int data_type, ret;
 	unsigned long tx_reg, rx_reg;
+	struct davinci_spi_platform_data *pdata;
 	struct device *sdev;
 
 	davinci_spi = spi_master_get_devdata(spi->master);
+	pdata = davinci_spi->pdata;
 	sdev = davinci_spi->bitbang.master->dev.parent;
 
 	davinci_spi_dma = &davinci_spi->dma_channels;
@@ -739,8 +740,6 @@ static int davinci_spi_bufs_dma(struct spi_device *spi, struct spi_transfer *t)
 	/* convert len to words based on bits_per_word */
 	data_type = davinci_spi->bytes_per_word[spi->chip_select];
 
-	data1_reg_val = ioread32(davinci_spi->base + SPIDAT1);
-
 	init_completion(&davinci_spi_dma->dma_rx_completion);
 	init_completion(&davinci_spi_dma->dma_tx_completion);
 
@@ -781,9 +780,6 @@ static int davinci_spi_bufs_dma(struct spi_device *spi, struct spi_transfer *t)
 	edma_set_dest_index(davinci_spi_dma->dma_tx_channel, 0, 0);
 
 	if (t->rx_buf) {
-		/* initiate transaction */
-		iowrite32(data1_reg_val, davinci_spi->base + SPIDAT1);
-
 		t->rx_dma = dma_map_single(&spi->dev, (void *)t->rx_buf, count,
 				DMA_FROM_DEVICE);
 		if (dma_mapping_error(&spi->dev, t->rx_dma)) {
@@ -805,18 +801,18 @@ static int davinci_spi_bufs_dma(struct spi_device *spi, struct spi_transfer *t)
 				data_type, 0);
 	}
 
-	if ((t->tx_buf) || (t->rx_buf))
-		edma_start(davinci_spi_dma->dma_tx_channel);
+	if (pdata->cshold_bug) {
+		u16 spidat1 = ioread16(davinci_spi->base + SPIDAT1 + 2);
+		iowrite16(spidat1, davinci_spi->base + SPIDAT1 + 2);
+	}
 
 	if (t->rx_buf)
 		edma_start(davinci_spi_dma->dma_rx_channel);
 
-	if ((t->rx_buf) || (t->tx_buf))
-		davinci_spi_set_dma_req(spi, 1);
+	edma_start(davinci_spi_dma->dma_tx_channel);
+	davinci_spi_set_dma_req(spi, 1);
 
-	if (t->tx_buf)
-		wait_for_completion_interruptible(
-				&davinci_spi_dma->dma_tx_completion);
+	wait_for_completion_interruptible(&davinci_spi_dma->dma_tx_completion);
 
 	if (t->rx_buf)
 		wait_for_completion_interruptible(
-- 
1.7.3.2

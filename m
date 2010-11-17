From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 07/49] spi: davinci: enable both activation and deactivation
	of chip-selects
Date: Wed, 17 Nov 2010 16:13:39 +0530
Message-ID: <1289990661-30126-8-git-send-email-nsekhar@ti.com>
References: <1289990661-30126-1-git-send-email-nsekhar@ti.com>
	<1289990661-30126-2-git-send-email-nsekhar@ti.com>
	<1289990661-30126-3-git-send-email-nsekhar@ti.com>
	<1289990661-30126-4-git-send-email-nsekhar@ti.com>
	<1289990661-30126-5-git-send-email-nsekhar@ti.com>
	<1289990661-30126-6-git-send-email-nsekhar@ti.com>
	<1289990661-30126-7-git-send-email-nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
        davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org,
        David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1289990661-30126-7-git-send-email-nsekhar-l0cyMroinI0@public.gmane.org>
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

Let davinci_spi_chipselect() perform both activation and
deactivation of chip selects. This lets spi_bitbang fully
control chip select activation, as intended by the SPI API.

With this change, the chip select activation code need not
be duplicated in davinci_spi_bufs_{pio|dma}().

Also, keeping chip select active control is removed as a
platform data and simply controlled using information from
spi_bitbang on whether chip slect should be activated or
de-activated.

Signed-off-by: Brian Niebuhr <bniebuhr-JaPwekKOx1yaMJb+Lgu22Q@public.gmane.org>
Tested-By: Michael Williamson <michael.williamson-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>
Signed-off-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-davinci/dm355.c            |    1 -
 arch/arm/mach-davinci/dm365.c            |    1 -
 arch/arm/mach-davinci/include/mach/spi.h |    1 -
 drivers/spi/davinci_spi.c                |   53 ++++++++++-------------------
 4 files changed, 18 insertions(+), 38 deletions(-)

diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index 9be261b..6a76dfa 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -413,7 +413,6 @@ static struct davinci_spi_platform_data dm355_spi0_pdata = {
 	.version 	= SPI_VERSION_1,
 	.num_chipselect = 2,
 	.clk_internal	= 1,
-	.cs_hold	= 1,
 	.intr_level	= 0,
 	.poll_mode	= 1,	/* 0 -> interrupt mode 1-> polling mode */
 	.c2tdelay	= 0,
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index a12065e..cd623db 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -626,7 +626,6 @@ static struct davinci_spi_platform_data dm365_spi0_pdata = {
 	.version 	= SPI_VERSION_1,
 	.num_chipselect = 2,
 	.clk_internal	= 1,
-	.cs_hold	= 1,
 	.intr_level	= 0,
 	.poll_mode	= 1,	/* 0 -> interrupt mode 1-> polling mode */
 	.c2tdelay	= 0,
diff --git a/arch/arm/mach-davinci/include/mach/spi.h b/arch/arm/mach-davinci/include/mach/spi.h
index 910efbf..2cb326e 100644
--- a/arch/arm/mach-davinci/include/mach/spi.h
+++ b/arch/arm/mach-davinci/include/mach/spi.h
@@ -33,7 +33,6 @@ struct davinci_spi_platform_data {
 	u8	wait_enable;
 	u8	timer_disable;
 	u8	clk_internal;
-	u8	cs_hold;
 	u8	intr_level;
 	u8	poll_mode;
 	u8	use_dma;
diff --git a/drivers/spi/davinci_spi.c b/drivers/spi/davinci_spi.c
index d6b6a49..105c686 100644
--- a/drivers/spi/davinci_spi.c
+++ b/drivers/spi/davinci_spi.c
@@ -66,7 +66,7 @@
 #define SPI_INTLVL_0		0x00000000u
 
 /* SPIDAT1 */
-#define SPIDAT1_CSHOLD_SHIFT	28
+#define SPIDAT1_CSHOLD_MASK	BIT(28)
 #define SPIDAT1_CSNR_SHIFT	16
 #define SPIGCR1_CLKMOD_MASK	BIT(1)
 #define SPIGCR1_MASTER_MASK     BIT(0)
@@ -235,7 +235,8 @@ static void davinci_spi_chipselect(struct spi_device *spi, int value)
 {
 	struct davinci_spi *davinci_spi;
 	struct davinci_spi_platform_data *pdata;
-	u32 data1_reg_val = 0;
+	u32 data1_reg_val;
+	u8 chip_sel = spi->chip_select;
 
 	davinci_spi = spi_master_get_devdata(spi->master);
 	pdata = davinci_spi->pdata;
@@ -244,14 +245,17 @@ static void davinci_spi_chipselect(struct spi_device *spi, int value)
 	 * Board specific chip select logic decides the polarity and cs
 	 * line for the controller
 	 */
-	if (value == BITBANG_CS_INACTIVE) {
-		data1_reg_val |= CS_DEFAULT << SPIDAT1_CSNR_SHIFT;
-		iowrite32(data1_reg_val, davinci_spi->base + SPIDAT1);
-
-		while ((ioread32(davinci_spi->base + SPIBUF)
-					& SPIBUF_RXEMPTY_MASK) == 0)
-			cpu_relax();
+	data1_reg_val = CS_DEFAULT << SPIDAT1_CSNR_SHIFT;
+	if (value == BITBANG_CS_ACTIVE) {
+		data1_reg_val |= SPIDAT1_CSHOLD_MASK;
+		data1_reg_val &= ~((0x1 << chip_sel) << SPIDAT1_CSNR_SHIFT);
 	}
+
+	iowrite32(data1_reg_val, davinci_spi->base + SPIDAT1);
+	while ((ioread32(davinci_spi->base + SPIBUF)
+				& SPIBUF_RXEMPTY_MASK) == 0)
+		cpu_relax();
+
 }
 
 /**
@@ -632,7 +636,7 @@ static int davinci_spi_bufs_pio(struct spi_device *spi, struct spi_transfer *t)
 {
 	struct davinci_spi *davinci_spi;
 	int int_status, count, ret;
-	u8 conv, tmp;
+	u8 conv;
 	u32 tx_data, data1_reg_val;
 	u32 buf_val, flg_val;
 	struct davinci_spi_platform_data *pdata;
@@ -647,6 +651,8 @@ static int davinci_spi_bufs_pio(struct spi_device *spi, struct spi_transfer *t)
 	conv = davinci_spi->slave[spi->chip_select].bytes_per_word;
 	davinci_spi->count = t->len / conv;
 
+	data1_reg_val = ioread32(davinci_spi->base + SPIDAT1);
+
 	INIT_COMPLETION(davinci_spi->done);
 
 	ret = davinci_spi_bufs_prep(spi, davinci_spi);
@@ -661,16 +667,6 @@ static int davinci_spi_bufs_pio(struct spi_device *spi, struct spi_transfer *t)
 			davinci_spi->base + SPIDELAY);
 
 	count = davinci_spi->count;
-	data1_reg_val = pdata->cs_hold << SPIDAT1_CSHOLD_SHIFT;
-	tmp = ~(0x1 << spi->chip_select);
-
-	clear_io_bits(davinci_spi->base + SPIDEF, ~tmp);
-
-	data1_reg_val |= tmp << SPIDAT1_CSNR_SHIFT;
-
-	while ((ioread32(davinci_spi->base + SPIBUF)
-				& SPIBUF_RXEMPTY_MASK) == 0)
-		cpu_relax();
 
 	/* Determine the command to execute READ or WRITE */
 	if (t->tx_buf) {
@@ -770,7 +766,6 @@ static int davinci_spi_bufs_dma(struct spi_device *spi, struct spi_transfer *t)
 	int int_status = 0;
 	int count, temp_count;
 	u8 conv = 1;
-	u8 tmp;
 	u32 data1_reg_val;
 	struct davinci_spi_dma *davinci_spi_dma;
 	int word_len, data_type, ret;
@@ -794,6 +789,8 @@ static int davinci_spi_bufs_dma(struct spi_device *spi, struct spi_transfer *t)
 	conv = davinci_spi->slave[spi->chip_select].bytes_per_word;
 	davinci_spi->count = t->len / conv;
 
+	data1_reg_val = ioread32(davinci_spi->base + SPIDAT1);
+
 	INIT_COMPLETION(davinci_spi->done);
 
 	init_completion(&davinci_spi_dma->dma_rx_completion);
@@ -820,28 +817,14 @@ static int davinci_spi_bufs_dma(struct spi_device *spi, struct spi_transfer *t)
 			davinci_spi->base + SPIDELAY);
 
 	count = davinci_spi->count;	/* the number of elements */
-	data1_reg_val = pdata->cs_hold << SPIDAT1_CSHOLD_SHIFT;
-
-	/* CS default = 0xFF */
-	tmp = ~(0x1 << spi->chip_select);
-
-	clear_io_bits(davinci_spi->base + SPIDEF, ~tmp);
-
-	data1_reg_val |= tmp << SPIDAT1_CSNR_SHIFT;
 
 	/* disable all interrupts for dma transfers */
 	clear_io_bits(davinci_spi->base + SPIINT, SPIINT_MASKALL);
 	/* Disable SPI to write configuration bits in SPIDAT */
 	clear_io_bits(davinci_spi->base + SPIGCR1, SPIGCR1_SPIENA_MASK);
-	iowrite32(data1_reg_val, davinci_spi->base + SPIDAT1);
 	/* Enable SPI */
 	set_io_bits(davinci_spi->base + SPIGCR1, SPIGCR1_SPIENA_MASK);
 
-	while ((ioread32(davinci_spi->base + SPIBUF)
-				& SPIBUF_RXEMPTY_MASK) == 0)
-		cpu_relax();
-
-
 	if (t->tx_buf) {
 		t->tx_dma = dma_map_single(&spi->dev, (void *)t->tx_buf, count,
 				DMA_TO_DEVICE);
-- 
1.7.3.2

From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 12/49] spi: davinci: make chip-slect specific parameters
	really chip-select specific
Date: Wed, 17 Nov 2010 16:13:44 +0530
Message-ID: <1289990661-30126-13-git-send-email-nsekhar@ti.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
        davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org,
        David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1289990661-30126-12-git-send-email-nsekhar-l0cyMroinI0@public.gmane.org>
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

Some chip-select specific paramterers like wdelay, parity, usage of
chip-select timers (and the actual timer values) are included in
platform data forcing the same behaviour across all chip-selects.

Create a new davinci_spi_config data structure which can be passed
along using controller_data member of spi_device data structure
on a per-device basis.

Signed-off-by: Brian Niebuhr <bniebuhr-JaPwekKOx1yaMJb+Lgu22Q@public.gmane.org>
Tested-By: Michael Williamson <michael.williamson-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>
Signed-off-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-davinci/dm355.c            |    3 -
 arch/arm/mach-davinci/dm365.c            |    3 -
 arch/arm/mach-davinci/include/mach/spi.h |   13 ++++--
 drivers/spi/davinci_spi.c                |   67 ++++++++++++++++-------------
 4 files changed, 45 insertions(+), 41 deletions(-)

diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index 6a76dfa..a6d9b72 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -413,10 +413,7 @@ static struct davinci_spi_platform_data dm355_spi0_pdata = {
 	.version 	= SPI_VERSION_1,
 	.num_chipselect = 2,
 	.clk_internal	= 1,
-	.intr_level	= 0,
 	.poll_mode	= 1,	/* 0 -> interrupt mode 1-> polling mode */
-	.c2tdelay	= 0,
-	.t2cdelay	= 0,
 };
 static struct platform_device dm355_spi0_device = {
 	.name = "spi_davinci",
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index cd623db..80dd159 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -626,10 +626,7 @@ static struct davinci_spi_platform_data dm365_spi0_pdata = {
 	.version 	= SPI_VERSION_1,
 	.num_chipselect = 2,
 	.clk_internal	= 1,
-	.intr_level	= 0,
 	.poll_mode	= 1,	/* 0 -> interrupt mode 1-> polling mode */
-	.c2tdelay	= 0,
-	.t2cdelay	= 0,
 };
 
 static struct resource dm365_spi0_resources[] = {
diff --git a/arch/arm/mach-davinci/include/mach/spi.h b/arch/arm/mach-davinci/include/mach/spi.h
index fe699140..29c19c4 100644
--- a/arch/arm/mach-davinci/include/mach/spi.h
+++ b/arch/arm/mach-davinci/include/mach/spi.h
@@ -29,17 +29,20 @@ enum {
 struct davinci_spi_platform_data {
 	u8	version;
 	u8	num_chipselect;
-	u8	wdelay;
-	u8	odd_parity;
-	u8	parity_enable;
-	u8	timer_disable;
 	u8	clk_internal;
 	u8	intr_level;
 	u8	poll_mode;
 	u8	use_dma;
+	u8	*chip_sel;
+};
+
+struct davinci_spi_config {
+	u8	wdelay;
+	u8	odd_parity;
+	u8	parity_enable;
+	u8	timer_disable;
 	u8	c2tdelay;
 	u8	t2cdelay;
-	u8	*chip_sel;
 };
 
 #endif	/* __ARCH_ARM_DAVINCI_SPI_H */
diff --git a/drivers/spi/davinci_spi.c b/drivers/spi/davinci_spi.c
index 5480857..d4320f7 100644
--- a/drivers/spi/davinci_spi.c
+++ b/drivers/spi/davinci_spi.c
@@ -156,6 +156,8 @@ struct davinci_spi {
 	struct davinci_spi_slave slave[SPI_MAX_CHIPSELECT];
 };
 
+static struct davinci_spi_config davinci_spi_default_cfg;
+
 static unsigned use_dma;
 
 static void davinci_spi_rx_buf_u8(u32 data, struct davinci_spi *davinci_spi)
@@ -434,8 +436,12 @@ static int davinci_spi_setup(struct spi_device *spi)
 	int retval;
 	struct davinci_spi *davinci_spi;
 	struct davinci_spi_dma *davinci_spi_dma;
+	struct davinci_spi_config *spicfg;
 
 	davinci_spi = spi_master_get_devdata(spi->master);
+	spicfg = (struct davinci_spi_config *)spi->controller_data;
+	if (!spicfg)
+		spicfg = &davinci_spi_default_cfg;
 
 	/* if bits per word length is zero then set it default 8 */
 	if (!spi->bits_per_word)
@@ -496,31 +502,34 @@ static int davinci_spi_setup(struct spi_device *spi)
 	 */
 
 	if (davinci_spi->version == SPI_VERSION_2) {
+
 		clear_fmt_bits(davinci_spi->base, SPIFMT_WDELAY_MASK,
-				spi->chip_select);
+							spi->chip_select);
 		set_fmt_bits(davinci_spi->base,
-				(davinci_spi->pdata->wdelay
-						<< SPIFMT_WDELAY_SHIFT)
-					& SPIFMT_WDELAY_MASK,
-				spi->chip_select);
+				(spicfg->wdelay << SPIFMT_WDELAY_SHIFT) &
+				SPIFMT_WDELAY_MASK, spi->chip_select);
 
-		if (davinci_spi->pdata->odd_parity)
-			set_fmt_bits(davinci_spi->base,
-					SPIFMT_ODD_PARITY_MASK,
-					spi->chip_select);
+		if (spicfg->odd_parity)
+			set_fmt_bits(davinci_spi->base, SPIFMT_ODD_PARITY_MASK,
+							spi->chip_select);
 		else
 			clear_fmt_bits(davinci_spi->base,
 					SPIFMT_ODD_PARITY_MASK,
 					spi->chip_select);
 
-		if (davinci_spi->pdata->parity_enable)
-			set_fmt_bits(davinci_spi->base,
-					SPIFMT_PARITYENA_MASK,
-					spi->chip_select);
+		if (spicfg->parity_enable)
+			set_fmt_bits(davinci_spi->base, SPIFMT_PARITYENA_MASK,
+							spi->chip_select);
 		else
-			clear_fmt_bits(davinci_spi->base,
-					SPIFMT_PARITYENA_MASK,
-					spi->chip_select);
+			clear_fmt_bits(davinci_spi->base, SPIFMT_PARITYENA_MASK,
+							spi->chip_select);
+
+		if (spicfg->timer_disable)
+			set_fmt_bits(davinci_spi->base, SPIFMT_DISTIMER_MASK,
+							spi->chip_select);
+		else
+			clear_fmt_bits(davinci_spi->base, SPIFMT_DISTIMER_MASK,
+							spi->chip_select);
 
 		if (spi->mode & SPI_READY)
 			set_fmt_bits(davinci_spi->base,
@@ -531,14 +540,6 @@ static int davinci_spi_setup(struct spi_device *spi)
 					SPIFMT_WAITENA_MASK,
 					spi->chip_select);
 
-		if (davinci_spi->pdata->timer_disable)
-			set_fmt_bits(davinci_spi->base,
-					SPIFMT_DISTIMER_MASK,
-					spi->chip_select);
-		else
-			clear_fmt_bits(davinci_spi->base,
-					SPIFMT_DISTIMER_MASK,
-					spi->chip_select);
 	}
 
 	retval = davinci_spi_setup_transfer(spi, NULL);
@@ -662,9 +663,13 @@ static int davinci_spi_bufs_pio(struct spi_device *spi, struct spi_transfer *t)
 	u32 tx_data, data1_reg_val;
 	u32 buf_val, flg_val;
 	struct davinci_spi_platform_data *pdata;
+	struct davinci_spi_config *spicfg;
 
 	davinci_spi = spi_master_get_devdata(spi->master);
 	pdata = davinci_spi->pdata;
+	spicfg = (struct davinci_spi_config *)spi->controller_data;
+	if (!spicfg)
+		spicfg = &davinci_spi_default_cfg;
 
 	davinci_spi->tx = t->tx_buf;
 	davinci_spi->rx = t->rx_buf;
@@ -684,8 +689,8 @@ static int davinci_spi_bufs_pio(struct spi_device *spi, struct spi_transfer *t)
 	/* Enable SPI */
 	set_io_bits(davinci_spi->base + SPIGCR1, SPIGCR1_SPIENA_MASK);
 
-	iowrite32(0 | (pdata->c2tdelay << SPI_C2TDELAY_SHIFT) |
-			(pdata->t2cdelay << SPI_T2CDELAY_SHIFT),
+	iowrite32((spicfg->c2tdelay << SPI_C2TDELAY_SHIFT) |
+			(spicfg->t2cdelay << SPI_T2CDELAY_SHIFT),
 			davinci_spi->base + SPIDELAY);
 
 	count = davinci_spi->count;
@@ -792,12 +797,14 @@ static int davinci_spi_bufs_dma(struct spi_device *spi, struct spi_transfer *t)
 	struct davinci_spi_dma *davinci_spi_dma;
 	int word_len, data_type, ret;
 	unsigned long tx_reg, rx_reg;
-	struct davinci_spi_platform_data *pdata;
+	struct davinci_spi_config *spicfg;
 	struct device *sdev;
 
 	davinci_spi = spi_master_get_devdata(spi->master);
-	pdata = davinci_spi->pdata;
 	sdev = davinci_spi->bitbang.master->dev.parent;
+	spicfg = (struct davinci_spi_config *)spi->controller_data;
+	if (!spicfg)
+		spicfg = &davinci_spi_default_cfg;
 
 	davinci_spi_dma = &davinci_spi->dma_channels[spi->chip_select];
 
@@ -834,8 +841,8 @@ static int davinci_spi_bufs_dma(struct spi_device *spi, struct spi_transfer *t)
 		return ret;
 
 	/* Put delay val if required */
-	iowrite32(0 | (pdata->c2tdelay << SPI_C2TDELAY_SHIFT) |
-			(pdata->t2cdelay << SPI_T2CDELAY_SHIFT),
+	iowrite32((spicfg->c2tdelay << SPI_C2TDELAY_SHIFT) |
+			(spicfg->t2cdelay << SPI_T2CDELAY_SHIFT),
 			davinci_spi->base + SPIDELAY);
 
 	count = davinci_spi->count;	/* the number of elements */
-- 
1.7.3.2

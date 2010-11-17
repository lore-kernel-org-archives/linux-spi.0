From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 09/49] spi: davinci: enable GPIO lines to be used as chip
	selects
Date: Wed, 17 Nov 2010 16:13:41 +0530
Message-ID: <1289990661-30126-10-git-send-email-nsekhar@ti.com>
References: <1289990661-30126-1-git-send-email-nsekhar@ti.com>
	<1289990661-30126-2-git-send-email-nsekhar@ti.com>
	<1289990661-30126-3-git-send-email-nsekhar@ti.com>
	<1289990661-30126-4-git-send-email-nsekhar@ti.com>
	<1289990661-30126-5-git-send-email-nsekhar@ti.com>
	<1289990661-30126-6-git-send-email-nsekhar@ti.com>
	<1289990661-30126-7-git-send-email-nsekhar@ti.com>
	<1289990661-30126-8-git-send-email-nsekhar@ti.com>
	<1289990661-30126-9-git-send-email-nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
        davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org,
        David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1289990661-30126-9-git-send-email-nsekhar-l0cyMroinI0@public.gmane.org>
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

Sometimes, the chip selects provided by SPI module are
muxed with other functionality and cannot be used in
some designs. In such cases, it becomes convenient to use
an available GPIO line as chip select.

This patch enables the DaVinci SPI driver to treat specific
GPIO lines as chip selects based on information provided in
platform data.

Signed-off-by: Brian Niebuhr <bniebuhr-JaPwekKOx1yaMJb+Lgu22Q@public.gmane.org>
Tested-By: Michael Williamson <michael.williamson-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>
Signed-off-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-davinci/include/mach/spi.h |    3 ++
 drivers/spi/davinci_spi.c                |   39 ++++++++++++++++++++++++-----
 2 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-davinci/include/mach/spi.h b/arch/arm/mach-davinci/include/mach/spi.h
index 2cb326e..734d1fb 100644
--- a/arch/arm/mach-davinci/include/mach/spi.h
+++ b/arch/arm/mach-davinci/include/mach/spi.h
@@ -19,6 +19,8 @@
 #ifndef __ARCH_ARM_DAVINCI_SPI_H
 #define __ARCH_ARM_DAVINCI_SPI_H
 
+#define SPI_INTERN_CS	0xFF
+
 enum {
 	SPI_VERSION_1, /* For DM355/DM365/DM6467 */
 	SPI_VERSION_2, /* For DA8xx */
@@ -38,6 +40,7 @@ struct davinci_spi_platform_data {
 	u8	use_dma;
 	u8	c2tdelay;
 	u8	t2cdelay;
+	u8	*chip_sel;
 };
 
 #endif	/* __ARCH_ARM_DAVINCI_SPI_H */
diff --git a/drivers/spi/davinci_spi.c b/drivers/spi/davinci_spi.c
index 82dddf8..d5d7014 100644
--- a/drivers/spi/davinci_spi.c
+++ b/drivers/spi/davinci_spi.c
@@ -238,20 +238,32 @@ static void davinci_spi_chipselect(struct spi_device *spi, int value)
 	struct davinci_spi_platform_data *pdata;
 	u8 chip_sel = spi->chip_select;
 	u16 spidat1_cfg = CS_DEFAULT;
+	bool gpio_chipsel = false;
 
 	davinci_spi = spi_master_get_devdata(spi->master);
 	pdata = davinci_spi->pdata;
 
+	if (pdata->chip_sel && chip_sel < pdata->num_chipselect &&
+				pdata->chip_sel[chip_sel] != SPI_INTERN_CS)
+		gpio_chipsel = true;
+
 	/*
 	 * Board specific chip select logic decides the polarity and cs
 	 * line for the controller
 	 */
-	if (value == BITBANG_CS_ACTIVE) {
-		spidat1_cfg |= SPIDAT1_CSHOLD_MASK;
-		spidat1_cfg &= ~(0x1 << chip_sel);
-	}
+	if (gpio_chipsel) {
+		if (value == BITBANG_CS_ACTIVE)
+			gpio_set_value(pdata->chip_sel[chip_sel], 0);
+		else
+			gpio_set_value(pdata->chip_sel[chip_sel], 1);
+	} else {
+		if (value == BITBANG_CS_ACTIVE) {
+			spidat1_cfg |= SPIDAT1_CSHOLD_MASK;
+			spidat1_cfg &= ~(0x1 << chip_sel);
+		}
 
-	iowrite16(spidat1_cfg, davinci_spi->base + SPIDAT1 + 2);
+		iowrite16(spidat1_cfg, davinci_spi->base + SPIDAT1 + 2);
+	}
 }
 
 /**
@@ -546,6 +558,7 @@ static void davinci_spi_cleanup(struct spi_device *spi)
 static int davinci_spi_bufs_prep(struct spi_device *spi,
 				 struct davinci_spi *davinci_spi)
 {
+	struct davinci_spi_platform_data *pdata;
 	int op_mode = 0;
 
 	/*
@@ -558,8 +571,12 @@ static int davinci_spi_bufs_prep(struct spi_device *spi,
 	op_mode = SPIPC0_DIFUN_MASK
 		| SPIPC0_DOFUN_MASK
 		| SPIPC0_CLKFUN_MASK;
-	if (!(spi->mode & SPI_NO_CS))
-		op_mode |= 1 << spi->chip_select;
+	if (!(spi->mode & SPI_NO_CS)) {
+		pdata = davinci_spi->pdata;
+		if (!pdata->chip_sel ||
+		     pdata->chip_sel[spi->chip_select] == SPI_INTERN_CS)
+			op_mode |= 1 << spi->chip_select;
+	}
 	if (spi->mode & SPI_READY)
 		op_mode |= SPIPC0_SPIENA_MASK;
 
@@ -1101,6 +1118,14 @@ static int davinci_spi_probe(struct platform_device *pdev)
 	udelay(100);
 	iowrite32(1, davinci_spi->base + SPIGCR0);
 
+	/* initialize chip selects */
+	if (pdata->chip_sel) {
+		for (i = 0; i < pdata->num_chipselect; i++) {
+			if (pdata->chip_sel[i] != SPI_INTERN_CS)
+				gpio_direction_output(pdata->chip_sel[i], 1);
+		}
+	}
+
 	/* Clock internal */
 	if (davinci_spi->pdata->clk_internal)
 		set_io_bits(davinci_spi->base + SPIGCR1,
-- 
1.7.3.2

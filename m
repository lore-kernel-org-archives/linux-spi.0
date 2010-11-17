From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 13/49] spi: davinci: consolidate setup of SPIFMTn in one
	function
Date: Wed, 17 Nov 2010 16:13:45 +0530
Message-ID: <1289990661-30126-14-git-send-email-nsekhar@ti.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
        davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org,
        David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1289990661-30126-13-git-send-email-nsekhar-l0cyMroinI0@public.gmane.org>
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

Consolidate the setup of SPIFMTn register under
davinci_spi_setup_transfer() simplifying the code
and avoiding unnecessary reads and writes to the
register.

The two inline functions {set|clear}_fmt_bits() can
be eliminated because of this.

Signed-off-by: Brian Niebuhr <bniebuhr-JaPwekKOx1yaMJb+Lgu22Q@public.gmane.org>
Tested-By: Michael Williamson <michael.williamson-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>
Signed-off-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
---
 drivers/spi/davinci_spi.c |  154 ++++++++++++++------------------------------
 1 files changed, 49 insertions(+), 105 deletions(-)

diff --git a/drivers/spi/davinci_spi.c b/drivers/spi/davinci_spi.c
index d4320f7..34b28fe 100644
--- a/drivers/spi/davinci_spi.c
+++ b/drivers/spi/davinci_spi.c
@@ -52,7 +52,6 @@
 #define SPIFMT_ODD_PARITY_MASK	BIT(23)
 #define SPIFMT_WDELAY_MASK	0x3f000000u
 #define SPIFMT_WDELAY_SHIFT	24
-#define SPIFMT_CHARLEN_MASK	0x0000001Fu
 #define SPIFMT_PRESCALE_SHIFT	8
 
 
@@ -212,16 +211,6 @@ static inline void clear_io_bits(void __iomem *addr, u32 bits)
 	iowrite32(v, addr);
 }
 
-static inline void set_fmt_bits(void __iomem *addr, u32 bits, int cs_num)
-{
-	set_io_bits(addr + SPIFMT0 + (0x4 * cs_num), bits);
-}
-
-static inline void clear_fmt_bits(void __iomem *addr, u32 bits, int cs_num)
-{
-	clear_io_bits(addr + SPIFMT0 + (0x4 * cs_num), bits);
-}
-
 static void davinci_spi_set_dma_req(const struct spi_device *spi, int enable)
 {
 	struct davinci_spi *davinci_spi = spi_master_get_devdata(spi->master);
@@ -306,10 +295,14 @@ static int davinci_spi_setup_transfer(struct spi_device *spi,
 {
 
 	struct davinci_spi *davinci_spi;
+	struct davinci_spi_config *spicfg;
 	u8 bits_per_word = 0;
-	u32 hz = 0, prescale = 0;
+	u32 hz = 0, spifmt = 0, prescale = 0;
 
 	davinci_spi = spi_master_get_devdata(spi->master);
+	spicfg = (struct davinci_spi_config *)spi->controller_data;
+	if (!spicfg)
+		spicfg = &davinci_spi_default_cfg;
 
 	if (t) {
 		bits_per_word = t->bits_per_word;
@@ -338,18 +331,55 @@ static int davinci_spi_setup_transfer(struct spi_device *spi,
 	if (!hz)
 		hz = spi->max_speed_hz;
 
+	/* Set up SPIFMTn register, unique to this chipselect. */
+
 	prescale = davinci_spi_get_prescale(davinci_spi, hz);
 	if (prescale < 0)
 		return prescale;
 
-	clear_fmt_bits(davinci_spi->base, SPIFMT_CHARLEN_MASK,
-			spi->chip_select);
-	set_fmt_bits(davinci_spi->base, bits_per_word & 0x1f,
-			spi->chip_select);
+	spifmt = (prescale << SPIFMT_PRESCALE_SHIFT) | (bits_per_word & 0x1f);
+
+	if (spi->mode & SPI_LSB_FIRST)
+		spifmt |= SPIFMT_SHIFTDIR_MASK;
+
+	if (spi->mode & SPI_CPOL)
+		spifmt |= SPIFMT_POLARITY_MASK;
+
+	if (!(spi->mode & SPI_CPHA))
+		spifmt |= SPIFMT_PHASE_MASK;
+
+	/*
+	 * Version 1 hardware supports two basic SPI modes:
+	 *  - Standard SPI mode uses 4 pins, with chipselect
+	 *  - 3 pin SPI is a 4 pin variant without CS (SPI_NO_CS)
+	 *	(distinct from SPI_3WIRE, with just one data wire;
+	 *	or similar variants without MOSI or without MISO)
+	 *
+	 * Version 2 hardware supports an optional handshaking signal,
+	 * so it can support two more modes:
+	 *  - 5 pin SPI variant is standard SPI plus SPI_READY
+	 *  - 4 pin with enable is (SPI_READY | SPI_NO_CS)
+	 */
+
+	if (davinci_spi->version == SPI_VERSION_2) {
+
+		spifmt |= ((spicfg->wdelay << SPIFMT_WDELAY_SHIFT)
+							& SPIFMT_WDELAY_MASK);
 
-	clear_fmt_bits(davinci_spi->base, 0x0000ff00, spi->chip_select);
-	set_fmt_bits(davinci_spi->base,
-			prescale << SPIFMT_PRESCALE_SHIFT, spi->chip_select);
+		if (spicfg->odd_parity)
+			spifmt |= SPIFMT_ODD_PARITY_MASK;
+
+		if (spicfg->parity_enable)
+			spifmt |= SPIFMT_PARITYENA_MASK;
+
+		if (spicfg->timer_disable)
+			spifmt |= SPIFMT_DISTIMER_MASK;
+
+		if (spi->mode & SPI_READY)
+			spifmt |= SPIFMT_WAITENA_MASK;
+	}
+
+	iowrite32(spifmt, davinci_spi->base + SPIFMT0);
 
 	return 0;
 }
@@ -436,12 +466,8 @@ static int davinci_spi_setup(struct spi_device *spi)
 	int retval;
 	struct davinci_spi *davinci_spi;
 	struct davinci_spi_dma *davinci_spi_dma;
-	struct davinci_spi_config *spicfg;
 
 	davinci_spi = spi_master_get_devdata(spi->master);
-	spicfg = (struct davinci_spi_config *)spi->controller_data;
-	if (!spicfg)
-		spicfg = &davinci_spi_default_cfg;
 
 	/* if bits per word length is zero then set it default 8 */
 	if (!spi->bits_per_word)
@@ -460,88 +486,6 @@ static int davinci_spi_setup(struct spi_device *spi)
 		}
 	}
 
-	/*
-	 * Set up SPIFMTn register, unique to this chipselect.
-	 *
-	 * NOTE: we could do all of these with one write.  Also, some
-	 * of the "version 2" features are found in chips that don't
-	 * support all of them...
-	 */
-	if (spi->mode & SPI_LSB_FIRST)
-		set_fmt_bits(davinci_spi->base, SPIFMT_SHIFTDIR_MASK,
-				spi->chip_select);
-	else
-		clear_fmt_bits(davinci_spi->base, SPIFMT_SHIFTDIR_MASK,
-				spi->chip_select);
-
-	if (spi->mode & SPI_CPOL)
-		set_fmt_bits(davinci_spi->base, SPIFMT_POLARITY_MASK,
-				spi->chip_select);
-	else
-		clear_fmt_bits(davinci_spi->base, SPIFMT_POLARITY_MASK,
-				spi->chip_select);
-
-	if (!(spi->mode & SPI_CPHA))
-		set_fmt_bits(davinci_spi->base, SPIFMT_PHASE_MASK,
-				spi->chip_select);
-	else
-		clear_fmt_bits(davinci_spi->base, SPIFMT_PHASE_MASK,
-				spi->chip_select);
-
-	/*
-	 * Version 1 hardware supports two basic SPI modes:
-	 *  - Standard SPI mode uses 4 pins, with chipselect
-	 *  - 3 pin SPI is a 4 pin variant without CS (SPI_NO_CS)
-	 *	(distinct from SPI_3WIRE, with just one data wire;
-	 *	or similar variants without MOSI or without MISO)
-	 *
-	 * Version 2 hardware supports an optional handshaking signal,
-	 * so it can support two more modes:
-	 *  - 5 pin SPI variant is standard SPI plus SPI_READY
-	 *  - 4 pin with enable is (SPI_READY | SPI_NO_CS)
-	 */
-
-	if (davinci_spi->version == SPI_VERSION_2) {
-
-		clear_fmt_bits(davinci_spi->base, SPIFMT_WDELAY_MASK,
-							spi->chip_select);
-		set_fmt_bits(davinci_spi->base,
-				(spicfg->wdelay << SPIFMT_WDELAY_SHIFT) &
-				SPIFMT_WDELAY_MASK, spi->chip_select);
-
-		if (spicfg->odd_parity)
-			set_fmt_bits(davinci_spi->base, SPIFMT_ODD_PARITY_MASK,
-							spi->chip_select);
-		else
-			clear_fmt_bits(davinci_spi->base,
-					SPIFMT_ODD_PARITY_MASK,
-					spi->chip_select);
-
-		if (spicfg->parity_enable)
-			set_fmt_bits(davinci_spi->base, SPIFMT_PARITYENA_MASK,
-							spi->chip_select);
-		else
-			clear_fmt_bits(davinci_spi->base, SPIFMT_PARITYENA_MASK,
-							spi->chip_select);
-
-		if (spicfg->timer_disable)
-			set_fmt_bits(davinci_spi->base, SPIFMT_DISTIMER_MASK,
-							spi->chip_select);
-		else
-			clear_fmt_bits(davinci_spi->base, SPIFMT_DISTIMER_MASK,
-							spi->chip_select);
-
-		if (spi->mode & SPI_READY)
-			set_fmt_bits(davinci_spi->base,
-					SPIFMT_WAITENA_MASK,
-					spi->chip_select);
-		else
-			clear_fmt_bits(davinci_spi->base,
-					SPIFMT_WAITENA_MASK,
-					spi->chip_select);
-
-	}
-
 	retval = davinci_spi_setup_transfer(spi, NULL);
 
 	return retval;
-- 
1.7.3.2

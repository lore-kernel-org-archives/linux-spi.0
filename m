From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch 2.6.30-rc2 1/2] spi: move common
	spi_setup() functionality into core
Date: Tue, 21 Apr 2009 02:20:20 -0700
Message-ID: <200904210220.20959.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>

Start moving some spi_setup() functionality into the SPI core
from the various spi_master controller drivers:

 - Make that function stop being an inline;

 - Move two common idioms from drivers into that new function:
    * Default bits_per_word to 8 if that field isn't set
    * Issue a standardized dev_dbg() message

This is a net minor source code shrink, and supports enhancments
found in some follow-up patches.

Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
 drivers/spi/atmel_spi.c   |    2 -
 drivers/spi/au1550_spi.c  |    2 -
 drivers/spi/omap2_mcspi.c |    4 ---
 drivers/spi/omap_uwire.c  |    2 -
 drivers/spi/orion_spi.c   |    3 --
 drivers/spi/pxa2xx_spi.c  |   11 +-------
 drivers/spi/spi.c         |   55 +++++++++++++++++++++++++++++++++++++++++++-
 drivers/spi/spi_bfin5xx.c |    4 ---
 drivers/spi/spi_bitbang.c |    7 -----
 drivers/spi/spi_imx.c     |    5 ----
 drivers/spi/spi_mpc83xx.c |    6 ----
 drivers/spi/spi_s3c24xx.c |    7 -----
 drivers/spi/spi_txx9.c    |    2 -
 drivers/spi/xilinx_spi.c  |    6 ----
 include/linux/spi/spi.h   |   25 --------------------
 15 files changed, 61 insertions(+), 80 deletions(-)

--- a/drivers/spi/atmel_spi.c
+++ b/drivers/spi/atmel_spi.c
@@ -555,8 +555,6 @@ static int atmel_spi_setup(struct spi_de
 		return -EINVAL;
 	}
 
-	if (bits == 0)
-		bits = 8;
 	if (bits < 8 || bits > 16) {
 		dev_dbg(&spi->dev,
 				"setup: invalid bits_per_word %u (8 to 16)\n",
--- a/drivers/spi/au1550_spi.c
+++ b/drivers/spi/au1550_spi.c
@@ -291,8 +291,6 @@ static int au1550_spi_setup(struct spi_d
 {
 	struct au1550_spi *hw = spi_master_get_devdata(spi->master);
 
-	if (spi->bits_per_word == 0)
-		spi->bits_per_word = 8;
 	if (spi->bits_per_word < 4 || spi->bits_per_word > 24) {
 		dev_err(&spi->dev, "setup: invalid bits_per_word=%d\n",
 			spi->bits_per_word);
--- a/drivers/spi/omap2_mcspi.c
+++ b/drivers/spi/omap2_mcspi.c
@@ -619,9 +619,7 @@ static int omap2_mcspi_setup(struct spi_
 		return -EINVAL;
 	}
 
-	if (spi->bits_per_word == 0)
-		spi->bits_per_word = 8;
-	else if (spi->bits_per_word < 4 || spi->bits_per_word > 32) {
+	if (spi->bits_per_word < 4 || spi->bits_per_word > 32) {
 		dev_dbg(&spi->dev, "setup: unsupported %d bit words\n",
 			spi->bits_per_word);
 		return -EINVAL;
--- a/drivers/spi/omap_uwire.c
+++ b/drivers/spi/omap_uwire.c
@@ -339,8 +339,6 @@ static int uwire_setup_transfer(struct s
 	bits = spi->bits_per_word;
 	if (t != NULL && t->bits_per_word)
 		bits = t->bits_per_word;
-	if (!bits)
-		bits = 8;
 
 	if (bits > 16) {
 		pr_debug("%s: wordsize %d?\n", dev_name(&spi->dev), bits);
--- a/drivers/spi/orion_spi.c
+++ b/drivers/spi/orion_spi.c
@@ -369,9 +369,6 @@ static int orion_spi_setup(struct spi_de
 		orion_spi_setbits(orion_spi, ORION_SPI_IF_CONFIG_REG,
 				  (1 << 14));
 
-	if (spi->bits_per_word == 0)
-		spi->bits_per_word = 8;
-
 	if ((spi->max_speed_hz == 0)
 			|| (spi->max_speed_hz > orion_spi->max_speed))
 		spi->max_speed_hz = orion_spi->max_speed;
--- a/drivers/spi/pxa2xx_spi.c
+++ b/drivers/spi/pxa2xx_spi.c
@@ -1236,9 +1236,6 @@ static int setup(struct spi_device *spi)
 	uint tx_thres = TX_THRESH_DFLT;
 	uint rx_thres = RX_THRESH_DFLT;
 
-	if (!spi->bits_per_word)
-		spi->bits_per_word = 8;
-
 	if (drv_data->ssp_type != PXA25x_SSP
 		&& (spi->bits_per_word < 4 || spi->bits_per_word > 32)) {
 		dev_err(&spi->dev, "failed setup: ssp_type=%d, bits/wrd=%d "
@@ -1328,18 +1325,14 @@ static int setup(struct spi_device *spi)
 
 	/* NOTE:  PXA25x_SSP _could_ use external clocking ... */
 	if (drv_data->ssp_type != PXA25x_SSP)
-		dev_dbg(&spi->dev, "%d bits/word, %ld Hz, mode %d, %s\n",
-				spi->bits_per_word,
+		dev_dbg(&spi->dev, "%ld Hz actual, %s\n",
 				clk_get_rate(ssp->clk)
 					/ (1 + ((chip->cr0 & SSCR0_SCR) >> 8)),
-				spi->mode & 0x3,
 				chip->enable_dma ? "DMA" : "PIO");
 	else
-		dev_dbg(&spi->dev, "%d bits/word, %ld Hz, mode %d, %s\n",
-				spi->bits_per_word,
+		dev_dbg(&spi->dev, "%ld Hz actual, %s\n",
 				clk_get_rate(ssp->clk) / 2
 					/ (1 + ((chip->cr0 & SSCR0_SCR) >> 8)),
-				spi->mode & 0x3,
 				chip->enable_dma ? "DMA" : "PIO");
 
 	if (spi->bits_per_word <= 8) {
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -265,7 +265,7 @@ int spi_add_device(struct spi_device *sp
 	 * normally rely on the device being setup.  Devices
 	 * using SPI_CS_HIGH can't coexist well otherwise...
 	 */
-	status = spi->master->setup(spi);
+	status = spi_setup(spi);
 	if (status < 0) {
 		dev_err(dev, "can't %s %s, status %d\n",
 				"setup", dev_name(&spi->dev), status);
@@ -583,6 +583,59 @@ EXPORT_SYMBOL_GPL(spi_busnum_to_master);
 
 /*-------------------------------------------------------------------------*/
 
+/* Core methods for SPI master protocol drivers.  Some of the
+ * other core methods are currently defined as inline functions.
+ */
+
+/**
+ * spi_setup - setup SPI mode and clock rate
+ * @spi: the device whose settings are being modified
+ * Context: can sleep, and no requests are queued to the device
+ *
+ * SPI protocol drivers may need to update the transfer mode if the
+ * device doesn't work with its default.  They may likewise need
+ * to update clock rates or word sizes from initial values.  This function
+ * changes those settings, and must be called from a context that can sleep.
+ * Except for SPI_CS_HIGH, which takes effect immediately, the changes take
+ * effect the next time the device is selected and data is transferred to
+ * or from it.  When this function returns, the spi device is deselected.
+ *
+ * Note that this call will fail if the protocol driver specifies an option
+ * that the underlying controller or its driver does not support.  For
+ * example, not all hardware supports wire transfers using nine bit words,
+ * LSB-first wire encoding, or active-high chipselects.
+ */
+int spi_setup(struct spi_device *spi)
+{
+	int		status;
+
+	if (!spi->bits_per_word)
+		spi->bits_per_word = 8;
+
+	status = spi->master->setup(spi);
+
+	dev_dbg(&spi->dev, "setup mode %d, %s%s%s%s"
+				"%u bits/w, %u Hz max --> %d\n",
+			(int) (spi->mode & (SPI_CPOL | SPI_CPHA)),
+			(spi->mode & SPI_CS_HIGH) ? "cs_high, " : "",
+			(spi->mode & SPI_LSB_FIRST) ? "lsb, " : "",
+			(spi->mode & SPI_3WIRE) ? "3wire, " : "",
+			(spi->mode & SPI_LOOP) ? "loopback, " : "",
+			spi->bits_per_word, spi->max_speed_hz,
+			status);
+
+	return status;
+}
+EXPORT_SYMBOL_GPL(spi_setup);
+
+
+/*-------------------------------------------------------------------------*/
+
+/* Utility methods for SPI master protocol drivers, layered on
+ * top of the core.  Some other utility methods are defined as
+ * inline functions.
+ */
+
 static void spi_complete(void *arg)
 {
 	complete(arg);
--- a/drivers/spi/spi_bfin5xx.c
+++ b/drivers/spi/spi_bfin5xx.c
@@ -1016,10 +1016,6 @@ static int bfin_spi_setup(struct spi_dev
 		return -EINVAL;
 	}
 
-	/* Zero (the default) here means 8 bits */
-	if (!spi->bits_per_word)
-		spi->bits_per_word = 8;
-
 	if (spi->bits_per_word != 8 && spi->bits_per_word != 16)
 		return -EINVAL;
 
--- a/drivers/spi/spi_bitbang.c
+++ b/drivers/spi/spi_bitbang.c
@@ -201,9 +201,6 @@ int spi_bitbang_setup(struct spi_device 
 		spi->controller_state = cs;
 	}
 
-	if (!spi->bits_per_word)
-		spi->bits_per_word = 8;
-
 	/* per-word shift register access, in hardware or bitbanging */
 	cs->txrx_word = bitbang->txrx_word[spi->mode & (SPI_CPOL|SPI_CPHA)];
 	if (!cs->txrx_word)
@@ -213,9 +210,7 @@ int spi_bitbang_setup(struct spi_device 
 	if (retval < 0)
 		return retval;
 
-	dev_dbg(&spi->dev, "%s, mode %d, %u bits/w, %u nsec/bit\n",
-			__func__, spi->mode & (SPI_CPOL | SPI_CPHA),
-			spi->bits_per_word, 2 * cs->nsecs);
+	dev_dbg(&spi->dev, "%s, %u nsec/bit\n", __func__, 2 * cs->nsecs);
 
 	/* NOTE we _need_ to call chipselect() early, ideally with adapter
 	 * setup, unless the hardware defaults cooperate to avoid confusion
--- a/drivers/spi/spi_imx.c
+++ b/drivers/spi/spi_imx.c
@@ -1286,10 +1286,7 @@ static int setup(struct spi_device *spi)
 
 	/* SPI word width */
 	tmp = spi->bits_per_word;
-	if (tmp == 0) {
-		tmp = 8;
-		spi->bits_per_word = 8;
-	} else if (tmp > 16) {
+	if (tmp > 16) {
 		status = -EINVAL;
 		dev_err(&spi->dev,
 			"setup - "
--- a/drivers/spi/spi_mpc83xx.c
+++ b/drivers/spi/spi_mpc83xx.c
@@ -447,9 +447,6 @@ static int mpc83xx_spi_setup(struct spi_
 	}
 	mpc83xx_spi = spi_master_get_devdata(spi->master);
 
-	if (!spi->bits_per_word)
-		spi->bits_per_word = 8;
-
 	hw_mode = cs->hw_mode; /* Save orginal settings */
 	cs->hw_mode = mpc83xx_spi_read_reg(&mpc83xx_spi->base->mode);
 	/* mask out bits we are going to set */
@@ -471,9 +468,6 @@ static int mpc83xx_spi_setup(struct spi_
 		return retval;
 	}
 
-	dev_dbg(&spi->dev, "%s, mode %d, %u bits/w, %u Hz\n",
-		__func__, spi->mode & (SPI_CPOL | SPI_CPHA),
-		spi->bits_per_word, spi->max_speed_hz);
 #if 0 /* Don't think this is needed */
 	/* NOTE we _need_ to call chipselect() early, ideally with adapter
 	 * setup, unless the hardware defaults cooperate to avoid confusion
--- a/drivers/spi/spi_s3c24xx.c
+++ b/drivers/spi/spi_s3c24xx.c
@@ -153,9 +153,6 @@ static int s3c24xx_spi_setup(struct spi_
 {
 	int ret;
 
-	if (!spi->bits_per_word)
-		spi->bits_per_word = 8;
-
 	if (spi->mode & ~MODEBITS) {
 		dev_dbg(&spi->dev, "setup: unsupported mode bits %x\n",
 			spi->mode & ~MODEBITS);
@@ -168,10 +165,6 @@ static int s3c24xx_spi_setup(struct spi_
 		return ret;
 	}
 
-	dev_dbg(&spi->dev, "%s: mode %d, %u bpw, %d hz\n",
-		__func__, spi->mode, spi->bits_per_word,
-		spi->max_speed_hz);
-
 	return 0;
 }
 
--- a/drivers/spi/spi_txx9.c
+++ b/drivers/spi/spi_txx9.c
@@ -126,7 +126,7 @@ static int txx9spi_setup(struct spi_devi
 			|| spi->max_speed_hz < c->min_speed_hz)
 		return -EINVAL;
 
-	bits_per_word = spi->bits_per_word ? : 8;
+	bits_per_word = spi->bits_per_word;
 	if (bits_per_word != 8 && bits_per_word != 16)
 		return -EINVAL;
 
--- a/drivers/spi/xilinx_spi.c
+++ b/drivers/spi/xilinx_spi.c
@@ -170,9 +170,6 @@ static int xilinx_spi_setup(struct spi_d
 	xspi = spi_master_get_devdata(spi->master);
 	bitbang = &xspi->bitbang;
 
-	if (!spi->bits_per_word)
-		spi->bits_per_word = 8;
-
 	if (spi->mode & ~MODEBITS) {
 		dev_err(&spi->dev, "%s, unsupported mode bits %x\n",
 			__func__, spi->mode & ~MODEBITS);
@@ -183,9 +180,6 @@ static int xilinx_spi_setup(struct spi_d
 	if (retval < 0)
 		return retval;
 
-	dev_dbg(&spi->dev, "%s, mode %d, %u bits/w, %u nsec/bit\n",
-		__func__, spi->mode & MODEBITS, spi->bits_per_word, 0);
-
 	return 0;
 }
 
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -523,30 +523,7 @@ static inline void spi_message_free(stru
 	kfree(m);
 }
 
-/**
- * spi_setup - setup SPI mode and clock rate
- * @spi: the device whose settings are being modified
- * Context: can sleep, and no requests are queued to the device
- *
- * SPI protocol drivers may need to update the transfer mode if the
- * device doesn't work with its default.  They may likewise need
- * to update clock rates or word sizes from initial values.  This function
- * changes those settings, and must be called from a context that can sleep.
- * Except for SPI_CS_HIGH, which takes effect immediately, the changes take
- * effect the next time the device is selected and data is transferred to
- * or from it.  When this function returns, the spi device is deselected.
- *
- * Note that this call will fail if the protocol driver specifies an option
- * that the underlying controller or its driver does not support.  For
- * example, not all hardware supports wire transfers using nine bit words,
- * LSB-first wire encoding, or active-high chipselects.
- */
-static inline int
-spi_setup(struct spi_device *spi)
-{
-	return spi->master->setup(spi);
-}
-
+extern int spi_setup(struct spi_device *spi);
 
 /**
  * spi_async - asynchronous SPI transfer

------------------------------------------------------------------------------
Stay on top of everything new and different, both inside and 
around Java (TM) technology - register by April 22, and save
$200 on the JavaOne (SM) conference, June 2-5, 2009, San Francisco.
300 plus technical and hands-on sessions. Register today. 
Use priority code J9JMT32. http://p.sf.net/sfu/p

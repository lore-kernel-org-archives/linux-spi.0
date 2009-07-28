From: Ben Dooks <ben-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org>
Subject: [patch 6/6] spi_s3c24xx: cache device setup data
Date: Tue, 28 Jul 2009 21:51:43 +0100
Message-ID: <20090728205239.821215698@fluff.org>
References: <20090728205137.613851078@fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline; filename=spi-improve-transfer-setup.patch
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

With the update to the spi_bitbang driver, the transfer setup code is
being called more often, and thus is often re-doing calculations that
have been done before. The SPI layer allows our driver to add its
own data to each device so add a result cache to each device.

This should also remove the problem where we where directly setting up
registers in the setup call which meant we might overwrite the state of
an extant transfer.,

Signed-off-by: Ben Dooks <ben-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org>

---
 drivers/spi/spi_s3c24xx.c |  126 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 89 insertions(+), 37 deletions(-)

Index: b/drivers/spi/spi_s3c24xx.c
===================================================================
--- a/drivers/spi/spi_s3c24xx.c	2009-07-28 15:20:22.000000000 +0100
+++ b/drivers/spi/spi_s3c24xx.c	2009-07-28 15:20:28.000000000 +0100
@@ -28,6 +28,20 @@
 #include <plat/regs-spi.h>
 #include <mach/spi.h>
 
+/**
+ * s3c24xx_spi_devstate - per device data
+ * @hz: Last frequency calculated for @sppre field.
+ * @mode: Last mode setting for the @spcon field.
+ * @spcon: Value to write to the SPCON register.
+ * @sppre: Value to write to the SPPRE register.
+ */
+struct s3c24xx_spi_devstate {
+	unsigned int	hz;
+	unsigned int	mode;
+	u8		spcon;
+	u8		sppre;
+};
+
 struct s3c24xx_spi {
 	/* bitbang has to be first */
 	struct spi_bitbang	 bitbang;
@@ -68,43 +82,31 @@ static void s3c24xx_spi_gpiocs(struct s3
 
 static void s3c24xx_spi_chipsel(struct spi_device *spi, int value)
 {
+	struct s3c24xx_spi_devstate *cs = spi->controller_state;
 	struct s3c24xx_spi *hw = to_hw(spi);
 	unsigned int cspol = spi->mode & SPI_CS_HIGH ? 1 : 0;
-	unsigned int spcon;
+
+	/* change the chipselect state and the state of the spi engine clock */
 
 	switch (value) {
 	case BITBANG_CS_INACTIVE:
 		hw->set_cs(hw->pdata, spi->chip_select, cspol^1);
+		writeb(cs->spcon, hw->regs + S3C2410_SPCON);
 		break;
 
 	case BITBANG_CS_ACTIVE:
-		spcon = readb(hw->regs + S3C2410_SPCON);
-
-		if (spi->mode & SPI_CPHA)
-			spcon |= S3C2410_SPCON_CPHA_FMTB;
-		else
-			spcon &= ~S3C2410_SPCON_CPHA_FMTB;
-
-		if (spi->mode & SPI_CPOL)
-			spcon |= S3C2410_SPCON_CPOL_HIGH;
-		else
-			spcon &= ~S3C2410_SPCON_CPOL_HIGH;
-
-		spcon |= S3C2410_SPCON_ENSCK;
-
-		/* write new configration */
-
-		writeb(spcon, hw->regs + S3C2410_SPCON);
+		writeb(cs->spcon | S3C2410_SPCON_ENSCK,
+		       hw->regs + S3C2410_SPCON);
 		hw->set_cs(hw->pdata, spi->chip_select, cspol);
-
 		break;
 	}
 }
 
-static int s3c24xx_spi_setupxfer(struct spi_device *spi,
-				 struct spi_transfer *t)
+static int s3c24xx_spi_update_state(struct spi_device *spi,
+				    struct spi_transfer *t)
 {
 	struct s3c24xx_spi *hw = to_hw(spi);
+	struct s3c24xx_spi_devstate *cs = spi->controller_state;
 	unsigned int bpw;
 	unsigned int hz;
 	unsigned int div;
@@ -124,41 +126,89 @@ static int s3c24xx_spi_setupxfer(struct 
 		return -EINVAL;
 	}
 
-	clk = clk_get_rate(hw->clk);
-	div = DIV_ROUND_UP(clk, hz * 2) - 1;
+	if (spi->mode != cs->mode) {
+		u8 spcon = SPCON_DEFAULT;
 
-	if (div > 255)
-		div = 255;
+		if (spi->mode & SPI_CPHA)
+			spcon |= S3C2410_SPCON_CPHA_FMTB;
 
-	dev_dbg(&spi->dev, "setting pre-scaler to %d (wanted %d, got %ld)\n",
-		div, hz, clk / (2 * (div + 1)));
+		if (spi->mode & SPI_CPOL)
+			spcon |= S3C2410_SPCON_CPOL_HIGH;
 
+		cs->mode = spi->mode;
+		cs->spcon = spcon;
+	}
 
-	writeb(div, hw->regs + S3C2410_SPPRE);
+	if (cs->hz != hz) {
+		clk = clk_get_rate(hw->clk);
+		div = DIV_ROUND_UP(clk, hz * 2) - 1;
 
-	spin_lock(&hw->bitbang.lock);
-	if (!hw->bitbang.busy) {
-		hw->bitbang.chipselect(spi, BITBANG_CS_INACTIVE);
-		/* need to ndelay for 0.5 clocktick ? */
+		if (div > 255)
+			div = 255;
+
+		dev_dbg(&spi->dev, "pre-scaler=%d (wanted %d, got %ld)\n",
+			div, hz, clk / (2 * (div + 1)));
+
+		cs->hz = hz;
+		cs->sppre = div;
 	}
-	spin_unlock(&hw->bitbang.lock);
 
 	return 0;
 }
 
+static int s3c24xx_spi_setupxfer(struct spi_device *spi,
+				 struct spi_transfer *t)
+{
+	struct s3c24xx_spi_devstate *cs = spi->controller_state;
+	struct s3c24xx_spi *hw = to_hw(spi);
+	int ret;
+
+	ret = s3c24xx_spi_update_state(spi, t);
+	if (!ret)
+		writeb(cs->sppre, hw->regs + S3C2410_SPPRE);
+
+	return ret;
+}
+
 static int s3c24xx_spi_setup(struct spi_device *spi)
 {
+	struct s3c24xx_spi_devstate *cs = spi->controller_state;
+	struct s3c24xx_spi *hw = to_hw(spi);
 	int ret;
 
-	ret = s3c24xx_spi_setupxfer(spi, NULL);
-	if (ret < 0) {
-		dev_err(&spi->dev, "setupxfer returned %d\n", ret);
+	/* allocate settings on the first call */
+	if (!cs) {
+		cs = kzalloc(sizeof(struct s3c24xx_spi_devstate), GFP_KERNEL);
+		if (!cs) {
+			dev_err(&spi->dev, "no memory for controller state\n");
+			return -ENOMEM;
+		}
+
+		cs->spcon = SPCON_DEFAULT;
+		cs->hz = -1;
+		spi->controller_state = cs;
+	}
+
+	/* initialise the state from the device */
+	ret = s3c24xx_spi_update_state(spi, NULL);
+	if (ret)
 		return ret;
+
+	spin_lock(&hw->bitbang.lock);
+	if (!hw->bitbang.busy) {
+		hw->bitbang.chipselect(spi, BITBANG_CS_INACTIVE);
+		/* need to ndelay for 0.5 clocktick ? */
 	}
+	spin_unlock(&hw->bitbang.lock);
 
 	return 0;
 }
 
+static void s3c24xx_spi_cleanup(struct spi_device *spi)
+{
+	kfree(spi->controller_state);
+}
+
 static inline unsigned int hw_txbyte(struct s3c24xx_spi *hw, int count)
 {
 	return hw->tx ? hw->tx[count] : 0;
@@ -286,7 +336,9 @@ static int __init s3c24xx_spi_probe(stru
 	hw->bitbang.setup_transfer = s3c24xx_spi_setupxfer;
 	hw->bitbang.chipselect     = s3c24xx_spi_chipsel;
 	hw->bitbang.txrx_bufs      = s3c24xx_spi_txrx;
-	hw->bitbang.master->setup  = s3c24xx_spi_setup;
+
+	hw->master->setup  = s3c24xx_spi_setup;
+	hw->master->cleanup = s3c24xx_spi_cleanup;
 
 	dev_dbg(hw->dev, "bitbang at %p\n", &hw->bitbang);
 

-- 

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july

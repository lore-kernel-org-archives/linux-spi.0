From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch 2.6.22-rc2-git] SPI controller drivers:
	check for unsupported modes
Date: Tue, 22 May 2007 12:22:28 -0700
Message-ID: <200705221222.29564.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Haavard Skinnemoen <hskinnemoen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	Dragos Carp <dragos.carp-+ybMorV4k0dBDgjK7y7TUQ@public.gmane.org>, Ben Dooks <ben-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org>,
	Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, a.paterniani-03BXCEkGbFHYGGNLXY5/rw@public.gmane.org,
	Stephen Street <stephen-nl6u4wocdmy51APUEpUfAkEOCMrvLtNR@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Minor SPI controller driver updates:  make the setup() methods reject
spi->mode bits they don't support, by masking aginst the inverse of
bits they *do* support.  This insures against misbehavior later when
new mode bits get added.
 
Most controllers can't support SPI_LSB_FIRST; more handle SPI_CS_HIGH.
Support for all four SPI clock/transfer modes is routine.

Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
 drivers/spi/atmel_spi.c       |    1 +
 drivers/spi/au1550_spi.c      |    9 +++++++++
 drivers/spi/mpc52xx_psc_spi.c |    9 +++++++++
 drivers/spi/omap_uwire.c      |    9 +++++++++
 drivers/spi/pxa2xx_spi.c      |    9 +++++++++
 drivers/spi/spi_bitbang.c     |    6 +++++-
 drivers/spi/spi_imx.c         |   24 +++++++++---------------
 drivers/spi/spi_mpc83xx.c     |    9 +++++++++
 drivers/spi/spi_s3c24xx.c     |    8 +++++++-
 9 files changed, 67 insertions(+), 17 deletions(-)

--- g26.orig/drivers/spi/au1550_spi.c	2007-05-22 11:24:05.000000000 -0700
+++ g26/drivers/spi/au1550_spi.c	2007-05-22 12:04:39.000000000 -0700
@@ -280,6 +280,9 @@ static int au1550_spi_setupxfer(struct s
 	return 0;
 }
 
+/* the spi->mode bits understood by this driver: */
+#define MODEBITS (SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST)
+
 static int au1550_spi_setup(struct spi_device *spi)
 {
 	struct au1550_spi *hw = spi_master_get_devdata(spi->master);
@@ -292,6 +295,12 @@ static int au1550_spi_setup(struct spi_d
 		return -EINVAL;
 	}
 
+	if (spi->mode & ~MODEBITS) {
+		dev_dbg(&spi->dev, "setup: unsupported mode bits %x\n",
+			spi->mode & ~MODEBITS);
+		return -EINVAL;
+	}
+
 	if (spi->max_speed_hz == 0)
 		spi->max_speed_hz = hw->freq_max;
 	if (spi->max_speed_hz > hw->freq_max
--- g26.orig/drivers/spi/mpc52xx_psc_spi.c	2007-05-22 11:24:05.000000000 -0700
+++ g26/drivers/spi/mpc52xx_psc_spi.c	2007-05-22 12:04:39.000000000 -0700
@@ -270,6 +270,9 @@ static void mpc52xx_psc_spi_work(struct 
 	spin_unlock_irq(&mps->lock);
 }
 
+/* the spi->mode bits understood by this driver: */
+#define MODEBITS (SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST)
+
 static int mpc52xx_psc_spi_setup(struct spi_device *spi)
 {
 	struct mpc52xx_psc_spi *mps = spi_master_get_devdata(spi->master);
@@ -279,6 +282,12 @@ static int mpc52xx_psc_spi_setup(struct 
 	if (spi->bits_per_word%8)
 		return -EINVAL;
 
+	if (spi->mode & ~MODEBITS) {
+		dev_dbg(&spi->dev, "setup: unsupported mode bits %x\n",
+			spi->mode & ~MODEBITS);
+		return -EINVAL;
+	}
+
 	if (!cs) {
 		cs = kzalloc(sizeof *cs, GFP_KERNEL);
 		if (!cs)
--- g26.orig/drivers/spi/omap_uwire.c	2007-05-22 11:24:05.000000000 -0700
+++ g26/drivers/spi/omap_uwire.c	2007-05-22 12:04:39.000000000 -0700
@@ -445,10 +445,19 @@ done:
 	return status;
 }
 
+/* the spi->mode bits understood by this driver: */
+#define MODEBITS (SPI_CPOL | SPI_CPHA | SPI_CS_HIGH)
+
 static int uwire_setup(struct spi_device *spi)
 {
 	struct uwire_state *ust = spi->controller_state;
 
+	if (spi->mode & ~MODEBITS) {
+		dev_dbg(&spi->dev, "setup: unsupported mode bits %x\n",
+			spi->mode & ~MODEBITS);
+		return -EINVAL;
+	}
+
 	if (ust == NULL) {
 		ust = kzalloc(sizeof(*ust), GFP_KERNEL);
 		if (ust == NULL)
--- g26.orig/drivers/spi/pxa2xx_spi.c	2007-05-22 11:24:05.000000000 -0700
+++ g26/drivers/spi/pxa2xx_spi.c	2007-05-22 12:04:39.000000000 -0700
@@ -1067,6 +1067,9 @@ static int transfer(struct spi_device *s
 	return 0;
 }
 
+/* the spi->mode bits understood by this driver: */
+#define MODEBITS (SPI_CPOL | SPI_CPHA)
+
 static int setup(struct spi_device *spi)
 {
 	struct pxa2xx_spi_chip *chip_info = NULL;
@@ -1093,6 +1096,12 @@ static int setup(struct spi_device *spi)
 		return -EINVAL;
 	}
 
+	if (spi->mode & ~MODEBITS) {
+		dev_dbg(&spi->dev, "setup: unsupported mode bits %x\n",
+			spi->mode & ~MODEBITS);
+		return -EINVAL;
+	}
+
 	/* Only alloc on first setup */
 	chip = spi_get_ctldata(spi);
 	if (!chip) {
--- g26.orig/drivers/spi/spi_bitbang.c	2007-05-22 11:24:05.000000000 -0700
+++ g26/drivers/spi/spi_bitbang.c	2007-05-22 12:13:09.000000000 -0700
@@ -191,8 +191,12 @@ int spi_bitbang_setup(struct spi_device 
 	 * bit encodings on the wire.  In pure software that would be trivial,
 	 * just bitbang_txrx_le_cphaX() routines shifting the other way, and
 	 * some hardware controllers also have this support.
+	 *
+	 * REVISIT: we should accept SPI_CS_HIGH in some cases; it's
+	 * easy to implement that with GPIOs, but we don't know if the
+	 * underlying chipselect() method support that...
 	 */
-	if ((spi->mode & SPI_LSB_FIRST) != 0)
+	if ((spi->mode & ~(SPI_CPOL|SPI_CPHA)) != 0)
 		return -EINVAL;
 
 	if (!cs) {
--- g26.orig/drivers/spi/spi_imx.c	2007-05-22 11:24:05.000000000 -0700
+++ g26/drivers/spi/spi_imx.c	2007-05-22 12:04:39.000000000 -0700
@@ -1163,6 +1163,9 @@ msg_rejected:
 	return -EINVAL;
 }
 
+/* the spi->mode bits understood by this driver: */
+#define MODEBITS (SPI_CPOL | SPI_CPHA | SPI_CS_HIGH)
+
 /* On first setup bad values must free chip_data memory since will cause
    spi_new_device to fail. Bad value setup from protocol driver are simply not
    applied and notified to the calling driver. */
@@ -1174,6 +1177,12 @@ static int setup(struct spi_device *spi)
 	u32 tmp;
 	int status = 0;
 
+	if (spi->mode & ~MODEBITS) {
+		dev_dbg(&spi->dev, "setup: unsupported mode bits %x\n",
+			spi->mode & ~MODEBITS);
+		return -EINVAL;
+	}
+
 	/* Get controller data */
 	chip_info = spi->controller_data;
 
@@ -1245,21 +1254,6 @@ static int setup(struct spi_device *spi)
 
 	/* SPI mode */
 	tmp = spi->mode;
-	if (tmp & SPI_LSB_FIRST) {
-		status = -EINVAL;
-		if (first_setup) {
-			dev_err(&spi->dev,
-				"setup - "
-				"HW doesn't support LSB first transfer\n");
-			goto err_first_setup;
-		} else {
-			dev_err(&spi->dev,
-				"setup - "
-				"HW doesn't support LSB first transfer, "
-				"default to MSB first\n");
-			spi->mode &= ~SPI_LSB_FIRST;
-		}
-	}
 	if (tmp & SPI_CS_HIGH) {
 		u32_EDIT(chip->control,
 				SPI_CONTROL_SSPOL, SPI_CONTROL_SSPOL_ACT_HIGH);
--- g26.orig/drivers/spi/spi_mpc83xx.c	2007-05-22 11:24:05.000000000 -0700
+++ g26/drivers/spi/spi_mpc83xx.c	2007-05-22 12:04:39.000000000 -0700
@@ -232,12 +232,21 @@ int mpc83xx_spi_setup_transfer(struct sp
 	return 0;
 }
 
+/* the spi->mode bits understood by this driver: */
+#define MODEBITS (SPI_CPOL | SPI_CPHA | SPI_CS_HIGH)
+
 static int mpc83xx_spi_setup(struct spi_device *spi)
 {
 	struct spi_bitbang *bitbang;
 	struct mpc83xx_spi *mpc83xx_spi;
 	int retval;
 
+	if (spi->mode & ~MODEBITS) {
+		dev_dbg(&spi->dev, "setup: unsupported mode bits %x\n",
+			spi->mode & ~MODEBITS);
+		return -EINVAL;
+	}
+
 	if (!spi->max_speed_hz)
 		return -EINVAL;
 
--- g26.orig/drivers/spi/spi_s3c24xx.c	2007-05-22 11:24:05.000000000 -0700
+++ g26/drivers/spi/spi_s3c24xx.c	2007-05-22 12:04:39.000000000 -0700
@@ -146,6 +146,9 @@ static int s3c24xx_spi_setupxfer(struct 
 	return 0;
 }
 
+/* the spi->mode bits understood by this driver: */
+#define MODEBITS (SPI_CPOL | SPI_CPHA | SPI_CS_HIGH)
+
 static int s3c24xx_spi_setup(struct spi_device *spi)
 {
 	int ret;
@@ -153,8 +156,11 @@ static int s3c24xx_spi_setup(struct spi_
 	if (!spi->bits_per_word)
 		spi->bits_per_word = 8;
 
-	if ((spi->mode & SPI_LSB_FIRST) != 0)
+	if (spi->mode & ~MODEBITS) {
+		dev_dbg(&spi->dev, "setup: unsupported mode bits %x\n",
+			spi->mode & ~MODEBITS);
 		return -EINVAL;
+	}
 
 	ret = s3c24xx_spi_setupxfer(spi, NULL);
 	if (ret < 0) {
--- g26.orig/drivers/spi/atmel_spi.c	2007-05-22 11:24:05.000000000 -0700
+++ g26/drivers/spi/atmel_spi.c	2007-05-22 12:04:39.000000000 -0700
@@ -350,6 +350,7 @@ atmel_spi_interrupt(int irq, void *dev_i
 	return ret;
 }
 
+/* the spi->mode bits understood by this driver: */
 #define MODEBITS (SPI_CPOL | SPI_CPHA | SPI_CS_HIGH)
 
 static int atmel_spi_setup(struct spi_device *spi)

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/

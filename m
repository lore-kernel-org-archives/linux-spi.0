From: Andreas Larsson <andreas@gaisler.com>
Subject: [PATCH v2 3/7] spi: spi-fsl-spi: Move setting non-zero tx and rx shifts to a function accessed by a function pointer
Date: Thu,  7 Feb 2013 14:12:07 +0100
Message-ID: <1360242731-13700-4-git-send-email-andreas@gaisler.com>
References: <1360242731-13700-1-git-send-email-andreas@gaisler.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>,
	spi-devel-general@lists.sourceforge.net,
	Mingkai Hu <Mingkai.hu@freescale.com>,
	Anton Vorontsov <anton.vorontsov@linaro.org>,
	Joakim Tjernlund <Joakim.Tjernlund@transmode.se>,
	Kumar Gala <galak@kernel.crashing.org>,
	Peter Korsgaard <jacmet@sunsite.dk>,
	linux-kernel@vger.kernel.org, software@gaisler.com
To: Grant Likely <grant.likely@secretlab.ca>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1360242731-13700-1-git-send-email-andreas@gaisler.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Signed-off-by: Andreas Larsson <andreas@gaisler.com>
---
 drivers/spi/spi-fsl-lib.h |    5 ++++
 drivers/spi/spi-fsl-spi.c |   51 +++++++++++++++++++++++++++-----------------
 2 files changed, 36 insertions(+), 20 deletions(-)

diff --git a/drivers/spi/spi-fsl-lib.h b/drivers/spi/spi-fsl-lib.h
index d785595..eae54b6 100644
--- a/drivers/spi/spi-fsl-lib.h
+++ b/drivers/spi/spi-fsl-lib.h
@@ -69,6 +69,11 @@ struct mpc8xxx_spi {
 
 	unsigned int flags;
 
+#ifdef CONFIG_SPI_FSL_SPI
+	void (*set_shifts)(u32 *rx_shift, u32 *tx_shift,
+			   int bits_per_word, int msb_first);
+#endif
+
 	struct workqueue_struct *workqueue;
 	struct work_struct work;
 
diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index b63ce63..128f7b3 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -91,6 +91,25 @@ static void fsl_spi_chipselect(struct spi_device *spi, int value)
 	}
 }
 
+static void fsl_spi_qe_cpu_set_shifts(u32 *rx_shift, u32 *tx_shift,
+				      int bits_per_word, int msb_first)
+{
+	*rx_shift = 0;
+	*tx_shift = 0;
+	if (msb_first) {
+		if (bits_per_word <= 8) {
+			*rx_shift = 16;
+			*tx_shift = 24;
+		} else if (bits_per_word <= 16) {
+			*rx_shift = 16;
+			*tx_shift = 16;
+		}
+	} else {
+		if (bits_per_word <= 8)
+			*rx_shift = 8;
+	}
+}
+
 static int mspi_apply_cpu_mode_quirks(struct spi_mpc8xxx_cs *cs,
 				struct spi_device *spi,
 				struct mpc8xxx_spi *mpc8xxx_spi,
@@ -101,31 +120,20 @@ static int mspi_apply_cpu_mode_quirks(struct spi_mpc8xxx_cs *cs,
 	if (bits_per_word <= 8) {
 		cs->get_rx = mpc8xxx_spi_rx_buf_u8;
 		cs->get_tx = mpc8xxx_spi_tx_buf_u8;
-		if (mpc8xxx_spi->flags & SPI_QE_CPU_MODE) {
-			cs->rx_shift = 16;
-			cs->tx_shift = 24;
-		}
 	} else if (bits_per_word <= 16) {
 		cs->get_rx = mpc8xxx_spi_rx_buf_u16;
 		cs->get_tx = mpc8xxx_spi_tx_buf_u16;
-		if (mpc8xxx_spi->flags & SPI_QE_CPU_MODE) {
-			cs->rx_shift = 16;
-			cs->tx_shift = 16;
-		}
 	} else if (bits_per_word <= 32) {
 		cs->get_rx = mpc8xxx_spi_rx_buf_u32;
 		cs->get_tx = mpc8xxx_spi_tx_buf_u32;
 	} else
 		return -EINVAL;
 
-	if (mpc8xxx_spi->flags & SPI_QE_CPU_MODE &&
-	    spi->mode & SPI_LSB_FIRST) {
-		cs->tx_shift = 0;
-		if (bits_per_word <= 8)
-			cs->rx_shift = 8;
-		else
-			cs->rx_shift = 0;
-	}
+	if (mpc8xxx_spi->set_shifts)
+		mpc8xxx_spi->set_shifts(&cs->rx_shift, &cs->tx_shift,
+					bits_per_word,
+					!(spi->mode & SPI_LSB_FIRST));
+
 	mpc8xxx_spi->rx_shift = cs->rx_shift;
 	mpc8xxx_spi->tx_shift = cs->tx_shift;
 	mpc8xxx_spi->get_rx = cs->get_rx;
@@ -487,10 +495,13 @@ static struct spi_master * fsl_spi_probe(struct device *dev,
 	if (ret)
 		goto err_cpm_init;
 
-	if (mpc8xxx_spi->flags & SPI_QE_CPU_MODE) {
-		mpc8xxx_spi->rx_shift = 16;
-		mpc8xxx_spi->tx_shift = 24;
-	}
+	if (mpc8xxx_spi->flags & SPI_QE_CPU_MODE)
+		mpc8xxx_spi->set_shifts = fsl_spi_qe_cpu_set_shifts;
+
+	if (mpc8xxx_spi->set_shifts)
+		/* 8 bits per word and MSB first */
+		mpc8xxx_spi->set_shifts(&mpc8xxx_spi->rx_shift,
+					&mpc8xxx_spi->tx_shift, 8, 1);
 
 	mpc8xxx_spi->reg_base = ioremap(mem->start, resource_size(mem));
 	if (mpc8xxx_spi->reg_base == NULL) {
-- 
1.7.0.4

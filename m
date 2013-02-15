From: Andreas Larsson <andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v3 3/7] spi: spi-fsl-spi: Move setting non-zero tx and rx
	shifts to a function accessed by a function pointer
Date: Fri, 15 Feb 2013 16:52:23 +0100
Message-ID: <1360943547-2186-4-git-send-email-andreas@gaisler.com>
References: <1360943547-2186-1-git-send-email-andreas@gaisler.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Joakim Tjernlund <Joakim.Tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>, software-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org,
	Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Anton Vorontsov <anton.vorontsov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Mingkai Hu <Mingkai.hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1360943547-2186-1-git-send-email-andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Acked-by: Anton Vorontsov <anton-9xeibp6oKSgdnm+yROfE0A@public.gmane.org>
Signed-off-by: Andreas Larsson <andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>
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
index 527ac35..aff8bdd 100644
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


------------------------------------------------------------------------------
Free Next-Gen Firewall Hardware Offer
Buy your Sophos next-gen firewall before the end March 2013 
and get the hardware for free! Learn more.
http://p.sf.net/sfu/sophos-d2d-feb

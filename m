From: Joakim Tjernlund <Joakim.Tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
Subject: [PATCH] spi: spi_mpc8xxx.c: Fix QE mode Litte
	Endian
Date: Fri, 14 May 2010 11:14:26 +0200
Message-ID: <1273828467-4593-1-git-send-email-Joakim.Tjernlund@transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Joakim Tjernlund <Joakim.Tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
To: Anton Vorontsov <cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

QE mode uses Little Endian so words > 8 bits are byte swapped.
Workaround this by always enforcing wordsize 8 for words
> 8 bits. Unfortunately this will not work for LSB transfers
where wordsize is > 8 bits so disable these for now.

Also move the different quirks into its own function to keep
mpc8xxx_spi_setup_transfer() sane.

Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
---
 drivers/spi/spi_mpc8xxx.c |  101 +++++++++++++++++++++++++++++++--------------
 1 files changed, 70 insertions(+), 31 deletions(-)

diff --git a/drivers/spi/spi_mpc8xxx.c b/drivers/spi/spi_mpc8xxx.c
index c312d0e..c85dbbb 100644
--- a/drivers/spi/spi_mpc8xxx.c
+++ b/drivers/spi/spi_mpc8xxx.c
@@ -285,36 +285,12 @@ static void mpc8xxx_spi_chipselect(struct spi_device *spi, int value)
 	}
 }
 
-static
-int mpc8xxx_spi_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
+static int
+mspi_apply_cpu_mode_quirks(struct spi_mpc8xxx_cs *cs,
+			   struct spi_device *spi,
+			   struct mpc8xxx_spi *mpc8xxx_spi,
+			   int bits_per_word)
 {
-	struct mpc8xxx_spi *mpc8xxx_spi;
-	u8 bits_per_word, pm;
-	u32 hz;
-	struct spi_mpc8xxx_cs	*cs = spi->controller_state;
-
-	mpc8xxx_spi = spi_master_get_devdata(spi->master);
-
-	if (t) {
-		bits_per_word = t->bits_per_word;
-		hz = t->speed_hz;
-	} else {
-		bits_per_word = 0;
-		hz = 0;
-	}
-
-	/* spi_transfer level calls that work per-word */
-	if (!bits_per_word)
-		bits_per_word = spi->bits_per_word;
-
-	/* Make sure its a bit width we support [4..16, 32] */
-	if ((bits_per_word < 4)
-	    || ((bits_per_word > 16) && (bits_per_word != 32)))
-		return -EINVAL;
-
-	if (!hz)
-		hz = spi->max_speed_hz;
-
 	cs->rx_shift = 0;
 	cs->tx_shift = 0;
 	if (bits_per_word <= 8) {
@@ -338,19 +314,82 @@ int mpc8xxx_spi_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
 		return -EINVAL;
 
 	if (mpc8xxx_spi->flags & SPI_QE_CPU_MODE &&
-			spi->mode & SPI_LSB_FIRST) {
+	    spi->mode & SPI_LSB_FIRST) {
 		cs->tx_shift = 0;
 		if (bits_per_word <= 8)
 			cs->rx_shift = 8;
 		else
 			cs->rx_shift = 0;
 	}
-
 	mpc8xxx_spi->rx_shift = cs->rx_shift;
 	mpc8xxx_spi->tx_shift = cs->tx_shift;
 	mpc8xxx_spi->get_rx = cs->get_rx;
 	mpc8xxx_spi->get_tx = cs->get_tx;
 
+	return bits_per_word;
+}
+
+static int
+mspi_apply_qe_mode_quirks(struct spi_mpc8xxx_cs *cs,
+			  struct spi_device *spi,
+			  int bits_per_word)
+{
+	/* QE uses Little Endian for words > 8
+	 * so transform all words > 8 into 8 bits
+	 * Unfortnatly that doesn't work for LSB so
+	 * reject these for now */
+	/* Note: 32 bits word, LSB works iff
+	 * tfcr/rfcr is set to CPMFCR_GBL */
+	if (spi->mode & SPI_LSB_FIRST &&
+	    bits_per_word > 8)
+		return -EINVAL;
+	if (bits_per_word > 8)
+		return 8; /* pretend its 8 bits */
+	return bits_per_word;
+}
+
+static
+int mpc8xxx_spi_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
+{
+	struct mpc8xxx_spi *mpc8xxx_spi;
+	int bits_per_word;
+	u8 pm;
+	u32 hz;
+	struct spi_mpc8xxx_cs	*cs = spi->controller_state;
+
+	mpc8xxx_spi = spi_master_get_devdata(spi->master);
+
+	if (t) {
+		bits_per_word = t->bits_per_word;
+		hz = t->speed_hz;
+	} else {
+		bits_per_word = 0;
+		hz = 0;
+	}
+
+	/* spi_transfer level calls that work per-word */
+	if (!bits_per_word)
+		bits_per_word = spi->bits_per_word;
+
+	/* Make sure its a bit width we support [4..16, 32] */
+	if ((bits_per_word < 4)
+	    || ((bits_per_word > 16) && (bits_per_word != 32)))
+		return -EINVAL;
+
+	if (!hz)
+		hz = spi->max_speed_hz;
+
+	if (!(mpc8xxx_spi->flags & SPI_CPM_MODE))
+		bits_per_word = mspi_apply_cpu_mode_quirks(cs, spi,
+							   mpc8xxx_spi,
+							   bits_per_word);
+	else if (mpc8xxx_spi->flags & SPI_QE)
+		bits_per_word = mspi_apply_qe_mode_quirks(cs, spi,
+							  bits_per_word);
+
+	if (bits_per_word < 0)
+		return bits_per_word;
+
 	if (bits_per_word == 32)
 		bits_per_word = 0;
 	else
-- 
1.6.4.4


------------------------------------------------------------------------------

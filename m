From: Andreas Larsson <andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v2 5/7] spi: spi-fsl-spi: Add support for setting a maximum
	number of bits per word
Date: Thu,  7 Feb 2013 14:12:09 +0100
Message-ID: <1360242731-13700-6-git-send-email-andreas@gaisler.com>
References: <1360242731-13700-1-git-send-email-andreas@gaisler.com>
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
In-Reply-To: <1360242731-13700-1-git-send-email-andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Signed-off-by: Andreas Larsson <andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>
---
 drivers/spi/spi-fsl-lib.h |    1 +
 drivers/spi/spi-fsl-spi.c |    8 +++++++-
 2 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/spi-fsl-lib.h b/drivers/spi/spi-fsl-lib.h
index 5a9c36c..d5c788b 100644
--- a/drivers/spi/spi-fsl-lib.h
+++ b/drivers/spi/spi-fsl-lib.h
@@ -71,6 +71,7 @@ struct mpc8xxx_spi {
 
 #ifdef CONFIG_SPI_FSL_SPI
 	int type;
+	u8 max_bits_per_word;
 
 	void (*set_shifts)(u32 *rx_shift, u32 *tx_shift,
 			   int bits_per_word, int msb_first);
diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index c018e1c..437319f 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -213,7 +213,8 @@ static int fsl_spi_setup_transfer(struct spi_device *spi,
 
 	/* Make sure its a bit width we support [4..16, 32] */
 	if ((bits_per_word < 4)
-	    || ((bits_per_word > 16) && (bits_per_word != 32)))
+	    || ((bits_per_word > 16) && (bits_per_word != 32))
+	    || (bits_per_word > mpc8xxx_spi->max_bits_per_word))
 		return -EINVAL;
 
 	if (!hz)
@@ -520,6 +521,7 @@ static struct spi_master * fsl_spi_probe(struct device *dev,
 	mpc8xxx_spi = spi_master_get_devdata(master);
 	mpc8xxx_spi->spi_do_one_msg = fsl_spi_do_one_msg;
 	mpc8xxx_spi->spi_remove = fsl_spi_remove;
+	mpc8xxx_spi->max_bits_per_word = 32;
 	mpc8xxx_spi->type = fsl_spi_get_type(dev);
 
 	ret = fsl_spi_cpm_init(mpc8xxx_spi);
@@ -557,6 +559,10 @@ static struct spi_master * fsl_spi_probe(struct device *dev,
 
 	/* Enable SPI interface */
 	regval = pdata->initial_spmode | SPMODE_INIT_VAL | SPMODE_ENABLE;
+	if (mpc8xxx_spi->max_bits_per_word < 8) {
+		regval &= ~SPMODE_LEN(0xF);
+		regval |= SPMODE_LEN(mpc8xxx_spi->max_bits_per_word - 1);
+	}
 	if (mpc8xxx_spi->flags & SPI_QE_CPU_MODE)
 		regval |= SPMODE_OP;
 
-- 
1.7.0.4


------------------------------------------------------------------------------
Free Next-Gen Firewall Hardware Offer
Buy your Sophos next-gen firewall before the end March 2013 
and get the hardware for free! Learn more.
http://p.sf.net/sfu/sophos-d2d-feb

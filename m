From: Andreas Larsson <andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v2 4/7 RESEND] spi: spi-fsl-spi: Introduce a type for the
	driver
Date: Thu,  7 Feb 2013 14:38:13 +0100
Message-ID: <1360244293-14518-1-git-send-email-andreas@gaisler.com>
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

For being able to distinguishing between the regular type of cores and others
with different entries in of_fsl_spi_match.

Signed-off-by: Andreas Larsson <andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>
---
[Resent, as the mail for patch 4 seems to have been lost somehow]

 drivers/spi/spi-fsl-lib.h |    2 ++
 drivers/spi/spi-fsl-spi.c |   39 ++++++++++++++++++++++++++++++++-------
 2 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-fsl-lib.h b/drivers/spi/spi-fsl-lib.h
index eae54b6..5a9c36c 100644
--- a/drivers/spi/spi-fsl-lib.h
+++ b/drivers/spi/spi-fsl-lib.h
@@ -70,6 +70,8 @@ struct mpc8xxx_spi {
 	unsigned int flags;
 
 #ifdef CONFIG_SPI_FSL_SPI
+	int type;
+
 	void (*set_shifts)(u32 *rx_shift, u32 *tx_shift,
 			   int bits_per_word, int msb_first);
 #endif
diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index 128f7b3..c018e1c 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -39,6 +39,37 @@
 #include "spi-fsl-cpm.h"
 #include "spi-fsl-spi.h"
 
+#define TYPE_FSL	0
+
+struct fsl_spi_match_data {
+	int type;
+};
+
+static struct fsl_spi_match_data of_fsl_spi_fsl_config = {
+	.type = TYPE_FSL,
+};
+
+static struct of_device_id of_fsl_spi_match[] = {
+	{
+		.compatible = "fsl,spi",
+		.data = &of_fsl_spi_fsl_config,
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(of, of_fsl_spi_match);
+
+static int fsl_spi_get_type(struct device *dev)
+{
+	const struct of_device_id *match;
+
+	if (dev->of_node) {
+		match = of_match_node(of_fsl_spi_match, dev->of_node);
+		if (match && match->data)
+			return ((struct fsl_spi_match_data *)match->data)->type;
+	}
+	return TYPE_FSL;
+}
+
 static void fsl_spi_change_mode(struct spi_device *spi)
 {
 	struct mpc8xxx_spi *mspi = spi_master_get_devdata(spi->master);
@@ -489,7 +520,7 @@ static struct spi_master * fsl_spi_probe(struct device *dev,
 	mpc8xxx_spi = spi_master_get_devdata(master);
 	mpc8xxx_spi->spi_do_one_msg = fsl_spi_do_one_msg;
 	mpc8xxx_spi->spi_remove = fsl_spi_remove;
-
+	mpc8xxx_spi->type = fsl_spi_get_type(dev);
 
 	ret = fsl_spi_cpm_init(mpc8xxx_spi);
 	if (ret)
@@ -716,12 +747,6 @@ static int of_fsl_spi_remove(struct platform_device *ofdev)
 	return 0;
 }
 
-static const struct of_device_id of_fsl_spi_match[] = {
-	{ .compatible = "fsl,spi" },
-	{}
-};
-MODULE_DEVICE_TABLE(of, of_fsl_spi_match);
-
 static struct platform_driver of_fsl_spi_driver = {
 	.driver = {
 		.name = "fsl_spi",
-- 
1.7.0.4


------------------------------------------------------------------------------
Free Next-Gen Firewall Hardware Offer
Buy your Sophos next-gen firewall before the end March 2013 
and get the hardware for free! Learn more.
http://p.sf.net/sfu/sophos-d2d-feb

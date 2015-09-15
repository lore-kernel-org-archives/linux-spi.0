From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 09/16] spi: omap-100k: Rely on validations done by spi core
Date: Tue, 15 Sep 2015 16:26:21 +0300
Message-ID: <1442323588-29642-9-git-send-email-jarkko.nikula@linux.intel.com>
References: <1442323588-29642-1-git-send-email-jarkko.nikula@linux.intel.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
	Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1442323588-29642-1-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

SPI core validates both bits_per_word and speed_hz transfer parameters and
defaults to spi->bits_per_word and spi->max_speed_hz in case these per
transfer parameters are not set.

This allows to remove a few if statements around per transfer bits_per_word
and speed_hz tests as they evaluate always to true.

Also defaulting word_len to 8 is needless since spi_setup() has already
made sure spi->bits_per_word is 8 in case it is not set.

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-omap-100k.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/drivers/spi/spi-omap-100k.c b/drivers/spi/spi-omap-100k.c
index 35b332dacb13..76a8425be227 100644
--- a/drivers/spi/spi-omap-100k.c
+++ b/drivers/spi/spi-omap-100k.c
@@ -244,12 +244,12 @@ static int omap1_spi100k_setup_transfer(struct spi_device *spi,
 {
 	struct omap1_spi100k *spi100k = spi_master_get_devdata(spi->master);
 	struct omap1_spi100k_cs *cs = spi->controller_state;
-	u8 word_len = spi->bits_per_word;
+	u8 word_len;
 
-	if (t != NULL && t->bits_per_word)
+	if (t != NULL)
 		word_len = t->bits_per_word;
-	if (!word_len)
-		word_len = 8;
+	else
+		word_len = spi->bits_per_word;
 
 	if (spi->bits_per_word > 32)
 		return -EINVAL;
@@ -302,7 +302,6 @@ static int omap1_spi100k_transfer_one_message(struct spi_master *master,
 	struct spi_device *spi = m->spi;
 	struct spi_transfer *t = NULL;
 	int cs_active = 0;
-	int par_override = 0;
 	int status = 0;
 
 	list_for_each_entry(t, &m->transfers, transfer_list) {
@@ -310,14 +309,9 @@ static int omap1_spi100k_transfer_one_message(struct spi_master *master,
 			status = -EINVAL;
 			break;
 		}
-		if (par_override || t->speed_hz || t->bits_per_word) {
-			par_override = 1;
-			status = omap1_spi100k_setup_transfer(spi, t);
-			if (status < 0)
-				break;
-			if (!t->speed_hz && !t->bits_per_word)
-				par_override = 0;
-		}
+		status = omap1_spi100k_setup_transfer(spi, t);
+		if (status < 0)
+			break;
 
 		if (!cs_active) {
 			omap1_spi100k_force_cs(spi100k, 1);
@@ -347,11 +341,7 @@ static int omap1_spi100k_transfer_one_message(struct spi_master *master,
 		}
 	}
 
-	/* Restore defaults if they were overriden */
-	if (par_override) {
-		par_override = 0;
-		status = omap1_spi100k_setup_transfer(spi, NULL);
-	}
+	status = omap1_spi100k_setup_transfer(spi, NULL);
 
 	if (cs_active)
 		omap1_spi100k_force_cs(spi100k, 0);
-- 
2.5.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

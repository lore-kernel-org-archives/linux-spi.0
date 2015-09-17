From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: omap-100k: Rely on validations done by spi core" to the spi tree
Date: Thu, 17 Sep 2015 18:37:10 +0100
Message-ID: <E1Zcd7O-0006WV-EF@finisterre>
References: <1442323588-29642-9-git-send-email-jarkko.nikula@linux.intel.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1442323588-29642-9-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: omap-100k: Rely on validations done by spi core

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 76f67ea9bf27b045eacf8f1e148fd13149f51823 Mon Sep 17 00:00:00 2001
From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Date: Tue, 15 Sep 2015 16:26:21 +0300
Subject: [PATCH] spi: omap-100k: Rely on validations done by spi core

SPI core validates both bits_per_word and speed_hz transfer parameters and
defaults to spi->bits_per_word and spi->max_speed_hz in case these per
transfer parameters are not set.

This allows to remove a few if statements around per transfer bits_per_word
and speed_hz tests as they evaluate always to true.

Also defaulting word_len to 8 is needless since spi_setup() has already
made sure spi->bits_per_word is 8 in case it is not set.

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-omap-100k.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/drivers/spi/spi-omap-100k.c b/drivers/spi/spi-omap-100k.c
index 35b332d..76a8425 100644
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
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

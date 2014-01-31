From: Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>
Subject: [PATCH] spi: spi-fsl-spi.c: Fix problem with multi message transfers
Date: Fri, 31 Jan 2014 13:44:59 +0100
Message-ID: <1391172299-30640-1-git-send-email-sr@denx.de>
Cc: Holger Brunck <holger.brunck-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

When used via spidev with more than one messages to tranfer via
SPI_IOC_MESSAGE the current implementation would return with
-EINVAL, since bits_per_word and speed_hz are set in all
transfer structs. And in the 2nd loop status will stay at
-EINVAL as its not overwritten again via fsl_spi_setup_transfer().

This patch changes this behavious by first checking if one of
the messages uses different settings. If this is the case
the function will return with -EINVAL. If not, the messages
are transferred correctly.

Signed-off-by: Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>
Cc: Holger Brunck <holger.brunck-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-fsl-spi.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index 14e202e..03a3b3c 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -362,18 +362,28 @@ static int fsl_spi_bufs(struct spi_device *spi, struct spi_transfer *t,
 static void fsl_spi_do_one_msg(struct spi_message *m)
 {
 	struct spi_device *spi = m->spi;
-	struct spi_transfer *t;
+	struct spi_transfer *t, *first;
 	unsigned int cs_change;
 	const int nsecs = 50;
 	int status;
 
-	cs_change = 1;
-	status = 0;
+	/* Don't allow changes if CS is active */
+	first = list_first_entry(&m->transfers, struct spi_transfer,
+			transfer_list);
 	list_for_each_entry(t, &m->transfers, transfer_list) {
-		if (t->bits_per_word || t->speed_hz) {
-			/* Don't allow changes if CS is active */
+		if ((first->bits_per_word != t->bits_per_word) ||
+			(first->speed_hz != t->speed_hz)) {
 			status = -EINVAL;
+			dev_err(&spi->dev,
+				"bits_per_word/speed_hz should be same for the same SPI transfer\n");
+			return;
+		}
+	}
 
+	cs_change = 1;
+	status = -EINVAL;
+	list_for_each_entry(t, &m->transfers, transfer_list) {
+		if (t->bits_per_word || t->speed_hz) {
 			if (cs_change)
 				status = fsl_spi_setup_transfer(spi, t);
 			if (status < 0)
-- 
1.8.5.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

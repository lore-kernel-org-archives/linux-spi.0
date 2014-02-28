From: Atsushi Nemoto <anemo-7JcRY8pycbNHfZP73Gtkiw@public.gmane.org>
Subject: [PATCH] spi: core: make zero length transfer valid again
Date: Fri, 28 Feb 2014 23:03:16 +0900
Message-ID: <1393596196-8652-1-git-send-email-anemo@mba.ocn.ne.jp>
Cc: iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org, gsi-ynQEQJNshbs@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Zero length transfer becomes invalid since
"spi: core: Validate length of the transfers in message" commit,
but it should be valid to support an odd device, for example, which
requires long delay between chipselect and the first transfer, etc.

Signed-off-by: Atsushi Nemoto <anemo-7JcRY8pycbNHfZP73Gtkiw@public.gmane.org>
---
 drivers/spi/spi.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index c2605aa..454a523 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1808,7 +1808,7 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 {
 	struct spi_master *master = spi->master;
 	struct spi_transfer *xfer;
-	int w_size, n_words;
+	int w_size;
 
 	if (list_empty(&message->transfers))
 		return -EINVAL;
@@ -1871,9 +1871,8 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 		else
 			w_size = 4;
 
-		n_words = xfer->len / w_size;
 		/* No partial transfers accepted */
-		if (!n_words || xfer->len % w_size)
+		if (xfer->len % w_size)
 			return -EINVAL;
 
 		if (xfer->speed_hz && master->min_speed_hz &&
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

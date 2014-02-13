From: "Ivan T. Ivanov" <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: core: Validate lenght of the transfers in message
Date: Thu, 13 Feb 2014 16:46:46 +0200
Message-ID: <1392302806-17267-1-git-send-email-iivanov@mm-sol.com>
Cc: "Ivan T. Ivanov" <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: "Ivan T. Ivanov" <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>

SPI transfer lenght should be a power-of-two multiple
of eight bits.

Signed-off-by: Ivan T. Ivanov <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 23756b0..474c0b0 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1619,6 +1619,7 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 {
 	struct spi_master *master = spi->master;
 	struct spi_transfer *xfer;
+	int w_size, n_words;
 
 	if (list_empty(&message->transfers))
 		return -EINVAL;
@@ -1670,6 +1671,22 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 				return -EINVAL;
 		}
 
+		/*
+		 * Word size of the SPI transfer should be a power-of-two
+		 * multiple of eight bits,
+		 */
+		if (xfer->bits_per_word <= 8)
+			w_size = 1;
+		else if (xfer->bits_per_word <= 16)
+			w_size = 2;
+		else
+			w_size = 4;
+
+		n_words = xfer->len / w_size;
+		/* No partial transfers accepted */
+		if (!n_words || xfer->len & (w_size - 1))
+			return -EINVAL;
+
 		if (xfer->speed_hz && master->min_speed_hz &&
 		    xfer->speed_hz < master->min_speed_hz)
 			return -EINVAL;
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

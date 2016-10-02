From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 01/11] spi: fsl-espi: reject MSB-first transfers with word
 sizes other than 8 or 16
Date: Sun, 2 Oct 2016 14:22:35 +0200
Message-ID: <d0497ac8-c74e-de72-62e7-b7de19b244b4@gmail.com>
References: <bb70b41a-f58c-074d-0d97-c6635a0aa29d@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <bb70b41a-f58c-074d-0d97-c6635a0aa29d-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

According to the ESPI spec MSB-first transfers are supported for
word size 8 and 16 only.

Check for this and reject MSB-first transfers with other word sizes.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 1f97cce..65bb70d 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -153,6 +153,7 @@ static int fsl_espi_check_message(struct spi_message *m)
 
 	first = list_first_entry(&m->transfers, struct spi_transfer,
 				 transfer_list);
+
 	list_for_each_entry(t, &m->transfers, transfer_list) {
 		if (first->bits_per_word != t->bits_per_word ||
 		    first->speed_hz != t->speed_hz) {
@@ -161,6 +162,15 @@ static int fsl_espi_check_message(struct spi_message *m)
 		}
 	}
 
+	/* ESPI supports MSB-first transfers for word size 8 / 16 only */
+	if (!(m->spi->mode & SPI_LSB_FIRST) && first->bits_per_word != 8 &&
+	    first->bits_per_word != 16) {
+		dev_err(mspi->dev,
+			"MSB-first transfer not supported for wordsize %u\n",
+			first->bits_per_word);
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
-- 
2.10.0


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
